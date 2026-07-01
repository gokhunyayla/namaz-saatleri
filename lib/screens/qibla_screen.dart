import 'dart:io' show Platform;
import 'dart:math' as math;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geomag/geomag.dart';

import '../app_settings.dart';
import '../services/location_service.dart';
import '../services/prayer_service.dart';

class QiblaScreen extends StatefulWidget {
  final ValueNotifier<LocationInfo?> location;

  const QiblaScreen({super.key, required this.location});

  @override
  State<QiblaScreen> createState() => _QiblaScreenState();
}

class _QiblaScreenState extends State<QiblaScreen> {
  bool _wasAligned = false;

  // Manyetik sapma önbelleği (konuma göre bir kez hesaplanır).
  double _declination = 0;
  String? _declinationKey;

  /// Android pusulası manyetik kuzeyi baz alır; gerçek kuzeye çevirmek için
  /// WMM-2025 modeliyle manyetik sapma eklenir. iOS zaten gerçek kuzey
  /// (trueHeading) bildirdiği için düzeltme uygulanmaz.
  double _declinationFor(LocationInfo info) {
    if (kIsWeb || !Platform.isAndroid) return 0;
    final key =
        '${info.latitude.toStringAsFixed(2)},${info.longitude.toStringAsFixed(2)}';
    if (_declinationKey != key) {
      _declination =
          GeoMag().calculate(info.latitude, info.longitude).dec;
      _declinationKey = key;
    }
    return _declination;
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance.strings;
    return Scaffold(
      appBar: AppBar(title: Text(s.qiblaTitle)),
      body: ValueListenableBuilder<LocationInfo?>(
        valueListenable: widget.location,
        builder: (context, info, _) {
          if (info == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  s.needLocationFirst,
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final qibla =
              PrayerService.qiblaDirection(info.latitude, info.longitude);
          return _compass(qibla, _declinationFor(info));
        },
      ),
    );
  }

  Widget _compass(double qibla, double declination) {
    final s = AppSettings.instance.strings;
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final rawHeading = snapshot.data?.heading;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (rawHeading == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Text(
                s.compassNotFound,
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        // Gerçek kuzeye göre yön (Android'de manyetik sapma düzeltilir).
        final heading = (rawHeading + declination) % 360;

        // Kıbleye göre sapma: -180..180 arası.
        var diff = (qibla - heading) % 360;
        if (diff > 180) diff -= 360;
        if (diff < -180) diff += 360;
        final aligned = diff.abs() < 3;

        // Hizalanma anında hafif titreşim.
        if (aligned && !_wasAligned) HapticFeedback.mediumImpact();
        _wasAligned = aligned;

        final scheme = Theme.of(context).colorScheme;
        final color = aligned ? Colors.green : scheme.primary;

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                aligned
                    ? s.facingQibla
                    : (diff > 0 ? s.turnRight : s.turnLeft),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: color, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pusula kadranı cihaz yönüne göre döner.
                    Transform.rotate(
                      angle: -heading * math.pi / 180,
                      child: CustomPaint(
                        size: const Size(300, 300),
                        painter: _CompassRosePainter(
                          qiblaAngle: qibla,
                          roseColor: scheme.onSurface,
                          qiblaColor: color,
                          cardinals: s.cardinals,
                        ),
                      ),
                    ),
                    // Sabit işaret: telefonun baktığı yön (yukarı).
                    const Positioned(
                      top: 0,
                      child: Icon(Icons.arrow_drop_down, size: 40),
                    ),
                    // Kâbe
                    const Text('🕋', style: TextStyle(fontSize: 40)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                '${s.qiblaLabel}: ${qibla.toStringAsFixed(0)}°   •   ${s.headingLabel}: ${heading.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  s.calibrateHint,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Pusula kadranı: yön harfleri, derece çizgileri ve kıble oku.
class _CompassRosePainter extends CustomPainter {
  final double qiblaAngle;
  final Color roseColor;
  final Color qiblaColor;

  /// Sırayla Kuzey, Doğu, Güney, Batı harfleri (dile göre değişir).
  final List<String> cardinals;

  _CompassRosePainter({
    required this.qiblaAngle,
    required this.roseColor,
    required this.qiblaColor,
    required this.cardinals,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final circlePaint = Paint()
      ..color = roseColor.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius - 4, circlePaint);

    final tickPaint = Paint()..color = roseColor.withValues(alpha: 0.5);

    // Derece çizgileri (her 15°).
    for (var deg = 0; deg < 360; deg += 15) {
      final isCardinal = deg % 90 == 0;
      final rad = deg * math.pi / 180;
      final outer = center +
          Offset(math.sin(rad), -math.cos(rad)) * (radius - 8);
      final inner = center +
          Offset(math.sin(rad), -math.cos(rad)) *
              (radius - (isCardinal ? 26 : 16));
      tickPaint.strokeWidth = isCardinal ? 3 : 1.5;
      canvas.drawLine(inner, outer, tickPaint);
    }

    // Yön harfleri: Kuzey, Doğu, Güney, Batı (seçili dilde).
    final labels = {
      0: cardinals[0],
      90: cardinals[1],
      180: cardinals[2],
      270: cardinals[3],
    };
    for (final e in labels.entries) {
      final rad = e.key * math.pi / 180;
      final pos = center +
          Offset(math.sin(rad), -math.cos(rad)) * (radius - 44);
      final tp = TextPainter(
        text: TextSpan(
          text: e.value,
          style: TextStyle(
            color: e.key == 0 ? Colors.red : roseColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      canvas.save();
      canvas.translate(pos.dx, pos.dy);
      tp.paint(canvas, Offset(-tp.width / 2, -tp.height / 2));
      canvas.restore();
    }

    // Kıble oku.
    final qRad = qiblaAngle * math.pi / 180;
    final dir = Offset(math.sin(qRad), -math.cos(qRad));
    final arrowPaint = Paint()
      ..color = qiblaColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(center + dir * 30, center + dir * (radius - 30), arrowPaint);

    // Ok başı.
    final tip = center + dir * (radius - 18);
    final left = center +
        dir * (radius - 38) +
        Offset(-dir.dy, dir.dx) * 10;
    final right = center +
        dir * (radius - 38) +
        Offset(dir.dy, -dir.dx) * 10;
    final headPath = Path()
      ..moveTo(tip.dx, tip.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(headPath, Paint()..color = qiblaColor);
  }

  @override
  bool shouldRepaint(_CompassRosePainter old) =>
      old.qiblaAngle != qiblaAngle ||
      old.roseColor != roseColor ||
      old.qiblaColor != qiblaColor ||
      old.cardinals != cardinals;
}
