//
//  ZJPlatformTool.h
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJPlatformTool : NSObject
//获得当前活动窗口的根视图
+ (UIViewController *)findCurrentShowingViewController;
+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc;
@end

NS_ASSUME_NONNULL_END
