import 'package:flutter/material.dart';

typedef FunctionStringCallback = void Function(String data);

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final double verticalPadding;
  final String value;
  final Icon suffixIcon;
  final bool showLabel;
  final TextEditingController controller;
  final FunctionStringCallback validator;
  final FunctionStringCallback onChange;
  
  CustomTextFormField(
      {@required this.hintText,
      this.verticalPadding,
      this.value,
      this.suffixIcon,
      this.controller,
      this.onChange,
      this.validator,
      this.showLabel = true});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          showLabel
              ? Text(
                  hintText.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    color: Color(0xFF9CA4AA),
                  ),
                )
              : SizedBox(),
          SizedBox(
            height: 7.0,
          ),
          TextFormField(
            onChanged:  (value) {
              onChange(value);
            },
            initialValue: value,
            validator: validator,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              contentPadding: EdgeInsets.symmetric(
                  vertical: verticalPadding != null ? verticalPadding : 10.0,
                  horizontal: 15.0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey[400],
                ),
              ),
              hintText: hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
                color: Colors.grey[400],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
