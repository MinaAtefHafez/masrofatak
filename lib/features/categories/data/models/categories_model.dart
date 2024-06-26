import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part 'categories_model.g.dart';
// ignore_for_file: public_member_api_docs, sort_constructors_first

@HiveType(typeId: 0)
class CategoryModel {
  @HiveField(0)
  final String? name;
  @HiveField(1)
  final int? id;
  @HiveField(2)
  final String? icon;
  CategoryModel({
    this.name,
    this.id,
    this.icon,
  });

  CategoryModel copyWith({
    String? name,
    int? id,
    String? icon,
  }) {
    return CategoryModel(
      name: name ?? this.name,
      id: id ?? this.id,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'icon': icon,
    };
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    return CategoryModel(
      name: map['name'] != null ? map['name'] as String : null,
      id: map['id'] != null ? map['id'] as int : null,
      icon: map['icon'] != null ? map['icon'] as String : null,
    );
  }

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source) as Map<String, dynamic>);
}


//! flutter packages pub run build_runner build