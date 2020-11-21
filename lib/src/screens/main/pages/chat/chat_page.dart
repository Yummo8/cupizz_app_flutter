library chat_page;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cupizz_app/src/widgets/index.dart';
import 'package:flutter/material.dart' hide Router;

import '../../../../base/base.dart';

part 'widgets/chat_item.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final GlobalKey<CustomAnimatedListState> _key =
      GlobalKey<CustomAnimatedListState>();

  int messageLength;
  String selectId;
  int selectAction;

  void updateBubble(int val) {
    setState(() {
      messageLength = val;
    });
  }

  // returns list id and action index
  void selecetedState(Map val) {
    setState(() {
      selectId = val["list_id"];
      selectAction = val["select_action"];
    });
    String _action;
    if (selectAction == 1) {
      _action = 'favorites';
    } else if (selectAction == 2) {
      _action = 'delete';
    } else if (selectAction == 3) {
      _action = 'archive';
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected action \"$_action\" for $selectId id number!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          // Message Text
          buildHeadingBar(context),
          // Inbox and Archive Button
          buildButtonBar(context),
          Expanded(
            child: CustomAnimatedList(
              items: <Conversation>[]
                  .asMap()
                  .map((i, e) {
                    return MapEntry(
                        i,
                        ChatItem(
                          conversation: e,
                          onHided: (_) {
                            _key.currentState.removeItem(i);
                          },
                          onDeleted: (_) {
                            _key.currentState.removeItem(i);
                          },
                        ));
                  })
                  .values
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBadge(int length) {
    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          length.toString(),
          style: TextStyle(color: context.colorScheme.onPrimary, fontSize: 11),
        ),
      ),
    );
  }

  Container buildHeadingBar(BuildContext context) {
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 20.0, top: 10),
      color: context.colorScheme.background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Tin nhắn',
            style: context.textTheme.headline4.copyWith(
              color: context.colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
          buildBadge(messageLength)
        ],
      ),
    );
  }

  Container buildButtonBar(BuildContext context) {
    return Container(
      color: context.colorScheme.background,
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Inbox',
                style: TextStyle(color: context.colorScheme.onPrimary),
              ),
            ),
            width: 80.0,
            height: 32.0,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: context.colorScheme.secondary.withOpacity(0.7),
                      blurRadius: 4.0)
                ],
                color: context.colorScheme.secondary,
                borderRadius: BorderRadius.circular(20.0)),
          ),
          SizedBox(width: 12.0),
          Text(
            'Archive',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
