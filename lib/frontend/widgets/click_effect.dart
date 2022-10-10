
import 'package:flutter/material.dart';

class AnimatedContainerOnClicked extends StatefulWidget {
  const AnimatedContainerOnClicked({Key? key,
    required this.child,
    required this.onClick}) : super(key: key);

  final Widget child;
  final Function onClick;
  @override
  State<AnimatedContainerOnClicked> createState() => _AnimatedContainerOnClickedState();
}

class _AnimatedContainerOnClickedState extends State<AnimatedContainerOnClicked> with TickerProviderStateMixin {

  AnimationController? controller;
  Animation<double>? animation;
  // GameAudioManager _gameAudioManager;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 100), reverseDuration: const Duration(milliseconds: 10),
      animationBehavior: AnimationBehavior.preserve
    );
    controller!.addListener(() {
      setState(() {});
    });
    controller!.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // getIt<GameAudioManager>().playClick();
        print("Completed");
        controller!.reverse();
        widget.onClick();
      }

      if (status == AnimationStatus.reverse) {
        print('Reverse');
      }
    });
    animation = Tween<double>(begin: 1, end: .7).animate(controller!);
    // _gameAudioManager = GameAudioManager();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          controller!.forward();
        },
        child: Transform.scale(
          scale: animation!.value,
          child: widget.child,
        )
    );
  }
}
