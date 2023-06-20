import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  final String title;

  const HeaderWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Divider(),
      ],
    );
  }
}
