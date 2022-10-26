// import 'package:zjsdk_flutter/ad.dart';
import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/banner.dart';
import 'package:zjsdk_flutter/interstitial.dart';
import 'package:zjsdk_flutter/reward_video.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        buttonTheme: ButtonThemeData(minWidth: 200),
      ),
      home: MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/reward-video': (BuildContext context) => RewardVideoPage(),
        '/banner': (BuildContext context) => BannerPage(),
        '/interstitial': (BuildContext context) => InterstitialPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({ Key key }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool splashTitle = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(child:         Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           FloatingActionButton(
                onPressed: () {
                  // @"J8648995207",@"J5621495755","c887417368"
                  ZjsdkFlutter.showSplashAd("J8648995207", 5,
                    onAdLoad: (String id,String msg) {
                      print("SplashAd onAdLoad");
                    },
                    onAdShow: (String id,String msg) {
                      print("SplashAd onAdShow");
                    },
                    onAdClick: (String id,String msg) {
                      print("SplashAd onAdClick");
                    },
                    onCountdownEnd: (String id,String msg) {
                      print("SplashAd onVideoComplete");
                    },
                    onAdClose: (String id,String msg) {
                      print("SplashAd onAdClose");
                    },
                    onError: (String id, String msg) {
                      print("SplashAd onError = "+(msg??'未知错误'));
                    },
                  );
                },
                child: Text("开屏广告")),
            FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/reward-video');
                },
                child: Text("激励视频广告")),
            FloatingActionButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/banner');
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                      return BannerPage();
                    })).then((value) {
                      //
                    });  
                },
                child: Text("Banner 广告")),
            FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/interstitial');
                },
                child: Text("插屏广告")),

            FloatingActionButton(
                onPressed: () {
                  // @"zjad_h500001iostest",@"J7539616190",@"J6596738679",@"J1009546769",@"J1747131627",@"J1194046705",@"J6060320975"
                  ZjsdkFlutter.showH5Ad("zjad_h500001iostest", "00012282", "吊炸天524", "",10000,"超级无敌4",
                    onAdLoad:  (String id,String msg) {
                      print("H5 onAdLoad");
                    },
                    onError:  (String id,String msg) {
                      print("H5 onAdLoad = "+(msg??'未知错误'));
                    },
                    onRewardAdLoad:  (String id,String msg) {
                      print("H5 onRewardAdLoad");
                    },
                    onRewardAdReward:  (String id,String msg) {
                      print("H5 onRewardAdReward = "+(msg??'未知错误'));
                    },
                    onRewardAdClick:  (String id,String msg) {
                      print("H5 onRewardAdClick");
                    },
                    onRewardAdError:  (String id,String msg) {
                      print("H5 onRewardAdError = "+(msg??'未知错误'));
                    },
                  );
                },
                child: Text("H5广告")),
          ],
        )
      )
    );
  }
}
