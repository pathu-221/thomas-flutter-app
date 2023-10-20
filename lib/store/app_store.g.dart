// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$userFirstNameAtom =
      Atom(name: '_AppStore.userFirstName', context: context);

  @override
  String get userFirstName {
    _$userFirstNameAtom.reportRead();
    return super.userFirstName;
  }

  @override
  set userFirstName(String value) {
    _$userFirstNameAtom.reportWrite(value, super.userFirstName, () {
      super.userFirstName = value;
    });
  }

  late final _$userLastNameAtom =
      Atom(name: '_AppStore.userLastName', context: context);

  @override
  String get userLastName {
    _$userLastNameAtom.reportRead();
    return super.userLastName;
  }

  @override
  set userLastName(String value) {
    _$userLastNameAtom.reportWrite(value, super.userLastName, () {
      super.userLastName = value;
    });
  }

  late final _$isLoggedInAtom =
      Atom(name: '_AppStore.isLoggedIn', context: context);

  @override
  bool get isLoggedIn {
    _$isLoggedInAtom.reportRead();
    return super.isLoggedIn;
  }

  @override
  set isLoggedIn(bool value) {
    _$isLoggedInAtom.reportWrite(value, super.isLoggedIn, () {
      super.isLoggedIn = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AppStore.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void setUserFirstName(String val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setUserFirstName');
    try {
      return super.setUserFirstName(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLoading(bool val) {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.setLoading');
    try {
      return super.setLoading(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserLastName(String val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setUserLastName');
    try {
      return super.setUserLastName(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsLoggedIn(bool val) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.setIsLoggedIn');
    try {
      return super.setIsLoggedIn(val);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userFirstName: ${userFirstName},
userLastName: ${userLastName},
isLoggedIn: ${isLoggedIn},
isLoading: ${isLoading}
    ''';
  }
}
