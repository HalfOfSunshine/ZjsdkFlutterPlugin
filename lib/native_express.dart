import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/zjsdk_flutter.dart';
import 'native_express_ad_view.dart';

class NativeExpressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NativeExpressAdView(
              // @"G3061112693227741",@"K4000000007",@"T945740162",@"zjad_iOS_ZF0001",@"K4000000008"
              adId: "J1516777127",
              width: 300,
              height: 200,
              onAdLoad: (String id,String msg) {
                print("NativeExpressAd onAdLoad");
              },
              onAdShow: (String id,String msg) {
                print("NativeExpressAd onAdShow");
              },
              onAdClick: (String id,String msg) {
                print("NativeExpressAd onAdClick");
              },
              onAdDislike: (String id,String msg) {
                print("NativeExpressAd onAdDislike");
              },
              onError: (String id,String msg) {
                print("NativeExpressAd onError = "+(msg));
              },
              onAdRenderSuccess: (String id,String msg) {
                print("NativeExpressAd onAdRenderSuccess");
              },
              onAdRenderFail: (String id,String msg) {
                print("NativeExpressAd onAdRenderFail");
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
