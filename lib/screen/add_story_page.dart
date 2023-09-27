import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/const/color.dart';
import 'package:story_app/reusable/flag_icon.dart';
import 'package:story_app/screen/add_story_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddStoryPage extends StatelessWidget {
  const AddStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (BuildContext context) => AddStoryProvider(),
        child: Scaffold(
            appBar: AppBar(
              actions: [
                FlagIconWidget(colors: Colors.white),
              ],
              foregroundColor: Colors.white,
              backgroundColor: appPrimary,
              title: Text(
                AppLocalizations.of(context)!.add_page,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Consumer<AddStoryProvider>(builder: (context, value, child) {
              return Form(
                key: value.key,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 150,
                            color: Colors.grey,
                            child: value.imageFile == null
                                ? Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 100,
                                    ),
                                  )
                                : Image.file(
                                    value.imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      value.getImage(ImageSource.camera),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.camera,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: appCyan),
                                ),
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Container(
                                width: 150,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: () =>
                                      value.getImage(ImageSource.gallery),
                                  child: Center(
                                    child: Text(
                                      AppLocalizations.of(context)!.gallery,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: appCyan),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          maxLines: 8,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Description Tidak boleh kosong";
                            }
                          },
                          controller: value.descriptionController,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 14),
                          decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.description,
                              contentPadding: EdgeInsets.all(15),
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Color(0xff595959),
                                  fontSize: 14),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              floatingLabelStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff595959),
                                  fontSize: 14),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              filled: true,
                              fillColor: Colors.grey[200]),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            bottomNavigationBar:
                Consumer<AddStoryProvider>(builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => value.imageFile == null
                        ? value.errorAlert(context)
                        : value.check(context),
                    child: Center(
                      child: value.isLoading
                          ? Container(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              AppLocalizations.of(context)!.upload,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                    ),
                    style: ElevatedButton.styleFrom(primary: appCyan),
                  ),
                ),
              );
            })));
  }
}
