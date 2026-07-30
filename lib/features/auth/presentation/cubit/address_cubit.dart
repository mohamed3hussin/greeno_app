import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/address_entity.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  AddressEntity? selectedAddress;

  void setAddress(AddressEntity address) {
    selectedAddress = address;
    emit(AddressSelected(address));
  }

  void clearAddress() {
    selectedAddress = null;
    emit(AddressInitial());
  }
}