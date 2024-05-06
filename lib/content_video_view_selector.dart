import 'package:flutter/material.dart';
import 'package:zjsdk_flutter/content_video.dart';

class ContentVideoViewSelector extends StatelessWidget {
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContentVideoListPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("视频内容列表")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContentVideoFeedPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("视频内容瀑布流")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContentVideoHorizontalPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("视频内容瀑横版")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ContentVideoImageTextPage();
                  })).then((value) {
                    //
                  });
                },
                child: Text("视频内容图文")),
          ],
        )));
  }
}
