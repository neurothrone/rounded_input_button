import 'package:flutter/material.dart';

class RoundedInputButton extends StatelessWidget {
  const RoundedInputButton({
    super.key,
    required this.controller,
    required this.onPressed,
    required this.buttonText,
    this.hintText = "",
    this.borderRadius = 30.0,
    this.borderColor = Colors.transparent,
    this.focusedBorderColor = Colors.blue,
    this.buttonForegroundColor = Colors.white,
    this.buttonBackgroundColor = Colors.blue,
    this.buttonDisabledColor,
    this.textAlign = TextAlign.center,
  });

  final TextEditingController controller;
  final VoidCallback onPressed;
  final String buttonText;
  final String hintText;

  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;

  final Color buttonForegroundColor;
  final Color buttonBackgroundColor;
  final Color? buttonDisabledColor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: LeftRoundedTextField(
              onSubmitted: onPressed,
              controller: controller,
              hintText: hintText,
              borderColor: borderColor,
              focusedBorderColor: focusedBorderColor,
              borderRadius: borderRadius,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: double.infinity,
            child: RightRoundedButton(
              onTap: onPressed,
              controller: controller,
              text: buttonText,
              borderRadius: borderRadius,
              foregroundColor: buttonForegroundColor,
              backgroundColor: buttonBackgroundColor,
              disabledColor: buttonDisabledColor ?? Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}

class LeftRoundedTextField extends StatelessWidget {
  const LeftRoundedTextField({
    super.key,
    required this.onSubmitted,
    required this.controller,
    this.hintText = "",
    required this.borderRadius,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.textAlign,
  });

  final TextEditingController controller;
  final VoidCallback onSubmitted;
  final String hintText;
  final double borderRadius;
  final Color borderColor;
  final Color focusedBorderColor;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: focusedBorderColor,
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            bottomLeft: Radius.circular(borderRadius),
          ),
        ),
      ),
      onSubmitted: (_) => onSubmitted(),
    );
  }
}

class RightRoundedButton extends StatefulWidget {
  const RightRoundedButton({
    super.key,
    required this.onTap,
    required this.controller,
    required this.text,
    required this.borderRadius,
    required this.foregroundColor,
    required this.backgroundColor,
    required this.disabledColor,
  });

  final VoidCallback onTap;
  final TextEditingController controller;
  final String text;

  final double borderRadius;

  final Color foregroundColor;
  final Color backgroundColor;
  final Color disabledColor;

  @override
  State<RightRoundedButton> createState() => _RightRoundedButtonState();
}

class _RightRoundedButtonState extends State<RightRoundedButton> {
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Add a listener on controller to enable/disable button
    widget.controller.addListener(() {
      setState(() {
        isButtonEnabled = widget.controller.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 60.0),
      child: Material(
        color: isButtonEnabled ? widget.backgroundColor : widget.disabledColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.borderRadius),
            bottomRight: Radius.circular(widget.borderRadius),
          ),
        ),
        child: InkWell(
          onTap: !isButtonEnabled
              ? null
              : () {
            widget.onTap();
            FocusScope.of(context).unfocus();
          },
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(widget.borderRadius),
            bottomRight: Radius.circular(widget.borderRadius),
          ),
          splashColor: Colors.deepPurple.shade700,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(widget.borderRadius),
                bottomRight: Radius.circular(widget.borderRadius),
              ),
            ),
            child: Text(
              widget.text,
              style: TextStyle(
                color: widget.foregroundColor,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
