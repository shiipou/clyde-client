import 'package:flutter/material.dart';
import 'package:docker_clyde/utils/theme.dart';
import 'package:provider/provider.dart';

class ThemeSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Theme selection'),
        Divider(color: Theme.of(context).accentColor, height: 20.0),
        Expanded(
          child: ListView.builder(
            itemCount: AppTheme.values.length,
            itemBuilder: (BuildContext context, int index) {
              // Get theme enum for the current item index
              final theme = AppTheme.values[index];

              return Card(
                // Style the item with corresponding theme color
                color: appThemeData[theme].scaffoldBackgroundColor,
                child: ListTile(
                  onTap: () {
                    // This will trigger notifyListeners and rebuild UI
                    // because of ChangeNotifierProvider in ThemeApp
                    Provider.of<ThemeManager>(context, listen: false)
                        .setTheme(theme);
                  },
                  title: Text(
                    enumName(theme),
                    style: appThemeData[theme].textTheme.bodyText1,
                  ),
                ),
              );
            },
          ),
        )
      ]),
    );
  }
}
