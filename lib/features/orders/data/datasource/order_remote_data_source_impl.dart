import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:greeno_app/core/errors/exceptions.dart';
import 'package:greeno_app/core/errors/failures.dart';
import 'package:greeno_app/features/checkout/data/models/order_model.dart';
import 'package:greeno_app/features/orders/data/datasource/order_remote_data_source.dart';

class OrderRemoteDataSourceImpl extends OrderRemoteDataSource {

  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl({required this.firestore});
  @override
  Future<List<OrderModel>> getOrders(String userUid)async {
    try{
      final snapshot = await firestore
          .collection('users')
          .doc(userUid)
          .collection('orders')
          .orderBy('createdAt',descending: true)
          .get();
      final orders = snapshot.docs.map((doc){
        return OrderModel.fromJson(doc.data(), doc.id);
      }).toList();
      return orders;
    }catch(e){
      throw const ServerException(message: 'Something went wrong while fetching orders');
    }
  }
}