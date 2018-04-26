import "package:flutter/material.dart";
import "package:chitchat/common/style.dart" as Style;
import "package:chitchat/auth/auth.dart";

void main() => runApp(new App());

class App extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return new MaterialApp(
			title: "ChitChat",
			theme: ThemeData(
				accentColor: Style.primaryFaint,
			),
			home: new Scaffold(
				body: new WelcomeScreen()
			)
		);
	}
}