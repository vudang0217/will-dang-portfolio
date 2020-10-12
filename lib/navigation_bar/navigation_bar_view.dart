import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/constants.dart';
import 'package:portfolio_flutter_web/portfolio/portfolio_view.dart';
import 'package:provider/provider.dart';
import 'package:portfolio_flutter_web/utils/hover_extensions.dart';

class NavigationBarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileDesktopViewBuilder(
      mobileView: NavigationMobileView(),
      desktopView: NavigationDesktopView(),
    );
  }
}

class NavigationDesktopView extends StatelessWidget {
  const NavigationDesktopView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationItems = context.watch<List<NavigationItem>>();
    final scrollController = context.watch<ScrollController>();
    return Container(
      height: 100,
      width: 1507,
      padding: kScreenPadding,
      child: Row(
        children: [
          Image.asset('images/navbar_logo.png', height: 60),
          Spacer(), //widget that expands as much as possible
          for (var item in navigationItems)
            NavigationBarItem(
                    onPressed: () {
                      scrollController.animateTo(
                        item.position,
                        duration: Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                      );
                    },
                    text: item.text)
                .moveUpOnHover,
        ],
      ),
    );
  }
}

class NavigationMobileView extends StatelessWidget {
  const NavigationMobileView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          SizedBox(width: 20),
          Image.asset('images/navbar_logo.png', height: 70),
          Spacer(),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          )
        ],
      ),
    );
  }
}

class NavigationBarItem extends StatelessWidget {
  const NavigationBarItem({
    Key key,
    @required this.onPressed,
    @required this.text,
  }) : super(key: key);

  final void Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    //final isSmall = MediaQuery.of(context).size.width < 710;
    //final isSmaller = MediaQuery.of(context).size.width < 630;
    final currWidth = MediaQuery.of(context).size.width;
    double fontSize = 24;
    if (currWidth < 630) {
      fontSize = 13;
    } else if (currWidth < 710) {
      fontSize = 17;
    }
    return Container(
      padding: const EdgeInsets.only(left: 64),
      child: InkWell(
        onTap: onPressed,
        mouseCursor: MaterialStateMouseCursor.clickable,
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
