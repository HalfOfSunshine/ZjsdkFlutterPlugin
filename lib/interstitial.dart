import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class InterstitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton(
                onPressed: () {
                  ZjsdkFlutter.showInterstitialAd(
                    "J9666281550",
                    onAdLoad: (String id,String msg) {
                      print("InterstitialAd onAdLoad");
                    },
                    onAdShow: (String id,String msg) {
                      print("InterstitialAd onAdShow");
                    },
                    onAdClick: (String id,String msg) {
                      print("InterstitialAd onAdClick");
                    },
                    onAdClose: (String id,String msg) {
                      print("InterstitialAd onAdClose");
                    },
                    onAdDetailClose: (String id,String msg){
                      print("InterstitialAd onAdDetailClose");
                    },
                    onError: (String id, String msg) {
                      print("InterstitialAd onError = "+(msg));
                    },
                  );
                },
                child: Text("加载插屏广告")),
          ],
        ),
      ),
    );
  }
}
