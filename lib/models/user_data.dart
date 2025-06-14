import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String name;
  final String uid;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserData({
    required this.email,
    required this.name,
    required this.uid,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      email: json['email'] as String,
      name: json['name'] as String,
      uid: json['uid'] as String,
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      updatedAt: (json['updatedAt'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'uid': uid,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  UserData copyWith({
    String? email,
    String? name,
    String? uid,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserData(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
