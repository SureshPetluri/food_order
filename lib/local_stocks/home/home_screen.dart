import 'package:flutter/material.dart';
import 'package:food_order/local_stocks/cart/cart_view.dart';
import 'package:food_order/local_stocks/dash_board/dash_board_view.dart';
import 'package:provider/provider.dart';

import '../profile/profile_screen.dart';
import 'home_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(
      {super.key, required this.themeMode, required this.changeTheme});

  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, controller, _) => Scaffold(
        body: controller.count == 0
            ? DashBoard(themeMode: themeMode, changeTheme: changeTheme)
            : controller.count == 1
                ? const ProfileScreen()
                : const CartScreen(),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.shifting,
          selectedItemColor: Theme.of(context).colorScheme.copyWith().tertiary,
          unselectedItemColor: Theme.of(context).colorScheme.copyWith().surface,
          backgroundColor: Theme.of(context).colorScheme.copyWith().primary,
          elevation: 10,
          currentIndex: controller.count,
          onTap: (e) {
            controller.bottomNavSelection(e);
            if (controller.count == 0) {
              // Navigator.pushNamed(context, '/');
            } else if (controller.count == 1) {
              // Navigator.pushNamed(context, '/cart');
            } else {
              // Navigator.pushNamed(context, '/');
            }
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.perm_identity_sharp), label: "You"),
            BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, right: 8.0),
                      child: const Icon(Icons.shopping_cart),
                    ),
                    if (controller.count > 0)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: controller.count == 2
                                ? Theme.of(context)
                                    .colorScheme
                                    .copyWith()
                                    .tertiary
                                : Theme.of(context)
                                    .colorScheme
                                    .copyWith()
                                    .surface,
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            controller.count.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                ),
                label: "Cart"),
          ],
        ),
      ),
    );
  }
}
