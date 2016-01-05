//
//  WXApiManger.h
//  RCTShare
//
//  Created by 李雨龙 on 16/1/4.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import "RCTConvert.h"
#import "WXApiObject.h"
@class BaseReq;
@class WXMediaMessage;
typedef NS_ENUM(NSInteger, WXReqType) {
  WXReqTypeText = 0,
  WXReqTypeImage = 1,
  WXReqTypeMusic =2,
  WXReqTypeVideo = 3,
  WXReqTypeWeb = 4,
  WXReqTypeDefault = WXReqTypeText
};

//enum WXScene {
//  WXSceneSession  = 0,        /**< 聊天界面    */
//  WXSceneTimeline = 1,        /**< 朋友圈      */
//  WXSceneFavorite = 2,        /**< 收藏       */
//};
typedef NS_ENUM(NSInteger, WXReqScene) {
  WXReqSceneSession = WXSceneSession,
 WXReqSceneTimeline  = WXSceneTimeline ,
 WXReqSceneFavorite = WXSceneFavorite
};
@interface WXApiManger : NSObject<RCTBridgeModule>

@end


@interface RCTConvert (WXReqScene)

@end
@interface RCTConvert (WXReqType)

@end

@interface WXApiReq : NSObject
{
  WXMediaMessage * _wxMessage;
   NSObject * _wxObject;
  NSDictionary * _shareData;
}
@property(readonly, nonatomic) BaseReq * req;
@property(readonly, nonatomic) NSObject * wxObject;
@property(readonly, nonatomic) WXMediaMessage * wxMessage;
-(instancetype)initWithDict:(NSDictionary *) dict;
-(BOOL) startShare;
-(void)handleMessage:(NSDictionary *) message;
//-(void)handleReq:(NSDictionary *) req;
-(void)handleMedia:(NSDictionary *) media;

@end

@interface WXApiTextReq : WXApiReq
-(instancetype)initWithDict:(NSDictionary *) dict;
@end

@interface WXApiImageReq : WXApiReq

@end

@interface WXApiMusicReq : WXApiReq

@end

@interface WXApiVideoReq : WXApiReq

@end

@interface WXApiWebReq : WXApiReq

@end