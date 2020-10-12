import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/blog/blog_view.dart';
import 'package:portfolio_flutter_web/drawer/drawer_view.dart';
import 'package:portfolio_flutter_web/experience/experience_view.dart';
import 'package:portfolio_flutter_web/footer/footer_view.dart';
import 'package:portfolio_flutter_web/header/header_view.dart';
import 'package:portfolio_flutter_web/navigation_bar/navigation_bar_view.dart';
import 'package:portfolio_flutter_web/portfolio/back_to_top_button.dart';
import 'package:portfolio_flutter_web/project/project_view.dart';
import 'package:portfolio_flutter_web/skills/skills_view.dart';
import 'package:provider/provider.dart';

class PortfolioView extends StatefulWidget {
  const PortfolioView({
    Key key,
  }) : super(key: key);

  @override
  _PortfolioViewState createState() => _PortfolioViewState();
}

class _PortfolioViewState extends State<PortfolioView> with AfterLayoutMixin {
  final projectKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final blogKey = GlobalKey();
  List<NavigationItem> navigationItems = []; //empty list

  final ScrollController scrollController = ScrollController(
    initialScrollOffset: 0,
    //everytime we refresh, we start at height 1750(skills)
  );
  @override
  void afterFirstLayout(BuildContext context) {
    setState(() {
      navigationItems = [
        //flutter convention : global variable starts with 'k'
        NavigationItem('Projects', key: projectKey),
        NavigationItem('Skills', key: skillsKey),
        NavigationItem('Experiences', key: experienceKey),
        NavigationItem('Blog', key: blogKey),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height; //current height of web
    final width = MediaQuery.of(context).size.width; //current width of web

    return MultiProvider(
      providers: [
        //proxy provider updates data in the widget tree
        //normal provider dont do that
        //we need proxy provider to update because
        //navigationItems get updated after the content is rendered
        //because of afterFirstL
        ProxyProvider0<List<NavigationItem>>(update: (_, __) {
          return navigationItems;
        }),
        ChangeNotifierProvider<ScrollController>(create: (_) {
          return scrollController;
        })
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        //backgroundColor: Colors.tealAccent,
        endDrawer: DrawerView(),
        body: SizedBox(
          width: width,
          child: SingleChildScrollView(
            //and child under SingleChildScrollView is scrollable
            controller: scrollController,
            child: Column(
              children: [
                NavigationBarView(),
                //most screens are 1080 height (1080 * 864)
                HeaderView(),
                ProjectView(key: projectKey),
                SkillsView(key: skillsKey),
                ExperienceView(key: experienceKey),
                BlogView(key: blogKey),
                FooterView(),
              ], //do not use the whole width of screenn as it is hard to read
            ),
          ),
        ),
        floatingActionButton: BackToTopButton(),
      ),
    );
  }
}

class NavigationItem {
  // make a class instead of string list because u can add icon
  final String text; // maker another parameter if icon needed
  final GlobalKey key;

  NavigationItem(
    this.text, {
    @required this.key,
  });

//allow for instance (i.e. a) to be called a.position which returns _getPosition(key)
  double get position => _getPosition(key);
}

double _getPosition(GlobalKey key) {
  final RenderBox renderBox = key.currentContext.findRenderObject();
  final position = renderBox.localToGlobal(Offset.zero);
  final scrollOffset = position.dy;
  return scrollOffset;
}
