import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:helpwave/pages/home.dart';
import 'package:helpwave/styling/constants.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    const double bannerWidthPercentage = 0.9;
    const double bannerHeightPercentage = 0.3;
    const double startContainerWidthPercentage = 0.4;
    const double startContainerHeightPercentage = 0.1;
    const double startContainerTextIconDistance = distanceDefault;
    const double startContainerBorderRadius = borderRadiusVeryBig;

    Size mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Image.asset(
              'assets/banner.png',
              width: mediaQuery.width * bannerWidthPercentage,
              height: mediaQuery.height * bannerHeightPercentage,
            ),
          ),
          SizedBox(
            width: mediaQuery.height * startContainerWidthPercentage,
            height: mediaQuery.height * startContainerHeightPercentage,
            child: InkWell(
              borderRadius: BorderRadius.circular(startContainerBorderRadius),
              onTap: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  )),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.start),
                  Container(width: startContainerTextIconDistance),
                  const Icon(Icons.arrow_forward),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
