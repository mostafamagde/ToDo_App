import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_provider.dart';

import '../../core/page_routes_names.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    var provider = Provider.of<SettingProuider>(context);
    List<String> modes = [
      "Light",
      "Dark",
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          width: media.width,
          height: media.height * 0.22,
          color: theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 80,
            ),
            child: Text(
              "Settings",
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDark() ? Color(0xFF060E1E) : Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          "  Select Theme",
          style: theme.textTheme.bodyLarge?.copyWith(
              color: provider.isDark() ? Colors.white : Colors.black),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomDropdown<String>(
            items: modes,
            initialItem: provider.isDark() ? modes[1] : modes[0],
            onChanged: (value) {
              if (value == modes[1]) provider.changeMode(ThemeMode.dark);
              if (value == modes[0]) provider.changeMode(ThemeMode.light);
            },
            hintText: "Select Theme",
            decoration: CustomDropdownDecoration(
                closedFillColor:
                    provider.isDark() ? Color(0xff1A1A2E) : Colors.white,
                expandedFillColor:
                    provider.isDark() ? Color(0xff1A1A2E) : Colors.white,
                closedSuffixIcon: Icon(
                  Icons.arrow_drop_down_outlined,
                  color: theme.primaryColor,
                ),
                expandedSuffixIcon: Icon(
                  Icons.arrow_drop_up_outlined,
                  color: theme.primaryColor,
                ),
                closedBorder: Border.all(color: theme.primaryColor, width: 2)),
          ),
        ),
        SizedBox(
          height: 100,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        "Are you sure you want to log out ",
                        style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 20,color:Colors.black ),
                      ),
                      content: Text(
                        "If yes, press continue",
                        style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      shape: Border.fromBorderSide(
                        BorderSide(color: theme.primaryColor),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                PageRoutesNames.login,
                                (Route<dynamic> route) => false);
                          },
                          child: Text(
                            "Continue",
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: theme.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  "log out",
                  style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        )
      ],
    );
  }
}
