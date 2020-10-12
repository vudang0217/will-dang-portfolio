import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/components/desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_view_builder.dart';
import 'package:portfolio_flutter_web/project/project_item_body.dart';

class ProjectItem {
  final String image;
  final String title;
  final String description;
  final List<String> technologies;

  //constructor using 'final' parameter has to be 'named parameter'
  //required means it will be compiled for us to have necessary field inside project
  ProjectItem({
    @required this.image,
    @required this.title,
    @required this.description,
    @required this.technologies,
  });
}

// add project later here
final kProjectItems = [
  ProjectItem(
    image: 'images/SurfStore_image.png',
    title: 'SurfStore',
    description:
        'A cloud storage system that allows client to connect and upload files. The cloud encrypts data to ensure security and supports version control.',
    technologies: ['Java', 'Apache Server'],
  ),
  ProjectItem(
    image: 'images/Diamondback_image.png',
    title: 'Diamondback',
    description:
        'A functional language that is compiled to ARM assembly code. Supports memory allocation in the heap.Diamondback is optimized to run faster.',
    technologies: ['Ocaml', 'ARM x86-64', 'C'],
  ),
  ProjectItem(
    image: 'images/2048_image.png',
    title: '2048 Solver',
    description:
        'An  artificial intelligence that solves the puzzle game 2048 on its own.',
    technologies: ['Python', 'Java'],
  ),
];

class ProjectView extends StatelessWidget {
  const ProjectView({
    Key key,
  }) : super(key: key);
  static const title = 'Projects';
  @override
  Widget build(BuildContext context) {
    return MobileDesktopViewBuilder(
      mobileView: ProjectMobileView(),
      desktopView: ProjectDesktopView(),
    );
  }
}

class ProjectDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DesktopViewBuilder(
      titleText: ProjectView.title,
      children: [
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final item in kProjectItems)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ProjectItemBody(
                    item: item,
                    isSmall: width < 782,
                  ),
                ),
              )
          ],
        ),
        SizedBox(height: 70),
      ],
    );
  }
}

//if we dont have a height in Container that constrains the expanded,
//we will get error
class ProjectMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileViewBuilder(
      titleText: ProjectView.title,
      children: [for (final item in kProjectItems) ProjectItemBody(item: item)],
    );
  }
}
