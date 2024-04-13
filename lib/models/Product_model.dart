import 'package:flutter/cupertino.dart';

class Product {
  Product({
    String? id,
    int?  gram,
    int? caliber,
    String?  name,
    String? imageUrl,

  }) {
    _id = id;
    _gram = gram;
    _caliber = caliber;
    _name = name;
    _uid = uid;
    _imageUrl = imageUrl;

  }

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _gram = json['gram'];
    _caliber = json['caliber'];
    _name = json['name'];
    _uid = json['uid'];
    _imageUrl = json['imageUrl'];

  }

  String? _id;
  int? _gram;
  int? _caliber;
  String? _name;
  String? _uid;
  String? _imageUrl;


  String? get id => _id;
  int? get gram => _gram;
  int? get caliber => _caliber;
  String? get name => _name;
  String? get uid => _uid;
  String? get imageUrl => _imageUrl;


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['gram'] = _gram;
    map['caliber'] = _caliber;
    map['name'] = _name;
    map['uid'] = _uid;
    map['imageUrl'] = _imageUrl;


    return map;
  }
}
