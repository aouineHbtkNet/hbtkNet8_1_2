import 'dart:convert';
import 'dart:io';
import 'package:simo_v_7_0_1/apis/future_functions_SP.dart';

import 'package:simo_v_7_0_1/modals/admin_login_response_model.dart';

import 'package:simo_v_7_0_1/modals/loginEndpointApiResponseFile.dart';


import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


enum States { initial, loading, loaded }

class ProviderOne extends ChangeNotifier {



  States state = States.initial;

//=================================================logOutUsers   4/2/2022 used ok  =========================

 Future<bool> logOutUsers(String mytoken) async {
  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',};

  Uri _tokenUrl = Uri.parse('http://192.168.1.22/api_v_1/public/client/user/logout');
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);
  return true;
 }


// ============================== Future get loginEndpointapi response for users  OK =======================

 Future<LoginEndpointApiResponseModel> getLoginEndpointApiResponse(String email,
     String password) async {

  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
  };
  Uri _tokenUrl = Uri.parse('http://10.0.2.2:8000/api_v_1/public/publicapi/admin/login');
  Map<String, String> body = {'email': email, 'password': password};


  http.Response response = await http.post(
      _tokenUrl, headers: _loginHeader, body: jsonEncode(body));

  var data = jsonDecode(response.body);

  LoginEndpointApiResponseModel loginEndpointApiResponseModel = LoginEndpointApiResponseModel();
  loginEndpointApiResponseModel = LoginEndpointApiResponseModel.fromJson(data);

  return loginEndpointApiResponseModel;
 }

//==================================addTokenToSPA 4/2/2022 used ok   ================================


 addTokenToSPA(String value) async {
  await FutureFunctionsSP().addTokenToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

//================================== getSPToken() 4/2/2022 used ok ================================
 String? spToken = '';

 getSPToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  spToken = prefs.getString('spToken');
  notifyListeners();
 }

 

//================================== addUserNameToSPA  2/4/2022 used ok  ================================

 addUserNameToSPA(String value) async {
  await FutureFunctionsSP().addUserNameToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

 //==============================   getuserNameFromSP   4/2/2022 used ok  =======================================

 String userNameFromSharedPtreferences = '';

 getuserNameFromSP() async {
  userNameFromSharedPtreferences =
  await FutureFunctionsSP().getuserNameFromSP();
  state = States.loaded;
  notifyListeners();
 }

//==============================================addUserEmailToSPA    4/2/2022   used ok ============================
 addUserEmailToSPA(String value) async {
  await FutureFunctionsSP().addUserEmailToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

//================================== getuserEmailFromSP 4/2/2022 used ok  ========================================
 String emailFromSharedPtreferences = '';
 getuserEmailFromSP() async {
  emailFromSharedPtreferences =
  await FutureFunctionsSP().getuserEmailFromSP();
  state = States.loaded;
  notifyListeners();
 }

//==================================== addUserIdToSPA 4/2/2022 used ok  =======================================

 addUserIdToSPA(int value) async {
  await FutureFunctionsSP().addUserIdToSPB(value);
  state = States.loaded;
  notifyListeners();
 }

//==================================getuserIdFromSP 4/2/2022 used ok  ========================================
 int idFromSharedPtreferences = 0;
 getuserIdFromSP() async {
  idFromSharedPtreferences = await FutureFunctionsSP().getuserIdFromSP();
  state = States.loaded;
  notifyListeners();
 }

//================================4/2/2022 used ok  ===================================================

 Future<AdminLoginResponse> registerAdmins   (String name ,String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
  };
  Uri _tokenUrl = Uri.parse('http://192.168.1.22/api_v_1/public/publicapi/admin/register');
  Map<String, String> body = {
   'name':name,
   'email': email,
   'password': password};

  http.Response response = await http.post(
      _tokenUrl,
      headers: _loginHeader,
      body: jsonEncode(body));

  var data = jsonDecode(response.body);

  AdminLoginResponse adminLoginResponse = AdminLoginResponse();
  adminLoginResponse = AdminLoginResponse.fromJson(data);

  return adminLoginResponse;
 }


 
 // ============================== loginInForAdmins   OK  4/2/2022=======================
 

 Future<AdminLoginResponse> loginInForAdmins (String email,String password) async {
  const Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',};
  Uri _tokenUrl = Uri.parse(
'http://192.168.1.22/api_v_1/public/publicapi/admin/login');
  Map<String, String> body = {'email': email, 'password': password};
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader, body: jsonEncode(body));
  var data = jsonDecode(response.body);
  AdminLoginResponse adminLoginResponse = AdminLoginResponse();
  adminLoginResponse = AdminLoginResponse.fromJson(data);
  return adminLoginResponse;
 }


//========================== logoutOutAdmins 04/2/2022 used ok ==========================

 Future<bool> logoutOutAdmins(String mytoken) async {

  Map<String, String> _loginHeader = {
   'Content-Type': 'application/json',
   'Accept': 'application/json',
   'Authorization': 'Bearer $mytoken',
  };
  Uri _tokenUrl = Uri.parse('http://192.168.1.22/api_v_1/public/admin/logout/admin');
  http.Response response = await http.post(_tokenUrl, headers: _loginHeader,);
  var data = jsonDecode(response.body);
  
  return true;
 }




}

