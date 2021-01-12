import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testo/constants.dart';

import 'homepage.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/auth';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String> _loginUser(LoginData data) {
    print("Connexion : ...");
    return Future.delayed(loginTime).then((_) async {
      if (await demandeUserName(data) == false) {
        return "Cet utilisateur n'existe pas";
      }
      if (await demandeUserNamePass(data) == false) {
        return 'Emal ou Mot de passe incorrect.';
      }
      return null;
    });
  }

  Future<String> _enregistrementUser(LoginData data) {
    print("je logue man ");
    return Future.delayed(loginTime).then((_) async {
      if (await enregistrement(data) == false) {
        return "Echec d'enregistrement.";
      }

      return null;
    });
  }

  Future<bool> enregistrement(LoginData data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    SharedPreferences pref2 = await SharedPreferences.getInstance();

    return await pref2.setString("motdepasse", data.password) &&
        await pref.setString("email", data.name);
  }

  Future<bool> demandeUserName(LoginData data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String x = pref.getString("email");
    if (x == null) {
      return false;
    }

    if (x != data.name) {
      return false;
    } else {
      return true;
    }
  }

  Future<bool> demandeUserNamePass(LoginData data) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String x = pref.getString("email");
    String y = pref.getString("motdepasse");
    if (x == null || y == null) {
      return false;
    }

    if (x == data.name && y == data.password) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> changePass(String username, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    String x = pref.getString("email");

    if (x == null) {
      return false;
    }

    if (x != username) {
      return false;
    } else {
      SharedPreferences pref2 = await SharedPreferences.getInstance();

      return await pref2.setString("motdepasse", password);
    }
  }

  Future<String> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) async {
      if (await changePass(name, "00000000") == false) {
        return "Cet utilisateur n'existe pas.";
      }
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Surveillance du Cholera"),
      ),
      body: Container(
        child: FlutterLogin(
          title: Constants.appName,
          logo: 'assets/images/ecorp.png',
          logoTag: Constants.logoTag,
          titleTag: Constants.titleTag,
          // messages: LoginMessages(
          //   usernameHint: 'Username',
          //   passwordHint: 'Pass',
          //   confirmPasswordHint: 'Confirm',
          //   loginButton: 'LOG IN',
          //   signupButton: 'REGISTER',
          //   forgotPasswordButton: 'Forgot huh?',
          //   recoverPasswordButton: 'HELP ME',
          //   goBackButton: 'GO BACK',
          //   confirmPasswordError: 'Not match!',
          //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
          //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
          //   recoverPasswordSuccess: 'Password rescued successfully',
          // ),
          // theme: LoginTheme(
          //   primaryColor: Colors.teal,
          //   accentColor: Colors.yellow,
          //   errorColor: Colors.deepOrange,
          //   pageColorLight: Colors.indigo.shade300,
          //   pageColorDark: Colors.indigo.shade500,
          //   titleStyle: TextStyle(
          //     color: Colors.greenAccent,
          //     fontFamily: 'Quicksand',
          //     letterSpacing: 4,
          //   ),
          //   // beforeHeroFontSize: 50,
          //   // afterHeroFontSize: 20,
          //   bodyStyle: TextStyle(
          //     fontStyle: FontStyle.italic,
          //     decoration: TextDecoration.underline,
          //   ),
          //   textFieldStyle: TextStyle(
          //     color: Colors.orange,
          //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
          //   ),
          //   buttonStyle: TextStyle(
          //     fontWeight: FontWeight.w800,
          //     color: Colors.yellow,
          //   ),
          //   cardTheme: CardTheme(
          //     color: Colors.yellow.shade100,
          //     elevation: 5,
          //     margin: EdgeInsets.only(top: 15),
          //     shape: ContinuousRectangleBorder(
          //         borderRadius: BorderRadius.circular(100.0)),
          //   ),
          //   inputTheme: InputDecorationTheme(
          //     filled: true,
          //     fillColor: Colors.purple.withOpacity(.1),
          //     contentPadding: EdgeInsets.zero,
          //     errorStyle: TextStyle(
          //       backgroundColor: Colors.orange,
          //       color: Colors.white,
          //     ),
          //     labelStyle: TextStyle(fontSize: 12),
          //     enabledBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
          //       borderRadius: inputBorder,
          //     ),
          //     focusedBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
          //       borderRadius: inputBorder,
          //     ),
          //     errorBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
          //       borderRadius: inputBorder,
          //     ),
          //     focusedErrorBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
          //       borderRadius: inputBorder,
          //     ),
          //     disabledBorder: UnderlineInputBorder(
          //       borderSide: BorderSide(color: Colors.grey, width: 5),
          //       borderRadius: inputBorder,
          //     ),
          //   ),
          //   buttonTheme: LoginButtonTheme(
          //     splashColor: Colors.purple,
          //     backgroundColor: Colors.pinkAccent,
          //     highlightColor: Colors.lightGreen,
          //     elevation: 9.0,
          //     highlightElevation: 6.0,
          //     shape: BeveledRectangleBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
          //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
          //   ),
          // ),
          messages: LoginMessages(
              recoverPasswordSuccess: "Nouveau mot de passe : 00000000"),
          theme: LoginTheme(),

          emailValidator: (value) {
            if (value.isEmpty) {
              return 'Entrer votre e-mail';
            } else if (!value.contains('@') || !value.endsWith('.com')) {
              return "Votre E-mail doit contenir '@' et finir par '.com'";
            }
            return null;
          },
          passwordValidator: (value) {
            if (value.isEmpty) {
              return 'Entrer votre mot de passe';
            }
            return null;
          },
          onLogin: (loginData) {
            print('Login info');
            print('Name: ${loginData.name}');
            print('Password: ${loginData.password}');
            return _loginUser(loginData);
          },
          onSignup: (loginData) {
            print('Signup info');
            print('Name: ${loginData.name}');
            print('Password: ${loginData.password}');
            return _enregistrementUser(loginData);
          },
          onSubmitAnimationCompleted: () {
            print('ici login ok');
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => HomePage(
                          title: "Menu Principal",
                        )));
          },
          onRecoverPassword: (name) {
            print('Recover password info');
            print('Name: $name');
            return _recoverPassword(name);
            // Show new password dialog
          },

          // showDebugButtons: true,
        ),
      ),
    );
  }
}
