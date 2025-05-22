import 'dart:math';

import 'package:flutter/material.dart';
import 'package:scratch_game/screens/scratcher_splash_screen.dart';
import 'package:scratcher/widgets.dart';

import '../generated/assets.dart';

class ScratcherGame extends StatefulWidget {
  const ScratcherGame({Key? key}) : super(key: key);

  @override
  _ScratcherGameState createState() => _ScratcherGameState();
}

class _ScratcherGameState extends State<ScratcherGame> {
  final scratchKey = GlobalKey<ScratcherState>();
  bool isRevealed = false;
  bool isWinner = false;
  double percentage = 0;

  // Generate random prize (for demo purposes)
  final prizeOptions = [
    'Win \$10!',
    'Win \$50!',
    'Win \$100!',
    'Win \$500!',
    'Try Again!'
  ];
  late String prize;

  @override
  void initState() {
    super.initState();
    print("Initializing scratcher game");
    // Determine if this card is a winner (80% chance of losing for demo)
    final random = Random();
    isWinner = random.nextDouble() > 0.8;

    // Select prize if winner, otherwise "Try Again"
    if (isWinner) {
      prize = prizeOptions[
          random.nextInt(prizeOptions.length - 1)]; // Exclude "Try Again"
    } else {
      prize = prizeOptions.last; // "Try Again"
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    print(
        "Building scratcher UI, percentage: $percentage, revealed: $isRevealed");

    // Attempt to precache the image to debug any loading issues
    try {
      precacheImage(AssetImage(Assets.scratchPattern), context).then((_) {
        print("Image pre-cached successfully");
      }).catchError((error) {
        print("Failed to pre-cache image: $error");
      });
    } catch (e) {
      print("Error loading image: $e");
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: IconButton(
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ScratcherSplashScreen(),
                ),
                (route) => false,
              );
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
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Logo centered above scratch card
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Image.asset(
                  Assets.winLog,
                  height: 90,
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                width: double.infinity,
                height: screenHeight * 0.35,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                  // Add subtle shadow for depth
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Colors.grey,
                              Colors.white12,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                prize,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      const Shadow(
                                        color: Colors.black26,
                                        offset: Offset(1, 1),
                                        blurRadius: 2,
                                      ),
                                    ]),
                              ),
                              if (isRevealed) ...[
                                const SizedBox(height: 16),
                                if (isWinner)
                                  Text(
                                    '🎉  Congratulations!  🎉',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                      ),

                      // Scratcher overlay (only visible when not revealed)
                      if (!isRevealed)
                        Scratcher(
                          key: scratchKey,
                          brushSize: 20,
                          threshold: 50,
                          image: Image.asset(
                            Assets.scratchPattern,
                            fit: BoxFit.cover,
                          ),
                          accuracy: ScratchAccuracy.medium,
                          onThreshold: () {
                            setState(() {
                              isRevealed = true;
                            });
                            print(
                                "50% threshold reached, removing scratch overlay");
                          },
                          onChange: (value) {
                            setState(() => percentage = value);
                            print("Scratch percentage changed: $value%");

                            // Auto-reveal at 50% (backup in case onThreshold doesn't trigger)
                            if (value >= 50 && !isRevealed) {
                              setState(() {
                                isRevealed = true;
                              });
                              print("Auto-revealing at 50% via onChange");
                            }
                          },
                          child: Container(
                            // Empty container - the scratch overlay
                            color: Colors.transparent,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // Progress indicator (only show when scratching)
              if (!isRevealed && percentage > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      Text(
                        percentage < 50
                            ? 'Keep scratching... ${(50 - percentage).toInt()}% to go!'
                            : 'Almost there!',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: screenWidth * 0.6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                            color: Colors.grey.shade600,
                            width: 1,
                          ),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (percentage / 50).clamp(0.0, 1.0),
                          // Progress relative to 50%
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: percentage >= 50
                                    ? [Colors.green, Colors.lightGreen]
                                    : [
                                        const Color(0xFF0EBFE9),
                                        const Color(0xFF00A8CC)
                                      ],
                              ),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${percentage.toInt()}% / 50%',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

              // Instructions when not started
              if (!isRevealed && percentage == 0)
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      Text(
                        'Scratch to reveal your prize!',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Scratch 50% to automatically reveal',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

// No longer needed since Play Again button is removed
// void _resetGame() {
//   setState(() {
//     scratchKey.currentState?.reset();
//     isRevealed = false;
//     final random = Random();
//     isWinner = random.nextDouble() > 0.8;
//     if (isWinner) {
//       prize = prizeOptions[random.nextInt(prizeOptions.length - 1)];
//     } else {
//       prize = prizeOptions.last;
//     }
//     percentage = 0;
//   });
//   print("Game reset");
// }
}
