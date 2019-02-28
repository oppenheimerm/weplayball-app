import 'package:flutter/material.dart';

//See:  https://stackoverflow.com/questions/49572747/flutter-how-to-hide-or-show-more-text-within-certain-length

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText>
    with TickerProviderStateMixin<ExpandableText> {

  @override
  Widget build(BuildContext context) {

    return new Column(children: <Widget>[
      new AnimatedSize(
          vsync: this,
          duration: const Duration(milliseconds: 500),
          child: new ConstrainedBox(
              constraints: widget.isExpanded
                  ? new BoxConstraints()
                  : new BoxConstraints(maxHeight: 50.0),
              child: new Text(
                widget.text,
                softWrap: true,
                overflow: TextOverflow.fade,
                /*style: textTheme.body1.copyWith(
                  color: Colors.black45,
                  fontSize: 16.0,
                ),*/
              ))),
      widget.isExpanded
          ? new ConstrainedBox(constraints: new BoxConstraints())
          : new FlatButton(
          child: const Text('...'),
          onPressed: () => setState(() => widget.isExpanded = true))
    ]);
  }
}