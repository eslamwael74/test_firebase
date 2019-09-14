import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'message.dart';
import 'notification_handler.dart';

class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  final List<Message> messages = [];

  Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    return Future<void>.value();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    new NotificationHandler().initializeFcmNotification();

//    _fcm.configure(
//      onMessage: (Map<String, dynamic> message) async {
//        print("onMeassage:  $message");
//
//        final notification = message['notification'];
//
//        final snackbar = SnackBar(
//          content: Text(notification['title']),
//          action:
//          SnackBarAction(label: 'onMessageCalled', onPressed: () => null),
//        );
//
//        Scaffold.of(context).showSnackBar(snackbar);
//
//        setState(() {
//          messages.add(Message(
//              title: notification['title'], body: notification['body']));
//        });
//      },
//      onLaunch: (Map<String, dynamic> message) async {
//        print("onLunch: $message ");
//
//        final notification = message['data'];
//
//        setState(() {
//          messages.add(Message(
//              title: 'onlunch: ${notification['title']}',
//              body: 'onlunch: ${notification['body']}'));
//        });
//      },
//      onResume: (Map<String, dynamic> message) async {
//        print("onResume: $message");
//      },
//    );
//
//    _fcm.requestNotificationPermissions(
//        const IosNotificationSettings(sound: true, badge: true, alert: true));

//    _fcm.getToken().then((String token) {
//      assert(token != null);
//      print("Token $token");
//
//      Future.delayed(const Duration(seconds: 1), () {
//        setState(() {
//          showDialog(
//              context: context,
//              builder: (context) =>
//                  AlertDialog(
//                    content: ListTile(
//                      title: Text("Updated Token"),
//                      subtitle: GestureDetector(
//                        child: Text(token),
//                        onLongPress: () {
//                          Clipboard.setData(ClipboardData(text: token));
//                          Scaffold.of(this.context).showSnackBar(SnackBar(
//                              duration: const Duration(microseconds: 500),
//                              content: Text('Token Coppied!')));
//                        },
//                      ),
//                    ),
//                    actions: <Widget>[
//                      FlatButton(
//                          onPressed: () => Navigator.of(context).pop(),
//                          child: Text('Ok'))
//                    ],
//                  ));
//        });
//      });
//    });

    /*_fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: ListTile(
              title: Text(message['notification']['title']),
              subtitle: Text(message['notification']['body']),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        // TODO optional
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        // TODO optional
      },
    );*/
  }

  @override
  Widget build(BuildContext context) =>
      ListView(
        children: messages.map(buildNewMessage).toList(),
      );

  Widget buildNewMessage(Message message) =>
      ListTile(
        title: Text(message.title),
        subtitle: Text(message.body),
      );
}
