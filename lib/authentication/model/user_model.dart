import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String email;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final String mobileNumber;
  @HiveField(4)
  String password; // Removed 'final' to allow updating
  @HiveField(5)
  final String hobbies;


  User({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.password,
    required this.hobbies,
  });

  // Optional: Add a setter for password if you want to include additional logic
  set updatePassword(String newPassword) {
    // Here you could include validation or encryption before setting the password
    password = newPassword;
  }
}