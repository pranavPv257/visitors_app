import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors_app/const/responsive.dart';
import 'package:visitors_app/const/sized_box.dart';

import 'colors.dart';

Widget text({
  String? text,
  double? size,
  Color? color,
  int? maxLines,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  String? fontFamily,
  TextDecoration? decoration,
  TextOverflow? overFlow,
  double? wordSpacing,
  double? letterSpacing,
  TextDecorationStyle? decorationStyle,
  Color? decorationColor,
}) {
  return Text(
    text ?? '',
    maxLines: maxLines,
    textAlign: textAlign,
    style: TextStyle(
      fontSize: size,
      color: color ?? AppColor.white,
      fontWeight: fontWeight,
      fontFamily: fontFamily ?? GoogleFonts.inter().fontFamily,
      decoration: decoration,
      decorationColor: decorationColor,
      overflow: overFlow,
      wordSpacing: wordSpacing,
      letterSpacing: letterSpacing,
      decorationStyle: decorationStyle,
    ),
  );
}

Widget button({
  double? height,
  double? width,
  Color? color,
  BorderRadius? borderRadius,
  String? name,
  Function()? onTap,
  double? fontSize,
  Color? textColor = AppColor.white,
  Color borderColor = AppColor.appPrimary,
  bool isLoading = false,
  bool isIcon = false,
  String? image,
  FontWeight? fontWeight,
}) {
  log(isLoading.toString());
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color ?? AppColor.appPrimary,
        borderRadius: borderRadius ?? BorderRadius.circular(4),
        border: Border.all(color: borderColor),
      ),
      child: Center(
        child: isLoading
            ? const CupertinoActivityIndicator(color: AppColor.white)
            : isIcon
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.string(image ?? ''),
                  const SizeBoxV(10),
                  text(
                    text: name ?? 'Continue',
                    size: fontSize,
                    color: textColor,
                    fontWeight: fontWeight,
                    letterSpacing: 1,
                  ),
                ],
              )
            : text(
                text: name ?? 'Continue',
                size: fontSize,
                color: textColor,
                fontWeight: fontWeight,
                letterSpacing: 1,
              ),
      ),
    ),
  );
}

Widget buildCommonTextFormField({
  double? hintFontSize,
  TextStyle? style,
  bool expands = false,
  Color borderColor = Colors.black12,
  required Color bgColor,
  required String hintText,
  Color hintTextColor = AppColor.hintTextColor,
  Widget? prefixIcon,
  Color color = AppColor.black,
  required TextInputType keyboardType,
  required TextInputAction textInputAction,
  String? Function(String?)? validator,
  int? maxLength,
  required TextEditingController? controller,
  List<TextInputFormatter>? inputFormatters,
  EdgeInsetsGeometry? contentPadding = const EdgeInsets.only(left: 30, top: 18, bottom: 18, right: 10),
  bool obscureText = false,
  Widget? suffixIcon,
  void Function()? onTap,
  bool enabled = true,
  bool readOnly = false,
  double radius = 8,
  int? minLine,
  int? maxLine,
  FocusNode? focusNode,
  bool isFromChat = false,
  void Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  required BuildContext context,
  bool isFromPhoneText = false,
}) {
  return TextFormField(
    inputFormatters: inputFormatters,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    onTap: onTap,
    style: style ?? TextStyle(fontFamily: GoogleFonts.inter().fontFamily, color: color, fontSize: 24),
    expands: expands,
    keyboardType: keyboardType,
    obscureText: obscureText,
    textInputAction: textInputAction,
    enabled: enabled,
    focusNode: focusNode,
    decoration: InputDecoration(
      prefixIcon: prefixIcon,
      counterText: '',
      contentPadding: contentPadding,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: isFromPhoneText ? BorderSide.none : BorderSide(color: borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: isFromPhoneText ? BorderSide.none : BorderSide(color: borderColor),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: isFromPhoneText ? BorderSide.none : BorderSide(color: borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: isFromPhoneText ? BorderSide.none : const BorderSide(color: Color(0x26000000)),
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      suffixIcon: suffixIcon,
      fillColor: bgColor,
      filled: true,
      labelText: hintText,
      labelStyle: TextStyle(color: hintTextColor, fontWeight: FontWeight.w300, fontSize: hintFontSize ?? 34),
    ),
    validator: validator,
    maxLength: maxLength,
    controller: controller,
    readOnly: readOnly,
    minLines: minLine,
    maxLines: maxLine,
  );
}

bool _isToastShowing = false;

void toast(BuildContext context, {String? title, int duration = 2, Color? backgroundColor}) {
  if (_isToastShowing) return;

  _isToastShowing = true;

  final scaffold = ScaffoldMessenger.of(context);
  final mediaQuery = MediaQuery.of(context);
  final bool isKeyboardOpen = mediaQuery.viewInsets.bottom > 0.0;

  scaffold
      .showSnackBar(
        SnackBar(
          backgroundColor: backgroundColor,
          duration: Duration(seconds: duration),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            height: Responsive.height * 3,
            width: Responsive.width * 90,
            alignment: Alignment.center,
            child: Text(
              title ?? 'Something went wrong',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: isKeyboardOpen ? mediaQuery.viewInsets.bottom : 15.0, left: 8.0, right: 8.0),
        ),
      )
      .closed
      .then((reason) {
        _isToastShowing = false;
      });
}
