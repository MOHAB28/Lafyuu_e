import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../cart/presentation/bloc/cart_bloc.dart';
import '../../bloc/bottom_nav_cubit/bottom_nav_cubit.dart';
import '../../bloc/home_bloc.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  void _blind() {
    BlocProvider.of<HomeBloc>(context).add(GetHomeDataEvent());
    BlocProvider.of<CartBloc>(context).add(GetCartsDataEvent());
  }

  @override
  void initState() {
    _blind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavCubit, BottomNavStates>(
      builder: (context, state) {
        var cubit = BottomNavCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.allFavsPageKey),
                icon: const Icon(
                  Icons.favorite_outline,
                  color: ColorManager.grey,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return Container(
                height: AppSize.s20,
                width: AppSize.s20,
                margin: const EdgeInsets.only(left: AppMargin.m18,top: AppMargin.m16),
                decoration: const BoxDecoration(
                  color: ColorManager.red,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    CartBloc.get(context).cartEntity != null
                        ? '${CartBloc.get(context).cartEntity!.cartData.cartItemData.length}'
                        : '0',
                    style: getSemiBoldStyle(
                      color: ColorManager.white,
                      fontSize: FontSize.s10,
                    ),
                  ),
                ),
              );
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeCurrentIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                label: 'Home',
                tooltip: 'Home',
                icon: Icon(Icons.home_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Explore',
                tooltip: 'Explore',
                icon: Icon(Icons.search),
              ),
              BottomNavigationBarItem(
                label: 'Cart',
                tooltip: 'Cart',
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Offer',
                tooltip: 'Offer',
                icon: Icon(Icons.local_offer_outlined),
              ),
              BottomNavigationBarItem(
                label: 'Account',
                tooltip: 'Account',
                icon: Icon(Icons.person_outline_rounded),
              ),
            ],
          ),
        );
      },
    );
  }
}
