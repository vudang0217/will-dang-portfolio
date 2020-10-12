import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileDesktopViewBuilder extends StatelessWidget {
  const MobileDesktopViewBuilder({
    Key key,
    this.showMobile,
    @required this.mobileView,
    @required this.desktopView,
  }) : super(key: key);

  final bool showMobile; /* Will Dang added this */
  final Widget mobileView;
  final Widget desktopView;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (_, size) {
        //if showMobile is null then use size.isMobile, else use showMobile
        if (showMobile ?? size.isMobile) return mobileView;
        return desktopView;
      },
    );
  }
}
