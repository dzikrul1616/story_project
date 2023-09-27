import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchWidget extends StatelessWidget {
  void Function(String)? onChanged;
  SearchWidget({this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextFormField(
            onChanged: onChanged,
            decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.search,
                filled: true,
                contentPadding: EdgeInsets.all(10),
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          )),
    );
  }
}
