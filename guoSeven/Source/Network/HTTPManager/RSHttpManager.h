//
//  RSHttpManager.h
//  AFNetWorkingProject
//
//  Created by apple on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AppDetailsInfo.h"
#import "AppPrice.h"
#import "AppDiscussion.h"
#import "WBFriendModel.h"


#define RSHTTPMANAGER (RSHttpManager *)[RSHttpManager shareClient]

@interface RSHttpManager : AFHTTPClient{
    UIActivityIndicatorView *activ;
}


-(void)showActivityView:(BOOL)bo;
-(void)startingActivityView;
-(void)stopActivityView;
@property (nonatomic) BOOL isShowActivity;
@property (nonatomic,retain) UIView *contentView;

+(RSHttpManager *)shareClient;


- (void)requestNotificationWithUID:(NSString *)uid  WithSuccess:(void (^)(NSArray *notiList))success
                           failure:(void (^)(NSError *error))failure;

- (void)requestGZAllWithUId:(NSString *)uid WithFollowIDs:(NSString *)fid WithSuccess:(void (^)(BOOL isSuccess))success
                    failure:(void (^)(NSError *error))failure;



- (void)requestShareList:(NSString *)uid  WithSuccess:(void (^)(NSArray *squareList))success
                 failure:(void (^)(NSError *error))failure;




- (void)requestDelShareWithUid:(NSString *)uid WithType:(NSString *)type WithSuccess:(void (^)(BOOL isSuccess))success
                       failure:(void (^)(NSError *error))failure;


- (void)requestBDDBWithUid:(NSString *)uid  WithType:(NSString *)type WithWID:(NSString *)wid WithWKey:(NSString *)wkey WithWT:(NSString *)wt WithSuccess:(void (^)(BOOL isSuccess))success
                   failure:(void (^)(NSError *error))failure;
- (void)requestBDQQWithUid:(NSString *)uid  WithType:(NSString *)type WithWID:(NSString *)wid WithWKey:(NSString *)wkey WithWT:(NSString *)wt WithWName:(NSString *)WNAme WithSuccess:(void (^)(BOOL isSuccess))success
                 failure:(void (^)(NSError *error))failure;
- (void)requestBDWithUid:(NSString *)uid  WithType:(NSString *)type WithWID:(NSString *)wid WithWT:(NSString *)wt WithSuccess:(void (^)(BOOL isSuccess))success
                 failure:(void (^)(NSError *error))failure;

- (void)requestWBFriendWithUID:(NSString *)uid WithType:(NSString *)type WithSuccess:(void (^)(WBFriendModel *userFriends))success
                       failure:(void (^)(NSError *error))failure;


- (void)requestQuestWithUID:(NSString *)uid WithContent:(NSString *)content WithSuccess:(void (^)(BOOL isSuccess))success
                    failure:(void (^)(NSError *error))failure;


//a、修改邮箱
//api/post_user_info

- (void)requestResetEmailWithUID:(NSString *)uid WithOldEmail:(NSString *)oldEM WithPassword:(NSString *)op WithNewEmail:(NSString *)ne WithSuccess:(void (^)(BOOL isSuccess))success
                         failure:(void (^)(NSError *error))failure;



//b、修改密码测试
- (void)requestRestPasswdWithUID:(NSString *)uid WithEmail:(NSString *)email WithPasswd:(NSString *)pwd WithNPasswd:(NSString *)npwd WithSuccess:(void (^)(BOOL isSuccess))success
                         failure:(void (^)(NSError *error))failure;

//修改icon
- (void)requesrRestIconWithUID:(NSString *)uid withIcon:(NSData *)imgData withSuccess:(void (^)(id response))success failure:(void (^)(NSError *error))failure;
//d、修改昵称

- (void)requestRestNickNameWithUID:(NSString *)uid WithNickName:(NSString *)nickName WithSuccess:(void (^)(BOOL isSuccess))success
                           failure:(void (^)(NSError *error))failure;

- (void)requestRestSigNameWithUID:(NSString *)uid WithNickName:(NSString *)sig WithSuccess:(void (^)(BOOL isSuccess))success
                           failure:(void (^)(NSError *error))failure;

//公共广场
//http://www.guo7.com/api/broadcast?uid=17
+ (void)requestSquareWithUID:(NSString *)uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *squareList))success
                     failure:(void (^)(NSError *error))failure;
//用户广播
- (void)requestUSquareWithUID:(NSString *)uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *squareList))success
                     failure:(void (^)(NSError *error))failure;






//获取信息回应的列表
//
//说明:    获取信息回应的列表
//URL:   /api/list_response?event_id=信息ID&p=分页

- (void)requestResponseListWithEvent_id:(NSString *)event_id WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *appInfoRWDList))success
                                failure:(void (^)(NSError *error))failure;



//愿望清单
//http://www.guo7.com/api/get_user_want?uid=17&login_uid=17
+ (void)requestWantWithUID:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *wantList))success
                   failure:(void (^)(NSError *error))failure;

//关注与粉丝
//http://www.guo7.com/api/get_follow?uid=17&p=1&type=follower
//http://www.guo7.com/api/get_follow?uid=17&p=1&type=following

- (void)requestUserWithUID:(NSString *)uid WithType:(NSString *)type WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *userList))success
                   failure:(void (^)(NSError *error))failure;

//搜索好友
-(void)requestSearchFriendWithString:(NSString *)string WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *friendList))success
                       failure:(void (^)(NSError *error))failure;

//我的评论
//http://www.guo7.com/api/get_user_discuss?uid=17
-(void)requestTopicForTalkWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *topicList))success
                        failure:(void (^)(NSError *error))failure;



//我的推荐
//http://www.guo7.com/api/get_user_recommend?uid=17
- (void)requestTopicForLIKEWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *topicList))success
                           failure:(void (^)(NSError *error))failure;

//私信列表
//http://www.guo7.com/api/get_message_list?uid=17
+ (void)requestMessageListWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *messageList))success
                          failure:(void (^)(NSError *error))failure;

//当前用户信息
//http://www.guo7.com/api/get_user_info?uid=17
+ (void)requestUserInfoWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *userList))success
                       failure:(void (^)(NSError *error))failure;
//他人信息
+ (void)requestTargetUserInfoWithUID:(NSString *)uid WithTUID:(NSString *)tuid WithSuccess:(void (^)(NSArray *userList))success
                       failure:(void (^)(NSError *error))failure;

//http://www.guo7.com/api/app_event?aid=377365825&type=1
//说明:    获取应用详细的推荐、愿望清单及讨论列表(3个API合并)
//URL:  /api/app_event?aid=应用id&type=类型
-(void)requestAppInfoRWDWithAppID:(NSString *)appID WithType:(NSString *)typeID WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *appInfoRWDList))success
                           failure:(void (^)(NSError *error))failure;



//http://www.guo7.com/api/login?email=lvjunwei2008@gmail.com&passwd=1
//登陆
+ (void)requestLoginWithEmail:(NSString *)email WithPasswd:(NSString *)passwd WithSuccess:(void (^)(NSArray *loginInfo))success
                                                                                  failure:(void (^)(NSError *error))failure;

//注册
+ (void)requestRegisterWithEmail:(NSString *)email WithPasswd:(NSString *)passwd WithNickName:(NSString *)nick_name WithCity_id:(NSString *)city_id WithCity_name:(NSString *)city_name WithSuccess:(void (^)(NSArray *loginInfo))success
                      failure:(void (^)(NSError *error))failure;


//赞
//说明:    用户对信息的赞
//URL:   /api/like?event_id=信息ID&uid=用户ID

-(void)requestZanWithEvent_id:(NSString *)event_id WithUid:(NSString *)uid WithSuccess:(void (^)(BOOL isSuccess))success
                       failure:(void (^)(NSError *error))failure;

- (void)requestUnZanWithEvent_id:(NSString *)event_id WithUid:(NSString *)uid WithSuccess:(void (^)(BOOL isSuccess))success
                         failure:(void (^)(NSError *error))failure;

//说明:    单条信息回应
//URL:  /api/new_response

+ (void)requestResponseWithUId:(NSString *)uid WithEvent_id:(NSString *)event_id WithContent:(NSString *)content WithSuccess:(void (^)(BOOL isSuccess))success
                       failure:(void (^)(NSError *error))failure;


//2、获取用户动态
//说明:    获取用户的动态,同样可以调用友邻
//URL:   /api/get_user_feed?uid=用户ID&p=分页
- (void)requestUserDynamicWithUid:(NSString *)uid WithLoginID:(NSString *)login_uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *dynimicList))success
                          failure:(void (^)(NSError *error))failure;



//获取用户推荐App列表
//
//说明:   获取用户推荐App列表,同样可以调用友邻
//URL:   /api/get_user_recommend?uid=用户id
- (void)requestUserRecommendWithUid:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *recommendList))success
                          failure:(void (^)(NSError *error))failure;


/*
 获取app详细信息
 http://www.guo7.com/api/appinfo?aid=1&uid=17
 appId：app id
 */
-(void)requestAppDetailsWitiAppId:(NSString *)appId andUid:(NSString *)strUid WithSuccess:(void (^)(AppDetailsInfo * appDetails))success failure:(void (^)(NSError *errorMSG))failure;

/*
 获取App 价格 走势列表
 http://www.guo7.com/api/price_version_change?aid=493136154
 appId : app id
 */

-(void)requestAppPriceChangeWitiAppId:(NSString *)appId WithSuccess:(void (^)(NSArray *arrPriceList))success failure:(void (^)(NSError *_err))failure;
//讨论列表
//http://www.guo7.com/api/get_user_discuss?uid＝用户ID
- (void)requestCommentWithUID:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *commentList))success failure:(void (^)(NSError *error))failure;

/*
 获取App 价格 走势统计
 http://www.guo7.com/api/price_statistics?aid=493136154
 appId : app id
 */

-(void)requestAppPriceStatisticWitiAppId:(NSString *)appId WithSuccess:(void (^)(AppPriceStatistic *appPriceStatistic))success failure:(void (^)(NSError *_err))failure;



/*
 app 分享列表获取
 http://www.guo7.com/api/share?uid=10
 userId:user id
 */

-(void)requestShareBlogListWithUserId:(NSString *)userId WithSuccess:(void (^)(NSArray *arrShare))success failure:(void (^)(NSError *_err))failure;

/*
 app 分享
 http://www.guo7.com/api/post_recommend
 uid,aid,content
 sina_weibo,qqwb_weibo,douban_weibo
 */
-(void)shareBlogWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;

/*
 添加app到愿望清单
 http://www.guo7.com/api/remind
 uid,aid
 */
-(void)addAppToWishlistWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;


/*
 对App进行讨论回复
 http://www.guo7.com/api/new_discuss
 uid: user id 
 application_id: app id
 content:讨论内容
 */
-(void)addDiscussionToAppWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(AppDiscussion *discussion))success failure:(void (^)(NSError *_err))failure;

//单例私信列表
//说明:    获取任何用户的私信详细
//URL:  /api/get_chat?uid=用户id&origin_user_id=用户id&p=1
+ (void)requestDialoguesWithUID:(NSString *)uid WithUser:(NSString *)uuid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *dialogueList))success
                       failure:(void (^)(NSError *error))failure;

//发送私信
//URL:  /api/send_message
//HTTP请求方式:    POST
//uid
//target_user_id
//content


+ (void)requestSendDialogueWithUID:(NSString *)uid WithTargetUID:(NSString *)targetID WithContent:(NSString *)content WithSuccess:(void (^)(BOOL isSucceed))success
                           failure:(void (^)(NSError *error))failure;

//搜索应用
//说明:    搜索应用
//URL:  /api/search?str=关键词



- (void)requestSearchAppWithStr:(NSString *)str WithDevice:(NSString *)device WithSort:(NSString *)sort WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *searchAppList))success
                        failure:(void (^)(NSError *error))failure;


//好友 添加关注/取消关注
//说明:   好友之间的关注操作
//URL:  /api/(follow|unfollow)?uid=用户ID&following_uid=对象ID
//GET /api/(follow)?uid=1&following_uid=10    //关注
//GET /api/(unfollow)?uid=1&following_uid=10    //取消关注

- (void)requestFollowPeopleWithUID:(NSString *)uid WithFollwingID:(NSString *)fuid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;
- (void)requestUnFollowPeopleWithUID:(NSString *)uid WithFollwingID:(NSString *)fuid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;


//
//删除单条私信
//说明:    好友之间单条私信删除
//URL:  /api/remove_message?message_id=私信编号

- (void)requestDelSimpleMSGWithMSGID:(NSString *)mid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;



//删除全部私信
//说明:    好友之间全部私信删除
//URL:  /api/removeall_message?uid=用户ID&target_user_id=对象好友

- (void)requestDelALLMSGWithUID:(NSString *)uid WithTargetUID:(NSString *)tuid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;

//http://www.guo7.com/api/app_event?uid=480&aid=420635506&type=4&p=0
-(void)requestAppInfoRWDWithAppID:(NSString *)appID userId:(NSString *)uId WithType:(NSString *)typeID WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *appInfoRWDList))success failure:(void (^)(NSError *error))failure;

//
//说明:   push提交设备号ID
//URL:   /api/push_device_token
//支持格式:    JSON
//HTTP请求方式:    POST

- (void)registePushDeviceTokenID:(NSString *)uid WithTokenID:(NSString *)token WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure;

- (void)getNoticationWithType:(NSString *)type WithUserId:(NSString *)uId WithSuccess:(void (^)(NSArray *dialogueList))success
                      failure:(void (^)(NSError *error))failure;

- (void)clearNoticationWithMID:(NSString *)mid WithUserId:(NSString *)uId WithSuccess:(void (^)(NSArray *dialogueList))success
                       failure:(void (^)(NSError *error))failure;


//获取私信
- (void)sx_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure;

//推荐和评论

-(void)tj_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure;

//关注
-(void)gz_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure;

//愿望清单
-(void)wantlist_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure;

@end

