import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/portfolio/portfolio_view.dart';
import 'package:provider/provider.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileDesktopViewBuilder(
      mobileView: DrawerMobileView(),
      desktopView: SizedBox(),
    );
    // return ResponsiveBuilder(
    //   builder: (_, size) {
    //     if (!size.isMobile) return SizedBox();
    //     return DrawerDesktopView();
    //   },
    // );
  }
}

class DrawerMobileView extends StatelessWidget {
  const DrawerMobileView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigationItems = context.watch<List<NavigationItem>>();
    final scrollController = context.watch<ScrollController>();
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero, //zero = no padding
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Welcome to my portfolio!',
              style: Theme.of(context).textTheme.headline4.copyWith(
                    color: Colors.white,
                  ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.red[900], Colors.deepPurple],
                  tileMode: TileMode.mirror),
            ),
          ),
          for (var item in navigationItems)
            ListTile(
              title: Text(
                item.text,
                style: Theme.of(context).textTheme.headline4.copyWith(
                      fontSize: 18,
                    ),
              ),
              onTap: () {
                scrollController.animateTo(
                  item.position,
                  duration: Duration(milliseconds: 700),
                  curve: Curves.easeInOut,
                );
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
