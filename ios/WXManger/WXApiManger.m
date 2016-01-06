//
//  WXApiManger.m
//  RCTShare
//
//  Created by 李雨龙 on 16/1/4.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "WXApiManger.h"
#import "WXApi.h"
#import "WXApiObject.h"
#define Type @"type"
#define OpenID @"openID"
@implementation WXApiManger
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(isWXAppInstalled:(RCTResponseSenderBlock) result ){
  result(@[@([WXApi isWXAppInstalled])]);
}
RCT_EXPORT_METHOD(getApiVersion:(RCTResponseSenderBlock) result ){
  
  result(@[[WXApi getApiVersion]]);
}
RCT_EXPORT_METHOD(openWXApp:(RCTResponseSenderBlock) result){
  result(@[@([WXApi openWXApp])]);
}
/*
    @{
      @"type":@(1),
      @"body":@{}
    }
 */
RCT_EXPORT_METHOD(sendReq:(NSDictionary *) req callBack:(RCTResponseSenderBlock) callBack){
  WXReqType type = [req[ Type] intValue];

  NSDictionary * body = req[@"body"];
  WXApiReq *_wxReq ;
  switch (type) {
    case WXReqTypeDefault:
      _wxReq = [[WXApiReq alloc] initWithDict:body];
      break;
    case WXReqTypeImage:
      _wxReq = [[WXApiImageReq alloc] initWithDict:body];
      break;
      
    case WXReqTypeVideo:
      _wxReq = [[WXApiVideoReq alloc] initWithDict:body];
      break;
      
      case WXReqTypeMusic:
      _wxReq = [[WXApiMusicReq alloc] initWithDict:body];
      break;
      case WXReqTypeWeb:
      _wxReq = [[WXApiWebReq alloc] initWithDict:body];
      break;
    default:
      break;
  }
  callBack(@[ @([_wxReq startShare]) ]);
}
-(NSDictionary<NSString *,id> *)constantsToExport{

  return @{
           @"WXSceneSession":@(WXSceneSession),
           @"WXSceneTimeline":@(WXSceneTimeline),
           @"WXSceneFavorite":@(WXSceneFavorite),
           
           //
           @"WXReqTypeText":@(WXReqTypeText),
           @"WXReqTypeImage":@(WXReqTypeImage),
           @"WXReqTypeMusic":@(WXReqTypeMusic),
           @"WXReqTypeVideo":@(WXReqTypeVideo),
           @"WXReqTypeWeb":@(WXReqTypeWeb),
           @"WXReqTypeDefault":@(WXReqTypeDefault)
           };
}
@end
@implementation RCTConvert (WXReqScene)

RCT_ENUM_CONVERTER(
                   WXReqScene,
                   (@{
                      @"WXSceneSession":@(WXReqSceneSession),
                      @"WXSceneTimeline":@(WXReqSceneTimeline),
                      @"WXSceneFavorite":@(WXReqSceneFavorite)
                      }),
                   WXSceneSession,
                   intValue)

@end

@implementation RCTConvert (WXReqType)

RCT_ENUM_CONVERTER(
                   WXReqType,
                   (@{
                      @"WXReqTypeText":@(WXReqTypeText),
                      @"WXReqTypeImage":@(WXReqTypeImage),
                      @"WXReqTypeMusic":@(WXReqTypeMusic),
                      @"WXReqTypeVideo":@(WXReqTypeVideo),
                      @"WXReqTypeWeb":@(WXReqTypeWeb),
                      @"WXReqTypeDefault":@(WXReqTypeDefault)
                      }),
                   WXSceneSession,
                   integerValue)

@end

/*
 @{
 bText:@(bool),
 message:@{...,@"object":@{}},
 scene :@(scene),
 
 }
*/

@implementation WXApiReq
@synthesize req = _req;

-(instancetype)initWithDict:(NSDictionary *) dict{
  if (self =[super init]) {
    _shareData = [dict copy];
  }
  return self;
}
-(BOOL)startShare{
  NSDictionary * dict = _shareData;
  NSDictionary * message = dict[@"message"];
  if (message) {
    
    [self handleMessage:message];
  }
  
  NSDictionary * media = message[@"object"];
  if (media) {
    [self handleMedia:media];
  }
  
  [self handleReq:dict];
return   [WXApi sendReq:_req];
  
}
-(void)handleMessage:(NSDictionary *) message{
  
}
-(void)handleMedia:(NSDictionary *) media{
  
}
-(void)handleReq:(NSDictionary *) req{
  _req = [[SendMessageToWXReq alloc] init];
  NSString * text = [req[@"text"] description];
  BOOL bText = [req[@"bText"] boolValue];
  int scene = [req[@"scene"] intValue];
  SendMessageToWXReq * tmpReq = (SendMessageToWXReq *)_req;
  tmpReq.text = text;
  tmpReq.bText = bText;
  tmpReq.scene = scene;
 
  if (_wxMessage) {
    
    if (_wxObject) {
      
      _wxMessage.mediaObject = _wxObject;
    }
    tmpReq.message = (WXMediaMessage *)_wxMessage;
  }
}
@end

@implementation WXApiTextReq
-(instancetype)initWithDict:(NSDictionary *)dict{
  return [super initWithDict:dict];
}
@end

/*
 
 @{
   @"thumbImage":@"thumbImage Name",
 @"thumbData":@"thumbData",
 
 }
 
 */
@implementation WXApiImageReq
-(void)handleMessage:(NSDictionary *)message{
  _wxMessage = [WXMediaMessage message] ;
  NSString * thumbImage = message[@"thumbImage"];
  if (thumbImage) {
    [_wxMessage setThumbImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.png",thumbImage]]];
  }
  NSData * thumbData = message[@"thumbData"];
  if (thumbData) {
    [_wxMessage setThumbData:thumbData];
  }
}

/*
 @{
 @"imageUrl":@" url",
 @"imageData":@""
 }
 */
-(void)handleMedia:(NSDictionary *)media{
  if (media.allKeys.count <= 0) {
    return;
  }
  NSString * imageUrl = media[@"imageUrl"];
  WXImageObject * imgObject= [WXImageObject object];
  if (imageUrl) {
    imgObject.imageUrl = imageUrl;
  }
  NSData * imageData = media[@"imageData"];
  if (imageData) {
    imgObject.imageData = imageData;
  }
  _wxObject = imgObject ;
}
@end

@implementation WXApiMusicReq
-(void)handleMessage:(NSDictionary *)message{
  
}
-(void)handleMedia:(NSDictionary *)media{
  
}
@end

/*
 @{
 @"title":@"title",
 @"description":@"desc",
 @"thumbImage":@"thumbImage Name",
 }
 */
@implementation WXApiVideoReq
-(void)handleMessage:(NSDictionary *)message{
  _wxMessage = [WXMediaMessage message];
  NSString * title = message[@"title"];
  if (title) {
    _wxMessage.title = title;
  }
  NSString * descption = message[@"descption"];
  if (descption) {
    _wxMessage.description = descption;
  }

  
}
-(void)handleMedia:(NSDictionary *)media{
  
}

@end


@implementation WXApiWebReq
/*
 @{
    @"title":@"title",
    @"description":@"description",
    @"thumbImage":@"thumbImageName"
 }
 */
-(void)handleMessage:(NSDictionary *)message{
    _wxMessage = [WXMediaMessage message];
    _wxMessage.title = [message[@"title"] description];
    _wxMessage.description = [message[@"description"] description];
    NSString * thumnImageName = message[@"thumbImage"];
    if (thumnImageName) {
        
        [_wxMessage setThumbImage:[UIImage imageNamed:thumnImageName]];
    }
}
/*
 @{
    @"webpageUrl":@"page url string",
 }
 */
-(void)handleMedia:(NSDictionary *)media{
  if (media.allKeys.count <= 0) {
    return;
  }
  _wxObject = [WXWebpageObject object];
  NSString * webpageUrl = media[@"webpageUrl"];
  if (webpageUrl) {
    WXWebpageObject * webObject = (WXWebpageObject *) _wxObject;
    webObject.webpageUrl = webpageUrl;
  }
}

@end
