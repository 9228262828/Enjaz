import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImage;

  UserModel({this.name, this.email, this.phone, this.profileImage});

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      name: data['name'] as String?,
      email: data['email'] as String?,
      phone: data['phone'] as String?,
      profileImage: data['profileImage'] as String?,
    );
  }
}

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final UserModel user;

  const UserLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object?> get props => [message];
}
