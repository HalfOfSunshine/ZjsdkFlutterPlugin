//
//  ZJHorizontalFeedPageVC.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import "ZJContentPageVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZJHorizontalFeedPageVC : ZJContentPageVC
@property (nonatomic,copy)void(^horizontalFeedDetailDidEnter)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidLeave)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidAppear)(void);
@property (nonatomic,copy)void(^horizontalFeedDetailDidDisappear)(void);

@end

NS_ASSUME_NONNULL_END
