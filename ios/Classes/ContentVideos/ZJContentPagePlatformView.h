//
//  ZJContentPagePlatformView.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentPagePlatformView : NSObject<FlutterPlatformView>

@end
@interface ZJContentPagePlatformViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end
NS_ASSUME_NONNULL_END
