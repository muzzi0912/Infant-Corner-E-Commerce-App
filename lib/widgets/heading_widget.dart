// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:infant_corner/utils/app-constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;

  const HeadingWidget({
    Key? key,
    required this.headingTitle,
    required this.headingSubTitle,
    required this.onTap,
    required this.buttonText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "Poppins",
                    color: Colors.grey.shade800,
                  ),
                ),
                AnimatedRainbowText(
                  text: headingSubTitle,
                  duration: Duration(seconds: 3),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    color: AppConstant.appSecoundryColor,
                    width: 1.5,
                  ),
                  color: AppConstant
                      .appSecoundryColor, // Set the background color to black
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins",
                      fontSize: 12.0,
                      color: AppConstant.appTextColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedRainbowText extends StatefulWidget {
  final String text;
  final Duration duration;

  const AnimatedRainbowText({
    Key? key,
    required this.text,
    required this.duration,
  }) : super(key: key);

  @override
  _AnimatedRainbowTextState createState() => _AnimatedRainbowTextState();
}

class _AnimatedRainbowTextState extends State<AnimatedRainbowText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _positionAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _positionAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {}); // Trigger a rebuild on each animation frame
      });

    _colorAnimation = RainbowColorTween(_controller).animate(_controller);

    _controller.repeat(); // Let the animation repeat continuously
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return LinearGradient(
          colors: [
            _colorAnimation.value!,
            Colors
                .transparent, // Use a transparent color to smoothly transition to the next color
          ],
          stops: [
            _positionAnimation.value,
            _positionAnimation.value +
                0.1, // Adjust the value to control the smoothness of the transition
          ],
        ).createShader(bounds);
      },
      child: Text(
        widget.text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontFamily: "Poppins",
          fontSize: 12.0,
          color: Colors.white, // Use any initial color here
        ),
      ),
    );
  }
}

class RainbowColorTween extends TweenSequence<Color?> {
  RainbowColorTween(Animation<double> parent)
      : super(_generateTweenSequence(parent));

  static List<TweenSequenceItem<Color?>> _generateTweenSequence(
      Animation<double> parent) {
    const List<Color> rainbowColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    List<TweenSequenceItem<Color?>> items = [];

    for (int i = 0; i < rainbowColors.length; i++) {
      items.add(
        TweenSequenceItem(
          tween: ColorTween(
            begin: rainbowColors[i],
            end: rainbowColors[(i + 1) % rainbowColors.length],
          ),
          weight: 1.0,
        ),
      );
    }

    return items;
  }
}
