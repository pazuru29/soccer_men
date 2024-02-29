import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(1)
  String name;
  @HiveField(2)
  Uint8List? image;

  UserModel({
    this.name = 'User',
    this.image,
  });
}
