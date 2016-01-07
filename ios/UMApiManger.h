//
//  UMApiManger.h
//  RCTShare
//
//  Created by 李雨龙 on 16/1/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCTBridgeModule.h"
#import "RCTConvert.h"
#import "RCTUtils.h"
#import "UMSocialSnsService.h"

@interface UMApiManger : NSObject<RCTBridgeModule,UMSocialUIDelegate,UIActionSheetDelegate>

@end

@interface RCTConvert (umSocialSnsType)

@end