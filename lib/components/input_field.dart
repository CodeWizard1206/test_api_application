import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const InputField({Key key, this.title, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(
        6.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                labelText: title,
                hintText: title,
                // enabledBorder: inputBoxStyle,
                // focusedBorder: inputBoxStyle,
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
