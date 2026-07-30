import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/features/auth/data/models/user_model.dart';
import 'package:greeno_app/features/splash/data/data_sources/splash_remote_data_source.dart';

class SplashRemoteDataSourceImpl implements SplashRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  SplashRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel?> getCurrentUser() async {
    try{
      final currentUser = firebaseAuth.currentUser;
      if(currentUser == null){
        return null;
      }
      final doc = await firestore.collection('users').doc(currentUser.uid).get();
      if(!doc.exists){
        return null;
      }
      return UserModel.fromJson(doc.data()!);
    }on FirebaseException catch(e){
      throw ServerException(
        message: e.message ?? 'Failed to get current user'
      );
    }catch(e){
      throw ServerException(
        message: e.toString(),
      );
    }
  }

  @override
  Future<bool> isEmailVerified() async{
    await firebaseAuth.currentUser?.reload();
    return firebaseAuth.currentUser?.emailVerified ?? false;
  }

}