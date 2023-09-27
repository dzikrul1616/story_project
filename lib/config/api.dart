import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiConfig {
  static const base_url = "https://story-api.dicoding.dev/v1";
  // auth
  static const login = "$base_url/login";
  static const register = "$base_url/register";
  //story
  static const story = "$base_url/stories";
  static const storyId = "$base_url/stories?id=";
}
