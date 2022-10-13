import 'package:flutter/material.dart';
import '../utils/styles.dart';

class SubmitButton extends StatefulWidget {
  const SubmitButton({ 
    Key? key,
    required this.text,
    required this.onPressed,
    required this.bgColor,
    required this.fontColor,
    this.isLoading,
    this.fontSize,
    this.style,
    this.width
  }) : super(key: key);
  final String text; 
  final VoidCallback onPressed;
  final Color bgColor;
  final Color fontColor;
  final dynamic fontSize;
  final bool? isLoading;
  final dynamic style;
  // ignore: prefer_typing_uninitialized_variables
  final width;


  @override
  State<SubmitButton> createState() => _SubmitButtonState();
}

class _SubmitButtonState extends State<SubmitButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ??MediaQuery.of(context).size.width,
      height: 48.0,
      child: ElevatedButton(
        onPressed: widget.onPressed, 
        child: Text(
          widget.text,
          // style:ralewayRegular(widget.fontColor,  widget.fontSize==null||widget.fontSize==''?16.sp:widget.fontSize, 0.14),
        ),
        style: widget.style??ElevatedButton.styleFrom(
          elevation: 0.5,
          padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side:  BorderSide(
              color: grey.withOpacity(0.5),
              width: 1
            )
          ),
          primary: widget.bgColor,
        ),
      ),
    );
  }
}