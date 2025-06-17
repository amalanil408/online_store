import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:online_store/global_variables.dart';
import 'package:online_store/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/provider/delivered_order_count_provider.dart';
import 'package:online_store/provider/user_provider.dart';
import 'package:online_store/services/manage_http_response.dart';
import 'package:online_store/views/screens/authentication/login_screen.dart';
import 'package:online_store/views/screens/authentication/otp_screen.dart';
import 'package:online_store/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

final providerContainer = ProviderContainer();

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
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => OtpScreen(email: email,)));
        showSnackBar(context, "Account has been created", Colors.green);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
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
      manageHttpResponse(response: response, context: context, onSuccess: () async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        String token = jsonDecode(response.body)['token'];
        await preferences.setString('auth_token', token);
        final userJson = jsonEncode(jsonDecode(response.body)['user']);
        providerContainer.read(userProvider.notifier).setUser(userJson);
        await preferences.setString('user', userJson);
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => MainScreen()),(route) => false);
        showSnackBar(context, "Logged in", Colors.green);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }


  Future<void> signOutUser({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('auth_token');
      await preferences.remove('user');
      providerContainer.read(userProvider.notifier).signOut();
      providerContainer.read(deliveredOrderCountProvider.notifier).resetCount();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (route) => false);
      showSnackBar(context, "Sign out successfully", Colors.green);
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }



  Future<void> updateUserLocaltion({
    required context,
    required String id,
    required String state,
    required String city,
    required String locality,
  }) async {
    try {
      http.Response response = await http.put(Uri.parse("$uri/api/users/$id"),
      headers: <String,String> {"Content-Type" : 'application/json; charset=UTF-8'},
      body: jsonEncode({
        'state' : state,
        'city' : city,
        'locality' : locality
      })
      );
      manageHttpResponse(response: response, context: context, onSuccess: () async{
        final updatedUser = jsonDecode(response.body);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        final userJson = jsonEncode(updatedUser);
        providerContainer.read(userProvider.notifier).setUser(userJson);
        await preferences.setString('user', userJson);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }


  Future<void> verifyOtp({required context,required String email, required String otp }) async {
    try {
      http.Response response =  await http.post(Uri.parse("$uri/api/verify-otp"),
      body: jsonEncode({
        'email': email,
        'otp' : otp,
      }),
      headers: <String,String> {"Content-Type" : 'application/json; charset=UTF-8'},
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx) => LoginScreen()), (Route<dynamic> route) => false);
        showSnackBar(context, "Account verified succesfully", Colors.green);
      });
    } catch (e) {
      showSnackBar(context, e.toString(), Colors.red);
    }
  }
}