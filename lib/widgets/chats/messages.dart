import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (context, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatDocs = chatSnapshot.data.docs;
        User user = FirebaseAuth.instance.currentUser;
        final userId = user.uid;

          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (context, i) => MessageBubble(
              chatDocs[i]['text'],
              chatDocs[i]['userId'] == userId,
              chatDocs[i]['userName'],
              chatDocs[i]['userImage'],
              key: ValueKey(chatDocs[i].documentID),
            ),
          );
      },
    );
  }
}
