//
//  ZJPlatformTool.m
//  zjsdk_flutter
//
//  Created by Mountain King on 2022/10/9.
//

#import "ZJPlatformTool.h"

@implementation ZJPlatformTool
//获得当前活动窗口的根视图
+ (UIViewController *)findCurrentShowingViewController{
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentShowingVC = [self findCurrentShowingViewControllerFrom:vc];
    return currentShowingVC;
}

+ (UIViewController *)findCurrentShowingViewControllerFrom:(UIViewController *)vc
{
    // 递归方法 Recursive method
    UIViewController *currentShowingVC;
    if ([vc presentedViewController]) {
        // 当前视图是被presented出来的
        UIViewController *nextRootVC = [vc presentedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        UIViewController *nextRootVC = [(UITabBarController *)vc selectedViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else if ([vc isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        UIViewController *nextRootVC = [(UINavigationController *)vc visibleViewController];
        currentShowingVC = [self findCurrentShowingViewControllerFrom:nextRootVC];

    } else {
        // 根视图为非导航类
        currentShowingVC = vc;
    }

    return currentShowingVC;
}

// 判断字符串是否为空（YES：空）
+(BOOL)isEmptyString:(NSString *)string {
    if (string) {
    } else {
        return YES;
    }
    
    if ([string isEqual:[NSNull null]]) {
        return YES;
    }
    NSString *compStr = [NSString stringWithFormat:@"%@", string];
    
    if ( compStr == nil || [compStr isEqualToString:@""] || [compStr isEqualToString:@"(null)"] || [compStr isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if([compStr length] == 0) {
        return YES;
    } else if([[compStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""] == YES) {
        return YES;
    }
    
    return NO;
}
@end
