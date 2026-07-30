import 'package:equatable/equatable.dart';

import '../../domain/entities/address_entity.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object?> get props => [];
}

class AddressInitial extends AddressState {}

class AddressSelected extends AddressState {
  final AddressEntity address;

  const AddressSelected(this.address);

  @override
  List<Object?> get props => [address];
}