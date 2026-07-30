import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeno_app/features/cart/presentation/pages/cart_page.dart';

import '../../../../core/assets_date/iconBroken.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../cubit/navigation_cubit.dart';

class NavigationView extends StatelessWidget {
  const NavigationView({
    super.key,
    required this.user
  });
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      builder: (context, state) {

        final pages = [
          HomePage(user: user,),

          const Scaffold(
            body: Center(
              child: Text('Favorite'),
            ),
          ),

          CartPage(),

          const Scaffold(
            body: Center(
              child: Text('Profile'),
            ),
          ),
        ];

        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index){
              context.read<NavigationCubit>().changeTab(index);
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primary,
            unselectedItemColor: AppColors.textSecondary,
            items: const [

              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: 'Home',
              ),

              BottomNavigationBarItem(
                icon: Icon(IconBroken.Heart),
                label: 'Favorite',
              ),

              BottomNavigationBarItem(
                icon: Icon(IconBroken.Bag),
                label: 'Cart',
              ),

              BottomNavigationBarItem(
                icon: Icon(IconBroken.Profile),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}