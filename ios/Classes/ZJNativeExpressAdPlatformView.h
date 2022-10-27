//
//  ZJNativeExpressAdPlatformView.h
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJNativeExpressAdPlatformView : NSObject<FlutterPlatformView>

@end

@interface ZJNativeExpressAdPlatformViewFactory : NSObject<FlutterPlatformViewFactory>
- (instancetype)initWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar;
@end
NS_ASSUME_NONNULL_END
