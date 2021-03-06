import React, { Component } from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';
import { API } from 'aws-amplify';

export default class ChatroomListItem extends Component {
	handleOpenChatroom = async () => {
		this.props.navigation.navigate('Chatroom', {
			chatroomId: this.props.chatroomId
		});
		/*
		try {
			console.log("Opening chatroom " + this.props.chatroomId);
			messages = await API.get('dev-chitchat-api', '/chatrooms/' + this.props.chatroomId);
			console.log(messages);
		} catch (err) {
			console.log("Error fetching messages");
			console.log(err);
		}*/
	}
	render() {
		return (
			<TouchableOpacity
				onPress={this.handleOpenChatroom.bind(this)}
				style={styles.container}
			>
				<Text style={styles.title}>{this.props.title}</Text>
				<Text style={styles.recentMessage}>{this.props.recentMessage}</Text>
			</TouchableOpacity>
		);
	}
}

const styles = StyleSheet.create({
	container: {
		marginBottom: 15
	},
	title: {
		fontSize: 18
	},
	recentMessage: {
		opacity: 0.6
	}
});
