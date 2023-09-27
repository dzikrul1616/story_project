import 'dart:convert';
import 'dart:io';

import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:story_app/config/api.dart';
import 'package:story_app/screen/list_story_page.dart';

class AddStoryProvider extends ChangeNotifier {
  AddStoryProvider() {
    getPref();
  }

  final key = GlobalKey<FormState>();

  bool isLoading = false;
  bool get _isLoading => isLoading;
  String? token;

  final descriptionController = TextEditingController();

  late String imageUrl;
  File? imageFile;
  final picker = ImagePicker();
  Future getImage(ImageSource image) async {
    final picker = ImagePicker();
    final pickedFile =
        await picker.pickImage(source: image, maxWidth: 1080, maxHeight: 1920);
    imageFile = File(pickedFile!.path);
    notifyListeners();
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token")!;
    notifyListeners();
  }

  check(context) {
    if (key.currentState!.validate()) {
      key.currentState!.save();
      addListStory(context);
    }
  }

  Future<void> addListStory(context) async {
    final url = Uri.parse(ApiConfig.story);
    isLoading = true;
    notifyListeners();
    try {
      var request = http.MultipartRequest('POST', url)
        ..headers['Authorization'] = "Bearer $token"
        ..fields['description'] = descriptionController.text
        ..fields['lat'] = '0'
        ..fields['lon'] = '0'
        ..files.add(http.MultipartFile(
          'photo',
          imageFile!.readAsBytes().asStream(),
          imageFile!.lengthSync(),
          filename: 'story_photo.jpg',
        ));

      final response = await http.Response.fromStream(await request.send());
      final data = jsonDecode(response.body);

      if (data['error'] == false) {
        print(data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => StoryListPage()));
        isLoading = false;
        notifyListeners();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${data['message']}'),
            backgroundColor: Colors.red,
          ),
        );
        print(data['message']);
        print(response.statusCode);
        notifyListeners();
      }
    } catch (e) {
      print(e);
    }
  }

  void errorAlert(context) async {
    ArtSweetAlert.show(
      context: context!,
      artDialogArgs: ArtDialogArgs(
        type: ArtSweetAlertType.danger,
        confirmButtonText: "Ya",
        cancelButtonText: "No",
        onCancel: () {
          Navigator.pop(context);
        },
        title: 'Peringatan!',
        text: 'Gambar harus di isi terlebih dahulu',
      ),
    );
  }
}
