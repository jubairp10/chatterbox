import 'package:flutter/material.dart';
class MyTextField extends StatelessWidget {
  final  String hintText;
  final bool obsecureText;
  final TextEditingController controller;
  const MyTextField({Key? key, required this.hintText, required this.obsecureText, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        decoration: InputDecoration(enabledBorder:
        OutlineInputBorder(
          borderSide:BorderSide(color: Theme.of(context).colorScheme.tertiary)
        ),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
        fillColor: Theme.of(context).colorScheme.secondary,
        filled: true,
        hintText:hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),

      ),
    );
  }
}
