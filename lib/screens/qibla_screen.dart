import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_compass/flutter_compass.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kıble Pusulası')),
      body: ValueListenableBuilder<LocationInfo?>(
        valueListenable: widget.location,
        builder: (context, info, _) {
          if (info == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  'Kıble yönü için önce Vakitler ekranından konumunuzun alınması gerekiyor.',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }
          final qibla =
              PrayerService.qiblaDirection(info.latitude, info.longitude);
          return _compass(qibla);
        },
      ),
    );
  }

  Widget _compass(double qibla) {
    return StreamBuilder<CompassEvent>(
      stream: FlutterCompass.events,
      builder: (context, snapshot) {
        final heading = snapshot.data?.heading;
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (heading == null) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'Bu cihazda pusula sensörü bulunamadı.',
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

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
                    ? 'Kıbleye dönüksünüz'
                    : (diff > 0 ? 'Sağa dönün' : 'Sola dönün'),
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
                        ),
                      ),
                    ),
                    // Sabit işaret: telefonun baktığı yön (yukarı).
                    const Positioned(
                      top: 0,
                      child: Icon(Icons.arrow_drop_down, size: 40),
                    ),
                    Icon(Icons.mosque, size: 40, color: color),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Kıble: ${qibla.toStringAsFixed(0)}°   •   Yönünüz: ${heading.toStringAsFixed(0)}°',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Telefonu düz tutun. Doğruluk için telefonu 8 çizecek şekilde hareket ettirerek pusulayı kalibre edebilirsiniz.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
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

  _CompassRosePainter({
    required this.qiblaAngle,
    required this.roseColor,
    required this.qiblaColor,
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

    // Yön harfleri: K (Kuzey), D (Doğu), G (Güney), B (Batı).
    const labels = {0: 'K', 90: 'D', 180: 'G', 270: 'B'};
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
      old.qiblaColor != qiblaColor;
}
