import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final bool expands;
  final TextStyle? textStyle;
  final Function(String)? onChanged;
  final bool isTitle;

  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.expands = false,
    this.textStyle,
    this.onChanged,
    this.isTitle = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _focusAnimation;
  late Animation<Color?> _colorAnimation;
  
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _focusAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      
      if (_isFocused) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    _colorAnimation = ColorTween(
      begin: colorScheme.outline.withOpacity(0.3),
      end: colorScheme.primary,
    ).animate(_animationController);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _focusAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.isTitle ? 20 : 16),
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: TextField(
              controller: widget.controller,
              focusNode: _focusNode,
              obscureText: widget.obscureText,
              keyboardType: widget.keyboardType,
              maxLines: widget.maxLines,
              expands: widget.expands,
              onChanged: widget.onChanged,
              textAlignVertical: widget.expands ? TextAlignVertical.top : null,
              style: widget.textStyle ??
                  TextStyle(
                    fontSize: widget.isTitle ? 20 : 16,
                    fontWeight: widget.isTitle ? FontWeight.w700 : FontWeight.w500,
                    color: colorScheme.onSurface,
                    height: 1.4,
                  ),
              decoration: InputDecoration(
                hintText: widget.hintText,
                labelText: widget.labelText,
                prefixIcon: widget.prefixIcon != null
                    ? Container(
                        margin: const EdgeInsets.only(left: 16, right: 12),
                        child: Icon(
                          widget.prefixIcon,
                          color: _isFocused
                              ? colorScheme.primary
                              : colorScheme.onSurface.withOpacity(0.6),
                          size: 22,
                        ),
                      )
                    : null,
                prefixIconConstraints: const BoxConstraints(minWidth: 50),
                filled: true,
                fillColor: _isFocused
                    ? colorScheme.surface
                    : colorScheme.surface.withOpacity(0.8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.isTitle ? 20 : 16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.isTitle ? 20 : 16),
                  borderSide: BorderSide(
                    color: colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.isTitle ? 20 : 16),
                  borderSide: BorderSide(
                    color: _colorAnimation.value ?? colorScheme.primary,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: widget.prefixIcon != null ? 8 : 20,
                  vertical: widget.isTitle ? 20 : 16,
                ),
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withOpacity(0.5),
                  fontSize: widget.isTitle ? 20 : 16,
                  fontWeight: FontWeight.w400,
                ),
                labelStyle: TextStyle(
                  color: _isFocused
                      ? colorScheme.primary
                      : colorScheme.onSurface.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}