import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:untitled/core/firebase_utiles.dart';

import '../../core/page_routes_names.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  var formfey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  bool obsecured = true;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xffDFECDB),
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Login", style: theme.textTheme.bodyLarge),
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: media.width * .04, right: media.width * .04),
          child: Form(
            key: formfey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        height: media.height * .25,
                      ),
                      Text(
                        "Welcome Back!",
                        style: theme.textTheme.bodyMedium,
                      ),
                      TextFormField(
                        validator: (value) {
                          if ( value!.trim().isEmpty) {
                            return "Please enter your email address.";
                          }
                          bool email = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (email) return null;
                          return "Please enter valid email address";
                        },
                        controller: email,
                        decoration: InputDecoration(
                          label: Text(
                            "E-mail",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.email_rounded,
                          ),
                          hintText: "Enter your email address",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        cursorColor: theme.primaryColor,
                        style: theme.textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        obscureText: obsecured,
                        validator: (value) {
                          if ( value!.trim().isEmpty) {
                            return "Please enter your password.";
                          }
                          return null;
                        },
                        controller: password,
                        decoration: InputDecoration(
                          label: Text(
                            "Password",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              obsecured = !obsecured;
                              setState(() {});
                            },
                            child: Icon(obsecured
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                          hintText: "Enter your password.",
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: theme.primaryColor,
                              width: 3,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),
                        cursorColor: theme.primaryColor,
                        style: theme.textTheme.displayMedium,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "Forget password",
                            style: theme.textTheme.bodySmall?.copyWith(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formfey.currentState!.validate()) {
                            FirebaseUtiles.login(email.text, password.text)
                                .then(
                              (onValue) {
                                if (onValue) {
                                  Navigator.pushReplacementNamed(
                                      context, PageRoutesNames.layout);
                                  BotToast.showText(text: "Welcome Back!");
                                }
                                if (onValue == false) {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: Border.fromBorderSide(
                                        BorderSide(color: theme.primaryColor),
                                      ),
                                      iconColor: theme.primaryColor,
                                      titleTextStyle:
                                          theme.textTheme.bodyMedium,
                                      contentTextStyle:
                                          theme.textTheme.bodySmall,
                                      title: Text(
                                        'Something went wrong',
                                        style: theme.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 20),
                                      ),
                                      content: Text(
                                        'Try enter e_mail and password again',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.grey),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text(
                                            'Ok',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                    color: theme.primaryColor),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Login",
                              style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.white, fontSize: 20, height: 3),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            PageRoutesNames.regester,
                          );
                        },
                        child: Text(
                          "Or create my account",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
