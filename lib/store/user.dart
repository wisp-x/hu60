import 'package:flutter/material.dart';

class User with ChangeNotifier {
  int _uid;

  String _name;

  String _mail;

  String _signature;

  String _contact;

  int _regtime;

  bool _hasRegPhone;

  bool _floorReverse;

  bool _siteAdmin;

  bool _isLogin = false;

  void setUserInfo(user) {
    if (user.uid != null) {
      _uid = user.uid ?? 0;
      _name = user.name ?? '';
      _mail = user.mail ?? '';
      _signature = user.signature ?? '';
      _contact = user.contact ?? '';
      _regtime = user.regtime ?? 0;
      _hasRegPhone = user.hasRegPhone ?? false;
      _floorReverse = user.floorReverse ?? false;
      _siteAdmin = user.siteAdmin ?? false;
      _isLogin = true;

      notifyListeners();
    }
  }

  void clearUserInfo() {
    _uid = 0;
    _name = '';
    _mail = '';
    _signature = '';
    _contact = '';
    _regtime = 0;
    _hasRegPhone = false;
    _floorReverse = false;
    _siteAdmin = false;
    _isLogin = false;
    notifyListeners();
  }

  int get uid => _uid;

  String get name => _name;

  String get mail => _mail;

  String get signature => _signature;

  String get contact => _contact;

  int get regtime => _regtime;

  bool get hasRegPhone => _hasRegPhone;

  bool get floorReverse => _floorReverse;

  bool get siteAdmin => _siteAdmin;

  bool get isLogin => _isLogin;
}