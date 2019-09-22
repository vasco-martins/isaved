import 'package:flutter/material.dart';

class InfiniteList extends StatefulWidget {
  InfiniteList({Key key}) : super(key: key);

  _InfiniteListState createState() => _InfiniteListState();
}

class _InfiniteListState extends State<InfiniteList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(top: 20.0),
            alignment:
                index % 2 == 0 ? Alignment.topLeft : Alignment.bottomRight,
            child: Text(
              "This is a list $index",
              style: TextStyle(fontSize: 16),
            ),
          );
        },
      ),
    );
  }
}
