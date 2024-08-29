
import 'package:flutter/material.dart';

class Regestration extends StatefulWidget {
  const Regestration({super.key});

  @override
  State<Regestration> createState() => _RegestrationState();
}

class _RegestrationState extends State<Regestration> {
  var formfey = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  var name = TextEditingController();
  bool obsecured = false;

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
          title: Text("Sign up", style: theme.textTheme.bodyLarge),
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
                    
                      TextFormField(
                        validator: (value) {
                          if(value?.length==0||value==null){
                            return "enter name please";
                          }
                          return null;
                        },
                    
                        controller: name,
                        decoration: InputDecoration(
                          label: Text(
                            "Full Name",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          suffixIcon: const Icon(
                            Icons.person,
                          ),
                          hintText: "Enter your full name",
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
                    
                      const SizedBox(
                        height: 25,
                      ),
                    
                      TextFormField(
                        obscureText: obsecured,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please enter your password.";
                          }
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
                            child: Icon(
                                obsecured ? Icons.visibility : Icons.visibility_off),
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
                      const SizedBox(
                        height: 50,
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
                              "Create account",
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
