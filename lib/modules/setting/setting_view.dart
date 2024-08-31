import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/core/app_provider.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: media.width,
          height: media.height * 0.22,
          color:  theme.primaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 80,
            ),
            child: Text(
              "Settings",
              style: theme.textTheme.bodyLarge?.copyWith(
                  color: provider.isDark()? Color(0xFF060E1E) : Colors.white
              ),
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
        CustomDropdown<String>(
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
            closedBorder: Border.all(
              color: theme.primaryColor,

              width: 2

            )


          ),

        )
      ],
    );
  }
}
