import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Controllers ──
  late AnimationController _bgRevealCtrl; // 0–900ms   : bg bursts in
  late AnimationController
  _orbitCtrl; // 0–∞       : continuous slow orbit of blobs + dashed ring
  late AnimationController _dropCtrl; // 900–1800ms: drop falls & squishes
  late AnimationController _rippleCtrl; // 1700–2700ms: ripple rings expand
  late AnimationController _textCtrl; // 2500–3400ms: text slides up
  late AnimationController _shimmerCtrl; // 3200–∞    : shimmer sweeps the title
  late AnimationController _particleCtrl; // 1800–∞    : particles float upward
  late AnimationController _breatheCtrl; // 0–∞       : logo gentle breathe

  // bg
  late Animation<double> _bgScale;
  late Animation<double> _bgOpacity;

  // drop
  late Animation<double> _dropY;
  late Animation<double> _dropScaleY;
  late Animation<double> _dropScaleX;
  late Animation<double> _dropOpacity;

  // ripples
  late Animation<double> _ripple1, _ripple2, _ripple3;
  late Animation<double> _rippleOpacity;

  // text
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _taglineOpacity;
  late Animation<Offset> _taglineSlide;
  late Animation<double> _loaderOpacity;

  // shimmer
  late Animation<double> _shimmerPos;

  // breathe
  late Animation<double> _breathe;

  @override
  void initState() {
    super.initState();

    _bgRevealCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _orbitCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 7000),
    )..repeat();
    _dropCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _rippleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _textCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _shimmerCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();
    _particleCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat();
    _breatheCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // ── BG ──
    _bgScale = Tween<double>(begin: 1.18, end: 1.0).animate(
      CurvedAnimation(parent: _bgRevealCtrl, curve: Curves.easeOutCubic),
    );
    _bgOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _bgRevealCtrl, curve: Curves.easeIn));

    // ── DROP falls from above, squishes on impact ──
    _dropY = Tween<double>(begin: -0.48, end: 0.0).animate(
      CurvedAnimation(
        parent: _dropCtrl,
        curve: const Interval(0.0, 0.62, curve: Curves.easeIn),
      ),
    );
    _dropOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _dropCtrl,
        curve: const Interval(0.0, 0.25, curve: Curves.easeIn),
      ),
    );
    _dropScaleY = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 62),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.72), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 0.72, end: 1.06), weight: 18),
      TweenSequenceItem(tween: Tween(begin: 1.06, end: 1.0), weight: 10),
    ]).animate(_dropCtrl);
    _dropScaleX = TweenSequence<double>([
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 62),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.40), weight: 10),
      TweenSequenceItem(tween: Tween(begin: 1.40, end: 0.94), weight: 18),
      TweenSequenceItem(tween: Tween(begin: 0.94, end: 1.0), weight: 10),
    ]).animate(_dropCtrl);

    // ── RIPPLES ──
    _ripple1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleCtrl,
        curve: const Interval(0.00, 0.70, curve: Curves.easeOut),
      ),
    );
    _ripple2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleCtrl,
        curve: const Interval(0.15, 0.85, curve: Curves.easeOut),
      ),
    );
    _ripple3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _rippleCtrl,
        curve: const Interval(0.30, 1.00, curve: Curves.easeOut),
      ),
    );
    _rippleOpacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(CurvedAnimation(parent: _rippleCtrl, curve: Curves.easeIn));

    // ── TEXT ──
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(0.0, 0.55, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(begin: const Offset(0, 0.55), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _textCtrl,
            curve: const Interval(0.0, 0.65, curve: Curves.easeOutCubic),
          ),
        );
    _taglineOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(0.30, 1.0, curve: Curves.easeOut),
      ),
    );
    _taglineSlide =
        Tween<Offset>(begin: const Offset(0, 0.65), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textCtrl,
            curve: const Interval(0.30, 1.0, curve: Curves.easeOutCubic),
          ),
        );
    _loaderOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textCtrl,
        curve: const Interval(0.65, 1.0, curve: Curves.easeIn),
      ),
    );

    // ── SHIMMER ──
    _shimmerPos = Tween<double>(
      begin: -1.8,
      end: 2.8,
    ).animate(CurvedAnimation(parent: _shimmerCtrl, curve: Curves.easeInOut));

    // ── BREATHE ──
    _breathe = Tween<double>(
      begin: 1.0,
      end: 1.07,
    ).animate(CurvedAnimation(parent: _breatheCtrl, curve: Curves.easeInOut));

    // ── Staggered sequence matching 5 s controller ──
    _bgRevealCtrl.forward().then((_) {
      _dropCtrl.forward().then((_) {
        _rippleCtrl.forward().then((_) {
          _textCtrl.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _bgRevealCtrl.dispose();
    _orbitCtrl.dispose();
    _dropCtrl.dispose();
    _rippleCtrl.dispose();
    _textCtrl.dispose();
    _shimmerCtrl.dispose();
    _particleCtrl.dispose();
    _breatheCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _bgRevealCtrl,
          _orbitCtrl,
          _dropCtrl,
          _rippleCtrl,
          _textCtrl,
          _shimmerCtrl,
          _particleCtrl,
          _breatheCtrl,
        ]),
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              // 1 ── Animated background ──
              Opacity(
                opacity: _bgOpacity.value,
                child: Transform.scale(
                  scale: _bgScale.value,
                  child: CustomPaint(
                    size: size,
                    painter: _BackgroundPainter(orbit: _orbitCtrl.value),
                  ),
                ),
              ),

              // 2 ── Floating particles (rise after splash) ──
              CustomPaint(
                size: size,
                painter: _ParticlePainter(
                  progress: _particleCtrl.value,
                  opacity: _dropOpacity.value,
                ),
              ),

              // 3 ── Ripple rings ──
              if (_rippleCtrl.value > 0)
                CustomPaint(
                  size: size,
                  painter: _RipplePainter(
                    r1: _ripple1.value,
                    r2: _ripple2.value,
                    r3: _ripple3.value,
                    opacity: _rippleOpacity.value,
                    center: Offset(size.width / 2, size.height / 2),
                  ),
                ),

              // 4 ── Logo drop ──
              Center(
                child: Transform.translate(
                  offset: Offset(0, size.height * _dropY.value),
                  child: Opacity(
                    opacity: _dropOpacity.value,
                    child: Transform.scale(
                      scaleX: _dropScaleX.value,
                      scaleY: _dropScaleY.value,
                      child: Transform.scale(
                        scale: _breathe.value,
                        child: _buildLogoMark(),
                      ),
                    ),
                  ),
                ),
              ),

              // 5 ── Text: title + tagline ──
              Positioned(
                bottom: size.height * 0.20,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    // Title with shimmer sweep
                    SlideTransition(
                      position: _titleSlide,
                      child: FadeTransition(
                        opacity: _titleOpacity,
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(
                            begin: Alignment(_shimmerPos.value - 1.0, 0),
                            end: Alignment(_shimmerPos.value + 1.0, 0),
                            colors: const [
                              Colors.white,
                              Color(0xFFE0F0FF),
                              Colors.white,
                              Color(0xFFAAD4FF),
                              Colors.white,
                            ],
                            stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
                          ).createShader(bounds),
                          child: const Text(
                            'MilkMate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 44,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: 2.5,
                              height: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Tagline with flanking lines
                    SlideTransition(
                      position: _taglineSlide,
                      child: FadeTransition(
                        opacity: _taglineOpacity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 32,
                              height: 1,
                              color: Colors.white.withOpacity(0.35),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              'SMART DAIRY MANAGEMENT',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.55),
                                letterSpacing: 3.2,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 32,
                              height: 1,
                              color: Colors.white.withOpacity(0.35),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 6 ── Loader ──
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: FadeTransition(
                  opacity: _loaderOpacity,
                  child: Center(
                    child: LoadingAnimationWidget.progressiveDots(
                      color: Colors.white.withOpacity(0.50),
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLogoMark() {
    return SizedBox(
      width: 136,
      height: 136,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer halo glow
          Container(
            width: 136,
            height: 136,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [Colors.white.withOpacity(0.14), Colors.transparent],
              ),
            ),
          ),
          // Rotating dashed ring
          CustomPaint(
            size: const Size(112, 112),
            painter: _DashedRingPainter(
              rotation: _orbitCtrl.value * 2 * math.pi,
            ),
          ),
          // Inner white disc with shadow
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Colors.white, Color(0xFFCEE5FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.60),
                  blurRadius: 32,
                  spreadRadius: 8,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.18),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: CustomPaint(painter: _MilkDropPainter()),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════
// PAINTERS
// ═══════════════════════════════

class _BackgroundPainter extends CustomPainter {
  final double orbit;
  _BackgroundPainter({required this.orbit});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Base gradient (deep navy → primary blue)
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          colors: [Color(0xFF0A2458), AppColors.primaryDark, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ).createShader(rect),
    );

    final a = orbit * 2 * math.pi;

    // Animated soft blob 1 (top area, orbits)
    canvas.drawCircle(
      Offset(
        size.width * (0.5 + 0.22 * math.cos(a)),
        size.height * (0.28 + 0.10 * math.sin(a)),
      ),
      size.width * 0.52,
      Paint()
        ..color = AppColors.primaryLight.withOpacity(0.20)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 90),
    );

    // Animated soft blob 2 (bottom area, counter-orbits)
    canvas.drawCircle(
      Offset(
        size.width * (0.5 - 0.18 * math.cos(a + 1.4)),
        size.height * (0.76 + 0.08 * math.sin(a + 1.4)),
      ),
      size.width * 0.58,
      Paint()
        ..color = AppColors.gradientEnd.withOpacity(0.14)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 110),
    );

    // Farm-green accent top-right
    canvas.drawCircle(
      Offset(size.width * 0.88, size.height * 0.08),
      size.width * 0.28,
      Paint()
        ..color = AppColors.secondary.withOpacity(0.11)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 65),
    );

    // Dot grid
    final dot = Paint()..color = Colors.white.withOpacity(0.045);
    const step = 34.0;
    for (double x = step; x < size.width; x += step) {
      for (double y = step; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.3, dot);
      }
    }
  }

  @override
  bool shouldRepaint(_BackgroundPainter old) => old.orbit != orbit;
}

class _RipplePainter extends CustomPainter {
  final double r1, r2, r3, opacity;
  final Offset center;
  _RipplePainter({
    required this.r1,
    required this.r2,
    required this.r3,
    required this.opacity,
    required this.center,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final maxR = size.width * 0.58;
    void ring(double t, double alpha) {
      if (t <= 0) return;
      canvas.drawCircle(
        center,
        maxR * t,
        Paint()
          ..color = Colors.white.withOpacity(alpha * opacity * (1 - t * 0.55))
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.8 * (1 - t * 0.5),
      );
    }

    ring(r1, 0.60);
    ring(r2, 0.40);
    ring(r3, 0.24);
  }

  @override
  bool shouldRepaint(_RipplePainter old) => true;
}

class _ParticlePainter extends CustomPainter {
  final double progress;
  final double opacity;
  _ParticlePainter({required this.progress, required this.opacity});

  static final _rng = math.Random(17);
  static final _pts = List.generate(
    22,
    (i) => _P(
      x: 0.28 + _rng.nextDouble() * 0.44,
      baseY: 0.50,
      speed: 0.35 + _rng.nextDouble() * 0.65,
      size: 1.8 + _rng.nextDouble() * 3.2,
      phase: _rng.nextDouble(),
      drift: (_rng.nextDouble() - 0.5) * 0.20,
    ),
  );

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity < 0.04) return;
    for (final p in _pts) {
      final t = ((progress + p.phase) % 1.0);
      final py = p.baseY - t * 0.52 * p.speed;
      final px = p.x + p.drift * t;
      if (py < 0.02) continue;
      final alpha = opacity * (1 - t) * 0.65;
      if (alpha <= 0) continue;
      canvas.drawCircle(
        Offset(px * size.width, py * size.height),
        p.size * (1 - t * 0.45),
        Paint()..color = Colors.white.withOpacity(alpha),
      );
    }
  }

  @override
  bool shouldRepaint(_ParticlePainter old) => true;
}

class _P {
  final double x, baseY, speed, size, phase, drift;
  const _P({
    required this.x,
    required this.baseY,
    required this.speed,
    required this.size,
    required this.phase,
    required this.drift,
  });
}

class _DashedRingPainter extends CustomPainter {
  final double rotation;
  _DashedRingPainter({required this.rotation});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;
    const count = 22;
    const sweep = (2 * math.pi) / count;
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < count; i++) {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: r),
        rotation + i * sweep,
        sweep * 0.52,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_DashedRingPainter old) => old.rotation != rotation;
}

class _MilkDropPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2 + size.height * 0.03;

    final dW = size.width * 0.28;
    final dH = size.height * 0.40;
    final top = cy - dH * 0.58;
    final bottom = cy + dH * 0.52;

    canvas.drawPath(
      Path()
        ..moveTo(cx, top)
        ..cubicTo(
          cx + dW * 1.1,
          cy - dH * 0.08,
          cx + dW * 0.9,
          bottom - dH * 0.08,
          cx,
          bottom,
        )
        ..cubicTo(
          cx - dW * 0.9,
          bottom - dH * 0.08,
          cx - dW * 1.1,
          cy - dH * 0.08,
          cx,
          top,
        )
        ..close(),
      Paint()..color = AppColors.primary,
    );

    // glint
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(cx - dW * 0.22, cy - dH * 0.18),
        width: dW * 0.32,
        height: dH * 0.20,
      ),
      Paint()..color = Colors.white.withOpacity(0.62),
    );
  }

  @override
  bool shouldRepaint(_MilkDropPainter _) => false;
}
