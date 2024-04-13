import 'package:flutter/cupertino.dart';

class Carts {
  Carts({
    String? id,

    String?  name,
    String? address,
    String? phone,
    String? number,
  }) {
    _id = id;

    _address =  address;
    _name = name;
    _uid = uid;
    _phone = phone;
    _number = number;

  }

  Carts.fromJson(dynamic json) {
    _id = json['id'];

    _address = json['address'];
    _name = json['name'];
    _uid = json['uid'];
    _phone= json['phone'];
    _number = json['number'];

  }

  String? _id;

  String? _address;
  String? _name;
  String? _uid;
  String? _phone;
  String? _number;

  String? get id => _id;

  String? get  address => _address;
  String? get name => _name;
  String? get number => _number;
  String? get uid => _uid;
  String? get phone => _phone;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;

    map[' address'] = _address;
    map['name'] = _name;
    map['number'] = _number;
    map['uid'] = _uid;
    map['phone'] = _phone;


    return map;
  }
}
