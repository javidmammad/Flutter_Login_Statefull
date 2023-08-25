import 'package:login_stateful/screens/login.dart';
import 'package:login_stateful/widgets/cat.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  late Animation<double> catAnimation;
  late AnimationController catController;
  late Animation<double> boxAnimation;
  late AnimationController boxController;

  @override
  void initState() {
    super.initState();
    boxController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65)
        .animate(CurvedAnimation(parent: boxController, curve: Curves.linear));

    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });

    boxController.forward();

    catController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    catAnimation = Tween(begin: -60.0, end: -120.0).animate(
      CurvedAnimation(parent: catController, curve: Curves.easeIn),
    );
  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
                hasScrollBody: false,
                child: SafeArea(
                  child: Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(padding: const EdgeInsets.only(top: 50.0)),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          buildCatAnimation(),
                          buildBox(),
                          buildLeftFlap(),
                          buildRightFlap()
                        ],
                      ),
                      Login(
                        onSecure: onTap,
                      )
                    ],
                  )),
                ))
          ],
        ));
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          top: catAnimation.value,
          right: 0,
          left: 0,
          child: child!,
        );
      },
      child: const Cat(),
    );
  }

  Widget buildBox() {
    return Container(
      height: 150,
      width: 150,
      color: Colors.brown,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
        left: 3,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              alignment: Alignment.topLeft,
              angle: boxAnimation.value,
              child: child,
            );
          },
          child: Container(
            height: 12.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ));
  }

  Widget buildRightFlap() {
    return Positioned(
        right: 3,
        child: AnimatedBuilder(
          animation: boxAnimation,
          builder: (context, child) {
            return Transform.rotate(
              alignment: Alignment.topRight,
              angle: -boxAnimation.value,
              child: child,
            );
          },
          child: Container(
            height: 12.0,
            width: 125.0,
            color: Colors.brown,
          ),
        ));
  }
}
