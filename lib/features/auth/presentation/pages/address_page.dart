import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:greeno_app/core/assets_date/iconBroken.dart';
import 'package:greeno_app/core/constants/primary_button.dart';
import 'package:greeno_app/core/theme/app_colors.dart';
import 'package:greeno_app/features/auth/presentation/cubit/address_cubit.dart';
import 'package:greeno_app/features/auth/presentation/widgets/address_header.dart';
import 'package:greeno_app/features/auth/presentation/widgets/choose_address_card.dart';
import 'package:greeno_app/features/auth/presentation/widgets/or_divider.dart';
import 'package:greeno_app/features/auth/presentation/widgets/selected_address_card.dart';
import 'package:greeno_app/features/auth/presentation/widgets/social_button.dart';

import '../../../../core/dependency_injection/injection_container.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/utils/address_helper.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/entities/register_data_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../cubit/address_state.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/auth_back_button.dart';
import '../widgets/auth_background.dart';
import 'map_picker_page.dart';

class AddressPage extends StatelessWidget {
  const AddressPage({
    super.key,
    required this.registerData,
  });
  final RegisterDataEntity registerData;

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers:[
        BlocProvider(
          create: (_)=> sl<AuthCubit>(),
        ),
        BlocProvider(
          create: (_)=> sl<AddressCubit>(),
        ),
      ],
      child:  _addressView(
        registerData: registerData,
      ),
    );
  }
}

class _addressView extends StatefulWidget{
  const _addressView({
    required this.registerData,
});
  final RegisterDataEntity registerData;

  @override
  State<_addressView> createState() => _addressViewState();
}

class _addressViewState extends State<_addressView> {

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location service'),
        ),
      );
      return;
    }
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Location permission denied'),
        ),
      );
      return;
    }
    final position = await Geolocator.getCurrentPosition();
    final address = await AddressHelper.fromCoordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
    context.read<AddressCubit>().setAddress(address);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.registerData.name);
    return ColoredBox(
      color: Colors.white,
      child: Stack(
        children: [
          const AuthBackground(),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: SafeArea(
              child: BlocConsumer<AuthCubit,AuthState>(
                listener: (context,state){
                  if(state is RegisterSuccess){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('register Success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    context.read<AuthCubit>().sendEmailVerification();
                  }
                  if (state is SendEmailVerificationSuccess) {
                    context.go(
                      RouteNames.verifyEmail,
                      extra: widget.registerData.email,
                    );
                  }

                  if(state is AuthError){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message),),
                    );
                  }
                },
                builder: (context,state){
                  return SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AuthBackButton(),
                          SizedBox(height: 10.h,),
                          Center(
                            child: const AddressHeader(),
                          ),
                          SizedBox(height: 20.h,),
                          ChooseAddressCard(
                            onTap: _getCurrentLocation,
                          ),
                          SizedBox(height: 14.h,),
                          SocialButton(
                              color: AppColors.primary,
                              text: 'Use Current Location',
                              icon: Icon(IconBroken.Location),
                              onPressed: _getCurrentLocation,
                          ),
                          SizedBox(height: 14.h,),
                          OrDivider(text: 'OR',),
                          SizedBox(height: 14.h,),
                          SocialButton(
                            color: AppColors.primary,
                            text: 'Choose on Map',
                            icon: Icon(Icons.map_outlined),
                            onPressed: () async {
                              final address = await Navigator.push<AddressEntity>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const MapPickerPage(),
                                ),
                              );

                              if (address != null) {
                                context.read<AddressCubit>().setAddress(address);
                              }
                            },
                          ),
                          SizedBox(height: 14.h,),
                          BlocBuilder<AddressCubit, AddressState>(
                            builder: (context, state) {
                              return SelectedAddressCard(
                                address: context.read<AddressCubit>().selectedAddress,
                              );
                            },
                          ),
                          SizedBox(height: 14.h,),
                          PrimaryButton(
                            text: 'Create Account',
                            isLoading: state is AuthLoading,
                            onPressed: (){
                              final address = context.read<AddressCubit>().selectedAddress;

                              if (address == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Please choose your address first"),
                                  ),
                                );
                                return;
                              }
                              final user = UserEntity(
                                name: widget.registerData.name,
                                email: widget.registerData.email,
                                phone: widget.registerData.phone,
                                address: address,
                                createdAt: DateTime.now(),
                              );

                              context.read<AuthCubit>().register(
                                email: widget.registerData.email,
                                password: widget.registerData.password,
                                user: user,
                              );

                            },
                          ),
                          SizedBox(height: 30.h,),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
