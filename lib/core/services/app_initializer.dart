import 'package:firebase_core/firebase_core.dart';
import 'package:greeno_app/features/favorite/data/models/favorite_item_hive_model.dart';
import 'package:greeno_app/firebase_options.dart';

import '../../features/cart/data/models/cart_item_hive_model.dart';
import '../../features/cart/data/models/product_hive_model.dart';
import '../dependency_injection/injection_container.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppInitializer {
  static Future<void>init()async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Hive.initFlutter();

    Hive.registerAdapter(ProductHiveModelAdapter());
    Hive.registerAdapter(CartItemHiveModelAdapter());
    Hive.registerAdapter(FavoriteItemHiveModelAdapter());
    await Hive.openBox<CartItemHiveModel>('cartBox');
    await Hive.openBox<FavoriteItemHiveModel>('favoriteBox');
    await setupDependencies();
  }
}