// import 'package:flutter/material.dart';
//
// import 'assets.dart';
//
// class ScratcherSplashScreen extends StatelessWidget {
//   const ScratcherSplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // Close button at top left
//             Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: IconButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 24,
//                   ),
//                 ),
//               ),
//             ),
//
//             // Main content centered
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // Logo image
//                     Image.asset(
//                       Assets.winLog,
//                       height: 120,
//                       fit: BoxFit.contain,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: const Text(
//                         'Winlads Scratch',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           letterSpacing: 1.2,
//                         ),
//                       ),
//                     ),
//
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 24),
//                       child: SizedBox(
//                         width: double.infinity,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             // Handle play button press
//                             _onPlayPressed(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.white,
//                             foregroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             elevation: 0,
//                           ),
//                           child: const Text(
//                             'Play',
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _onPlayPressed(BuildContext context) {
//     // Navigate to game screen or handle play action
//     // Example:
//     // Navigator.pushReplacement(
//     //   context,
//     //   MaterialPageRoute(builder: (context) => GameScreen()),
//     // );
//
//     print('Play button pressed');
//   }
// }

import 'package:flutter/material.dart';
import '../generated/assets.dart';
import 'how_to_play_modal.dart';

class ScratcherSplashScreen extends StatefulWidget {
  const ScratcherSplashScreen({super.key});

  @override
  State<ScratcherSplashScreen> createState() => _ScratcherSplashScreenState();
}

class _ScratcherSplashScreenState extends State<ScratcherSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _highlightController;
  late Animation<double> _slideAnimation;
  late Animation<double> _highlightAnimation;

  @override
  void initState() {
    super.initState();

    // Slide animation controller (left-right movement)
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Highlight animation controller (glow effect)
    _highlightController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Left-right slide animation
    _slideAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    // Highlight glow animation
    _highlightAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _highlightController,
      curve: Curves.easeInOut,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() {
    // Delay before starting animations
    Future.delayed(const Duration(milliseconds: 500), () {
      // Start slide animation (repeating back and forth)
      _slideController.repeat(reverse: true);

      // Start highlight animation (repeating)
      _highlightController.repeat(reverse: true);
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    _highlightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () {
              // Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo image
              Image.asset(
                Assets.winLog,
                height: 90,
                fit: BoxFit.contain,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Winlads Scratch',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              // Animated Play Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedBuilder(
                  animation: Listenable.merge(
                      [_slideController, _highlightController]),
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(_slideAnimation.value, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(
                                  alpha: _highlightAnimation.value * 0.5),
                              blurRadius: 20,
                              spreadRadius: 2,
                            ),
                            BoxShadow(
                              color: Colors.cyan.withValues(
                                  alpha: _highlightAnimation.value * 0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              _onPlayPressed(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withValues(
                                  alpha: 0.9 +
                                      (_highlightAnimation.value * 0.1)),
                              foregroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: BorderSide(
                                  color: Colors.cyan.withValues(
                                      alpha: _highlightAnimation.value *
                                          0.5),
                                  width: 1,
                                ),
                              ),
                              elevation:
                                  5 + (_highlightAnimation.value * 5),
                            ),
                            child: Text(
                              'Play',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withValues(
                                    alpha: 0.8 +
                                        (_highlightAnimation.value *
                                            0.2)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onPlayPressed(BuildContext context) {
    // Stop animations when button is pressed
    _slideController.stop();
    _highlightController.stop();

    // Show How To Play modal
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.8),
      builder: (BuildContext context) {
        return const HowToPlayModal();
      },
    );
  }
}
