import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../constant/constants.dart';

class AnimatedPopup extends HookWidget {
  final Widget child;

  const AnimatedPopup({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: kAnimationDuration(0.3),
    );
    final animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    useEffect(() {
      animationController.forward();
      return null; // Forward the animation
    }, []);

    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
