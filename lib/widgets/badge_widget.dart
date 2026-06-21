import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/badge_model.dart';
import '../constants/app_colors.dart';

class BadgeWidget extends StatelessWidget {
  final BadgeModel badge;
  const BadgeWidget({super.key, required this.badge});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: badge.description,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: badge.isUnlocked
                  ? AppColors.gold.withValues(alpha: 0.15)
                  : Colors.grey.shade200,
              border: Border.all(
                color: badge.isUnlocked ? AppColors.gold : Colors.grey.shade300,
                width: 2.5,
              ),
              boxShadow: badge.isUnlocked
                  ? [
                      BoxShadow(
                        color: AppColors.gold.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: Center(
              child: badge.isUnlocked
                  ? Text(badge.emoji, style: const TextStyle(fontSize: 32))
                      .animate()
                      .scale(duration: 300.ms, curve: Curves.elasticOut)
                  : ColorFiltered(
                      colorFilter: const ColorFilter.matrix([
                        0.2, 0.2, 0.2, 0, 0,
                        0.2, 0.2, 0.2, 0, 0,
                        0.2, 0.2, 0.2, 0, 0,
                        0, 0, 0, 1, 0,
                      ]),
                      child: Text(badge.emoji,
                          style: const TextStyle(fontSize: 32)),
                    ),
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 80,
            child: Text(
              badge.name,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: badge.isUnlocked
                    ? AppColors.textDark
                    : Colors.grey.shade400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
