import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/const/color.dart';
import 'package:story_app/screen/authentication_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationProvider>(builder: (context, value, child) {
      return Form(
        key: value.key,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.login,
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Email Tidak boleh kosong";
                  } else if (!RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                      .hasMatch(e)) {
                    return 'Masukkan alamat email yang valid';
                  }
                },
                controller: value.emailController,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14),
                decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff595959),
                        fontSize: 14),
                    contentPadding: EdgeInsets.all(15),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
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
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                validator: (e) {
                  if (e!.isEmpty) {
                    return "Password tidak boleh kosong";
                  }
                },
                controller: value.passwordController,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14),
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.password,
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Color(0xff595959),
                        fontSize: 14),
                    contentPadding: EdgeInsets.all(15),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
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
              const SizedBox(
                height: 30.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (!value.isLoading) {
                      value.check(context);
                    }
                  },
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
                            AppLocalizations.of(context)!.login,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                  ),
                  style: ElevatedButton.styleFrom(primary: appYoung),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
