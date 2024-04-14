import 'package:flutter/cupertino.dart';

class Carts {
  Carts({
    String? id,
    String? name,
    String? product,
    String? address,
    String? phone,
    int? earat,
    String? uid,
  }) {
    _id = id;
    _address = address;
    _name = name;
    _product = product;
    _earat = earat;
    _uid = uid;
    _phone = phone;
  }

  Carts.fromJson(dynamic json) {
    _id = json['id'];
    _address = json['address'];
    _product = json['product'];
    _name = json['name'];
    _uid = json['uid'];
    _phone = json['phone'];
    _earat = json['earat'];
  }

  String? _id;
  String? _address;
  String? _name;
  String? _product;
  int? _earat;
  String? _uid;
  String? _phone;
  int? _amount;

  String? get id => _id;
  String? get address => _address;
  String? get name => _name;
  String? get product => _product;
  String? get uid => _uid;
  int? get earat => _earat;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map[' address'] = _address;
    map['name'] = _name;
    map[' product '] = _product;
    map[' earat'] = _earat;
    map['uid'] = _uid;
    map['phone'] = _phone;

    return map;
  }
}
