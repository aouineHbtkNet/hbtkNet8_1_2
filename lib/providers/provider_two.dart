import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' ;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';
import 'package:http/http.dart' as http;


class ProviderTwo extends ChangeNotifier {




  //=====================================================START ===========/public/admin/subirAProductos =================


  Map <String, dynamic>    _responseFromuploadData = {};
  Map<String, dynamic> get responseFromUploaddata =>_responseFromuploadData;

  bool _mistake = false;
  bool  get mistake =>_mistake;

  String _mistakeMessage = '';
  String  get mistakeMessage => _mistakeMessage;

  Future<http.StreamedResponse?> addProducts(  File imageFile,String name,String marca, String price ,String previousPrice) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');


    var request = http.MultipartRequest('POST',
        Uri.parse('http://192.168.1.22/api_v_1/public/admin/subirAProductos'));


    if (imageFile != null) {


       request.files.add(await http.MultipartFile.fromPath('foto_producto', imageFile.path));
        request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Accept': 'application/json',
        'Authorization': 'Bearer $spToken',
      });

      request.fields['nombre_producto'] = name;
      request.fields['marca'] = marca;
      request.fields['precio_ahora'] = price;
      request.fields['precio_anterior'] = previousPrice;

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);


      if (response.statusCode == 201) // first if
          {
        try {
          _responseFromuploadData = jsonDecode(response.body);
          _mistake = false;
        }
        catch (e) // catch error if the code is 201 nothing to do with other code values
            {
          _mistake = true;
          // _errorMessage=' Something went bad ${e.toString()}'; // not tested yet i will use this instead of   _errorMessage=e.toString(); if it works
          _mistakeMessage = e.toString();
          _responseFromuploadData = {};
        }
      }
      else // second if : if the code is not 201 which means the connection is not build so it may be internet or other stuff
          {
        _mistake = true;
        _mistakeMessage = 'It could be no internet';
        _responseFromuploadData = {};
      }

    }
  }







  //=============================================== END ==========================to send dta =======


//======================================start  uploadANewProductWithNoImage=================================


  String mistakeMessageFromUploadnewproductWithNoImage = '';
  var id;

  Future  uploadANewProductWithNoImage(
      String categoria_id,
      String nombre_producto,
      String marca,
      String contenido,
      String porcientoDeiva,
      String precio_ahora,
      String hayDescuento,
      String precio_anterior,
      String porciento_de_descuento,
      String descripcion,
      ) async {

    var json;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');
    print ('Got token');

    final url = Uri.parse('http://192.168.1.22/api_v_1/public/admin/subirAProductostest');

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };

    Map<String, String> body = {
      'categoria_id': categoria_id,
      'nombre_producto':nombre_producto,
      'marca':marca,
      'contenido':contenido,
      'porciento_de_iva':porciento_de_descuento,
      'precio_ahora':precio_ahora,
      'hay_descuento':hayDescuento,
      'precio_anterior':precio_anterior,
      'porciento_de_descuento':porciento_de_descuento,
      'descripcion':descripcion
    };

    final response = await post(url, headers: headers, body:jsonEncode(body));

    if (response.statusCode == 201) // first if
        {
      try {     json = jsonDecode(response.body);
        mistakeMessageFromUploadnewproductWithNoImage = 'Nuevo producto sin imagen  ha sido agregado exitosamente ';
      }
      catch (e) // catch error if the code is 200 nothing to do with oer code values
          {
        mistakeMessageFromUploadnewproductWithNoImage = e.toString();


      }
    }
    else // second if : if the code is not 201 which means the connection is not build so it may be internet or other stuff
        {
      mistakeMessageFromUploadnewproductWithNoImage = 'OPs Someting went wrong .Check your internet connection and try again';

    }



    id =json['id'];

    notifyListeners();

    return mistakeMessageFromUploadnewproductWithNoImage;

  }










//=====================================================================bring productos===================================
  Map <String, dynamic>    _map = {};
  Map<String, dynamic> get map =>_map;
  bool _error = false;
  bool  get error =>_error;
  String _errorMessage = '';
  String  get errorMessage => _errorMessage;


  Future bringproductos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? spToken = await prefs.getString('spToken');
    print('sptoken ========================$spToken');


    final Map<String, String> _userprofileHeader = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $spToken',
    };
    Uri _tokenUrl = Uri.parse(
        'http://192.168.1.22/api_v_1/public/admin/bringproductos');

    http.Response response = await http.post(
        _tokenUrl, headers: _userprofileHeader);

    if (response.statusCode == 201) // first if
        {
      try {
        _map = jsonDecode(response.body);
        _error = false;
      }
      catch (e) // catch error if the code is 201 nothing to do with other code values
          {
        _error = true;
        // _errorMessage=' Something went bad ${e.toString()}'; // not tested yet i will use this instead of   _errorMessage=e.toString(); if it works
        _errorMessage = e.toString();
        _map = {};
      }
    }
    else // second if : if the code is not 201 which means the connection is not build so it may be internet or other stuff
        {
      _error = true;
      _errorMessage = 'It could be no internet';
      _map = {};
    }
    notifyListeners();
  }

  void  initialValues (){
    _map = {};
    _error = false;
    _errorMessage = '';
    notifyListeners();
  }














}

