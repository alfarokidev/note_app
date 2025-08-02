import 'package:flutter/material.dart';

import 'shimmer_widget.dart';

class ShimmerTextField extends StatelessWidget {
  final double height;
  final bool isTitle;

  const ShimmerTextField({
    super.key,
    this.height = 56,
    this.isTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(isTitle ? 20 : 16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  height: isTitle ? 20 : 16,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(4),
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