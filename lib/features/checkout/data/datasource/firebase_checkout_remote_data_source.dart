import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/order_model.dart';
import 'checkout_remote_data_source.dart';

class FirebaseCheckoutRemoteDataSource
    implements CheckoutRemoteDataSource {

  final FirebaseFirestore firestore;

  FirebaseCheckoutRemoteDataSource(this.firestore);

  @override
  Future<void> placeOrder(OrderModel order) async {
   try{
     await firestore
         .collection('users')
         .doc(order.userId)
         .collection('orders')
         .doc(order.id)
         .set(order.toJson());
   }on NetworkException catch(e){
     throw NetworkException(message: e.message);
   }on ServerException catch(e){
     throw ServerException(message: e.message);
   }catch(e){
     throw ServerException(message: 'some thing went wrong');
   }

  }
}