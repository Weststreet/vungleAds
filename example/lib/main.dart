import 'package:flutter/material.dart';
import 'package:vungle_ads/vungle_ads.dart';
import 'dart:async';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<StreamSubscription<dynamic>> _streamSubscriptions =
  <StreamSubscription<dynamic>>[];
  @override
  void initState() {
    super.initState();

    _streamSubscriptions.add(VungleAds.vungleAdEvents.listen((String result) {
      print('获得$result金币啊aa');
    }));

  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            FlatButton(onPressed: (){
              VungleAds.init('5d484183bc64ab0018545ab3');
            },child: Text('初始化'),),

            FlatButton(onPressed: (){
              VungleAds.loadPlacementWithID('DEFAULT-6961208');
            },child: Text('加载视频'),),
            FlatButton(onPressed: (){
             isReady();
            },child: Text('isReady'),),
            FlatButton(onPressed: (){
              VungleAds.playAd('DEFAULT-6961208','10026');
            },child: Text('显示视频'),),

          ],),
        ),
      ),
    );
  }

  isReady() async{
    bool isReady= await  VungleAds.isAdCachedForPlacementID('DEFAULT-6961208');
    print('isReady==$isReady');
  }
}
