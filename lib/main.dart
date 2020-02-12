import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ja', 'JP'),
      ],
      title: 'Lifely',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: MyHomePage(title: 'Lifely'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings)
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row( // for padding
              children: <Widget>[
                SizedBox(
                  height: 10,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.wb_sunny),
                      Text("0-19℃")
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.train),
                      Text("平常通り"),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      new Icon(Icons.error),
                      Text("注意あり"),
                    ],
                  )
                )
              ],
            ),
            Row( // for padding
              children: <Widget>[
                SizedBox(
                  height: 10,
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "朝のタスク",
                    style: TextStyle(
                      fontSize: 20.0,
                    )
                  ),
                  SizedBox(
                      height: 5
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: true,
                      ),
                      Text("弁当をかばんに入れる"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: false,
                      ),
                      Text("ゴミ出し"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: Colors.blue,
                        value: false,
                      ),
                      Text("株価チェック"),
                    ],
                  ),
                ],
              ),
            ),
            Container(
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
          ],
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

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _buildDialog(context, "onMessage");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _buildDialog(context, "onLaunch");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _buildDialog(context, "onResume");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("/topics/all");
  }

  // ダイアログを表示するメソッド
  void _buildDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            content: new Text("Message: $message"),
            actions: <Widget>[
              new FlatButton(
                child: const Text('CLOSE'),
                onPressed: () {
                  Navigator.pop(context, false);
                },
              ),
              new FlatButton(
                child: const Text('SHOW'),
                onPressed: () {
                  Navigator.pop(context, true);
                },
              ),
            ],
          );
        }
    );
  }
}
