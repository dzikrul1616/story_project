import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/screen/list_story_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ListStoryProvider>(builder: (context, value, child) {
      return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(top: 50, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Icon(
                      Icons.person_2,
                      size: 15,
                      color: Colors.grey[100],
                    ),
                  ),
                ),
                title: Text(
                  value.name!,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  value.email!,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey[400],
                ),
              ),
              ListTile(
                onTap: () => value.check(context),
                leading: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                title: Text(
                  AppLocalizations.of(context)!.logout,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  child: Center(
                    child: Text(
                      "Aplication version : 1.0 ",
                      style: TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
