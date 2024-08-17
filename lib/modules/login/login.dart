import 'package:flutter/material.dart';

class Loginview extends StatefulWidget {
  const Loginview({super.key});

  @override
  State<Loginview> createState() => _LoginviewState();
}

class _LoginviewState extends State<Loginview> {
  var formfey = GlobalKey<FormState>();
  var email = TextEditingController();

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
                SizedBox(
                  height: media.height * .25,
                ),
                Text(
                  "Welcome Back!",
                  style: theme.textTheme.bodyMedium,
                ),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
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
                SizedBox(
                  height: media.height * .1,
                ),
                ElevatedButton(
                  onPressed: () {
                    formfey.currentState!.validate();
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*  Scaffold(
      body: Container(

        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.only(left: 20,right: 20),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: media.height*.1),
                  child: Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: media.height*.2),
                  child:
                ),
              ],
            ),
          ),
        ),
      ),
    );*/
