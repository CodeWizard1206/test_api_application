import 'package:flutter/material.dart';

class ProfileThumb extends StatelessWidget {
  final String initial;
  const ProfileThumb({Key key, this.initial}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: CircleAvatar(
          maxRadius: 30,
          minRadius: 30,
          backgroundColor: Colors.tealAccent,
          child: Text(
            initial,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 45.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
