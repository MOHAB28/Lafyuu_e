import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/presentation/pages/cart_page/cart_page.dart';
import '../../../../profile/presentation/pages/profile_page.dart';
import '../../pages/layout/home/home_page.dart';

abstract class BottomNavStates {}

class BottomNavIntialState extends BottomNavStates {}

class ChangeCurrentIndexState extends BottomNavStates {}

class BottomNavCubit extends Cubit<BottomNavStates> {
  BottomNavCubit() : super(BottomNavIntialState());
  static BottomNavCubit get(BuildContext context) => BlocProvider.of(context);
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<Widget> screens = const [
    HomePage(),
    Center(
      child: Text('Explore'),
    ),
    CartPage(),
    Center(
      child: Text('Offer'),
    ),
    ProfilePage(),
  ];
  void changeCurrentIndex(int index) {
    _currentIndex = index;
    emit(ChangeCurrentIndexState());
  }
}
