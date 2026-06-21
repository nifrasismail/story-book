import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/app_colors.dart';

class StarCounterWidget extends StatelessWidget {
  final int count;
  final bool animate;
  const StarCounterWidget({super.key, required this.count, this.animate = false});

  @override
  Widget build(BuildContext context) {
    Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.gold.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.gold, width: 1.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('⭐', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            count.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 16,
              color: Color(0xFF92600A),
            ),
          ),
        ],
      ),
    );

    if (animate) {
      badge = badge
          .animate()
          .scale(begin: const Offset(1.4, 1.4), end: const Offset(1, 1), duration: 400.ms)
          .then()
          .shake(duration: 300.ms);
    }

    return badge;
  }
}
