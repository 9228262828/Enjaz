import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> register(String email, String fullName, String phoneNumber,
      String password) async {
    emit(RegisterLoading());
    try {
      // Create user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user details to Firestore
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': fullName,
        'email': email,
        'phone': phoneNumber,
      });

      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }

  // Login logic
  Future<void> login(String emailOrPhone, String password) async {
    emit(LoginLoading());
    try {
      if (emailOrPhone.contains('@')) {
        // Login using email
        await _auth.signInWithEmailAndPassword(
          email: emailOrPhone,
          password: password,
        );
        emit(LoginSuccess());
      } else {
        // Phone login logic goes here (you can implement OTP handling here)
        emit(LoginFailure('Phone login is not implemented'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }

  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    emit(PasswordVisibilityState(_isPasswordVisible));
  }
}

class PasswordVisibilityState extends AuthState {
  final bool isPasswordVisible;

  PasswordVisibilityState(this.isPasswordVisible);
}
