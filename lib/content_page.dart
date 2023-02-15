import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';

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
                  // ZjsdkFlutter.showContentVideoListPage("K90010005",onAdLoad: )
                  // @"zjad_h500001iostest",@"J7539616190",@"J6596738679",@"J1009546769",@"J1747131627",@"J1194046705",@"J6060320975"
                  ZjsdkFlutter.showContentVideoListPage(
                    "K90010005",
                    onAdLoad: (String id, String msg) {
                      print("ContentVideo onAdLoad");
                    },
                    onError: (String id, String msg) {
                      print("ContentVideo onAdLoad = " + (msg ?? '未知错误'));
                    },
                    onAdClick: (String id, String msg) {
                      print("ContentVideo onAdLoad");
                    },
                    onAdClose: (String id, String msg) {
                      print("ContentVideo onAdReward = " + (msg ?? '未知错误'));
                    },
                    onAdDetailClose: (String id, String msg) {
                      print("ContentVideo onAdClick");
                    },
                  );
                },
                child: Text("视频内容图文")),
          ],
        )));
  }
}
