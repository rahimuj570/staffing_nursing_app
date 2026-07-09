// {
//   "name": "string",
//   "phone": "string",
//   "email": "user@example.com",
//   "password": "string",
//   "password_confirm": "string",
//   "address": "string",
//   "ssn": "string",
//   "profile_picture": "string"
// }

import 'dart:io';

class RegisterRequest {
  final String name;
  final String phone;
  final String email;
  final String password;
  final String passwordConfirm;
  final String address;
  final String ssn;
  final File? profilePicture;

  RegisterRequest({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.passwordConfirm,
    required this.address,
    required this.ssn,
    this.profilePicture,
  });
}
