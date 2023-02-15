import 'package:flutter/material.dart';
// import 'package:zjsdk_flutter/zjsdk_flutter.dart';

class ContentPage extends StatelessWidget {
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
            ElevatedButton(onPressed: () {}, child: Text("视频内容列表")),
            ElevatedButton(onPressed: () {}, child: Text("视频内容瀑布流")),
            ElevatedButton(onPressed: () {}, child: Text("视频内容横版")),
            ElevatedButton(
                onPressed: () {
                  // @"zjad_h500001iostest",@"J7539616190",@"J6596738679",@"J1009546769",@"J1747131627",@"J1194046705",@"J6060320975"
                  // ZjsdkFlutter.showH5Ad(
                  //   "zjad_h500001iostest",
                  //   "00012282",
                  //   "吊炸天524",
                  //   "",
                  //   10000,
                  //   "超级无敌4",
                  //   onAdLoad: (String id, String msg) {
                  //     print("H5 onAdLoad");
                  //   },
                  //   onError: (String id, String msg) {
                  //     print("H5 onAdLoad = " + (msg ?? '未知错误'));
                  //   },
                  //   onRewardAdLoad: (String id, String msg) {
                  //     print("H5 onRewardAdLoad");
                  //   },
                  //   onRewardAdReward: (String id, String msg) {
                  //     print("H5 onRewardAdReward = " + (msg ?? '未知错误'));
                  //   },
                  //   onRewardAdClick: (String id, String msg) {
                  //     print("H5 onRewardAdClick");
                  //   },
                  //   onRewardAdError: (String id, String msg) {
                  //     print("H5 onRewardAdError = " + (msg ?? '未知错误'));
                  //   },
                  // );
                },
                child: Text("视频内容图文")),
          ],
        )));
  }
}
