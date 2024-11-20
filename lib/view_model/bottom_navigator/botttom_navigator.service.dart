import 'package:flutter/widgets.dart';

class BotttomNavigatorService with ChangeNotifier {
  int _selectedScreenIndex = 0;
  int get selectedScreenIndex => _selectedScreenIndex;

  void onRedirectScreen(BottomNavScreen bottomNavScreen) {
    switch (bottomNavScreen) {
      case BottomNavScreen.TRANGCHU:
        _selectedScreenIndex = 0;
        break;

      case BottomNavScreen.THOIKHOABIEU:
        _selectedScreenIndex = 1;
        break;

      case BottomNavScreen.QUETQR:
        _selectedScreenIndex = 2;
        break;

      case BottomNavScreen.THONGTIN:
        _selectedScreenIndex = 3;
        break;

      case BottomNavScreen.CAIDAT:
        _selectedScreenIndex = 4;
        break;
    }
    notifyListeners();
  }

  void setScreen(int onIndex) {
    _selectedScreenIndex = onIndex;
    notifyListeners();
  }
}

enum BottomNavScreen { TRANGCHU, THOIKHOABIEU, QUETQR, THONGTIN, CAIDAT }
