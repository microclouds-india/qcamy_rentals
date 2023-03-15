import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qcamyrentals/config/colors.dart';

class BookingFormTextFields extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool readOnly;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextEditingController? controller;
  const BookingFormTextFields(
      {Key? key,
      required this.hint,
      required this.maxLines,
      this.keyboardType,
      this.inputFormatters,
      this.suffixIcon,
      this.maxLength,
      this.readOnly = false,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 5)),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.05)),
      ),
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        readOnly: readOnly,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        maxLines: maxLines,
        style: const TextStyle(color: Colors.black, fontSize: 13),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          isDense: true,
          fillColor: Colors.white,
          filled: true,
          hintText: hint,
          counterText: "",
          hintStyle: const TextStyle(color: grey),
          contentPadding: const EdgeInsets.all(12),
          border: InputBorder.none,

          // enabledBorder: OutlineInputBorder(
          //   borderSide: BorderSide(color: Colors.grey.shade800, width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: const BorderSide(color: primaryColor, width: 1),
          //   borderRadius: BorderRadius.circular(10),
          // ),
          // focusedBorder: const UnderlineInputBorder(
          //   borderSide: BorderSide(color: primaryColor),
          // ),
        ),
      ),
    );
  }
}
