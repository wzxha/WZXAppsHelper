//
//  ViewController.h
//  WZXAppsHelper
//
//  Created by WzxJiang on 16/7/4.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

typedef NS_ENUM(NSInteger, WZX_Apps) {
    WZXApps_WeChat,
    WZXApps_QQ,
    WZXApps_WeiBo,
    WZXApps_Facebook,
    WZXApps_Twitter,
    WZXApps_Instagram,
    WZXApps_Alipay,
};

@interface ViewController : NSViewController <NSTableViewDataSource, NSTableViewDelegate>
@property(nonatomic ,strong)NSWindow * window;
@property (weak) IBOutlet NSClipView *clipView;


@property (weak) IBOutlet NSPathControl *pathControl;

@property (weak) IBOutlet NSScrollView *scrollView;

@property (weak) IBOutlet NSButton *addBtn;
@end

