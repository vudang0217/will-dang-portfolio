import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/utils/animated_button_v2.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonColors {
  static get backgroundColor => const Color(0xFFECF0F1);
  static get defaultColor => const Color(0xffc3c4c4);
  static get emerald => const Color(0xff2ecc71);
}

class HeaderBody extends StatelessWidget {
  final bool isMobile;
  final bool isTooSmall;
  final bool isMobileSmall;
  const HeaderBody({
    Key key,
    this.isMobile,
    this.isTooSmall,
    this.isMobileSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttons = [
      HeaderButton(
        isMobileSmall: this.isMobileSmall,
        text: 'Contact Me',
        link: 'mailto:vu.dang0217@gmail.com',
        widthPadding: 0,
      ),
      SizedBox(width: 20, height: 20),
      HeaderButton(
        isMobileSmall: this.isMobileSmall,
        text: 'Resume',
        link:
            'https://drive.google.com/file/d/1P-in5xmKr43_0pk1AXrWD8GbaOVCwVWb/view?usp=sharing',
        widthPadding: 20,
      ),
    ];
    final animatedButton = [
      AnimatedButton(
        height: isMobile ?? false ? 42 : 60,
        width: isMobile ?? false ? 145 : 175,
        initialText: 'Contact Me',
        finalText: 'vu.dang0217@gmail.com',
        animationColor: Colors.redAccent,
        textSize: isMobile ?? false ? 20 : 24,
        finalTextSize: 13,
        link: 'mailto:vu.dang0217@gmail.com',
      ),
      SizedBox(width: 20, height: 20),
      AnimatedButton(
        height: isMobile ?? false ? 42 : 60,
        width: isMobile ?? false ? 145 : 175,
        initialText: 'Resume',
        finalText: 'It\'s a PDF!',
        animationColor: Colors.redAccent,
        textSize: isMobile ?? false ? 20 : 24,
        finalTextSize: 20,
        link:
            'https://drive.google.com/file/d/1P-in5xmKr43_0pk1AXrWD8GbaOVCwVWb/view?usp=sharing',
      ),
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          child: AutoSizeText(
            'I\'m a Software',
            style: Theme.of(context).textTheme.headline2,
            maxLines: 1,
          ),
        ),
        FittedBox(
          child: AutoSizeText(
            'Developer < / >',
            style: Theme.of(context).textTheme.headline2,
            //style: TextStyle(fontSize: 50),
            maxLines: 1,
          ),
        ),
        SizedBox(
            height:
                isMobile ?? false ? 20 : 37), //good for empty negative spaces
        SizedBox(
          height: 50,
          child: AutoSizeText(
            'I have 2 years of professional working experience. I am experienced with Java, Python, and C/C++ via my cool projects.',
            style: TextStyle(fontSize: 27),
            //minFontSize: 10,
            //maxFontSize: 24,
            maxLines: 3,
          ),
        ),
        SizedBox(height: isMobile ?? false ? 20 : 40),
        //getColumnOrRow(isTooSmall, buttons),
        // SizedBox(
        //   height: 40,
        // ),
        (isMobile ?? false)
            ? Center(
                child: Row(
                  children: buttons,
                ),
              )
            : getColumnOrRow(isTooSmall, animatedButton),
      ],
    );
  }
}

Widget getColumnOrRow(bool isTooSmall, List<Widget> children) {
  if (isTooSmall ?? false) {
    return Column(children: children);
  } else {
    return Row(children: children);
  }
}

class HeaderButton extends StatelessWidget {
  const HeaderButton({
    Key key,
    @required this.isMobileSmall,
    @required this.text,
    @required this.link,
    @required this.widthPadding,
  }) : super(key: key);

  final bool isMobileSmall;
  final String text;
  final String link;
  final double widthPadding;

  @override
  Widget build(BuildContext context) {
    double verticalPadding;
    double horizontalPadding;
    double fontSize;
    if (isMobileSmall ?? false) {
      verticalPadding = 7;
      horizontalPadding = this.widthPadding;
      fontSize = 18;
    } else {
      verticalPadding = 10;
      horizontalPadding = this.widthPadding + 8;
      fontSize = 20;
    }
    return FlatButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      color: Colors.redAccent,
      onPressed: () => launch(this.link),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: horizontalPadding,
        ),
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
