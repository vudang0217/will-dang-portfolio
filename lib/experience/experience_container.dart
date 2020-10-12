import 'package:flutter/material.dart';
import 'package:portfolio_flutter_web/utils/colour_assets.dart';

class ExperienceContainer extends StatelessWidget {
  const ExperienceContainer({
    Key key,
    @required this.experience,
    @required this.index,
  }) : super(key: key);

  final ExperienceInfo experience;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = ColourAssets.all;
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: colors.elementAt(index % colors.length),
          ),
          borderRadius: BorderRadius.circular(3),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.company,
              style: textStyle(isBold: true),
            ),
            SizedBox(height: 10),
            Text(
              experience.timeline,
              style: textStyle(isGrey: true),
            ),
            SizedBox(height: 10),
            for (var item in experience.descriptions)
              Text(
                item,
                style: textStyle(),
              ),
          ],
        ));
  }
}

//
// underscore _ indicate PRIVATE function or variables in dart
TextStyle textStyle({bool isBold, bool isGrey}) {
  return TextStyle(
    fontSize: 20,
    height: 1.3,
    fontWeight: (isBold ?? false) ? FontWeight.bold : FontWeight.normal,
    color: isGrey ?? false ? Colors.grey : Colors.black,
  );
}

class ExperienceInfo {
  final String company;
  final String timeline;
  final List<String> descriptions;
  ExperienceInfo({
    @required this.company,
    @required this.timeline,
    @required this.descriptions,
  });
}

final experiences = [
  ExperienceInfo(
    company: 'Technical Assistant @ Math Diagnostic Testing Project',
    timeline: 'November 2018 - Present (2 years)',
    descriptions: [
      '\u2022 Introduced a JavaScript application that automated student placement in college math courses.',
      '\u2022 Led a team of 3 to maintaine online exam platforms with numerous content updates.',
      '\u2022 Designed algorithms and styleguides to generate graphics.',
    ],
  ),
  ExperienceInfo(
    company: 'B.S. Computer Science @ UC San Diego',
    timeline: 'September 2016 - June 2020 (4 years)',
    descriptions: [
      '\u2022 GPA 3.708.',
      '\u2022 Learned data structures, architecture, security, machine learning, and networked services.',
      '\u2022 Designed and implemented the user interface for final project in software engineering class.',
    ],
  ),
];
