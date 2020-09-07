import 'package:flutter/material.dart';

class NavigationListTile extends StatefulWidget {
  NavigationListTile(
      {Key key,
      this.id,
      @required this.title,
      @required this.icon,
      this.minWidth = 70.0,
      this.maxWidth = 250.0,
      this.animation})
      : super(key: key);

  final String id;
  final String title;
  final IconData icon;

  final double maxWidth;
  final double minWidth;

  final AnimationController animation;

  @override
  _NavigationListTileState createState() => _NavigationListTileState();
}

class _NavigationListTileState extends State<NavigationListTile> {
  Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    this._widthAnimation =
        Tween<double>(begin: widget.minWidth, end: widget.maxWidth)
            .animate(widget.animation);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: this.isSelected()
            ? Theme.of(context).highlightColor
            : Colors.transparent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      width: this._widthAnimation != null
          ? this._widthAnimation.value
          : widget.minWidth,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      padding: EdgeInsets.all(8.0),
      child: InkWell(
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: Theme.of(context).backgroundColor.computeLuminance() > 0.5
                  ? Theme.of(context).iconTheme.color
                  : Theme.of(context).accentColor,
              size: 38.0,
            ),
            this._widthAnimation.value >= widget.maxWidth
                ? SizedBox(width: 10.0)
                : Container(),
            this._widthAnimation.value >= widget.maxWidth
                ? Text(widget.title,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontSize: 20.0,
                        color: Theme.of(context)
                                    .backgroundColor
                                    .computeLuminance() >
                                0.5
                            ? null
                            : Theme.of(context).accentColor))
                : Container()
          ],
        ),
        onTap: () {
          if (!this.isSelected()) {
            Navigator.of(context).popAndPushNamed(widget.id);
          }
        },
      ),
    );
  }

  bool isSelected() => ModalRoute.of(context).settings.name == widget.id;
}
