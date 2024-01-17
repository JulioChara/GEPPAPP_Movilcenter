
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPGlobal {

  static final SPGlobal _instance = SPGlobal._();

  SPGlobal._();

  factory SPGlobal(){
    return _instance;
  }

  late SharedPreferences _prefs;

  Future<void> initShared() async{
    _prefs = await SharedPreferences.getInstance();
  }

  bool get isLogin => _prefs.getBool("isLogin") ?? false;

  set isLogin(bool value){
    _prefs.setBool("isLogin", value);
  }

  String get idUser => _prefs.getString("idUser") ?? "";
  set idUser(String value){
    _prefs.setString("idUser", value);
  }

  String get rolId => _prefs.getString("rolId") ?? "";
  set rolId(String value){
    _prefs.setString("rolId", value);
  }

  String get rolName => _prefs.getString("rolName") ?? "";
  set rolName(String value){
    _prefs.setString("rolName", value);
  }

  String get usNombre => _prefs.getString("usNombre") ?? "";
  set usNombre(String value){
    _prefs.setString("usNombre", value);
  }




  String get idOffPagSec => _prefs.getString("idOffPagSec") ?? "";
  set idOffPagSec(String value){
    _prefs.setString("idOffPagSec", value);
  }



  String get spNumeroCobranzaNext => _prefs.getString("spNumeroCobranzaNext") ?? "";
  set spNumeroCobranzaNext(String value){
    _prefs.setString("spNumeroCobranzaNext", value);
  }


  String get spInformeCloud => _prefs.getString("spInformeCloud") ?? "";  //1 DESCARGDO // 0 SUBIDO REGRESA
  set spInformeCloud(String value){
    _prefs.setString("spInformeCloud", value);
  }




  //PARA VALORES DE IMPRESION XD//

  String get spImpEmpDireccion => _prefs.getString("spImpEmpDireccion") ?? "";  //1 DESCARGDO // 0 SUBIDO REGRESA
  set spImpEmpDireccion(String value){
    _prefs.setString("spImpEmpDireccion", value);
  }

  String get spImpEmpTelefono => _prefs.getString("spImpEmpTelefono") ?? "";  //1 DESCARGDO // 0 SUBIDO REGRESA
  set spImpEmpTelefono(String value){
    _prefs.setString("spImpEmpTelefono", value);
  }




  Color get colorA => Color(_prefs.getInt('color') ?? Colors.green.value);
  set colorA(Color value) {
    //_prefs.getInt("colorA", value);
  }

  Color get colorB => Color(_prefs.getInt('color') ?? Colors.red.value);
  set colorB(Color value) {
    //_prefs.getInt("colorA", value);
  }



}