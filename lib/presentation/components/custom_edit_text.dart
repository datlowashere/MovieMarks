import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_marks/config/theme/app_colors.dart';
import 'package:movie_marks/config/theme/app_text_styles.dart';

class CustomEditText extends StatefulWidget {
  final String? mainMessage;
  final TextStyle? textStyle;
  final TextStyle? titleStyle;
  final ValueChanged<String>? onChanged;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? height;
  final int? maxLength;
  final bool isPasswordInput;
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

  const CustomEditText(
      {super.key,
      this.textStyle,
      this.titleStyle,
      this.onChanged,
      this.textCapitalization,
      this.textInputType,
      this.backgroundColor,
      this.height,
      this.maxLength,
      this.isPasswordInput = false,
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
      this.contentPadding});

  @override
  State<CustomEditText> createState() => _CustomEditTextState();
}

class _CustomEditTextState extends State<CustomEditText> {
  late bool isTextVisible;
  late TextEditingController controller;
  late FocusNode focusNode = FocusNode();

  @override
  void initState() {
    isTextVisible = !widget.isPasswordInput;
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
    return SizedBox(
      height: widget.height,
      child: TextField(
        enabled: widget.enable ?? true,
        style:
            widget.textStyle ?? AppTextStyles.beVietNamProStyles.regular14White,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        controller: controller,
        focusNode: focusNode,
        autofocus: false,
        cursorColor: widget.cursorColor ?? AppColors.brightGray,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        keyboardType: widget.textInputType ?? TextInputType.text,
        obscureText: widget.isPasswordInput ? !isTextVisible : false,
        inputFormatters: [
          if (widget.inputFormatters != null) ...widget.inputFormatters!,
        ],
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              AppTextStyles.beVietNamProStyles.regular16White,
          counterText: "",
          fillColor: widget.enable == false
              ? AppColors.charlestonGreen
              : widget.backgroundColor,
          filled: true,
          prefixIcon: widget.prefix,
          suffixIcon: widget.isPasswordInput
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      isTextVisible = !isTextVisible;
                    });
                  },
                  child: Icon(
                    isTextVisible ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.brightGray,
                  ),
                )
              : widget.suffix,
          contentPadding: widget.contentPadding ??
              const EdgeInsets.symmetric(vertical: 12.0, horizontal: 11.5),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.brightGray,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.borderColor ?? AppColors.brightGray,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.eucalyptus)),
          errorBorder: UnderlineInputBorder(
              borderSide:
                  BorderSide(color: widget.borderColor ?? AppColors.brinkPink)),
        ),
        maxLength: widget.maxLength,
      ),
    );
  }
}
