import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'product_quantity_state.dart';

class ProductQuantityCubit extends Cubit<ProductQuantityState> {

  ProductQuantityCubit(): super(const ProductQuantityState(quantity: 1));

  void increment (){
    emit(
        ProductQuantityState(
            quantity: state.quantity + 1,
        ),
    );
  }
  void decrement (){
    if(state.quantity > 1 ){
      emit(
        ProductQuantityState(
          quantity: state.quantity - 1,
        ),
      );
    }

  }

}