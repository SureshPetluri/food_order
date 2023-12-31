import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../custom_widgets/const_widgets.dart';
import '../custom_widgets/custom_drop_down.dart';
import '../custom_widgets/switch_modes.dart';
import 'dash_board_provider.dart';
import 'dash_board_widgets/offer_show.dart';

class DashBoard extends StatefulWidget {
  const DashBoard(
      {super.key, required this.themeMode, required this.changeTheme});

  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DashBoardProvider>(
      builder: (context, controller, _) => Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor:
                    Theme.of(context).colorScheme.copyWith().primary,
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: const EdgeInsets.only(top: 5, bottom: 8),
                  expandedTitleScale: 1.0,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.person),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.5,
                        height: 40,
                        child: TextFormField(
                          controller: controller.productSearchController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SwitchMode(
                          themeMode: widget.themeMode,
                          changeTheme: widget.changeTheme,
                        ),
                      ),
                    ],
                  ),
                  background: Stack(
                    children: [
                      const Positioned(
                          top: 10,
                          left: 10,
                          child: Text(
                            "Local Stocks",
                            style: TextStyle(fontSize: 24),
                          )),
                      Positioned.fill(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 5),
                          child: Image.network(
                            'assest/local_stocks/images/homeAppliclance.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(controller.offerMap.length, (index) {
                    return OffersShowBadge(
                      text: controller.offerMap[index]["discount"],
                      size: MediaQuery.sizeOf(context).width > 750 ? 230 : 100,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(8.0)),
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        height: MediaQuery.sizeOf(context).width > 750
                            ? MediaQuery.sizeOf(context).height * 0.3
                            : MediaQuery.sizeOf(context).height * 0.15,
                        child: Image.asset(
                            controller.offerMap[index]["imageUrl"],
                            fit: BoxFit.contain),
                      ),
                    );
                  }),
                ),
                sizedBox30(),
                const Center(
                  child: SizedBox(
                      height: 200, width: 250, child: CustomDropDown()),
                ),
              ],
            ),
          ),
        ),
      ),
      // bottomNavigationBar: const CustomBottomNaBar(),
    );
  }
}

