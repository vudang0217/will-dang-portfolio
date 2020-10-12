import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimatedButton extends StatefulWidget {
  final double height;
  final double width;
  final String initialText;
  final String finalText;
  final double textSize;
  final double finalTextSize;
  final Color animationColor;
  final String link;

  AnimatedButton(
      {this.height,
      this.width,
      this.initialText,
      this.animationColor,
      this.textSize,
      this.finalText,
      this.finalTextSize,
      this.link});

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  Color textColor;
  Color borderColor;
  Color finalTextColor;
  AnimationController _controller;
  Animation _animation;
  Animation _finalTextColorAnimation;

  @override
  void initState() {
    super.initState();
    textColor = widget.animationColor;
    borderColor = widget.animationColor;
    finalTextColor = Colors.transparent;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );

    _animation = Tween(begin: 0.0, end: 500.0)
        .animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller))
          ..addListener(() {
            setState(() {});
          });
    _finalTextColorAnimation = ColorTween(
            begin: Colors.transparent, end: Colors.white)
        .animate(CurvedAnimation(curve: Curves.easeInOut, parent: _controller));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: widget.animationColor,
            width: 3,
          ),
        ),
        child: InkWell(
          //InkWell needs Material as ancestor
          onTap: () {
            _controller.forward();
            setState(() {
              finalTextColor = Colors.white;
              textColor = Colors.transparent;
            });
            _controller.reverse();
            setState(() {
              finalTextColor = Colors.transparent;
              textColor = widget.animationColor;
            });
            return launch(widget.link);
          },
          onHover: (value) {
            if (value) {
              _controller.forward();
              setState(() {
                finalTextColor = Colors.white;
                textColor = Colors.transparent;
              });
            } else {
              _controller.reverse();
              setState(() {
                finalTextColor = Colors.transparent;
                textColor = widget.animationColor;
              });
            }
          },
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: widget.animationColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    width: _animation.value,
                  ),
                ),
                //final text
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    child: Text(
                      widget.finalText,
                      style: TextStyle(
                        color: finalTextColor,
                        fontSize: widget.finalTextSize,
                      ),
                    ),
                    curve: Curves.easeIn,
                  ),
                ),
                //initial text
                Center(
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 50),
                    child: Text(
                      widget.initialText,
                      style: TextStyle(
                        color: textColor,
                        fontSize: widget.textSize,
                      ),
                    ),
                    curve: Curves.easeIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
