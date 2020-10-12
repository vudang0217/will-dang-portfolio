import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio_flutter_web/utils/hover_extensions.dart';

class FooterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileDesktopViewBuilder(
      mobileView: FooterMobileView(),
      desktopView: FooterDesktopView(),
    );
  }
}

class FooterDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year; //return current year
    return Container(
      height: 100,
      width: kInitWidth,
      padding: kScreenPadding,
      child: Row(
        children: [
          Text('© Will Dang $currentYear -- '),
          InkWell(
            child: Text(
              'See the source code',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            mouseCursor: MaterialStateMouseCursor.clickable,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () =>
                launch('https://github.com'), //make sure you include https
          ),
          Spacer(),
          for (final social in socials)
            IconButton(
              icon: social.icon,
              onPressed: () => launch(social.url),
              color: Colors.red,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ).moveUpOnHover,
          SizedBox(width: 60),
        ],
      ),
    );
  }
}

class FooterMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year; //return current year
    return Container(
      padding: kScreenPadding,
      height: 150,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (final social in socials)
                IconButton(
                  icon: social.icon,
                  onPressed: () => launch(social.url),
                  color: Colors.red,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                )
            ],
          ),
          SizedBox(height: 20),
          Text('© Will Dang $currentYear'),
          SizedBox(height: 20),
          InkWell(
            child: Text(
              'See the source code',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            mouseCursor: MaterialStateMouseCursor.clickable,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            onTap: () =>
                launch('https://github.com'), //make sure you include https
          ),
        ],
      ),
    );
  }
}

class SocialInfo {
  final Widget icon;
  final String url;
  SocialInfo({
    @required this.icon,
    @required this.url,
  });
}

final socials = [
  SocialInfo(
    icon: FaIcon(FontAwesomeIcons.facebook),
    url: 'https://www.facebook.com/vuiuhUyk',
  ),
  SocialInfo(
    icon: FaIcon(FontAwesomeIcons.twitter),
    url: 'https://www.twitter.com/vudang0217',
  ),
  SocialInfo(
    icon: FaIcon(FontAwesomeIcons.linkedin),
    url: 'https://www.linkedin.com/in/willdang/',
  ),
  SocialInfo(
    icon: FaIcon(FontAwesomeIcons.github),
    url: 'https://github.com/vudang0217',
  ),
];
