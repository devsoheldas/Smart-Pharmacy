import 'package:e_pharma/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class TimeLineItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color lineColor;

  const TimeLineItem({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Space between timeline items
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ---------------- Left Section (Dot + Line) ----------------
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: lineColor, // dynamic color
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 14, color: AppColors.whiteColor),
              ),

              // Vertical line
              Container(
                width: 2,
                height: 70,
                color: lineColor, // dynamic color
              ),
            ],
          ),

          const SizedBox(width: 12),

          // ---------------- Right Section (Card with content) ----------------
          Expanded(
            child: Card(
              color: AppColors.mintGreenColor,
              elevation: 2,
              margin: EdgeInsets.zero, // Clean look
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.blackColor
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 14,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
