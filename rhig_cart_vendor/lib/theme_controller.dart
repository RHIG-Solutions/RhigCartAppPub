import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Notes on styles colours and theme:
//Static items preset in the app is prefixed by a k. (kColourMine / kMyStyle)
//Dynamic items that change depending on user settings is prefixed by a d.
//(dColourChangeable / dMyChangingTheme)

//First section is for static theming and colours
// Colours
const kColourRHIGGrey = Color(0xFF686868);
const kColourRHIGHintGrey = Color(0x66AAAAAA);
const kColourInputBackground = Color(0xFFEEEEEE);
const kColourRHIGLightGrey = Color(0xFFCCCCCC);
const kColourRHIGBackLightGrey = Color(0xFF787878);
const kColourRHIGBackDarkGrey = Color(0xFF6D6A69);

// Font sizes
const double kHeader2Size = 18;
const double kHeader3Size = 14;

// Text Styles
const kHeader1Style = TextStyle(
  color: Colors.white,
  fontSize: 45,
);

TextStyle kHeader3StyleWhite = const TextStyle(
  color: Colors.white,
  fontSize: kHeader3Size,
  fontWeight: FontWeight.bold,
);

const kStandardWhiteStyle = TextStyle(
  color: Colors.white,
);

const kLabelStyle = TextStyle(
  color: kColourRHIGGrey,
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

const kLabelLightStyle = TextStyle(
  color: kColourRHIGLightGrey,
  fontWeight: FontWeight.bold,
  fontSize: 12,
);

const kHintStyle = TextStyle(
  color: kColourRHIGHintGrey,
  fontSize: 14,
);

const kAvatarTextStyle = TextStyle(
  color: kColourRHIGGrey,
  fontWeight: FontWeight.bold,
  fontSize: 25,
);

const kErrorTextStyle = TextStyle(
  color: Colors.red,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

//myPrefs is set here and is imported to anything needing dynamic theming data
//including dynamic colours and styles.
PreferenceController myPrefs = PreferenceController();

//Class for loading and saving user preferences including setting up of dynamic
//colours and styles
class PreferenceController {
  late int dColourBackground;
  late int dColourMain1;
  late int dColourMain2;
  late int dColourContrast;
  late Color dColourSelection;
  late TextStyle dHeader1Main1Style;
  late TextStyle dHeader2ContrastStyle;
  late TextStyle dHeader3Main1Style;
  late TextStyle dHeader3ContrastStyle;
  bool loadComplete = false;
  final loadNotifier = ValueNotifier<bool>(false);

  PreferenceController() {
    loadPreferences();
  }

  //TODO Add error catching for loading preferences - not likely problem, but just in case
  //Load colour and preferences from file, an set dynamic colours and styles
  loadPreferences() async {
    loadNotifier.value = false;
    loadComplete = false;
    final prefs = await SharedPreferences.getInstance();
    //await Future.delayed(const Duration(milliseconds: 2500)); //TODO Remove delay after testing is over

    // Load main colours from file
    // Default colours if values are not set:
    // BackGround: Color(0xFFFFFFFF)
    // Main1: Color(0xFF9FC519)
    // Main2: Color(0xFFB1D140)
    // Contrast: Color(0xFF428BFF)
    dColourBackground = prefs.getInt('colourBackground') ?? 0xFFFFFFFF;
    dColourMain1 = prefs.getInt('colourMain1') ?? 0xFF9FC519;
    dColourMain2 = prefs.getInt('colourMain2') ?? 0xFFB1D140;
    dColourContrast = prefs.getInt('colourContrast') ?? 0xFF428BFF;

    // Set colours and styles requiring loaded colours
    // Selection colour subtracts the needed integer from the main to make it
    // partially see through, essentially making the FF less.
    dColourSelection = Color(dColourMain1 - 2281701376);
    dHeader1Main1Style = TextStyle(
      color: Color(myPrefs.dColourMain1),
      fontWeight: FontWeight.bold,
      fontSize: 45,
    );
    dHeader2ContrastStyle = TextStyle(
      color: Color(myPrefs.dColourContrast),
      fontSize: kHeader2Size,
      fontWeight: FontWeight.bold,
    );
    dHeader3Main1Style = TextStyle(
      color: Color(myPrefs.dColourMain1),
      fontSize: kHeader3Size,
      fontWeight: FontWeight.bold,
    );

    dHeader3ContrastStyle = TextStyle(
      color: Color(myPrefs.dColourContrast),
      fontSize: kHeader3Size,
      fontWeight: FontWeight.bold,
    );

    //Complete load and set flags and watchers to true
    loadComplete = true;
    loadNotifier.value = true;
  }

  save1() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colourBackground', 0xFFFFFFFF);
    await prefs.setInt('colourMain1', 0xFF9FC519);
    await prefs.setInt('colourMain2', 0xFFB1D140);
    await prefs.setInt('colourContrast', 0xFF428BFF);
  }

  save2() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('colourBackground', 0xFFFFFFFF);
    await prefs.setInt('colourMain1', 0xFF428BFF);
    await prefs.setInt('colourMain2', 0xFF7AAEFF);
    await prefs.setInt('colourContrast', 0xFF9FC519);
  }
}
