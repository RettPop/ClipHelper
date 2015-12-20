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
#import "CHOptionsHelper.h"

#define kDefBorder 5.f
#define kDefSpace 15.f
#define kIconWidth 30.f
#define kDefButtonHeight 40.f

@interface TodayViewController () <NCWidgetProviding>
{
    BOOL _showDTLong;
    BOOL _showClearCipboard;
}
    @property (strong, nonatomic) UIButton *btnCopyDateTime;
    @property (strong, nonatomic) UIButton *btnClearClipboard;
@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    _showDTLong = [CHOptionsHelper optionValueForKey:kKeyNameSwDTLong];
    _showClearCipboard = [CHOptionsHelper optionValueForKey:kKeyNameSwClearClipboard];
    
    NSUInteger position = 0;
    
    if( _showDTLong )
    {
        _btnCopyDateTime = [self createButtonWithTitle:[self stringDateTime] action:@selector(btnCopyDateTimeClicked:) onPosition:position];
        [[self view] addSubview:_btnCopyDateTime];
        position++;
    }
    
    if( _showClearCipboard )
    {
        _btnClearClipboard = [self createButtonWithTitle:LOC(@"btn.ClearClipboard") action:@selector(btnCopyDateTimeClicked:) onPosition:position];
        [[self view] addSubview:_btnClearClipboard];
        position++;
    }
}

-(UIButton *)createButtonWithTitle:(NSString *)title action:(SEL)actioin onPosition:(NSUInteger)position
{
    CGFloat btnWidth = CGRectGetWidth([[self view] bounds]) - kIconWidth - kDefSpace - 100;
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [newButton setFrame:CGRectMake(0, 0, btnWidth, kDefButtonHeight)];
    [newButton addTarget:self action:actioin forControlEvents:UIControlEventTouchUpInside];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [newButton setBackgroundColor:[UIColor blackColor]];
    
    [newButton changeFrameXDelta:.0f yDelta:(kDefButtonHeight + kDefSpace) * position];
    
    return newButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    CGFloat oneButtonSpace = kDefButtonHeight + kDefSpace;
    if( _showClearCipboard && _showDTLong ) {
        oneButtonSpace *= 2;
    }
    [self setPreferredContentSize: CGSizeMake(CGRectGetWidth([[self view] bounds]), oneButtonSpace)];
    [_btnClearClipboard setNewWidth:CGRectGetWidth([[self view] bounds])];
    [_btnCopyDateTime setNewWidth:CGRectGetWidth([[self view] bounds])];
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
    
    [_btnCopyDateTime setTitle:[self stringDateTime] forState:UIControlStateNormal];
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)btnCopyDateTimeClicked:(id)sender
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    [pb setString:[self stringDateTime]];
}

-(NSString *)stringDateTime
{
    NSDateFormatter *df = [NSDateFormatter new];
    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [df stringFromDate:[NSDate date]];
}

@end
