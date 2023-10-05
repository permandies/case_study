import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController textEditingController;
  final String label;
  final String title;
  final Function(String? v) validator;
  final TextInputType? textInputType;
  final bool isThisPasswordField;

  const MyTextField({
    super.key,
    this.textInputType,
    required this.textEditingController,
    required this.label,
    required this.title,
    required this.validator,
    this.isThisPasswordField = false,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool showText = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.w500, color: Color.fromARGB(255, 60, 62, 66)),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 80,
          child: TextFormField(
            controller: widget.textEditingController,
            autofocus: false,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Color.fromARGB(255, 47, 48, 50)),
            validator: (value) => widget.validator(value),
            obscureText: widget.isThisPasswordField ? showText : false,
            keyboardType: widget.textInputType,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              focusColor: const Color.fromARGB(255, 231, 231, 231),
              suffixIconColor: Colors.black54,
              suffixIcon: widget.isThisPasswordField
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          showText = !showText;
                        });
                      },
                      icon: Icon(showText ? FontAwesomeIcons.eye : FontAwesomeIcons.eyeSlash))
                  : null,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(221, 47, 47, 47)),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(221, 47, 47, 47)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(221, 47, 47, 47)),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(194, 0, 0, 0), width: 1.5),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color.fromARGB(221, 47, 47, 47)),
              ),
              fillColor: Colors.white,
              hoverColor: Colors.white,
              labelText: widget.label,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color.fromARGB(143, 60, 62, 66)),
            ),
          ),
        ),
      ],
    );
  }
}
