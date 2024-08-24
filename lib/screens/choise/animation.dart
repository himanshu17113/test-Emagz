
import 'package:emagz_vendor/screens/choise/e_business_screen.dart';
import 'package:emagz_vendor/screens/choise/e_magz_screen.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

class FlipCardScreen extends StatelessWidget {
  FlipCardScreen({super.key});
 final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  Widget build(BuildContext context) {
    return FlipCard(
      direction: FlipDirection.HORIZONTAL,
      key: cardKey,
      flipOnTouch: true,
      fill: Fill.fillBack,
      front: EbusinessScreen(
        key: cardKey,
      ),
      back: EmagzScreen(
        key: cardKey,
      ),
    );
  }
}
