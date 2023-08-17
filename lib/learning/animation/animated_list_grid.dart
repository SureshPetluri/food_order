import 'package:flutter/material.dart';

void main() {
  runApp(
    MyAppGrid(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: ListView.builder(
              scrollDirection: Axis.horizontal,
              cacheExtent: 0,
              itemCount: 30,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedScrollViewItem(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 200,
                    width: 200,
                    color: Colors.blue,
                  ),
                ),
              )),
        ));
  }
}


class MyAppGrid extends StatelessWidget {
  const MyAppGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              cacheExtent: 0,
              padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 20),
              itemCount: 200,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedScrollViewItem(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    height: 200,
                    width: 200,
                    color: Colors.blue,
                  ),
                ),
              )),
        ));
  }
}




class AnimatedScrollViewItem extends StatefulWidget {
  const AnimatedScrollViewItem({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<AnimatedScrollViewItem> createState() => _AnimatedScrollViewItemState();
}

class _AnimatedScrollViewItemState extends State<AnimatedScrollViewItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..forward();

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: widget.child,
    );
  }

}
