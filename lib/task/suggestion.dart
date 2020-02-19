import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SuggestedList extends StatefulWidget {
  @override
  _SuggestedListState createState() => _SuggestedListState();
}

class _SuggestedListState extends State<SuggestedList> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AIからのおすすめタスク"),
      ),
      body: Container(
          padding: EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "今日のお役立ち情報",
                  style: TextStyle(fontSize: 20.0),
                ),
                SizedBox(height: 5),
                TaskCard(
                    "こんにちは。梅雨の時期の洗濯に悩んでいませんか？梅雨時の洗濯､プロ実践｢部屋干し｣5つのコツ", false),
                TaskCard("こんにちは。", true),
                RaisedButton(
                  onPressed: _launchURL,
                  child: Text("梅雨時の洗濯､プロ実践｢部屋干し｣5つのコツ"),
                ),
              ])),
    );
  }

  _launchURL() async {
    const url = 'https://toyokeizai.net/articles/-/282543';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class TaskCard extends StatefulWidget {
  final String _title;
  final bool _isFavorite;

  TaskCard(this._title, this._isFavorite);

  @override
  _TaskCardState createState() => new _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  IconData _favorite;

  @override
  void initState() {
    super.initState();
    if (this.widget._isFavorite) {
      //if (true) {
      this._favorite = Icons.favorite;
    } else {
      this._favorite = Icons.favorite_border;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 10, bottom: 10),
            child: Icon(
              this._favorite,
              color: Colors.red,
            ),
          ),
          Flexible(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(right: 5, top: 10, bottom: 10),
                child: DefaultTextStyle(
                  style: TextStyle(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  child: Text(this.widget._title),
                ),
              )),
        ],
      ),
    );
  }
}
