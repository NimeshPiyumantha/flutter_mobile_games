import 'package:flutter/material.dart';
import 'package:scratch_game/screens/scratcher_game.dart';

import '../generated/assets.dart';

class HowToPlayModal extends StatefulWidget {
  const HowToPlayModal({super.key});

  @override
  State<HowToPlayModal> createState() => _HowToPlayModalState();
}

class _HowToPlayModalState extends State<HowToPlayModal>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    // 5-second progress animation
    _progressController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.linear,
    ));

    // Start the progress animation
    _progressController.forward();

    // Auto-close after 5 seconds
    _progressController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          Navigator.of(context).pop();
          // Navigate to game screen here
          _navigateToGame();
        }
      }
    });
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  void _navigateToGame() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScratcherGame(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.grey.shade800,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(),
                const Text(
                  'How To Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Color(0xFF4F4F4F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.grey.shade500,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    width: 110,
                    height: 140,
                    fit: BoxFit.cover,
                    Assets.scratchModel,
                  ),
                ),
              ),
            ),
            const Text(
              'The hidden content is revealed by\nscratching the card with your finger on\ntouch devices or scrubbing the card with\nyour mouse cursor. Good luck!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 16),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 80,
                    height: 80,
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return CircularProgressIndicator(
                          value: _progressAnimation.value,
                          strokeWidth: 4,
                          backgroundColor: Colors.grey.shade600,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      _navigateToGame();
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            AnimatedBuilder(
              animation: _progressAnimation,
              builder: (context, child) {
                final remainingSeconds =
                    (5 - (_progressAnimation.value * 5)).ceil();
                return Text(
                  'Starting in ${remainingSeconds}s',
                  style: TextStyle(
                    color: Colors.grey.shade300,
                    fontSize: 14,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
