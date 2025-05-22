import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/services/manage_http_response.dart';
import 'package:online_store/views/screens/authentication/login_screen.dart';
import 'package:online_store/views/screens/main_screen.dart';

class AuthController {
  Future<void> signUpUsers({required BuildContext context,required String email,required String fullName,required String password}) async{
    try {
      User user = User(
        id: '', 
        fullName: fullName, 
        email: email, 
        state: '', 
        city: '', 
        locality: '', 
        password: password,
        token: ''
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup'),
      body: user.toJson(),
      headers: <String,String> {"Content-Type" : 'application/json; charset=UTF-8'}
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => LoginScreen()));
        showSnackBar(context, "Account has been created", Colors.green);
      });
    } catch (e) {

    }
  }



  Future<void> siginuser({required BuildContext context,required String email,required String password}) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin'),
      body: jsonEncode({
        'email' : email,
        'password' : password
      }),
      headers: <String,String> {"Content-Type" : 'application/json; charset=UTF-8'}
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => MainScreen()),(route) => false);
        showSnackBar(context, "Logged in", Colors.green);
      });
    } catch (e) {

    }
  }
}