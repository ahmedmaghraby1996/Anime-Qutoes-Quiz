

import 'package:anime_quiz_app/main.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:shared_preferences/shared_preferences.dart';
class EndScreen extends StatefulWidget{
int i,ad;
EndScreen(this.i,this.ad);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
return EndScreenState();
  }

}
class EndScreenState extends State<EndScreen>{
  List<String> ads=["ca-app-pub-8624410529269642/7360146271","ca-app-pub-8624410529269642/5219152375","ca-app-pub-8624410529269642/5734173609","ca-app-pub-8624410529269642/1794928598","ca-app-pub-8624410529269642/5542601911"];

  playad(){

    InterstitialAd(
        adUnitId:ads[0] ,

        listener: (MobileAdEvent event) {

        })..load()..show(

    );
    print("done");
  }
  int i = 0;
  SharedPreferences prefs;
  int high=0;
  highScore()async{
    setState(() {
      i=widget.i;
    });

    prefs=await SharedPreferences.getInstance();
    setState(() {


      if(prefs.getInt("high")!=null)
      high=prefs.getInt("high");
      else high=0;

      if(i>high)
        high=i;
      prefs.setInt("high", high);
    });

    print(i.toString());
    print(high.toString());
  }

@override
  void initState() {
    // TODO: implement initState
ads.shuffle();
  FirebaseAdMob.instance.initialize(appId: "ca-app-pub-8624410529269642~7543963196");
highScore();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
return Scaffold(
    body: Container(
    width: double.infinity,
    child: Column(mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children:[ Text("game over",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      Text("Your Score is ${i.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
      Text("Your highest Score is ${high.toString()}",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
    RaisedButton(child: Text("Play again"),onPressed: (){
      widget.ad%3==0? playad():null;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>MyHomePage(widget.ad)));

    })
    ]),
    ));
  }

}