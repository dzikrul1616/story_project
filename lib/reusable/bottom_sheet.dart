import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:story_app/const/color.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BottomSheetPage extends StatelessWidget {
  String? image;
  String? createdAt;
  String? description;
  String? user;
  String? lat;
  String? long;
  BottomSheetPage(
      {this.image,
      this.createdAt,
      this.description,
      this.user,
      this.lat,
      this.long});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          width: 80,
          height: 5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'by: ${user!}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    size: 12,
                    color: Colors.grey[400],
                  ),
                  Text(
                    '${lat!} ${long!}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                createdAt!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5.0,
              ),
              Text(
                description!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
          padding: EdgeInsets.all(20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Center(
                  child: Text(
                AppLocalizations.of(context)!.close,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )),
              style: ElevatedButton.styleFrom(primary: appCyan),
            ),
          )),
    );
  }
}
