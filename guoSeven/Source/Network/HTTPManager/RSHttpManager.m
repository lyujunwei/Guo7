//
//  RSHttpManager.m
//  AFNetWorkingProject
//
//  Created by apple on 12-7-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RSHttpManager.h"
#import "AFJSONRequestOperation.h"
#import "AFXMLRequestOperation.h"
#import "AFJSONUtilities.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "common.h"
#import "SquareModel.h"
#import "WantModel.h"
#import "UserModel.h"
#import "TopicModel.h"
#import "MessageModel.h"
#import "UserInfo.h"
#import "UserModel.h"
#import "AppInfoRWDModel.h"
#import "LoginInfoModel.h"
#import "AppShareModel.h"
#import "DialogueModel.h"
#import "SearchAppModel.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"
#import "NSError + Addition.h"
#import "AppReplyInfo.h"
#import "Base64.h"
#import "AllModel.h"
#import "CountModle.h"
#import "FriendsModel.h"
#import "WeiBoShare.h"
#import "NotificaitonModel.h"



//static NSString * const RSBaseURLString = @"http://digihub.antinganting.com.cn/app/";
@implementation RSHttpManager

@synthesize isShowActivity,contentView;

+(RSHttpManager *)shareClient{
    static RSHttpManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[RSHttpManager alloc] initWithBaseURL:[NSURL URLWithString:kAFAppDotNetAPIBaseURLString]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    activ = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [activ setFrame:CGRectMake(0, 0, 50, 50)];
    [activ setBackgroundColor:[UIColor grayColor]];
    
    //检查网络
    [self setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
            NSMutableDictionary *errDict = [NSMutableDictionary dictionary];
            [errDict setValue:@"网络不可用..." forKey:NSLocalizedDescriptionKey];
            NSError *err = [NSError errorWithDomain:GErrorDomain code:GConnectFailed userInfo:errDict];
            [SVProgressHUD showErrorWithStatus:err.localizedDescription];
        }
    }];
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    return self;
}

+ (NSSet *)defaultAcceptableContentTypes;
{
    return [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain",@"text/html", nil];
}


-(void)showActivityView:(BOOL)bo{
    
    self.isShowActivity = bo;
//    self.contentView = view;
}

-(void)startingActivityView{
    if (self.isShowActivity) {
        [SVProgressHUD show];
    }
}

-(void)stopActivityView{
    [SVProgressHUD dismiss];
}

//http://www.guo7.com/api/login?email=549858687@qq.com&passwd=1111

- (void)postContentsWithPath:(NSString *)path
                  paramters:(NSDictionary *)parameters
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure {

    NSLog(@"开始Post请求数据");

    [RSHTTPMANAGER postPath:path parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

    
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            NSMutableDictionary *errDict = [NSMutableDictionary dictionary];
            [errDict setValue:NETREACHIBILITYISUNABLE forKey:NSLocalizedDescriptionKey];
            error = [error setCustomErrorWithDomin:GErrorDomain andCode:GConnectFailed andUserInfo:errDict];
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];

        }
    }];

}

- (void)postImageContentsWithPath:(NSString *)path
                   paramters:(NSDictionary *)parameters
                     success:(void (^)(id responseObject))success
                     failure:(void (^)(NSError *error))failure {
	
	
    NSMutableURLRequest *afRequest = [RSHTTPMANAGER multipartFormRequestWithMethod:@"POST"
                                                                           path:path
                                                                     parameters:nil
                                                      constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
                                      {
                                          NSString *userIcon = [NSString stringWithFormat:@"%@.jpg",[parameters valueForKey:@"uid"]];
                                          [formData appendPartWithFileData:[parameters valueForKey:@"file"] name:@"file" fileName:userIcon mimeType:@"image/jpeg"];
                                          [formData appendPartWithFormData:[[parameters valueForKey:@"uid"] dataUsingEncoding:NSUTF8StringEncoding] name:@"uid"];
                                          [formData appendPartWithFormData:[[parameters valueForKey:@"type"] dataUsingEncoding:NSUTF8StringEncoding] name:@"type"];
                                          
                                          NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                                          [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
                                          NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
                                          NSString *md5Str = [[NSString stringWithFormat:@"%@%@",KEY,strDate] md5];
                                          NSString *pwdEntript = [md5Str md5];
                                          
                                          
                                          [formData appendPartWithFormData:[pwdEntript dataUsingEncoding:NSUTF8StringEncoding] name:@"auth_key"];
                                          [formData appendPartWithFormData:[strDate dataUsingEncoding:NSUTF8StringEncoding] name:@"authKey_time"];                                          
                                      }
                                      ];
    DLog(@"afrequest==%@",afRequest);
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:afRequest];    
    [operation setCompletionBlock:^{
        NSLog(@"1111111111%@", operation.responseString); //Gives a very scary warning
        success(operation.responseString);
    }];
    [operation start];
    
}


- (void)getContentsWithPath:(NSString *)path
                  paramters:(NSDictionary *)parameters
                    success:(void (^)(id responseObject))success
                    failure:(void (^)(NSError *error))failure {
    NSLog(@"开始Get请求数据");
    
//    NSMutableDictionary *mudicPara = [NSMutableDictionary dictionaryWithDictionary:parameters];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    NSString *md5Str = [[NSString stringWithFormat:@"%@%@",KEY,strDate] md5];
    NSString *pwdEntript = [md5Str md5];
    
//    [mudicPara setObject:pwdEntript forKey:@"auth_key"];
//    [mudicPara setObject:strDate forKey:@"authKey_time"];
    NSString *pathP = [path stringByAppendingString:[NSString stringWithFormat:@"&auth_key=%@&authKey_time=%@",pwdEntript,strDate]];
    DLog(@"pathP==%@",pathP);
    NSMutableURLRequest *request = [RSHTTPMANAGER requestWithMethod:@"GET" path:pathP parameters:parameters];
    [request setTimeoutInterval:20];
    NSLog(@"========%@",request);
    AFHTTPRequestOperation *operation = [RSHTTPMANAGER HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            NSMutableDictionary *errDict = [NSMutableDictionary dictionary];
            [errDict setValue:NETREACHIBILITYISUNABLE forKey:NSLocalizedDescriptionKey];
            error = [error setCustomErrorWithDomin:GErrorDomain andCode:GConnectFailed andUserInfo:errDict];
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
            failure(error);
        }
    }];
    [RSHTTPMANAGER enqueueHTTPRequestOperation:operation];
    
}


- (void)requestNotificationWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSString *tmp = [NSString stringWithFormat:@"notification?uid=%@",uid];

    [RSHTTPMANAGER getContentsWithPath:tmp paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);            
            
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                NotificaitonModel *noti = [NotificaitonModel instancefromJsonDic:responseData];
                [mutableSquareList addObject:noti];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }

            
    
            if (success) {
            }
            
            
        }
        
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestGZAllWithUId:(NSString *)uid WithFollowIDs:(NSString *)fid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", fid, @"following_uid",nil];
    ///api/del_share?uid=用户ID&type=微博分类
    NSString *path = [NSString stringWithFormat:@"del_share?uid=%@&type=%@",uid,fid];
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
        
    } failure:^(NSError *error) {
        
    }];

    
}

- (void)requestShareList:(NSString *)uid WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSString *tmp = [NSString stringWithFormat:@"share?uid=%@",uid];
    
    [RSHTTPMANAGER getContentsWithPath:tmp paramters:nil success:^(id responseObject) {
//        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
//            success(NO);
//        }else{
//            success(YES);
//        }
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                WeiBoShare *share = [WeiBoShare instancefromJsonDic:attributes];
                [mutableSquareList addObject:share];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
        }
    

        
    } failure:^(NSError *error) {
        
    }];
}


- (void)requestDelShareWithUid:(NSString *)uid WithType:(NSString *)type WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", type, @"type",nil];
    NSString *path = [NSString stringWithFormat:@"del_share?uid=%@&type=%@",uid,type];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
        
    } failure:^(NSError *error) {
        
    }];

}


- (void)requestBDDBWithUid:(NSString *)uid WithType:(NSString *)type WithWID:(NSString *)wid WithWKey:(NSString *)wkey WithWT:(NSString *)wt WithSuccess:(void (^)(BOOL isSuccess))success
                   failure:(void (^)(NSError *error))failure;{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"user_id", type, @"weibo_type", wid, @"weibo_user_id", wt, @"weibo_access_token", wkey,@"weibo_user_key", nil];
    
    [RSHTTPMANAGER postPath:@"post_user_weibo?" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)requestBDQQWithUid:(NSString *)uid WithType:(NSString *)type WithWID:(NSString *)wid WithWKey:(NSString *)wkey WithWT:(NSString *)wt WithWName:(NSString *)WNAme WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"user_id", type, @"weibo_type", wid, @"weibo_user_id", wt, @"weibo_access_token", wkey,@"weibo_user_key", WNAme, @"weibo_qq_name",nil];
    
    [RSHTTPMANAGER postPath:@"post_user_weibo?" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


- (void)requestBDWithUid:(NSString *)uid WithType:(NSString *)type WithWID:(NSString *)wid WithWT:(NSString *)wt WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"user_id", type, @"weibo_type", wid, @"weibo_user_id", wt, @"weibo_access_token",nil];

    [RSHTTPMANAGER postPath:@"post_user_weibo?" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (void)requestWBFriendWithUID:(NSString *)uid WithType:(NSString *)type WithSuccess:(void (^)(WBFriendModel *))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", type, @"type",nil];
    NSString *path = [NSString stringWithFormat:@"online_friends?uid=%@&type=%@",uid,type];

    
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            //            NSLog(@"/////%@",responseData);
//            NSMutableArray *mutableSquareList = [NSMutableArray array];
            WBFriendModel *wbF = [WBFriendModel instancefromJsonDic:responseData];
            wbF.countModel = [CountModle instancefromJsonDic:[responseData valueForKeyPath:@"count"]];
            
            DLog(@"=====%@",[responseData valueForKeyPath:@"friends.all"])
            if ([[responseData valueForKeyPath:@"friends.all"] class] != [NSNull class]) {
                wbF.arrFriendsAll = [AllModel instancesFromJsonArray:[responseData valueForKeyPath:@"friends.all"]];
            }else{
                //friends.all = null
            }
//            [mutableSquareList addObject:wbF];
            if (success) {
                success(wbF);
            }
            
            DLog(@"wbf.arfriends==%@",[[wbF arrFriendsAll] description])

        }
        
    } failure:^(NSError *error) {
    
    }];
    
}



- (void)requestQuestWithUID:(NSString *)uid WithContent:(NSString *)content WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", content, @"content",nil];
    
    NSString *path = [NSString stringWithFormat:@"question?uid=%@&content=%@",uid,content];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }

    } failure:^(NSError *error) {
        
    }];
    

}

- (void)requestResetEmailWithUID:(NSString *)uid WithOldEmail:(NSString *)oldEM WithPassword:(NSString *)op WithNewEmail:(NSString *)ne WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", @"email", @"type", oldEM, @"old_email", op, @"passwd", ne, @"new_email",nil];
    
    [RSHTTPMANAGER postContentsWithPath:@"post_user_info?" paramters:param success:^(id responseObject) {
        NSLog(@"resetEmail/////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)requestRestPasswdWithUID:(NSString *)uid WithEmail:(NSString *)email WithPasswd:(NSString *)pwd WithNPasswd:(NSString *)npwd WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", @"passwd", @"type", email, @"email", pwd, @"passwd", npwd, @"new_passwd",nil];
    [RSHTTPMANAGER postContentsWithPath:@"post_user_info?" paramters:param success:^(id responseObject) {
        NSLog(@"resetPWD/////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)requesrRestIconWithUID:(NSString *)uid withIcon:(NSData *)imgData withSuccess:(void (^)(id response))success failure:(void (^)(NSError *error))failure {
//	 NSString *strPhotoData = [Base64 encode:imgData];
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid,@"uid",@"user_icon",@"type",imgData,@"file", nil];
    [RSHTTPMANAGER postImageContentsWithPath:@"post_user_info" paramters:param success:^(id responseObject) {
        DLog(@"responseObj==%@",responseObject);
        if (success) {
            success(responseObject);
        }
    } failure:^(NSError *error) {
        DLog(@"error==%@",error.localizedDescription);
        if (failure) {
            failure(error);
        }
    }];
}

-(NSString *)Base64Encode:(NSData *)data{
    //Point to start of the data and set buffer sizes
    int inLength = [data length];
    int outLength = ((((inLength * 4)/3)/4)*4) + (((inLength * 4)/3)%4 ? 4 : 0);
    const char *inputBuffer = [data bytes];
    char *outputBuffer = malloc(outLength);
    outputBuffer[outLength] = 0;
    
    //64 digit code
    static char Encode[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    
    //start the count
    int cycle = 0;
    int inpos = 0;
    int outpos = 0;
    char temp;
    
    //Pad the last to bytes, the outbuffer must always be a multiple of 4
    outputBuffer[outLength-1] = '=';
    outputBuffer[outLength-2] = '=';
    
    /* http://en.wikipedia.org/wiki/Base64
     Text content   M           a           n
     ASCII          77          97          110
     8 Bit pattern  01001101    01100001    01101110
     
     6 Bit pattern  010011  010110  000101  101110
     Index          19      22      5       46
     Base64-encoded T       W       F       u
     */
    
    
    while (inpos < inLength){
        switch (cycle) {
            case 0:
                outputBuffer[outpos++] = Encode[(inputBuffer[inpos]&0xFC)>>2];
                cycle = 1;
                break;
            case 1:
                temp = (inputBuffer[inpos++]&0x03)<<4;
                outputBuffer[outpos] = Encode[temp];
                cycle = 2;
                break;
            case 2:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xF0)>> 4];
                temp = (inputBuffer[inpos++]&0x0F)<<2;
                outputBuffer[outpos] = Encode[temp];
                cycle = 3;
                break;
            case 3:
                outputBuffer[outpos++] = Encode[temp|(inputBuffer[inpos]&0xC0)>>6];
                cycle = 4;
                break;
            case 4:
                outputBuffer[outpos++] = Encode[inputBuffer[inpos++]&0x3f];
                cycle = 0;
                break;                          
            default:
                cycle = 0;
                break;
        }
    }
    NSString *pictemp = [NSString stringWithUTF8String:outputBuffer];
    free(outputBuffer); 
    return pictemp;
}

- (void)requestRestNickNameWithUID:(NSString *)uid WithNickName:(NSString *)nickName WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", @"nick_name", @"type", nickName, @"nick_name", nil];
    [RSHTTPMANAGER postContentsWithPath:@"post_user_info?" paramters:param success:^(id responseObject) {
        NSLog(@"resetNick/////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(NSError *error) {
        
    }];
}


- (void)requestRestSigNameWithUID:(NSString *)uid WithNickName:(NSString *)sig WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", @"signature", @"type", sig, @"signature", nil];
    NSLog(@"////param:%@",param);
    [RSHTTPMANAGER postContentsWithPath:@"post_user_info?" paramters:param success:^(id responseObject) {
        NSLog(@"resetSig/////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }
    } failure:^(NSError *error) {
        
    }];
}

//http://www.guo7.com/api/broadcast?uid=17
+ (void)requestSquareWithUID:(NSString *)uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *squareList))success
                     failure:(void (^)(NSError *error))failure{
    
//    NSDictionary *param = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", page, @"p", nil];
    NSString *path = [NSString stringWithFormat:@"broadcast_a?uid=%@&p=%@",uid,page];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                SquareModel *square = [SquareModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:square];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);                
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


- (void)requestUSquareWithUID:(NSString *)uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    if (self.isShowActivity) {
        [self startingActivityView];
    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", page, @"p", nil];
    NSString *path = [NSString stringWithFormat:@"broadcast_b?uid=%@&p=%@",uid,page];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                SquareModel *square = [SquareModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:square];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
            [self stopActivityView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

//URL:   /api/list_response?event_id=信息ID&p=分页

- (void)requestResponseListWithEvent_id:(NSString *)event_id WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSString *str = [NSString stringWithFormat:@"list_response?event_id=%@&p=%@",event_id, page];
    [RSHTTPMANAGER getContentsWithPath:str paramters:nil success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        //        DLog(@"responseData==%d",[responseData count]);
        //        if ([responseData count]) {
        NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
        for (NSDictionary *attributes in responseData) {
            AppInfoRWDModel *appInfo = [AppInfoRWDModel instancefromJsonDic:attributes];
            appInfo.user = [UserInfo instancefromJsonDic:[attributes valueForKeyPath:@"user"]];
            [mutableList addObject:appInfo];
        }
        if (success) {
            success([NSArray arrayWithArray:mutableList]);
        }
        //        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//http://www.guo7.com/api/get_user_want?uid=17&login_uid=17
+ (void)requestWantWithUID:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *wantList))success failure:(void (^)(NSError *))failure{
    [RSHTTPMANAGER startingActivityView];
    
//    NSDictionary *param = [NSDictionary dictionaryWithObject:uid forKey:@"uid"];
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", login_uid, @"login_uid",nil];
    
    NSString *path = [NSString stringWithFormat:@"get_user_want?uid=%@&login_uid=%@",uid,login_uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableWantList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                WantModel *want = [WantModel instancefromJsonDic:attributes];
                [mutableWantList addObject:want];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableWantList]);
            }
            [RSHTTPMANAGER stopActivityView];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
        [RSHTTPMANAGER stopActivityView];
    }];
    
}

//following关注
//follower粉丝

- (void)requestUserWithUID:(NSString *)uid WithType:(NSString *)type WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *userList))success failure:(void (^)(NSError *))failure{
//    if (self.isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", type, @"type", page, @"p", nil];
    NSString *path = [NSString stringWithFormat:@"get_follow?uid=%@&type=%@&p=%@",uid,type,page];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                UserModel *user = [UserModel instancefromJsonDic:attributes];
                [mutableList addObject:user];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
//            [self stopActivityView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}


//搜索人
-(void)requestSearchFriendWithString:(NSString *)string WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:string, @"str", nil];
    
    NSString *path = [NSString stringWithFormat:@"friend_search?str=%@",string];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                UserModel *user = [UserModel instancefromJsonDic:attributes];
                [mutableList addObject:user];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}






//我的推荐
//http://www.guo7.com/api/get_user_discuss?uid=17
-(void)requestTopicForTalkWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *topicList))success failure:(void (^)(NSError *))failure{
//    if (self.isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",nil];
    NSString *path = [NSString stringWithFormat:@"get_user_recommend?uid=%@",uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                TopicModel *topic = [TopicModel instancefromJsonDic:attributes];
                [mutableList addObject:topic];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
            [self stopActivityView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

//我的评论
//http://www.guo7.com/api/get_user_recommend?uid=17
- (void)requestTopicForLIKEWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *topicList))success failure:(void (^)(NSError *))failure{
//    if (self.isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",nil];
    NSString *path = [NSString stringWithFormat:@"get_user_discuss?uid=%@",uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                TopicModel *topic = [TopicModel instancefromJsonDic:attributes];
                [mutableList addObject:topic];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
            [self stopActivityView];
        }else{
            [SVProgressHUD showErrorWithStatus:@"Error "];
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

//私信列表
//http://www.guo7.com/api/get_message_list?uid=17

+ (void)requestMessageListWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *messageList))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",nil];
    NSString *path = [NSString stringWithFormat:@"get_message_list?uid=%@",uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                MessageModel *message = [MessageModel instancefromJsonDic:attributes];
                [mutableList addObject:message];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

//当前用户信息
//http://www.guo7.com/api/get_user_info?uid=17
+ (void)requestUserInfoWithUID:(NSString *)uid WithSuccess:(void (^)(NSArray *userList))success
                       failure:(void (^)(NSError *error))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",nil];
    NSString *path = [NSString stringWithFormat:@"get_user_info?uid=%@",uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
                UserInfo *userInfo = [UserInfo instancefromJsonDic:responseData];
            if (success) {
                success([NSArray arrayWithObject:userInfo]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
+ (void)requestTargetUserInfoWithUID:(NSString *)uid WithTUID:(NSString *)tuid WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:tuid, @"target_uid",uid, @"uid",nil];
    
    NSString *path = [NSString stringWithFormat:@"get_user_info?uid=%@&target_uid=%@",uid,tuid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
            
            UserInfo *userInfo = [UserInfo instancefromJsonDic:responseData];
            NSLog(@".........discuss:%@",userInfo.discuss_count);
            if (success) {
                success([NSArray arrayWithObject:userInfo]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


//http://www.guo7.com/api/app_event?aid=377365825&type=1
//说明:    获取应用详细的推荐、愿望清单及讨论列表(3个API合并)


-(void)requestAppInfoRWDWithAppID:(NSString *)appID WithType:(NSString *)typeID WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//     NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:appID, @"aid", typeID,  @"type", page, @"p", nil];
    if (self.isShowActivity) {
        [self startingActivityView];
    }
    NSString *str = [NSString stringWithFormat:@"app_event?aid=%@&type=%@&p=%@",appID, typeID, page];
    [RSHTTPMANAGER getContentsWithPath:str paramters:nil success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        DLog(@"responseData==%@",responseData);
//        if ([responseData count]) {
            NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
        if ([typeID isEqualToString:@"4"]) {
            mutableList = [NSMutableArray arrayWithArray:[AppReplyInfo instancesFromJsonArray:responseData]];
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
        }else{
            for (NSDictionary *attributes in responseData) {
                AppInfoRWDModel *appInfo = [AppInfoRWDModel instancefromJsonDic:attributes];
                appInfo.user = [UserInfo instancefromJsonDic:[attributes valueForKeyPath:@"user"]];
                [mutableList addObject:appInfo];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableList]);
            }
        }
        [self stopActivityView];
//        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
    
}
//http://www.guo7.com/api/app_event?uid=480&aid=420635506&type=4&p=0
-(void)requestAppInfoRWDWithAppID:(NSString *)appID userId:(NSString *)uId WithType:(NSString *)typeID WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    //     NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:appID, @"aid", typeID,  @"type", page, @"p", nil];
    if (self.isShowActivity) {
        [self startingActivityView];
    }
    NSString *str = [NSString stringWithFormat:@"app_event?uid=%@&aid=%@&type=%@&p=%@",uId,appID, typeID, page];
    [RSHTTPMANAGER getContentsWithPath:str paramters:nil success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        DLog(@"responseData==%@",responseData);
        //        if ([responseData count]) {
        NSMutableArray *mutableList = [NSMutableArray arrayWithCapacity:[responseData count]];
        mutableList = [NSMutableArray arrayWithArray:[AppReplyInfo instancesFromJsonArray:responseData]];
        if (success) {
            success([NSArray arrayWithArray:mutableList]);
        }
        [self stopActivityView];
        //        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
    
}

/*
 获取app详细信息
 http://www.guo7.com/api/appinfo?aid=1&uid=17
 appId：app id
 */
-(void)requestAppDetailsWitiAppId:(NSString *)appId andUid:(NSString *)strUid WithSuccess:(void (^)(AppDetailsInfo *))success failure:(void (^)(NSError *))failure{

    if (self.isShowActivity) {
        [RSHTTPMANAGER startingActivityView];
    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:appID, @"aid", typeID,  @"type", page, @"p", nil];
    NSString *endPoint = [strUid length] > 0 ? [NSString stringWithFormat:@"appinfo?aid=%@&uid=%@",appId,strUid] : [NSString stringWithFormat:@"appinfo?aid=%@",appId];
    [RSHTTPMANAGER getContentsWithPath:endPoint paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",responseData);
//            DLog(@"developer==%@",[responseData objectForKey:@"seller_name"]);
//            DLog(@"utf-8string==%@",[self UTF8_To_GB2312:[responseData objectForKey:@"description"]]);
//            DLog(@"utf-8string==%@",[self UTF8_To_GB2312:[responseData objectForKey:@"primary_genre_name"]]);
//            DLog(@"utf-8string==%@",[self UTF8_To_GB2312:[responseData objectForKey:@"recommended_age"]]);
//            DLog(@"utf-8string==%@",[self UTF8_To_GB2312:[responseData objectForKey:@"release_notes"]]);
//            DLog(@"utf-8string==%@",[self UTF8_To_GB2312:[responseData objectForKey:@"language_code"]]);
            
            AppDetailsInfo *appDetailsInfo = [AppDetailsInfo instancefromJsonDic:responseData];
            
            NSArray *types = [[responseData objectForKey:@"screenshot_url"] allKeys];
            NSString *strKey = nil;
            if ([APPDELEGATE devicetype] == iPhone || [APPDELEGATE devicetype] == iPodtouch) {
                if ([types containsObject:@"iPhone"]) {
                    strKey = @"iPhone";
                }
            }else if ([APPDELEGATE devicetype] == iPad) {
                if ([types containsObject:@"iPad"]) {
                    strKey = @"iPad";
                }
            }
            
            if (!strKey) {
                strKey = [[[responseData objectForKey:@"screenshot_url"] allKeys] objectAtIndex:0];
            }
            
            if ([strKey caseInsensitiveCompare:@"iPhone"] == NSOrderedSame) {
                appDetailsInfo.devicetypeFit = fitIphone;
            }else if([strKey caseInsensitiveCompare:@"iPad"] == NSOrderedSame){
                appDetailsInfo.devicetypeFit = fitIpad;
            }else if ([strKey caseInsensitiveCompare:@"Mac"] == NSOrderedSame){
                appDetailsInfo.devicetypeFit = fitMac;
            }
            appDetailsInfo.arrIphoneScreenshots = [responseData valueForKeyPath:[NSString stringWithFormat:@"screenshot_url.%@",strKey]];
            appDetailsInfo.arrTags = [responseData valueForKeyPath:@"tags"];//arrTags contents is nsdictionary
            if (success) {
                success(appDetailsInfo);
                [RSHTTPMANAGER stopActivityView];
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}


/*
 获取App 价格 走势列表
 http://www.guo7.com/api/price_version_change?aid=493136154
 appId : app id
 */

-(void)requestAppPriceChangeWitiAppId:(NSString *)appId WithSuccess:(void (^)(NSArray *arrPriceList))success failure:(void (^)(NSError *_err))failure{
    if (self.isShowActivity) {
        [self startingActivityView];
    }
    NSString *endPoint = [NSString stringWithFormat:@"%@%@",@"price_version_change?aid=",appId];
    [RSHTTPMANAGER getContentsWithPath:endPoint paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",responseData);
            DLog(@"--------time:%@  version==%@",[self UTF8_To_GB2312:[[responseData objectAtIndex:0] valueForKey:@"price_name"]],[self UTF8_To_GB2312:[[responseData objectAtIndex:0] valueForKey:@"version"]]);
            NSArray *priceList = [AppPrice instancesFromJsonArray:responseData];
            if (success) {
               success([NSArray arrayWithArray:priceList]);
            }
        }
        [self stopActivityView];
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

/*
 获取App 价格 走势统计
 http://www.guo7.com/api/price_statistics?aid=493136154
 appId : app id
 */

-(void)requestAppPriceStatisticWitiAppId:(NSString *)appId WithSuccess:(void (^)(AppPriceStatistic *appPriceStatistic))success failure:(void (^)(NSError *_err))failure{
    NSString *endPoint = [NSString stringWithFormat:@"%@%@",@"price_statistics?aid=",appId];
    [RSHTTPMANAGER getContentsWithPath:endPoint paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",responseData);
            AppPriceStatistic *priceStatistic = [AppPriceStatistic instancefromJsonDic:responseData];
            if (success) {
                success(priceStatistic);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* gb2312data = [utf8string dataUsingEncoding:encoding];
    return [[NSString alloc] initWithData:gb2312data encoding:encoding];
}


//http://www.guo7.com/api/login?email=549858687@qq.com&passwd=1111

+ (void)requestLoginWithEmail:(NSString *)email WithPasswd:(NSString *)passwd WithSuccess:(void (^)(NSArray *loginInfo))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", passwd, @"passwd", nil];
    [RSHTTPMANAGER postContentsWithPath:@"login?" paramters:param success:^(id responseObject) {
        if (success) {
            NSLog(@"ssss///wwww//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
                success(nil);
            }else{
                id responseData = AFJSONDecode(responseObject, nil);
                LoginInfoModel *login = [LoginInfoModel instancefromJsonDic:responseData];
                login.user_id = [responseData valueForKey:@"id"];
                success([NSArray arrayWithObject:login]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}



-(void)requestZanWithEvent_id:(NSString *)event_id WithUid:(NSString *)uid WithSuccess:(void (^)(BOOL isSuccess))success failure:(void (^)(NSError *))failure{
    if (self.isShowActivity) {
        [self startingActivityView];
    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:event_id, @"event_id", uid, @"uid", nil];
    
    NSString *path = [NSString stringWithFormat:@"like?uid=%@&event_id=%@",uid,event_id];

    
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"zan///wwww//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
                [SVProgressHUD showSuccessWithStatus:@"赞成功"];
            }else{
                success(NO);
                [SVProgressHUD showErrorWithStatus:@"赞失败"];
            }
//            [self stopActivityView];
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"zan\\\\\\%@",error.localizedDescription);
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

- (void)requestUnZanWithEvent_id:(NSString *)event_id WithUid:(NSString *)uid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    if (self.isShowActivity) {
        [self startingActivityView];
    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:event_id, @"event_id", uid, @"uid", nil];
    
    NSString *path = [NSString stringWithFormat:@"unlike?uid=%@&event_id=%@",uid,event_id];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"zan///wwww//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
                [SVProgressHUD showSuccessWithStatus:@"取消赞成功"];
            }else{
                success(NO);
                [SVProgressHUD showErrorWithStatus:@"取消赞失败"];
            }
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"zan\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}

+ (void)requestRegisterWithEmail:(NSString *)email WithPasswd:(NSString *)passwd WithNickName:(NSString *)nick_name WithCity_id:(NSString *)city_id WithCity_name:(NSString *)city_name WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:email, @"email", passwd, @"passwd",  nick_name, @"nick_name", city_id, @"city_id",  city_name, @"city_name", nil];
    
    [RSHTTPMANAGER postContentsWithPath:@"register?" paramters:param success:^(id responseObject) {
        if (success) {
             NSLog(@"respond//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
                success(nil);
            }else{
                id responseData = AFJSONDecode(responseObject, nil);
                NSLog(@"//////////:%@",responseData);
                LoginInfoModel *model = [LoginInfoModel instancefromJsonDic:responseData];
                success([NSArray arrayWithObject:model]);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}


+ (void)requestResponseWithUId:(NSString *)uid WithEvent_id:(NSString *)event_id WithContent:(NSString *)content WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", event_id, @"event_id", content, @"content", nil];
    NSLog(@"param:%@",param);
    [RSHTTPMANAGER postContentsWithPath:@"new_response?" paramters:param success:^(id responseObject) {
        if (success) {
            NSLog(@"respond//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);

            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}




- (void)requestUserDynamicWithUid:(NSString *)uid WithLoginID:(NSString *)login_uid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    if (self.isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", page, @"p",login_uid, @"login_uid", nil];
    NSString *path = [NSString stringWithFormat:@"get_user_feed?uid=%@&login_uid=%@&p=%@",uid,login_uid,page];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
            if (success) {
                id responseData = AFJSONDecode(responseObject, nil);
                //            NSLog(@"/////%@",responseData);
                NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
                for (NSDictionary *attributes in responseData) {
                    SquareModel *square = [SquareModel instancefromJsonDic:attributes];
                    [mutableSquareList addObject:square];
                }
                if (success) {
                    success([NSArray arrayWithArray:mutableSquareList]);
                }
//                [self stopActivityView];
            }else{
                [SVProgressHUD showErrorWithStatus:@"ERROR"];
            }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}


- (void)requestUserRecommendWithUid:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    if (self.isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",login_uid, @"login_uid", nil];
    
    NSString *path = [NSString stringWithFormat:@"get_user_recommend?uid=%@&login_uid=%@",uid,login_uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                SquareModel *square = [SquareModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:square];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
//            [self stopActivityView];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}



//讨论列表
//http://www.guo7.com/api/get_user_discuss?uid＝用户ID
- (void)requestCommentWithUID:(NSString *)uid WithLoginID:(NSString *)login_uid WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    if (isShowActivity) {
//        [self startingActivityView];
//    }
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",login_uid,@"login_uid", nil];
    NSString *path = [NSString stringWithFormat:@"get_user_discuss?uid=%@&login_uid=%@",uid,login_uid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                SquareModel *square = [SquareModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:square];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
//            [self stopActivityView];
        }else{
//            [SVProgressHUD showErrorWithStatus:@"ERROR"];
        }
    } failure:^(NSError *error) {
        NSLog(@"\\\\\\%@",error.localizedDescription);
        failure(error);
        [SVProgressHUD showErrorWithStatus:error.localizedDescription];
    }];
}


/*
 app 分享列表获取
 http://www.guo7.com/api/share?uid=10
 userId:user id
 */

-(void)requestShareBlogListWithUserId:(NSString *)userId WithSuccess:(void (^)(NSArray *arrShare))success failure:(void (^)(NSError *_err))failure{
    NSString *endPoint = [NSString stringWithFormat:@"%@%@",@"share?uid=",userId];
    [RSHTTPMANAGER getContentsWithPath:endPoint paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",responseData);
            
            NSArray *arrShareL = [AppShareModel instancesFromJsonArray:responseData];
            if (success) {
                success(arrShareL);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/*
 app 分享
 http://www.guo7.com/api/post_recommend
 uid,aid,content
 sina_weibo,qqwb_weibo,douban_weibo
 */
-(void)shareBlogWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure{
    NSString *endPoint = @"post_recommend";
    [RSHTTPMANAGER postContentsWithPath:endPoint paramters:dictPar success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",responseData);
            NSString *strResult = [responseData objectForKey:@"msg"];
            if ([strResult caseInsensitiveCompare:@"OK"] == NSOrderedSame) {
                success(TRUE);
            }else{
                success(FALSE);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}

/*
 添加app到愿望清单
 http://www.guo7.com/api/remind
 uid,aid
 */
-(void)addAppToWishlistWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *_err))failure{
    if (self.isShowActivity) {
        [self startingActivityView];
    }
    NSString *endPoint = @"remind";
    DLog(@"dictPar==%@",dictPar);
    [RSHTTPMANAGER postContentsWithPath:endPoint paramters:dictPar success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            DLog(@"responseData==%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            NSString *strResult = [responseData objectForKey:@"msg"];
            if ([strResult intValue] == 1) {
                success(TRUE);
            }else{
                success(FALSE);
            }
            [self stopActivityView];
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
            [SVProgressHUD showErrorWithStatus:error.localizedDescription];
        }
    }];
}

/*
 对App进行讨论回复
 http://www.guo7.com/api/new_discuss
 uid: user id
 application_id: app id
 content:讨论内容
 */
-(void)addDiscussionToAppWithParameters:(NSDictionary *)dictPar WithSuccess:(void (^)(AppDiscussion *discussion))success failure:(void (^)(NSError *_err))failure{
    NSString *endPoint = @"new_discuss";
    DLog(@"dictPar==%@",dictPar);
    [RSHTTPMANAGER postContentsWithPath:endPoint paramters:dictPar success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        DLog(@"responseData==++++++++%@",responseData);
        AppDiscussion *appDis = [AppDiscussion instancefromJsonDic:responseData];
        appDis._id = [responseData valueForKeyPath:@"_id.$id"];
        
        if (success) {
            success(appDis);
        }else{
            success(appDis);
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"\\\\\\%@",error.localizedDescription);
        }
    }];
}

//单例私信列表
//说明:    获取任何用户的私信详细
//URL:  /api/get_chat?uid=用户id&origin_user_id=用户id&p=1
+ (void)requestDialoguesWithUID:(NSString *)uid WithUser:(NSString *)uuid WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", uuid, @"origin_user_id", page, @"p", nil];
    NSString *path = [NSString stringWithFormat:@"get_chat?uid=%@&origin_user_id=%@&p=%@",uid,uuid,page];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                DialogueModel *dialogue = [DialogueModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:dialogue];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"\\\\\\%@",error.localizedDescription);
        failure(error);
    }];
}

//发送私信
//URL:  /api/send_message
//HTTP请求方式:    POST
//uid
//target_user_id
//content

+ (void)requestSendDialogueWithUID:(NSString *)uid WithTargetUID:(NSString *)targetID WithContent:(NSString *)content WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *))failure{
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", targetID, @"target_user_id", content, @"content", nil];
    NSLog(@"param:%@",params);
    [RSHTTPMANAGER postContentsWithPath:@"send_message?" paramters:params success:^(id responseObject) {
        if (success) {
            NSLog(@"respond//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        failure(error);
    }];
    
    
}

//URL:  /api/search?str=关键词
- (void)requestSearchAppWithStr:(NSString *)str WithDevice:(NSString *)device WithSort:(NSString *)sort WithPage:(NSString *)page WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSLog(@"device:%@",device);
    NSLog(@"str:%@",str);
    NSLog(@"sort:%@",sort);
    
    NSString *tmpStr = [[NSString stringWithFormat:@"search?str=%@&device=%@&sort=%@&p=%@",str, device, sort, page] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:str, @"str", device, @"device", sort, @"sort", page, @"p", nil];
//    NSLog(@"......%@",params);
    [RSHTTPMANAGER getContentsWithPath:tmpStr paramters:nil success:^(id responseObject) {
        if (success) {
            id responseData = AFJSONDecode(responseObject, nil);
//            NSLog(@"/////%@",responseData);
            NSMutableArray *mutableSquareList = [NSMutableArray arrayWithCapacity:[responseData count]];
            for (NSDictionary *attributes in responseData) {
                SearchAppModel *searchModel = [SearchAppModel instancefromJsonDic:attributes];
                [mutableSquareList addObject:searchModel];
            }
            if (success) {
                success([NSArray arrayWithArray:mutableSquareList]);
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"\\\\\\%@",error.localizedDescription);
        failure(error);
    }];
}

//好友 添加关注/取消关注
//说明:   好友之间的关注操作
//URL:  /api/(follow|unfollow)?uid=用户ID&following_uid=对象ID
//GET /api/(follow)?uid=1&following_uid=10    //关注
//GET /api/(unfollow)?uid=1&following_uid=10    //取消关注
- (void)requestFollowPeopleWithUID:(NSString *)uid WithFollwingID:(NSString *)fuid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", fuid, @"following_uid", nil];
    NSString *path = [NSString stringWithFormat:@"follow?uid=%@&following_uid=%@",uid,fuid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"添加关注//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"添加关注\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];

}


- (void)requestUnFollowPeopleWithUID:(NSString *)uid WithFollwingID:(NSString *)fuid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", fuid, @"following_uid", nil];
    NSString *path = [NSString stringWithFormat:@"unfollow?uid=%@&following_uid=%@",uid,fuid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"取消关注//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"取消关注\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];

}

//
//删除单条私信
//说明:    好友之间单条私信删除
//URL:  /api/remove_message?message_id=私信编号
- (void)requestDelSimpleMSGWithMSGID:(NSString *)mid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:mid, @"message_id",nil];
    NSString *path = [NSString stringWithFormat:@"remove_message?message_id=%@",mid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"删除单条私信//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"删除单条私信\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}

//删除全部私信
//说明:    好友之间全部私信删除
//URL:  /api/removeall_message?uid=用户ID&target_user_id=对象好友

- (void)requestDelALLMSGWithUID:(NSString *)uid WithTargetUID:(NSString *)tuid WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
//    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid",tuid, @"target_user_id",nil];
    NSString *path = [NSString stringWithFormat:@"removeall_message?uid=%@&target_user_id=%@",uid,tuid];

    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            NSLog(@"删除全部私信//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
                success(YES);
            }else{
                success(NO);
            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            NSLog(@"删除全部私信\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
}

- (void)registePushDeviceTokenID:(NSString *)uid WithTokenID:(NSString *)token WithSuccess:(void (^)(BOOL))success failure:(void (^)(NSError *))failure{
    NSLog(@"uid:%@",uid);
    NSLog(@"token:%@",token);
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uid, @"uid", token, @"device_token",  nil];
  
    [RSHTTPMANAGER postContentsWithPath:@"push_device_token?" paramters:param success:^(id responseObject) {
        if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"fail"]) {
            success(NO);
        }else{
            success(YES);
        }

    } failure:^(NSError *error) {
        
    }];
}

- (void)getNoticationWithType:(NSString *)type WithUserId:(NSString *)uId WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uId, @"uid", type, @"type",  nil];
    
    [RSHTTPMANAGER getContentsWithPath:@"notification?" paramters:param success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        NSLog(@"/////%@",responseData);
        
        
        success([NSArray arrayWithArray:responseData]);

    } failure:^(NSError *error) {
        
    }];

}


- (void)clearNoticationWithMID:(NSString *)mid WithUserId:(NSString *)uId WithSuccess:(void (^)(NSArray *))success failure:(void (^)(NSError *))failure{
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:uId, @"uid", mid, @"message_id",  nil];
    
    [RSHTTPMANAGER getContentsWithPath:@"markAs_read?" paramters:param success:^(id responseObject) {
        id responseData = AFJSONDecode(responseObject, nil);
        NSLog(@"/////%@",responseData);
        
        
        success([NSArray arrayWithArray:responseData]);
        
    } failure:^(NSError *error) {
        
    }];

}

//获得私信
- (void)sx_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure{
    
    NSString *path = [NSString stringWithFormat:@"notification?uid=%@&type=4",uid];
    
    NSLog(@"%@",path);
    
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            //            NSLog(@"添加关注//////:%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            
            //            if ([[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"success"]) {
            //                success(YES);
            //            }else{
            //                success(NO);
            //            }
        }
    } failure:^(NSError *error) {
        if (failure) {
            //            NSLog(@"添加关注\\\\\\%@",error.localizedDescription);
            failure(error);
        }
    }];
    
}

-(void)tj_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"notification?uid=%@&type=3",uid];
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)gz_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"notification?uid=%@&type=2",uid];
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

-(void)wantlist_notifcationMessage:(NSString *)uid WithSuccess:(void (^)(BOOL isSucceed))success failure:(void (^)(NSError *error))failure{
    NSString *path = [NSString stringWithFormat:@"notification?uid=%@&type=1",uid];
    [RSHTTPMANAGER getContentsWithPath:path paramters:nil success:^(id responseObject) {
        if (success) {
            
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end









