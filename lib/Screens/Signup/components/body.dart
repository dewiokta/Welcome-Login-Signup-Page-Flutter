import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/Signup/components/or_divider.dart';
import 'package:flutter_auth/Screens/Signup/components/social_icon.dart';
import 'package:flutter_auth/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/components/rounded_button.dart';
import 'package:flutter_auth/components/rounded_input_field.dart';
import 'package:flutter_auth/components/rounded_password_field.dart';
import 'package:flutter_auth/components/text_field_container.dart';
import 'package:flutter_auth/pages/google_page.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_auth/services/email_services.dart';
import 'package:flutter_auth/services/google_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_auth/pages/email_page.dart';

import '../../../constants.dart';

class Body extends StatelessWidget {
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  User user;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    IconData icon = Icons.person;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            /*
                RoundedInputField(
                  controller: usernameController,
                  hintText: "Your Email",
                  onChanged: (value) {},
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  onChanged: (value) {},
                ),
                */
            //username
            TextFieldContainer(
              child: TextField(
                controller: usernameController,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    icon,
                    color: kPrimaryColor,
                  ),
                  hintText: "Your Email",
                  border: InputBorder.none,
                ),
              ),
            ),
            //password
            TextFieldContainer(
              child: TextField(
                controller: passwordController,
                obscureText: true,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: kPrimaryColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: kPrimaryColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedButton(
              text: "SIGNUP",
              press: () async {
                LogEmail result = await EmailServices.createUser(
                    email: usernameController.text,
                    pass: passwordController.text);
                if (result.user != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailPage(
                                result.user,
                              )));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text('Error'),
                            content: Text(result.message),
                            actions: <Widget>[
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Ok'),
                              )
                            ],
                          ));
                }
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            OrDivider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SocalIcon(
                  iconSrc: "assets/icons/facebook.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/twitter.svg",
                  press: () {},
                ),
                SocalIcon(
                  iconSrc: "assets/icons/google.svg",
                  press: () {
                    signInWithGoogle().then((result) {
                      if (result != null) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return GooglePage();
                            },
                          ),
                        );
                      }
                    });
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
