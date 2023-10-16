import 'package:mobx/mobx.dart';

part 'app_store.g.dart';

class AppStore = _AppStore with _$AppStore;

abstract class _AppStore with Store {
  @observable
  String userFirstName = '';

  @observable
  String userLastName = '';

  @observable
  bool isLoggedIn = false;

  @action
  void setUserFirstName(String val) {
    userFirstName = val;
  }

  @action
  void setUserLastName(String val) {
    userLastName = val;
  }

  @action
  void setIsLoggedIn(bool val) {
    isLoggedIn = val;
  }
}
