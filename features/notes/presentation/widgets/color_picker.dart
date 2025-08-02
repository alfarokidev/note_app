import 'package:flutter/material.dart';

import '../../../../core/constants/note_colors.dart';

class ColorPicker extends StatelessWidget {
  final int selectedColor;
  final Function(int) onColorSelected;

  const ColorPicker({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: NoteColors.colors.length,
        itemBuilder: (context, index) {
          final color = NoteColors.colors[index];
          final isSelected = color == selectedColor;
          
          return GestureDetector(
            onTap: () => onColorSelected(color),
            child: Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Color(color),
                shape: BoxShape.circle,
                border: isSelected
                    ? Border.all(color: Colors.black87, width: 3)
                    : Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      color: _getIconColor(Color(color)),
                      size: 20,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  Color _getIconColor(Color backgroundColor) {
    final brightness = ThemeData.estimateBrightnessForColor(backgroundColor);
    return brightness == Brightness.dark ? Colors.white : Colors.black87;
  }
}