//
//  ZJContentListPagePlatformView.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>
#import <ZJSDK/ZJContentPage.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentListPagePlatformView : NSObject<FlutterPlatformView,ZJContentPageVideoStateDelegate,ZJContentPageStateDelegate>

@end
@interface ZJContentListPagePlatformViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end
NS_ASSUME_NONNULL_END
