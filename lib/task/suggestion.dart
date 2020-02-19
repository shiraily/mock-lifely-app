import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class Suggestion extends StatefulWidget {
  @override
  _SuggestionState createState() => new _SuggestionState();

}

class _SuggestionState extends State<Suggestion> {
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text("AIからのおすすめタスク"),
      ),
      body: new Center(
        child: Container(
          child:             Container(
              padding: EdgeInsets.only(left: 16, top: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment:  MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "今日のお役立ち情報",
                      style: TextStyle(fontSize: 20.0),
                    ),
                    SizedBox(
                        height: 5
                    ),
                    Text("こんにちは。梅雨の時期の洗濯に悩んでいませんか。"),
                    Text("詳しくはこちら↓"),
                    RaisedButton(
                      onPressed: _launchURL,
                      child: Text("梅雨時の洗濯､プロ実践｢部屋干し｣5つのコツ"),
                    ),
                  ]
              )
          )
          ,
        ),
      ),
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