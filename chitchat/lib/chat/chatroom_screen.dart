import "dart:async";
import "package:flutter/material.dart";
import "package:chitchat/state/state.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class ChatroomScreen extends StatefulWidget<_ChatroomScreenState> {
	ChatroomScreen({this.id});
	final String id;

	_ChatroomScreenState createState() => new _ChatroomScreenState();

}

class _ChatroomScreenState extends State<ChatroomScreen> {

	bool isLoaded = false;
	List<Message> messages = null;

	@override
	void initState() {
		print("Initiating chatroom state...");
		_getMessages();
	}

	void _getMessages() async {
		Firestore.instance.collection("chatroom_id_to_messages")
			.document(widget.id).snapshots.listen((DocumentSnapshot snapshot) {
				print(snapshot.data);
				List<Message> newMessages = new List();
				snapshot.data["messages"].forEach((data) {
					newMessages.add(new Message(
						author: data["author"],
						content: data["content"]
					));
				});
				setState(() {
					messages = newMessages;
					isLoaded = true;
				});
			});
	}

	@override
	Widget build(BuildContext context) {
		Widget body = new Center(
			child: const Text("Loading...")
		);
		if (isLoaded) {
			body = new Column(
				children: messages.map((message) => new Text(message.content)).toList()
			);
		}
		return new Scaffold(
			appBar: new AppBar(
				title: new Text("Chatroom ${widget.id}"),
			),
			body: body
		);
	}
}