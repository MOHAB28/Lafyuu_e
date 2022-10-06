import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: cubit.currentIndex,
          onTap: (index) {
            cubit.changeCurrentIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(Icons.search),
            ),
            BottomNavigationBarItem(
              label: 'Cart',
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Offer',
              icon: Icon(Icons.local_offer_outlined),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(Icons.person_outline_rounded),
            ),
          ],
        ),
      );
    });
  }
}
