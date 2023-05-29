import 'package:flutter/material.dart';

//
class Badge extends StatelessWidget {
  final Widget childWidget;
  final String value;
  final Color color;
  //
  const Badge(
      {Key? key,
      required this.childWidget,
      required this.value,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        childWidget,
        Positioned(
            right: 2,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: color,
              ),
              constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
              child: Center(
                child: Text(
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: 'AlfaSlabOne',
                        //fontWeight: FontWeight.bold,
                        color: Colors.white),
                    value),
              ),
            ))
      ],
    );
  }
}
