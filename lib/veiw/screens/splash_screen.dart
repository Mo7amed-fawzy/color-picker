import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:color_picker_app/core/utils/app_colors.dart';
import 'package:color_picker_app/core/utils/app_images.dart';
import 'package:color_picker_app/veiw/screens/color_picker_screen.dart';
import 'package:color_picker_app/veiw/widgets/borders_style.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'dart:ui';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final logoHeight = screenHeight * 0.14;

    return AnimatedSplashScreen(
      duration: 2500,
      splash: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Blurred background circle
              Positioned(
                top: 100,
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        AppColors.deepOrange.withValues(alpha: 0.3),
                        AppColors.transparent,
                      ],
                      radius: 0.8,
                    ),
                  ),
                ),
              ),

              // Glassmorphism Container (بدون اللوجو بداخلها الآن)
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 40,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.05),
                      borderRadius: borderRaduis(30),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.2),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 60),

                          ShaderMask(
                            shaderCallback:
                                (bounds) => const LinearGradient(
                                  colors: [
                                    Colors.orange,
                                    Colors.deepOrangeAccent,
                                  ],
                                ).createShader(bounds),
                            child: const Text(
                              "My Awesome App",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                                color: AppColors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10,
                                    color: AppColors.black54,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              Positioned(
                child: Image.asset(
                  AppAssets.splash,
                  height: logoHeight,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
      nextScreen: const ColorPickerScreen(),
      splashTransition: SplashTransition.scaleTransition,
      pageTransitionType: PageTransitionType.fade,
      backgroundColor: AppColors.blackBackGround,
    );
  }
}
