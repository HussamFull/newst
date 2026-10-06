import 'package:flutter/material.dart';

class CustomTextFormFeild extends StatefulWidget {
  const CustomTextFormFeild({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    required this.obscureText,
    required this.hintText,
    this.suffixIcon,
    this.maxLines,
  });

  final String title;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final String hintText;
  final Widget? suffixIcon;
  final int? maxLines;

  @override
  State<CustomTextFormFeild> createState() => _CustomTextFormFeildState();
}

class _CustomTextFormFeildState extends State<CustomTextFormFeild> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: Color(0xFF141414),
          ),
        ),

        SizedBox(height: 8),

        TextFormField(
          controller: widget.controller,
          maxLines: widget.maxLines,
          validator: widget.validator != null
              ? (String? value) => widget.validator!(value)
              : null,

          obscureText: widget.obscureText && !isVisible,

          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.obscureText
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        isVisible = !isVisible;
                      });
                    },
                    icon: isVisible
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
