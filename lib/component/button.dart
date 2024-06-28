import 'package:flutter/material.dart';
import 'package:mathgame/const/colors.dart';

class BlueButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
   
  const BlueButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: BACKGROUND_COLOR
                    ),
                  onPressed:  onPressed,
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                );
  }
}