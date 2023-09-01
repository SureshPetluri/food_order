import 'package:flutter/material.dart';

import '../custom_widgets/const_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.copyWith().primary,
              expandedHeight: 90.0,
              // title: Text("Local Stock"),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                titlePadding: const EdgeInsets.only(top: 5, bottom: 8),
                expandedTitleScale: 1.0,
                title: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Local Stocks",
                          style: TextStyle(fontSize: 24),
                        ),
                        Spacer(),
                        Icon(Icons.notifications_active_outlined),
                        sizedBoxWidth10(),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
                background: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 2.0, left: 8.0),
                        child: CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15,
                        ),
                      ),
                      // Icon(Icons.person),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 8.0,
                        ),
                        child: Text(
                          "Suresh",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      const Spacer(),

                      sizedBoxWidth10(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(Icons.language),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: [
            sizedBox10(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildContainer(context, "Your Orders"),
                buildContainer(context, "Buy Again"),
              ],
            ),
            sizedBox20(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildContainer(context, "Your Account"),
                buildContainer(context, "Watch List"),
              ],
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Orders"),
                  Text("See all"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context,String text) {
    return Container(
                height: 50,
                  width: MediaQuery.sizeOf(context).width/2.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white)
                  ),
                  child: Center(child: Text(text)));
  }
}
