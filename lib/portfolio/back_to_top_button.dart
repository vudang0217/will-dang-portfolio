import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BackToTopButton extends StatelessWidget {
  const BackToTopButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // need provider and watch version because the first scrollController
    //(which has isOffsetZero = true) does not gets updated as we scroll so
    //it will return SizedBox all the time, which makes the button disappear
    //the instance of scrollController must be updated everytime so
    //provider comes in handy

    final scrollController = context.watch<ScrollController>();
    if (scrollController.isOffsetZero) return SizedBox();
    return FloatingActionButton(
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.arrow_upward),
        onPressed: () {
          scrollController.animateTo(
            0,
            duration: Duration(milliseconds: 700),
            curve: Curves.easeInOut,
          );
        });
  }
}

//scrollController.iszero = false or true
extension on ScrollController {
  bool get isOffsetZero {
    return this.offset == 0;
  }
}
