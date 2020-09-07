import 'package:flutter/material.dart';
import 'package:docker_clyde/models/navigation.dart';
import 'package:docker_clyde/pages/drawer/components/navigation_tile.dart';

class NavigationDrawer extends StatefulWidget {
  NavigationDrawer(
      {Key key, this.minWidth = 70.0, this.maxWidth = 250.0, this.child})
      : super(key: key);

  final Widget child;
  final double maxWidth;
  final double minWidth;

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer>
    with SingleTickerProviderStateMixin {
  bool collapsed;

  AnimationController _animationController;
  Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    this.collapsed = true;
    this._animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    this._widthAnimation =
        Tween<double>(begin: widget.minWidth, end: widget.maxWidth)
            .animate(this._animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) => Container(
          width: this._widthAnimation.value,
          color: Theme.of(context).backgroundColor,
          child: Column(
            children: [
              SizedBox(height: 20),
              NavigationListTile(
                id: '/profile',
                title: 'Flavien CADET',
                icon: Icons.person,
                maxWidth: this.widget.maxWidth,
                minWidth: this.widget.minWidth,
                animation: this._animationController,
              ),
              Divider(height: 40.0),
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, counter) =>
                      SizedBox(height: 10.0),
                  itemBuilder: (context, counter) => NavigationListTile(
                      id: NavigationModel.list[counter].id,
                      title: NavigationModel.list[counter].title,
                      icon: NavigationModel.list[counter].icon,
                      maxWidth: this.widget.maxWidth,
                      minWidth: this.widget.minWidth,
                      animation: this._animationController),
                  itemCount: NavigationModel.list.length,
                ),
              ),
              InkWell(
                child: AnimatedIcon(
                  icon: AnimatedIcons.menu_close,
                  progress: _animationController,
                  color:
                      Theme.of(context).backgroundColor.computeLuminance() > 0.5
                          ? Theme.of(context).iconTheme.color
                          : Theme.of(context).accentColor,
                  size: 50,
                ),
                onTap: () {
                  setState(() {
                    this.collapsed = !this.collapsed;
                    this.collapsed
                        ? this._animationController.reverse()
                        : this._animationController.forward();
                  });
                },
              ),
              SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
      Expanded(child: widget.child ?? Container())
    ]);
  }
}
