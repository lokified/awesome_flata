import 'package:flutter/material.dart';

import '../core/constants.dart';

class DialogCard extends StatelessWidget {
  const DialogCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          decoration: BoxDecoration(
              color: white,
              border: Border.all(width: 2) ,
              boxShadow: [BoxShadow(
                offset: Offset(4, 4),
              )],
              borderRadius: BorderRadius.circular(12)
          ),
          width:
          MediaQuery.sizeOf(context).width *
              0.75,
          margin: MediaQuery.viewInsetsOf(context),
          padding: const EdgeInsets.all(16.0),
          child: child
        ),
      ),
    );
  }
}
