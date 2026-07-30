import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:greeno_app/features/auth/data/models/user_model.dart';

class FirebaseAuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    required UserModel user,
  })async {
    try{
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user!.uid;
      final updatedUser = user.copyWith(
        uid: uid,
      );
      await firestore.collection('users').doc(uid).set(updatedUser.toJson());

      return updatedUser;

    } on FirebaseAuthException catch(e){
      throw AuthException(
          message: e.message ?? 'Authentication failed.'
      );
    } on FirebaseException catch(e){
      throw ServerException(
          message: e.message ?? 'Failed to save user data'
      );
    } catch(e){
      throw ServerException(
          message: e.toString()
      );
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try{
      final credential = await
      firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
      );

      final uid = credential.user!.uid;

      final document = await firestore.collection('users').doc(uid).get();

      final data = document.data();
      if(data == null) {
        throw ServerException(message: 'User data not found');
      }

      return UserModel.fromJson(data);

    }on FirebaseAuthException catch(e){
      throw AuthException(
          message: e.message ?? 'Authentication failed.'
      );
    } on FirebaseException catch(e){
      throw ServerException(
          message: e.message ?? 'Failed to save user data'
      );
    } catch(e){
      throw ServerException(
          message: e.toString()
      );
    }

  }

  @override
  Future<void> forgetPassword({
    required String email
  })async {
    try{
      await firebaseAuth.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch(e){
      throw AuthException(
          message: e.message ?? 'Failed to send reset email.'
      );
    }catch(e){
      throw ServerException(
          message: e.toString()
      );
    }

  }

  @override
  Future<void> sendEmailVerification() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(
          message: 'No authenticated user found.',
        );
      }
      await user.reload();
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Failed to send verification email.',
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }



  @override
  Future<void> logout()async {
    try{
      await firebaseAuth.signOut();
    }catch(e){
      throw ServerException(
          message: e.toString()
      );
    }
  }

  @override
  Future<bool> checkEmailVerification() async {
    try {
      await firebaseAuth.currentUser?.reload();

      final user = firebaseAuth.currentUser;

      if (user == null) {
        throw const AuthException(
          message: 'No authenticated user found.',
        );
      }

      return user.emailVerified;
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        message: e.message ?? 'Failed to check email verification.',
      );
    } catch (e) {
      throw ServerException(
        message: e.toString(),
      );
    }
  }


}