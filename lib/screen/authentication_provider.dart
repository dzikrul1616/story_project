import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_app/config/api.dart';
import 'package:story_app/screen/authentication_page.dart';
import 'package:story_app/screen/list_story_page.dart';

class AuthenticationProvider extends ChangeNotifier {
  AuthenticationProvider() {
    getPref();
  }

  Locale _locale = const Locale("id");
   Locale get locale => _locale;

  LoginStatus loginStatus = LoginStatus.notSignin;

  //login
  final key = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool get _isLoading => isLoading;

  //register
  final key2 = GlobalKey<FormState>();
  final nameRegistController = TextEditingController();
  final emailRegistController = TextEditingController();
  final passwordRegistController = TextEditingController();
  bool isLoading2 = false;
  bool get _isLoading2 => isLoading;
  bool? status;

  getPref() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      status = preferences.getBool("status")!;
      loginStatus =
          status == false ? LoginStatus.signIn : LoginStatus.notSignin;
      notifyListeners();
    } catch (e) {
      print('Auth undetected');
    }
  }

  void setLocale(Locale locale){
    _locale = locale;
    notifyListeners();
  }

  check(context) {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      login(context);
    }
  }

  checkRegist(context) {
    if (key2.currentState!.validate()) {
      key2.currentState!.save();
      register(context);
    }
  }

  Future<void> login(context) async {
    final url = Uri.parse(ApiConfig.login);
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(url,
          body: jsonEncode({
            "email": emailController.text,
            "password": passwordController.text
          }),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        savePref(data['loginResult']['token'], data['loginResult']['name'],
            emailController.text, data['loginResult']['userId'], data['error']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StoryListPage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}... Anda berhail login'),
            backgroundColor: Colors.green,
          ),
        );
        isLoading = false;
        print(data);
        notifyListeners();
      } else {
        isLoading = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: Colors.red,
          ),
        );
        print(data);
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      print(e);
    }
  }

  Future<void> register(context) async {
    final url = Uri.parse(ApiConfig.register);
    isLoading2 = true;
    notifyListeners();
    try {
      final response = await http.post(url,
          body: jsonEncode({
            "name": nameRegistController.text,
            "email": emailRegistController.text,
            "password": passwordRegistController.text
          }),
          headers: {"Content-Type": "application/json"});
      final data = jsonDecode(response.body);
      if (data['error'] == false) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AuthenticationPage()));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}... Silakan Login Kembali'),
            backgroundColor: Colors.green,
          ),
        );
        isLoading2 = false;
        print(data);
        notifyListeners();
      } else {
        isLoading2 = false;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: Colors.red,
          ),
        );
        print(data);
        notifyListeners();
      }
    } catch (e) {
      isLoading2 = false;
      print(e);
    }
  }

  savePref(String token, String name, String email, String userId,
      bool status) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token);
    preferences.setString("name", name);
    preferences.setString("email", email);
    preferences.setString("userId", userId);
    preferences.setBool("status", status);
    preferences.commit();
    notifyListeners();
  }
}
