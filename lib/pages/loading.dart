import 'package:flutter/material.dart';
//import 'package:weplayball/models/loading_page_state.dart';
//import 'package:weplayball/ui/colors.dart';


//  See:  https://www.clounce.com/flutter/loading-screen-in-flutter

/// Loading Screen Widget that updates the screen once all inistializer methods
/// are called
/*class LoadingPage extends StatefulWidget {
  /// List of methods that are called once the Loading Screen is rendered
  /// for the first time. These are the methods that can update the messages
  /// that are shown under the loading symbol
  final List<dynamic> initializers;

  /// The name of the application that is shown at the top of the loading screen
  final RichText title;

  /// The background colour which is used as a filler when the image doesn't
  /// occupy the full screen
  final Color backgroundColor;

  /// The styling that is used with the text (messages) that are displayed under
  /// the loader symbol
  final TextStyle styleTextUnderTheLoader;

  /// The Layout/Scaffold Widget that is loaded once all the initializer methods
  /// have been executed
  final dynamic navigateToWidget;

  /// The colour that is used for the loader symbol
  final Color loaderColor;

  /// The image widget that is used as a background cover to the loading screen
  final Image image;

  /// The message that is displayed on the first load of the widget
  final String initialMessage;

  /// Constructor for the LoadingScreen widget with all the required
  /// initializers
  LoadingPage(
      {this.initializers,
        this.navigateToWidget,
        this.loaderColor,
        this.image,
        this.title = const RichText(text: TextSpan(text: 'Welcome In Our App')),
        this.backgroundColor = Colors.white,
        this.styleTextUnderTheLoader = const TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black),
        this.initialMessage})
  // The Widget depends on the initializers and navigateToWidget to have a
  // valid value. Thus we assert that the values passed are valid and
  // not null
      : assert(initializers != null && initializers.length > 0),
        assert(navigateToWidget != null);

  /// Bind the Widget to the custom State object
  @override
  LoadingPageState createState() => LoadingPageState();
}*/