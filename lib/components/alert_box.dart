import 'package:flutter/material.dart';

class AlertBox extends StatefulWidget {
  String error;
  Function onPressed;
  AlertBox({@required this.error, this.onPressed});

  @override
  _AlertBoxState createState() => _AlertBoxState();
}

class _AlertBoxState extends State<AlertBox> {
  @override
  Widget build(BuildContext context) {
    if (widget.error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                right: 8.0,
              ),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: Text(widget.error),
            ),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: widget.onPressed,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }
}
