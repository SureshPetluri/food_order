import 'package:flutter/material.dart';
import '../screens/cart/cart_view.dart';
import '../screens/details/details_view.dart';
import '../screens/home/home_screen.dart';
import '../screens/products_show/products_show_screen.dart';
import '../screens/profile/profile_screen.dart';
//
// class AppPages {
//   static List<Route> generateRoutes(BuildContext context) {
//     final appState = Provider.of<AppState>(context, listen: false);
//
//     return [
//       MaterialPageRoute(
//         builder: (context) => DashBoard(
//           themeMode: appState.themeMode,
//           changeTheme: appState.changeTheme,
//         ),
//       ),
//       // Define other routes here
//     ];
//   }
// }

// class AppPages {
//   const AppPages(
//       {this.themeMode, required this.changeTheme});
//
//   final void Function(ThemeMode) changeTheme;
//    final ThemeMode? themeMode;
//   // static ThemeMode themeMode = ThemeMode.system;
//   // static void Function(ThemeMode) changeTheme = (newThemeMode) {
//   //   themeMode = newThemeMode;
//   // };
//   ThemeMode? get getThemeMode => themeMode;
//
//   static Map<String, WidgetBuilder> routes = {
//     '/': (context) => HomeScreen(themeMode: getThemeMode ?? ThemeMode.system, changeTheme: changeTheme,),
//     '/cart': (context) => const CartScreen(),
//     // Add other routes here
//   };
// }
class AppPages {
  final void Function(ThemeMode)? changeTheme;
  final ThemeMode? themeMode;

  AppPages({
     this.themeMode,
     this.changeTheme,
  });

  ThemeMode? get getThemeMode => themeMode;

  Map<String, WidgetBuilder> get routes {
    return {
      '/': (context) => HomeScreen(
        themeMode: getThemeMode ?? ThemeMode.system,
        changeTheme: changeTheme?? (vv){},
      ),
      '/cart': (context) => const CartScreen(),
      '/profile': (context) => const ProfileScreen(),
      '/products': (context) => const ProductsShowScreen(),
      '/productDetails': (context) => const ProductDetailsScreen(),

    };
  }
}
