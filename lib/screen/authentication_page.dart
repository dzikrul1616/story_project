import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/const/color.dart';
import 'package:story_app/reusable/empty_app_bar.dart';
import 'package:story_app/reusable/flag_icon.dart';
import 'package:story_app/screen/authentication_provider.dart';
import 'package:story_app/screen/list_story_page.dart';
import 'package:story_app/screen/tab_auth/login_page.dart';
import 'package:story_app/screen/tab_auth/register.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum LoginStatus { notSignin, signIn }

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AuthenticationProvider(),
        child: Scaffold(
          appBar: BarEmpty.emptyAppBar(context),
          body: Consumer<AuthenticationProvider>(
              builder: (context, value, child) {
            switch (value.loginStatus) {
              case LoginStatus.notSignin:
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: appCyan,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10))),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.auth_page,
                                style: TextStyle(fontSize: 30, height: 1.5),
                              ),
                              FlagIconWidget(colors: appCyan),
                            ],
                          ),
                          Divider(),
                          const SizedBox(
                            height: 40.0,
                          ),
                          DefaultTabController(
                              length: 2,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.grey[200],
                                    ),
                                    child: Center(
                                      child: TabBar(
                                          indicatorPadding: EdgeInsets.all(5),
                                          indicator: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: appPrimary,
                                          ),
                                          unselectedLabelColor:
                                              Color(0xff565656),
                                          labelColor: Colors.white,
                                          tabs: [
                                            Tab(
                                              icon: Text(
                                                AppLocalizations.of(context)!
                                                    .login,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                            Tab(
                                              icon: Text(
                                                AppLocalizations.of(context)!
                                                    .register,
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    height: 500,
                                    child: TabBarView(
                                      children: [
                                        LoginPage(),
                                        RegisterPage(),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 10,
                            decoration: BoxDecoration(
                                color: appCyan,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10))),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              case LoginStatus.signIn:
                return StoryListPage();
            }
          }),
        ));
  }
}
