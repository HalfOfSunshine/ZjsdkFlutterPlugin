import 'package:flutter/material.dart';
import 'native_express_ad_view.dart';

class NativeExpressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NativeExpressAdView(
              // @"G3061112693227741",@"K4000000007",@"T945740162",@"zjad_iOS_ZF0001",@""
              adId: "K4000000008",
              width: 300,
              height: 100,
              adBackgroundColor:
                  Color.fromARGB(255, 50, 255, 248), //部分联盟背景色为白色不支持自定义。
              onAdLoad: (String id, String msg) {
                print("NativeExpressAd onAdLoad");
              },
              onAdShow: (String id, String msg) {
                print("NativeExpressAd onAdShow");
              },
              onAdClick: (String id, String msg) {
                print("NativeExpressAd onAdClick");
              },
              onAdDislike: (String id, String msg) {
                print("NativeExpressAd onAdDislike");
              },
              onError: (String id, String msg) {
                print("NativeExpressAd onError = " + (msg));
              },
              onAdRenderSuccess: (id, msg, {extraMap}) {
                print("NativeExpressAd onAdRenderSuccess");
              },
              onAdRenderFail: (String id, String msg) {
                print("NativeExpressAd onAdRenderFail");
              },
            ),
          ],
        ),
      ),
    );
  }
}
