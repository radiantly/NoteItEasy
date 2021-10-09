import 'package:flutter/material.dart';
import 'package:noteiteasy/globals.dart' as globals;
import 'package:google_fonts/google_fonts.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {Key? key, required this.gradient, this.style})
      : super(key: key);

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: GradientText("Note it Easy",
                  style: GoogleFonts.loveYaLikeASister(
                      textStyle: TextStyle(fontSize: 42)),
                  gradient: const LinearGradient(
                      // TODO: Fix Gradient rotation here to be diagonal
                      colors: [globals.gradientPurple, globals.gradientPink])),
            ),
          ],
        )
      ],
    )));
  }
}
