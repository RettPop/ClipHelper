//
//  TodayViewController.m
//  ClipHelperWidget
//
//  Created by Rett Pop on 2015-08-30.
//  Copyright (c) 2015 SapiSoft. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>
#import "UIView+SSUIViewCategory.h"
#include "ClipHelperConstants.h"

#define kDefSpace 5.f

@interface TodayViewController () <NCWidgetProviding>
    @property (strong, nonatomic) IBOutlet UIButton *btnCopyDateTime;
    @property (strong, nonatomic) IBOutlet UIButton *btnClearClipboard;
@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    _btnClearClipboard = [[UIButton alloc] initWithFrame:[_btnCopyDateTime frame]];
//    [_btnClearClipboard changeFrameXDelta:.0f yDelta:CGRectGetHeight([_btnCopyDateTime frame]) + kDefSpace];
//    [_btnClearClipboard addTarget:self action:@selector(clearClipBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_btnClearClipboard setTitle:LOC(@"btn.ClearClipboard") forState:UIControlStateNormal];
    
//    [[self view] changeSizeWidthDelta:.0f heightDelta:CGRectGetHeight([_btnCopyDateTime frame]) + kDefSpace];
//    [[self view] addSubview:_btnClearClipboard];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)clearClipBtnTapped:(id)sender
{
    [self clearClipboard];
}

-(void) clearClipboard
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:@""];
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    DLog(@"");
    
    [_btnCopyDateTime setTitle:[self dateTime] forState:UIControlStateNormal];
    [_btnClearClipboard setTitle:LOC(@"btn.ClearClipboard") forState:UIControlStateNormal];
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)btnCopyDateTimeClicked:(id)sender
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:[self dateTime]];
}

-(NSString *)dateTime
{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df stringFromDate:[NSDate date]];
}

@end
