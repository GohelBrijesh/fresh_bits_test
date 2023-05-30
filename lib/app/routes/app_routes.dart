part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const CART = _Paths.CART;
  static const HOME = _Paths.HOME;
  static const LOGIN = _Paths.LOGIN;
  static const SPLASH = _Paths.SPLASH;
}

abstract class _Paths {
  _Paths._();
  static const CART = '/cart';
  static const HOME = '/home';
  static const LOGIN = '/login';
  static const SPLASH = '/splash';

}
