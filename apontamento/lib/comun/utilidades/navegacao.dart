import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

Future navegar({@required BuildContext context, @required Widget pagina}) {
  return Navigator.push(
    context,
    PageTransition(
      type: PageTransitionType.rightToLeft,
      child: pagina,
    ),
  );
}
