import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    Center(
      child: Text('Cart'),
    ),
    Center(
      child: Text('Offer'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];
  void changeCurrentIndex(int index) {
    _currentIndex = index;
    emit(ChangeCurrentIndexState());
  }
}
