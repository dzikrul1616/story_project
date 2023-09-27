import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/config/api.dart';
import 'package:story_app/screen/authentication_page.dart';
import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListStoryProvider extends ChangeNotifier {
  ListStoryProvider() {
    getPref();
  }

  LoginStatus loginStatus = LoginStatus.notSignin;

  String? token;
  String? name;
  String? email;
  String? userId;

  List<dynamic> story = [];

  bool isLoading = false;
  bool get _isLoading => isLoading;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token")!;
    name = preferences.getString("name")!;
    email = preferences.getString("email")!;
    userId = preferences.getString("userId")!;
    getListStory();
    notifyListeners();
  }

  check(context) {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        confirmButtonText: AppLocalizations.of(context)!.yes,
        cancelButtonText: "No",
        onCancel: () {
          Navigator.pop(context);
        },
        onConfirm: () => logout(context),
        title: AppLocalizations.of(context)!.warning,
        text: AppLocalizations.of(context)!.logout_allert,
      ),
    );
  }

  void logout(context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("status", true);
    loginStatus = LoginStatus.notSignin;
    List<String> keysToRemove = ["token", "name", "email", "userId"];
    for (String key in keysToRemove) {
      preferences.remove(key);
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AuthenticationPage()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Berhasil logout'),
        backgroundColor: Colors.red,
      ),
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    await getListStory();
  }

  Future<void> getListStory() async {
    final url = Uri.parse(ApiConfig.story);
    isLoading = true;
    notifyListeners();
    try {
      final response =
          await http.get(url, headers: {"Authorization": "Bearer $token"});
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        story = data['listStory'];
        filteredStory = story;
        print(data);
        isLoading = false;
        notifyListeners();
      } else {
        print(response.statusCode);
        print(token);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  List<dynamic> filteredStory = [];
  void filterStory(String query) {
    filteredStory = story
        .where((story) =>
            story['description']!.toLowerCase().contains(query.toLowerCase()) ||
            story['name']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    print('jumlah filter : ${filteredStory.length}');
    notifyListeners();
  }

  String convertToTimeAgo(String createdAt) {
    DateTime now = DateTime.now();
    DateTime createdDateTime = DateTime.parse(createdAt);
    Duration difference = now.difference(createdDateTime);

    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes} minutes ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours} hours ago";
    } else if (difference.inDays < 30) {
      return "${difference.inDays} days ago";
    } else {
      final format = DateFormat('dd MMM yyyy');
      return format.format(createdDateTime);
    }
  }
}
