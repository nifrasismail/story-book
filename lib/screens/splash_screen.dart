import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../app.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2800), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => const AuthGate(),
            transitionsBuilder: (_, anim, __, child) =>
                FadeTransition(opacity: anim, child: child),
            transitionDuration: const Duration(milliseconds: 600),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF6B35),
              Color(0xFFF9C74F),
              Color(0xFF4ECDC4),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Floating emojis background
              const _FloatingEmojis(),

              // Main logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text('📚', style: TextStyle(fontSize: 64)),
                ),
              )
                  .animate()
                  .scale(
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1, 1),
                    duration: 700.ms,
                    curve: Curves.elasticOut,
                  )
                  .fade(duration: 400.ms),

              const SizedBox(height: 28),

              // App name
              Text(
                'KidStories',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              )
                  .animate()
                  .slideY(begin: 0.4, end: 0, delay: 300.ms, duration: 600.ms)
                  .fade(delay: 300.ms, duration: 600.ms),

              const SizedBox(height: 8),
              Text(
                'Magical Stories for Little Minds ✨',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
                  .animate()
                  .fade(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.3, end: 0, delay: 600.ms, duration: 600.ms),

              const SizedBox(height: 60),

              // Loading dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3,
                  (i) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(delay: Duration(milliseconds: 800 + i * 150))
                      .fade(duration: 300.ms)
                      .then()
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .scale(
                        end: const Offset(1.6, 1.6),
                        duration: 500.ms,
                        curve: Curves.easeInOut,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FloatingEmojis extends StatelessWidget {
  const _FloatingEmojis();

  @override
  Widget build(BuildContext context) {
    final items = ['🌟', '🐷', '🐢', '🦁', '🧚', '🐸', '🌈', '⭐'];
    return SizedBox(
      height: 0,
      child: Stack(
        clipBehavior: Clip.none,
        children: List.generate(items.length, (i) {
          const radius = 180.0;
          final x = radius * (i % 2 == 0 ? 1 : -1) * (0.5 + (i * 0.1));
          final y = -120.0 - (i * 30.0);
          return Positioned(
            left: x,
            top: y,
            child: Text(
              items[i],
              style: TextStyle(fontSize: 24 + (i * 2).toDouble()),
            )
                .animate(
                  delay: Duration(milliseconds: 200 + i * 100),
                  onPlay: (c) => c.repeat(reverse: true),
                )
                .moveY(
                  begin: 0,
                  end: -10,
                  duration: Duration(milliseconds: 1500 + i * 200),
                  curve: Curves.easeInOut,
                )
                .fade(delay: Duration(milliseconds: i * 100), duration: 500.ms),
          );
        }),
      ),
    );
  }
}
