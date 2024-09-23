import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enjaz/shared/components/toast_component.dart';
import 'package:enjaz/view/controllers/settings_controller/settings_states.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingCubit extends Cubit<SettingState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  SettingCubit() : super(SettingInitial()) {
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        final userDoc = await _firestore.collection('users').doc(currentUser.uid).get();
        if (userDoc.exists) {
          emit(SettingLoaded(userName: userDoc['name']));
        } else {
          emit(SettingLoaded(userName: 'User'));
        }
      } else {
        emit(SettingUnauthenticated());
      }
    } catch (e) {
      emit(SettingError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
      emit(SettingLogoutSuccess());
      showToast(text: 'تم تسجيل الخروج بنجاح' , state: ToastStates.SUCCESS);
    } catch (e) {
      emit(SettingLogoutError(message: e.toString()));
      showToast(text: 'خطأ في تسجيل الخروج' , state: ToastStates.ERROR);
    }
  }

  Future<void> deleteAccount() async {
    try {
      final User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(currentUser.uid).delete();
        // Delete the user from Firebase Auth
        await currentUser.delete();
        emit(SettingAccountDeleted());
        showToast(text: 'تم حذف حسابك بنجاح' , state: ToastStates.SUCCESS);
      } else {
        emit(SettingUnauthenticated());
        showToast(text: 'خطأ في حذف حسابك' , state: ToastStates.ERROR);
      }
    } catch (e) {
      emit(SettingAccountDeletionError(message: e.toString()));
    }
  }
}
