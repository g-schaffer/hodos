// DOC & SRC CODE : https://pub.dev/packages/flutter_login

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hodos/views/screens/search_route_page.dart';
import 'package:http/http.dart' as http;
import 'package:hodos/constants.dart';
import 'package:flutter_login/theme.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    debugPrint('_authUser => Name: ${data.name}, password: ${data.password}');
    var body = <String, dynamic>{};
    body["email"] = data.name;
    body["password"] = data.password;
    debugPrint(Uri.parse(ApiConstants.baseUrl + ApiConstants.login).toString());
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.login),
        body: body,
      );

      if (response.statusCode < 300 && response.statusCode >= 200) {

        var body = json.decode(response.body);

        // Create storage
        final storage = new FlutterSecureStorage();

        // Write value
        await storage.write(key: 'token_access', value: body["tokens"]['access']);
        await storage.write(key: 'token_refresh', value: body["tokens"]['refresh']);

        return null;
      } else {
        return "error code : ${response.statusCode}";
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String?> _signupUser(SignupData data) async {
    debugPrint('_signupUser =>  Name: ${data.name}, password: ${data.password}');
    // why using map ? => https://stackoverflow.com/questions/57846215/how-make-a-http-post-using-form-data-in-flutter
    // tldr => using string (body: jsonEncode(jsonObject)) not working properly bc using raw-data and not form-data
    var body = <String, dynamic>{};
    body["email"] = data.name;
    body["password"] = data.password;
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.register),
        body: body,
      );

      if (response.statusCode < 300 && response.statusCode >= 200) {
        //todo need wait for confirm email
        return "You will receive an email with a link to finalize the creation of your account.";
      } else {
        return "error code : ${response.statusCode}";
      }
    } catch (e) {
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<String?> _recoverPassword(String name) async {

    var body = <String, dynamic>{};
    body["email"] = name;

      final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.recover),
        body: body,
      );

    if (response.statusCode == 200) {
      return null;
    } else {
      return "This email doesn't exist.";
    }
    return null;
  }

  Future<String?> _codePassword(String, LoginData) async {
    var body = {};

      body["password"] = LoginData.password;
      body["token"] = String;
      body["uidb64"] = "MQ";
    print(body);
    try {
      final response = await http.patch(
          Uri.parse(ApiConstants.baseUrl + ApiConstants.recoverCompleted),
          body: body,
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return null;
      } else {
        return "error code : ${response.statusCode}";
      }
    } catch (e) {
      return e.toString();
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'Hodos',

      logo: const AssetImage('lib/assets/images/loading-hodos.gif'),
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onConfirmRecover: _codePassword,

      messages: LoginMessages(
        userHint: 'Email',
      ),

      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const SearchRoutePage(),
        ));
      },


    );
  }
}
