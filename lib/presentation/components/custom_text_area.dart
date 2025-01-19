import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class CustomTextArea extends StatefulWidget {
  final String? mainMessage;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final ValueChanged<String>? onChanged;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final Color? backgroundColor;
  final Color? borderColor;
  final int? maxLength;
  final Widget? suffix;
  final Widget? prefix;
  final Color? cursorColor;
  final bool? enable;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onSubmitted;
  final String? initialValue;
  final Function(String)? onLostFocus;
  final String? hintText;
  final TextStyle? hintStyle;
  final EdgeInsets? contentPadding;
  final int? maxLines;
  final double? height, width;

  const CustomTextArea({
    super.key,
    this.textStyle,
    this.titleStyle,
    this.onChanged,
    this.textCapitalization,
    this.textInputType,
    this.backgroundColor,
    this.maxLength,
    this.suffix,
    this.borderColor,
    this.cursorColor,
    this.inputFormatters,
    this.enable = true,
    this.onSubmitted,
    this.initialValue,
    this.onLostFocus,
    this.hintText,
    this.hintStyle,
    this.mainMessage,
    this.prefix,
    this.contentPadding,
    this.maxLines = 5, this.height, this.width,
  });

  @override
  State<CustomTextArea> createState() => _CustomTextAreaState();
}

class _CustomTextAreaState extends State<CustomTextArea> {
  late TextEditingController controller;
  late FocusNode focusNode = FocusNode();

  @override
  void initState() {
    focusNode.addListener(_onFocusChange);
    controller = TextEditingController(text: widget.initialValue ?? "");
    super.initState();
  }

  void _onFocusChange() {
    if (!focusNode.hasFocus) {
      String trimmedText = controller.text.trim();
      if (trimmedText != controller.text) {
        controller.text = trimmedText;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: trimmedText.length));
      }
      widget.onLostFocus?.call(trimmedText);
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_onFocusChange);
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: widget.borderColor ?? AppColors.brightGray,
        ),
      ),
      child: TextField(
        enabled: widget.enable ?? true,
        style:
        widget.textStyle ?? AppTextStyles.beVietNamProStyles.regular14White,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        controller: controller,
        focusNode: focusNode,
        maxLines: widget.maxLines,
        autofocus: false,
        cursorColor: widget.cursorColor ?? AppColors.brightGray,
        textCapitalization:
        widget.textCapitalization ?? TextCapitalization.none,
        keyboardType: widget.textInputType ?? TextInputType.text,
        inputFormatters: [
          if (widget.inputFormatters != null) ...widget.inputFormatters!,
        ],
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              AppTextStyles.beVietNamProStyles.regular16White,
          counterText: "",
          fillColor: widget.backgroundColor,
          filled: true,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 11.5),
          border: InputBorder.none,
        ),
        maxLength: widget.maxLength,
      ),
    );
  }
}
