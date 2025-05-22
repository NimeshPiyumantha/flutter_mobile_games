# Scratch Game 🎰

A Flutter-based scratch card game with animated splash screen and interactive gameplay.

## Features ✨

- **Animated Splash Screen** with glowing Play button
- **Interactive Scratch Cards** with 50% auto-reveal
- **Random Prize System** with winner/loser outcomes
- **Progress Indicator** showing scratch completion
- **Smooth Animations** and transitions
- **Responsive Design** for different screen sizes

## Screenshots 📱

### Splash Screen

- Animated logo with "Winlads Scratch" branding
- Glowing Play button with left-right slide animation
- "How To Play" modal with 5-second countdown

### Game Screen

- Interactive scratch card interface
- Real-time progress tracking
- Auto-reveal at 50% completion
- Winner/loser result display

## Getting Started 🚀

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (2.17.0 or higher)
- Android Studio / VS Code
- Android/iOS device or emulator

### Installation

1. **Clone the repository**
   ```bash
   https://github.com/NimeshPiyumantha/flutter_mobile_games.git
   ```
   **Switch to branch**

 ```bash
   git checkout scratch_game
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Add required assets**
    - Create `assets/logo/` directory
    - Add your logo image as `assets/logo/winlads_splash_logo.png`

4. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies 📦

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  scratcher: ^2.5.0

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0
```

## Project Structure 📁

```
lib/
├── main.dart                    # App entry point
├── generated/
│   └── assets.dart             # Generated asset path constants
└── screens/
    ├── how_to_play_modal.dart  # Instructions modal widget
    ├── scratcher_game.dart     # Main scratch card game screen
    └── scratcher_splash_screen.dart  # Animated splash screen


assets/
└── images/
    ├── scratch.png        
    └── scratch_pattern.png  
    logo/
    └── winlads_splash_logo.png
 ```    

## Configuration ⚙️

### Assets Setup

Update `lib/generated/assets.dart` with your image paths:

## Usage 📖

### Basic Flow

1. **Splash Screen** → Animated intro with Play button
2. **How To Play Modal** → 5-second instruction screen
3. **Scratch Game** → Interactive scratch card
4. **Result Display** → Winner/loser outcome
5. **Navigation** → Close button returns to splash

### Key Interactions

- **Tap Play** → Shows instructions modal
- **Scratch card** → Reveals content progressively
- **50% scratched** → Auto-reveals full result
- **Close button** → Returns to splash screen

## Troubleshooting 🔧

### Common Issues

**Images not loading:**

```bash
flutter clean
flutter pub get
flutter run
```

**Animation stuttering:**

- Check device performance
- Reduce animation complexity
- Enable hardware acceleration

**Scratch not working:**

- Verify scratcher package version
- Check touch event handling
- Ensure proper widget hierarchy

## License 📄

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments 👏

- **Flutter team** for the amazing framework
- **Scratcher package** for scratch card functionality
- **Community** for inspiration and support

## Connect with me

#### If you have any bugs or issues , If you want to explain my code please contact me on :

<div align="center">
 <br><b>MAIL ME</b>&nbsp;
  <a href="mailto:nimeshpiyumantha11@gmail.com">
      <img width="20px" src="https://github.com/NimeshPiyumantha/red-alpha/blob/main/gmail.svg" />
  </a></p>

 </div>

<p align="center">
<a href="https://twitter.com/NPiyumantha60"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/twitter.svg" alt="__NimeshPiyumantha__" height="30" width="40" /></a>
<a href="https://www.linkedin.com/in/nimesh-piyumantha-33736a222" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/linked-in-alt.svg" alt="https://www.linkedin.com/public-profile/settings?trk=d_flagship3_profile_self_view_public_profile" height="30" width="40" /></a>
<a href="https://www.facebook.com/profile.php?id=100025931563090" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/facebook.svg" alt="Nimesh Piyumantha" height="30" width="40" /></a>
<a href="https://www.instagram.com/_.nimmaa._/" target="blank"><img align="center" src="https://raw.githubusercontent.com/rahuldkjain/github-profile-readme-generator/master/src/images/icons/Social/instagram.svg" alt="_.nimmaa._" height="30" width="40" /></a>
</p>

##

<div align="center">

![repo license](https://img.shields.io/github/license/NimeshPiyumantha/flutter_mobile_games/blob/scratch_game?&labelColor=black&color=3867d6&style=for-the-badge)
![repo size](https://img.shields.io/github/repo-size/NimeshPiyumantha/flutter_mobile_games/blob/scratch_game?label=Repo%20Size&style=for-the-badge&labelColor=black&color=20bf6b)
![GitHub forks](https://img.shields.io/github/forks/NimeshPiyumantha/flutter_mobile_games/blob/scratch_game?&labelColor=black&color=0fb9b1&style=for-the-badge)
![GitHub stars](https://img.shields.io/github/stars/NimeshPiyumantha/flutter_mobile_games/blob/scratch_game?&labelColor=black&color=f7b731&style=for-the-badge)
![GitHub LastCommit](https://img.shields.io/github/last-commit/NimeshPiyumantha/flutter_mobile_games/blob/scratch_game?logo=github&labelColor=black&color=d1d8e0&style=for-the-badge)

</div>

<div align="center">

#### @2025 [Nimesh Piyumantha](https://github.com/NimeshPiyumantha/), Inc.All rights reserved

</div>
