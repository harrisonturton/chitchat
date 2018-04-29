import "dart:ui";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";
import "package:chitchat/common/style.dart" as Style;
import "package:chitchat/common/firebase.dart" as Firebase;
import "package:chitchat/common/common.dart";
import "package:chitchat/state/state.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:chitchat/main_screen.dart";

import "package:redux/redux.dart";
import "package:flutter_redux/flutter_redux.dart";
import "actions.dart";

class WelcomeScreen extends StatefulWidget<_WelcomeScreenState> {

	@override
	_WelcomeScreenState createState() => new _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
	
	final _formKey = new GlobalKey<FormState>();
	final _emailController = new TextEditingController();
	final _passwordController = new TextEditingController();

	String _errorText = "Incorrect details. Have you made a typo?";
	bool _hasError = false;

	void _attemptLogin(BuildContext context, Store<AppState> store) {
		_hasError = false;
		setState(() {});
		String email = _emailController.text;
		String password = _passwordController.text;
		if (email == "" && password == "") {
			email = "harrisonturton@gmail.com";
			password = "test123";
		}
		Firebase.login(email: email, password: password).then((FirebaseUser user) {
			store.dispatch(new Login(user: user));
			Navigator.of(context).pushAndRemoveUntil(
				new MaterialPageRoute(
					builder: (_) => new MainScreen()
				),
				(Route<dynamic> route) => false
			);
		}).catchError((err) =>_hasError = true);
	}

	@override
	Widget build(BuildContext context) {
		double height = MediaQuery.of(context).size.height;
		return new StoreConnector<AppState, Store<AppState>>(
			converter: (store) => store,
			builder: (context, store) {
				return new Container(
					padding: const EdgeInsets.only(
						left: 30.0, right: 30.0, bottom: 30.0
					),
					child: new Column(
						crossAxisAlignment: CrossAxisAlignment.start,
						children: [
							new VerticalSpace(height / 12.0),
							new Text(
								"welcome to",
								style: Style.welcomeStyleLight
							),
							new Text(
								"chitchat.",
								style: Style.welcomeStyle
							),
							new Expanded(child: new Column()),
							new Column(
								crossAxisAlignment: CrossAxisAlignment.stretch,
								children: [
									new TextField(
										controller: _emailController,
										decoration: new InputDecoration(
											labelText: "Email",
											labelStyle: new TextStyle(
												color: Style.textFaint
											)
										)
									),
									new VerticalSpace(5.0),
									new TextField(
										controller: _passwordController,
										obscureText: true,
										decoration: new InputDecoration(
											labelText: "Password",
											labelStyle: new TextStyle(
												color: Style.textFaint
											)
										)
									),
									new VerticalSpace(7.0),
									this._hasError
										? new Text(_errorText, style: Style.errorText)
										: null,
									new VerticalSpace(7.0),
									new StrongButton(
										onPressed: () => _attemptLogin(context, store),
										text: "LOGIN"
									),
									new Container(
										padding: const EdgeInsets.symmetric(vertical: 20.0),
										child: new Column(
											children: [
												new Text("OR", style: new TextStyle(color: Style.textLight))
											]
										)
									),
									new LightButton(
										onPressed: () {},
										text: "CREATE ACCOUNT"
									),
								].where((i) => i != null).toList()
							)
						]
					)
				);
			}
		);
	}
}
