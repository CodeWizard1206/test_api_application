import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const InputField(
      {Key key,
      this.title,
      this.controller,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(
        6.0,
      ),
      child: TextFormField(
        cursorColor: Colors.teal,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: title,
          hintText: title,
          // enabledBorder: inputBoxStyle,
          // focusedBorder: inputBoxStyle,
        ),
        maxLines: 1,
      ),
    );
  }
}
