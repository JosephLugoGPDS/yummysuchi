
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventario_yummy_sushi/app/constants/app_theme.dart';
import 'package:inventario_yummy_sushi/app/extensions/size_extension.dart';

class ThemeTextFormField extends StatelessWidget {
  const ThemeTextFormField({
    Key? key,
    this.textEditingController,
    this.hint,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.leftIcon,
    this.rightIcon,
    this.onRightTap,
    this.obscureText = false,
    this.onChanged,
    this.onSubmitted,
    this.borderRadius = 5,
    this.width,
    this.maxLines,
    this.hintColor,
    this.inputFormatters,
    this.initialValue,
    this.onTap,
    this.label,
    this.readOnly = false,
    this.isDense = true,
    this.keyboardType = TextInputType.text,
    this.textCapitalization = TextCapitalization.none,
    this.maxLength,
    this.styleLabel,
    this.style,
    this.hintStyle,
    this.disableBorder,
    this.enabledBorder,
    this.focusedBorder,
    this.borderColor = AppTheme.grayTextColor,
    this.margin,
  }): super(key: key);

  final TextEditingController? textEditingController;
  final String? hint;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function()? onRightTap;
  final void Function()? onTap;
  final TextInputAction textInputAction;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final double borderRadius;
  final double? width;
  final int? maxLines;
  final Color? hintColor;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final InputBorder? disableBorder;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final String? label;
  final bool readOnly;
  final bool isDense;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final int? maxLength;
  final TextStyle? styleLabel;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final Color borderColor;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero, 
      child: TextFormField(
        controller: textEditingController,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onTap: onTap,
        textCapitalization: textCapitalization,
        readOnly: readOnly,
        onFieldSubmitted: onSubmitted,
        style: style ?? TextStyle(color: Colors.black,  fontWeight: FontWeight.bold, fontSize: 12.sp),
        textInputAction: textInputAction,
        obscureText: obscureText,
        cursorColor: AppTheme.grayTextColor,
        maxLines: maxLines,
        initialValue: initialValue,
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        validator: validator ?? (String? value) {
          return value!.isEmpty ? 'required' : null;
        },
        
        decoration: InputDecoration(
          alignLabelWithHint: true,
          suffixIcon: GestureDetector(
            onTap: onRightTap,
            child: Icon(rightIcon)
          ),
          // labelText: label,
          floatingLabelStyle: styleLabel,
          hintStyle: hintStyle ?? TextStyle(color: hintColor ?? AppTheme.grayTextColor, fontSize: 12.sp),
          labelStyle: styleLabel ?? TextStyle(color: AppTheme.grayTextColor, fontSize: 14.sp),
          border: InputBorder.none,
          hintText: hint,
          isDense: isDense,
          hintMaxLines: 1,
          label: label != null ? Text(
            label!,
            style: styleLabel ?? TextStyle(color: AppTheme.grayTextColor, fontSize: 14.sp),
          )
          : null,
          
          disabledBorder: disableBorder ?? OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1.2
            ),
          ),
          enabledBorder: enabledBorder ?? OutlineInputBorder(
            borderSide: BorderSide(
              color: borderColor,
              width: 1.2
            ),
          ),
          focusedBorder: focusedBorder ?? const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppTheme.accentColor,
              width: 1.2
            ),
          ),
        ),
      ),
    );
  }
}
