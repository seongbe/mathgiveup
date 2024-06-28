import 'package:flutter/material.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
   
  const BlueButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                  onPressed: () {
                   
                  },
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 93, 97, 213),
                    ),
                  ),
                );
  }
}