import 'package:flutter/material.dart';
import 'banner_ad_view.dart';

class BannerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BannerAdView(
              // @"1080958885885321",@"945778025",@"zjad_iOS_ZB0001",@"J7564361179",@"J9474896977",@"J7722563364"
              adId: "945778025",
              width: 300,
              height: 300 / 6.4,
              onAdLoad: (String id,String msg) {
                print("BannerAd onAdLoad");
              },
              onAdShow: (String id,String msg) {
                print("BannerAd onAdShow");
              },
              onAdClick: (String id,String msg) {
                print("BannerAd onAdClick");
              },
              onAdClose: (String id,String msg) {
                print("BannerAd onAdClose");
              },
              onError: (String id,String msg) {
                print("BannerAd onError = "+(msg??'未知错误'));
              },
              onAdDetailClose: (String id,String msg) {
                print("BannerAd onAdDetailClose");
              },
              
            ),
          ],
        ),
      ),
    );
  }
}
