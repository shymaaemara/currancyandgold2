import 'package:flutter/cupertino.dart';

class Exhibit {
  Exhibit({
    String? id,
    String? place,
    String? email,
    String? name,
    String? password,
    String? phone,
    String? uid,
    String? imageUrl,

  }) {
    _id = id;
    _place = place;
    _email = email;
    _name = name;
    _password = password;
    _phone = phone;
    _uid = uid;
    _imageUrl = imageUrl;

  }

  Exhibit.fromJson(dynamic json) {
    _id = json['id'];
    _place = json['place'];
    _email = json['email'];
    _name = json['name'];
    _password = json['password'];
    _phone = json['phone'];
    _uid = json['uid'];
    _imageUrl = json['imageUrl'];

  }

  String? _id;
  String? _place;
  String? _email;
  String? _name;
  String? _password;
  String? _phone;
  String? _uid;
  String? _imageUrl;


  String? get id => _id;
  String? get address => _place;
  String? get email => _email;
  String? get name => _name;
  String? get password => _password;
  String? get phone => _phone;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['address'] = _place;
    map['email'] = _email;
    map['name'] = _name;
    map['password'] = _password;
    map['phone'] = _phone;
    map['uid'] = _uid;
    map['imageUrl'] = _imageUrl;


    return map;
  }
}
