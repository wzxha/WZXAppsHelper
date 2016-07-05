//
//  ViewController.m
//  WZXAppsHelper
//
//  Created by WzxJiang on 16/7/4.
//  Copyright © 2016年 WzxJiang. All rights reserved.
//

#import "ViewController.h"

NSArray * Schemes(WZX_Apps app) {
    switch (app) {
        case WZXApps_QQ:
            return @[@"mqq",
                     @"mqqapi",
                     @"mqqOpensdkSSoLogin",
                     @"mqqopensdkapiV2",
                     @"mqqopensdkapiV3",
                     @"wtloginmqq2"];
            break;
        case WZXApps_Instagram:
            return @[@"instagram"];
            break;
        case WZXApps_Facebook:
            return @[@"fb",
                     @"fbauth2"];
            break;
        case WZXApps_Twitter:
            return @[@"twitter"];
            break;
        case WZXApps_WeChat:
            return @[@"wechat",
                     @"weixin"];
            break;
        case WZXApps_WeiBo:
            return @[@"sinaweibo",
                     @"sinaweibosso",
                     @"sinaweibohd",
                     @"weibosdk",
                     @"weibosdk2.5"];
            break;
        case WZXApps_Alipay:
            return @[@"alipay",
                     @"alipayshare"];
            break;
        default:
            return @[];
            break;
    }
}

NSArray * apps() {
   return  @[ @"WeChat",
              @"QQ",
              @"WeiBo",
              @"Facebook",
              @"Twitter",
              @"Instagram",
              @"Alipay"];
}

@implementation ViewController {
    NSMutableArray * _selectArr;
    NSString * _path;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectArr = [NSMutableArray array];
    _scrollView.wantsLayer = YES;
    _scrollView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    _clipView.autoresizingMask = NSViewWidthSizable | NSViewHeightSizable;
    NSView * view = [[NSView alloc]initWithFrame:NSRectFromCGRect(CGRectMake(0, 0, _scrollView.frame.size.width, 40 * apps().count))];
    [_scrollView setDocumentView:view];
    for (int i = 0; i < apps().count; i++) {
        NSString * app = apps()[i];
        NSButton * btn  = [[NSButton alloc]initWithFrame:NSRectFromCGRect(CGRectMake(0, i * 40, _scrollView.frame.size.width, 40))];
        [btn setButtonType:NSSwitchButton];
        btn.title = app;
        btn.tag = 10000 + i;
        [btn setAction:@selector(btnClickAction:)];
        [btn setTarget:self];
        [view addSubview:btn];
    }
}

- (void)btnClickAction:(NSButton *)sender {
    if (sender.state == NSOnState) {
        [_selectArr addObject:@(sender.tag - 10000)];
    } else {
        [_selectArr removeObject:@(sender.tag - 10000)];
    }
}

- (IBAction)addBtnClick:(id)sender {
    NSMutableDictionary * info = [[NSMutableDictionary alloc] initWithContentsOfFile:_path];
    NSMutableArray * schemeArr = [NSMutableArray arrayWithArray:info[@"LSApplicationQueriesSchemes"]];
    for (NSNumber * appNum in _selectArr) {
        for (NSString * scheme in Schemes([appNum integerValue])) {
            if (![schemeArr containsObject:scheme]) {
                [schemeArr addObject:scheme];
            }
        }
    }
    [info setObject:schemeArr forKey:@"LSApplicationQueriesSchemes"];
    [info writeToFile:_path atomically:YES];
    [self showAlert:@"添加成功"];
}

- (void)showAlert:(NSString *)title {
    NSAlert *alert = [[NSAlert alloc] init];
    [alert addButtonWithTitle:@"确定"];
    [alert setMessageText:title];
    [alert setAlertStyle:NSInformationalAlertStyle];
    [alert beginSheetModalForWindow:self.window completionHandler:^(NSModalResponse returnCode) {
        
    }];
}

- (IBAction)pathControlDo:(NSPathControl *)sender {
    _path = sender.URL.path;
    if (![_path hasSuffix:@"Info.plist"]) {
        [self showAlert:@"文件有误，这不是Info.plist"];
        return;
    }
}

- (NSWindow *)window {
    if (!_window) {
        _window = [[NSWindow alloc]initWithContentRect:NSRectFromCGRect(CGRectZero) styleMask:4 backing:NSBackingStoreBuffered defer:NO];
        [_window center];
    }
    return _window;
}



- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
