import 'package:flutter/material.dart';

import 'package:portfolio_flutter_web/components/desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_desktop_view_builder.dart';
import 'package:portfolio_flutter_web/components/mobile_view_builder.dart';
import 'package:portfolio_flutter_web/experience/experience_container.dart';
// ignore: unused_import
import 'package:portfolio_flutter_web/skills/skills_view.dart';

class ExperienceView extends StatelessWidget {
  const ExperienceView({
    Key key,
  }) : super(key: key);
  static const title = 'Experience';
  @override
  Widget build(BuildContext context) {
    return MobileDesktopViewBuilder(
      mobileView: ExperienceMobileView(),
      desktopView: ExperienceDesktopView(),
    );
  }
}

class ExperienceDesktopView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DesktopViewBuilder(
      titleText: ExperienceView.title,
      children: [
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var rowIndex = 0; rowIndex < experiences.length; rowIndex++)
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ExperienceContainer(
                  experience: experiences.elementAt(rowIndex),
                  index: rowIndex,
                ),
              )),
          ],
        ),
        SizedBox(
          height: 70,
        )
      ],
    );
  }
}

class ExperienceMobileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MobileViewBuilder(
      titleText: ExperienceView.title,
      children: [
        Column(
          children: [
            for (final experience in experiences)
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ExperienceContainer(
                  experience: experience,
                  index: experiences.indexOf(experience),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
