//
//  ZJImageTextVC.h
//  ZJSDKDemo
//
//  Created by 麻明康 on 2023/1/5.
//  Copyright © 2023 zj. All rights reserved.
//

#import "ZJContentPageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJImageTextVC : ZJContentPageVC
@property (nonatomic,copy)void(^horizontalFeedDetailDidEnter)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidLeave)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidAppear)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidDisappear)(void);

@property (nonatomic,copy)void(^imageTextDetailDidEnter)(void);
@property (nonatomic,copy)void(^imageTextDetailDidLeave)(void);
@property (nonatomic,copy)void(^imageTextDetailDidAppear)(void);
@property (nonatomic,copy)void(^imageTextDetailDidDisappear)(void);
@property (nonatomic,copy)void(^imageTextDetailDidLoadFinish)(void);
@property (nonatomic,copy)void(^imageTextDetailDidScroll)(void);
@end

NS_ASSUME_NONNULL_END
