//
//  ZJContentPageVC.h
//  zjsdk_flutter
//
//  Created by 麻明康 on 2023/2/17.
//

#import <UIKit/UIKit.h>
#import <ZJSDK/ZJContentPageStateDelegate.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZJContentPageVC : UIViewController<ZJContentPageVideoStateDelegate,ZJContentPageStateDelegate>
@property (nonatomic,copy)NSString *contentId;

-(void)tryAddSubVC:(UIViewController *)vc;

#pragma mark =============== ZJContentPageVideoStateDelegate ===============
/**
 * 视频开始播放
 * @param videoContent 内容模型
 */
@property (nonatomic,copy)void(^videoDidStartPlay)(void);

/**
* 视频暂停播放
* @param videoContent 内容模型
*/
@property (nonatomic,copy)void(^videoDidPause)(void);

/**
* 视频恢复播放
* @param videoContent 内容模型
*/
@property (nonatomic,copy)void(^videoDidResume)(void);


/**
* 视频停止播放
* @param videoContent 内容模型
* @param finished     是否播放完成
*/
@property (nonatomic,copy)void(^videoDidEndPlay)(void);

/**
* 视频播放失败
* @param videoContent 内容模型
* @param error        失败原因
*/
@property (nonatomic,copy)void(^videoDidFailedToPlay)(NSError *error);

#pragma mark =============== ZJContentPageStateDelegate ===============
/**
* 内容展示
* @param content 内容模型
*/
@property (nonatomic,copy)void(^contentDidFullDisplay)(void);

/**
* 内容隐藏
* @param content 内容模型
*/
@property (nonatomic,copy)void(^contentDidEndDisplay)(void);

/**
* 内容暂停显示，ViewController disappear或者Application resign active
* @param content 内容模型
*/
@property (nonatomic,copy)void(^contentDidPause)(void);

/**
* 内容恢复显示，ViewController appear或者Application become active
* @param content 内容模型
*/
@property (nonatomic,copy)void(^contentDidResume)(void);
@end

NS_ASSUME_NONNULL_END
