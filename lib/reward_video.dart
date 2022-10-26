import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class RewardVideoPage extends StatelessWidget {
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
                  ZjsdkFlutter.showRewardVideoAd(
                    // @"c945709452",@"zjad_iOS_ZR0001",@"zjad_T945484376"
                    "c945709452","userId123",
                    onAdLoad: (String id,String msg) {
                      print("RewardVideoAd onAdLoad");
                    },
                    onAdShow: (String id,String msg) {
                      print("RewardVideoAd onAdShow");
                    },
                    onReward: (String id,String msg) {
                      print("RewardVideoAd onReward,transId = "+(msg??'未知错误'));
                    },
                    onAdClick: (String id,String msg) {
                      print("RewardVideoAd onAdClick");
                    },
                    onVideoComplete: (String id,String msg) {
                      print("RewardVideoAd onVideoComplete");
                    },
                    onAdClose: (String id,String msg) {
                      print("RewardVideoAd onAdClose");
                    },
                    onError: (String id, String msg) {
                      print("RewardVideoAd onError = "+(msg??'未知错误'));
                    },
                  );
                },
                child: Text("加载激励视频广告")),
          ],
        ),
      ),
    );
  }
}
