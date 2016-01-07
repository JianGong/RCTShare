//
//  UMApiManger.m
//  RCTShare
//
//  Created by 李雨龙 on 16/1/7.
//  Copyright © 2016年 Facebook. All rights reserved.
//

#import "UMApiManger.h"
#import "AppDelegate.h"
#import "UMSocial.h"

#define kTagShareEdit 101
#define kTagSharePost 102

@implementation UMApiManger
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(shareText:(NSString *) shareText shareImageName:(NSString *) imageNamed shareToSnsNames:(NSArray *)snsNames ){
  UIImage *shareImage = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"shop" ofType:@"png"]];

UIViewController * rootController =  RCTKeyWindow().rootViewController;
  
  
  //iOS8下使用UIAlertController
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
  if([[UIDevice currentDevice].systemVersion floatValue] >= 8.0){
    
    UIAlertControllerStyle alertStyle = UIAlertControllerStyleActionSheet;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
      alertStyle = UIAlertControllerStyleAlert;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"图文分享" message:@"图文分享" preferredStyle: alertStyle ];
    for (NSNumber *type in snsNames) {
      UMSocialSnsPlatform *snsPlatform = [self getSocialPlatformBy:(int)type.intValue];
      UIAlertAction *alertAction = [UIAlertAction actionWithTitle:snsPlatform.displayName style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //设置分享内容，和回调对象
        NSString *shareText = @"友盟社会化组件可以让移动应用快速具备社会化分享、登录、评论、喜欢等功能，并提供实时、全面的社会化数据统计分析服务。 http://www.umeng.com/social";
        UIImage *shareImage = [UIImage imageNamed:@"UMS_social_demo"];
        
        [[UMSocialControllerService defaultControllerService] setShareText:shareText shareImage:shareImage socialUIDelegate:nil];
        UMSocialSnsPlatform *snsPlatform = [self getSocialPlatformBy:(int)type.integerValue];
        snsPlatform.snsClickHandler(rootController,[UMSocialControllerService defaultControllerService],YES);
      }];
      [alertController addAction:alertAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
      [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    UIPopoverPresentationController *popover = alertController.popoverPresentationController;
    if (popover)
    {
      popover.sourceView = rootController.view;
      popover.sourceRect = rootController.view.bounds;
      popover.permittedArrowDirections = UIPopoverArrowDirectionAny;
    }
    [rootController presentViewController:alertController animated:YES completion:nil];
  } else {
#endif
    UIActionSheet * editActionSheet = [[UIActionSheet alloc] initWithTitle:@"图文分享" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    for (NSNumber *type in snsNames) {
      UMSocialSnsPlatform *snsPlatform = [self getSocialPlatformBy:type.intValue];
      [editActionSheet addButtonWithTitle:snsPlatform.displayName];
    }
    [editActionSheet addButtonWithTitle:@"取消"];
    editActionSheet.tag = kTagShareEdit;
    [editActionSheet showInView:rootController.view];
    editActionSheet.delegate = self;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 80000
  }
#endif
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{

}
- (UMSocialSnsPlatform *)getSocialPlatformBy:(UMSocialSnsType) socialSnsType{
  NSString * snsName = [UMSocialSnsPlatformManager getSnsPlatformString: socialSnsType];
  
  return   [UMSocialSnsPlatformManager getSocialPlatformWithName: snsName ];
}

-(NSDictionary<NSString *,id> *)constantsToExport{
  return @{
           @"UMSocialSnsTypeNone":@(UMSocialSnsTypeNone),
           @"UMSocialSnsTypeSina":@(UMSocialSnsTypeSina),
           @"UMSocialSnsTypeTenc":@(UMSocialSnsTypeTenc),
           @"UMSocialSnsTypeRenr":@(UMSocialSnsTypeRenr),
           
           @"UMSocialSnsTypeDouban":@(UMSocialSnsTypeDouban),
           @"UMSocialSnsTypeRenr":@(UMSocialSnsTypeRenr),
           @"UMSocialSnsTypeWechatSession":@(UMSocialSnsTypeWechatSession),
           @"UMSocialSnsTypeWechatTimeline":@(UMSocialSnsTypeWechatTimeline),
           
           
           @"UMSocialSnsTypeWechatFavorite":@(UMSocialSnsTypeWechatFavorite),
           @"UMSocialSnsTypeEmail":@(UMSocialSnsTypeEmail),
           @"UMSocialSnsTypeSms":@(UMSocialSnsTypeSms),
           @"UMSocialSnsTypeMobileQQ":@(UMSocialSnsTypeMobileQQ),
           
           
           @"UMSocialSnsTypeFacebook":@(UMSocialSnsTypeFacebook),
           @"UMSocialSnsTypeTwitter":@(UMSocialSnsTypeTwitter),
           @"UMSocialSnsTypeYiXinSession":@(UMSocialSnsTypeYiXinSession),
           @"UMSocialSnsTypeYiXinTimeline":@(UMSocialSnsTypeYiXinTimeline),
           
           
           @"UMSocialSnsTypeLaiWangSession":@(UMSocialSnsTypeLaiWangSession),
           @"UMSocialSnsTypeLaiWangTimeline":@(UMSocialSnsTypeLaiWangTimeline),
           @"UMSocialSnsTypeInstagram":@(UMSocialSnsTypeInstagram),
           @"UMSocialSnsTypeWhatsApp":@(UMSocialSnsTypeWhatsApp),
           
           
           @"UMSocialSnsTypeLine":@(UMSocialSnsTypeLine),
           @"UMSocialSnsTypeTumblr":@(UMSocialSnsTypeTumblr),
           @"UMSocialSnsTypeKakaoTalk":@(UMSocialSnsTypeKakaoTalk),
           @"UMSocialSnsTypeFlickr":@(UMSocialSnsTypeFlickr),
           
           @"UMSocialSnsTypePinterest":@(UMSocialSnsTypePinterest),
           @"UMSocialSnsTypeAlipaySession":@(UMSocialSnsTypeAlipaySession),
           @"UMSocialSnsTypeNew":@(UMSocialSnsTypeNew)
           
           };
}
@end


@implementation RCTConvert (umSocialSnsType)

RCT_ENUM_CONVERTER(UMSocialSnsType,
                   (@{
                      @"UMSocialSnsTypeNone":@(UMSocialSnsTypeNone),
                      @"UMSocialSnsTypeSina":@(UMSocialSnsTypeSina),
                      @"UMSocialSnsTypeTenc":@(UMSocialSnsTypeTenc),
                      @"UMSocialSnsTypeRenr":@(UMSocialSnsTypeRenr),
                      
                      @"UMSocialSnsTypeDouban":@(UMSocialSnsTypeDouban),
                      @"UMSocialSnsTypeRenr":@(UMSocialSnsTypeRenr),
                      @"UMSocialSnsTypeWechatSession":@(UMSocialSnsTypeRenr),
                      @"UMSocialSnsTypeWechatTimeline":@(UMSocialSnsTypeWechatTimeline),

                      
                      @"UMSocialSnsTypeWechatFavorite":@(UMSocialSnsTypeWechatFavorite),
                      @"UMSocialSnsTypeEmail":@(UMSocialSnsTypeEmail),
                      @"UMSocialSnsTypeSms":@(UMSocialSnsTypeSms),
                      @"UMSocialSnsTypeMobileQQ":@(UMSocialSnsTypeMobileQQ),
                      
                      
                      @"UMSocialSnsTypeFacebook":@(UMSocialSnsTypeFacebook),
                      @"UMSocialSnsTypeTwitter":@(UMSocialSnsTypeTwitter),
                      @"UMSocialSnsTypeYiXinSession":@(UMSocialSnsTypeYiXinSession),
                      @"UMSocialSnsTypeYiXinTimeline":@(UMSocialSnsTypeYiXinTimeline),
                    
                      
                      @"UMSocialSnsTypeLaiWangSession":@(UMSocialSnsTypeLaiWangSession),
                      @"UMSocialSnsTypeLaiWangTimeline":@(UMSocialSnsTypeLaiWangTimeline),
                      @"UMSocialSnsTypeInstagram":@(UMSocialSnsTypeInstagram),
                      @"UMSocialSnsTypeWhatsApp":@(UMSocialSnsTypeWhatsApp),
                      
                      
                      @"UMSocialSnsTypeLine":@(UMSocialSnsTypeLine),
                      @"UMSocialSnsTypeTumblr":@(UMSocialSnsTypeTumblr),
                      @"UMSocialSnsTypeKakaoTalk":@(UMSocialSnsTypeKakaoTalk),
                      @"UMSocialSnsTypeFlickr":@(UMSocialSnsTypeFlickr),
                      
                      @"UMSocialSnsTypePinterest":@(UMSocialSnsTypePinterest),
                      @"UMSocialSnsTypeAlipaySession":@(UMSocialSnsTypeAlipaySession),
                      @"UMSocialSnsTypeNew":@(UMSocialSnsTypeNew)

                      }),
                   UMSocialSnsTypeNone,
                   intValue)

@end