// import 'package:zjsdk_flutter/ad.dart';
import 'package:flutter/material.dart';

import 'package:zjsdk_flutter/banner.dart';
import 'package:zjsdk_flutter/interstitial.dart';
import 'package:zjsdk_flutter/reward_video.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';
import 'package:zjsdk_flutter/native_express.dart';
import 'package:zjsdk_flutter/content_native_page.dart';
import 'package:zjsdk_flutter/content_video_view_selector.dart';

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
    ZjsdkFlutter.initZJMethodChannel((msg) {
      //先建立事件通道，在所有广告请求前调用
      //确保广告调用都在事件通道建立成功之后，否则可能会收不到回调
      print("iOS->flutter事件通道建立成功");
      ZjsdkFlutter.showSplashAd(
        "J5621495755",
        5,
        onAdLoad: (String id, String msg) {
          print("SplashAd onAdLoad");
        },
        onAdShow: (String id, String msg) {
          print("SplashAd onAdShow");
        },
        onAdClick: (String id, String msg) {
          print("SplashAd onAdClick");
        },
        onCountdownEnd: (String id, String msg) {
          print("SplashAd onVideoComplete");
        },
        onAdClose: (String id, String msg) {
          print("SplashAd onAdClose");
        },
        onError: (String id, String msg) {
          print("SplashAd onError = " + (msg));
        },
      );
    });
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
        '/content_native_page': (BuildContext context) => ContentNativePage(),
        '/content_video_view_selector': (BuildContext context) =>
            ContentVideoViewSelector(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () {
                  // @"J8648995207",@"J5621495755","c887417368"
                  ZjsdkFlutter.showSplashAd(
                    "J5621495755",
                    5,
                    onAdLoad: (String id, String msg) {
                      print("SplashAd onAdLoad");
                    },
                    onAdShow: (String id, String msg) {
                      print("SplashAd onAdShow");
                    },
                    onAdClick: (String id, String msg) {
                      print("SplashAd onAdClick");
                    },
                    onCountdownEnd: (String id, String msg) {
                      print("SplashAd onVideoComplete");
                    },
                    onAdClose: (String id, String msg) {
                      print("SplashAd onAdClose");
                    },
                    onError: (String id, String msg) {
                      print("SplashAd onError = " + (msg));
                    },
                  );
                },
                child: Text("开屏广告")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/reward-video');
                },
                child: Text("激励视频广告")),
            ElevatedButton(
                onPressed: () {
                  // Navigator.of(context).pushNamed('/banner');
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BannerPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("Banner 广告")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/interstitial');
                },
                child: Text("插屏广告")),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/content_native_page');
                },
                child: Text("视频内容(ios原生vc形式)")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContentVideoViewSelector();
                  })).then((value) {
                    //
                  });
                },
                child: Text("视频内容(视图嵌入形式)")),
            ElevatedButton(
                // @"G3061112693227741",@"K4000000007",@"T945740162",@"zjad_iOS_ZF0001",@"K4000000008"
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NativeExpressPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("信息流广告")),
            ElevatedButton(
                onPressed: () {
                  // @"zjad_h500001iostest",@"J7539616190",@"J6596738679",@"J1009546769",@"J1747131627",@"J1194046705",@"J6060320975"
                  ZjsdkFlutter.showH5Ad(
                    "zjad_h500001iostest",
                    "00012282",
                    "吊炸天524",
                    "",
                    10000,
                    "超级无敌4",
                    onAdLoad: (String id, String msg) {
                      print("H5 onAdLoad");
                    },
                    onError: (String id, String msg) {
                      print("H5 onAdLoad = " + (msg));
                    },
                    onRewardAdLoad: (String id, String msg) {
                      print("H5 onRewardAdLoad");
                    },
                    onRewardAdReward: (String id, String msg) {
                      print("H5 onRewardAdReward = " + (msg));
                    },
                    onRewardAdClick: (String id, String msg) {
                      print("H5 onRewardAdClick");
                    },
                    onRewardAdError: (String id, String msg) {
                      print("H5 onRewardAdError = " + (msg));
                    },
                  );
                },
                child: Text("H5广告")),
          ],
        )));
  }
}
