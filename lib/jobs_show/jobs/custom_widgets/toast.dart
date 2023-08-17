

import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, String message) {
  OverlayEntry? overlayEntry;
  OverlayState overlayState = Overlay.of(context);
  // Create an AnimationController with duration and curve
  AnimationController controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: overlayState,
  );

  overlayEntry = OverlayEntry(
    builder: (BuildContext context) => Positioned(
      top: MediaQuery.of(context).size.height * 0.7,
      left: 100,
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.center,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1.0, 0.0),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: controller,
              curve: Curves.easeOut,
            )),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);

  // Start the animation by forward()
  controller.forward();

  // Automatically remove the toast after a duration
  Future.delayed(const Duration(seconds: 2), () {
    controller.reverse(); // Reverse the animation
    // Delay the removal after the animation finishes
    Future.delayed(controller.duration!, () {
      overlayEntry == null;
      overlayEntry?.remove();

    });
  });
}

