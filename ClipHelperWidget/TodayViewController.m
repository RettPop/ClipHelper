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
#define kDefSpace 5.f
#define kIconWidth 30.f
#define kDefButtonHeight 34.f
#define kOneButtonSpaceHeight (kDefButtonHeight + kDefSpace)

#define kBtnTitleCopyDTShortFormat @"📋📆: "
#define kBtnTitleCopyDTLongFormat @"📋📅: "
#define kBtnTitleClearClipboard @"📋🗑️: "


typedef enum : NSUInteger {
    DTFORMAT_SHORT,
    DTFORMAT_LONG,
} DTFORMAT;

@interface TodayViewController () <NCWidgetProviding>
{
    BOOL _showDTShort;
    BOOL _showDTLong;
    BOOL _showClearCipboard;
    NSMutableArray *_visibleItems;
    NSArray *_availableItems;
}
@property (strong, nonatomic) UIButton *btnCopyDTShort;
@property (strong, nonatomic) UIButton *btnCopyDTLong;
@property (strong, nonatomic) UIButton *btnClearClipboard;
@end

@implementation TodayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _visibleItems = [NSMutableArray arrayWithCapacity:3]; // have 3 buttons for now
    [self setupControls];
}

-(void)setupControls
{
    NSUInteger position = 0;
    _btnCopyDTShort = [self createButtonWithTitle:[kBtnTitleCopyDTShortFormat stringByAppendingString:[self stringDateTime:DTFORMAT_SHORT]]
                                           action:@selector(btnCopyDTClicked:)
                                       onPosition:position++];
    
    _btnCopyDTLong = [self createButtonWithTitle:[kBtnTitleCopyDTLongFormat stringByAppendingString:[self stringDateTime:DTFORMAT_LONG]]
                                          action:@selector(btnCopyDTClicked:)
                                      onPosition:position++];
    
    _btnClearClipboard = [self createButtonWithTitle: [kBtnTitleClearClipboard stringByAppendingString:LOC(@"btn.ClearClipboard")]
                                              action:@selector(clearClipBtnTapped:)
                                          onPosition:position++];
    
    _availableItems = @[_btnCopyDTShort, _btnCopyDTLong, _btnClearClipboard];
}

-(void)layoutControls
{
    _showDTShort = [CHOptionsHelper optionValueForKey:kKeyNameSwDTShort];
    _showDTLong = [CHOptionsHelper optionValueForKey:kKeyNameSwDTLong];
    _showClearCipboard = [CHOptionsHelper optionValueForKey:kKeyNameSwClearClipboard];

    [_visibleItems removeAllObjects];
    
    if( _showDTShort ) {
        [_visibleItems addObject:_btnCopyDTShort];
    }
    if( _showDTLong ) {
        [_visibleItems addObject:_btnCopyDTLong];
    }
    if( _showClearCipboard ) {
        [_visibleItems addObject:_btnClearClipboard];
    }

    for (UIView *oneView in _availableItems)
    {
        [oneView removeFromSuperview];
    }
    
    NSUInteger position = 0;
    for (UIButton *oneBtn in _visibleItems)
    {
        [oneBtn setFrameX:.0f andY:kOneButtonSpaceHeight * position++];
        [[self view] addSubview:oneBtn];
    }
}

-(UIButton *)createButtonWithTitle:(NSString *)title action:(SEL)actioin onPosition:(NSUInteger)position
{
    CGFloat btnWidth = CGRectGetWidth([[self view] bounds]) - kIconWidth - kDefSpace - 100;
    UIButton *newButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [newButton setFrame:CGRectMake(0, 0, btnWidth, kDefButtonHeight)];
    [newButton addTarget:self action:actioin forControlEvents:UIControlEventTouchUpInside];
    [newButton setTitle:title forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [newButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [[newButton titleLabel] setFont:[UIFont systemFontOfSize:11.f]];
    
    [newButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [newButton setBackgroundColor:[UIColor clearColor]];
    
    [newButton setFrameX:.0f andY:kOneButtonSpaceHeight * position];
    return newButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self layoutControls];
    CGFloat spaceNeeded = [_visibleItems count] * kOneButtonSpaceHeight;
    
    if( 0 == [_visibleItems count] ) {
        spaceNeeded = 1.f;
    }
    
    [self setPreferredContentSize: CGSizeMake(CGRectGetWidth([[self view] bounds]), spaceNeeded)];
    
    for (UIButton *oneItem in _visibleItems)
    {
        [oneItem setNewWidth:CGRectGetWidth([[self view] bounds])];
    }
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
    
    [_btnCopyDTShort setTitle:[kBtnTitleCopyDTShortFormat stringByAppendingString:[self stringDateTime:DTFORMAT_SHORT]] forState:UIControlStateNormal];
    [_btnCopyDTLong setTitle:[kBtnTitleCopyDTLongFormat stringByAppendingString:[self stringDateTime:DTFORMAT_LONG]] forState:UIControlStateNormal];
    
    // If an error is encountered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

- (IBAction)btnCopyDTClicked:(id)sender
{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    if( _btnCopyDTShort == sender ) {
        [pb setString:[self stringDateTime:DTFORMAT_SHORT]];
    }
    else if (_btnCopyDTLong == sender) {
        [pb setString:[self stringDateTime:DTFORMAT_LONG]];
    }
}

-(NSString *)stringDateTime:(DTFORMAT)format
{
    NSDateFormatter *df = [NSDateFormatter new];
    
    switch(format)
    {
        case DTFORMAT_SHORT:
        {
            [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            break;
        }
        case DTFORMAT_LONG:
        {
            //2009-06-15T13:45:30 -> Monday, June 15, 2009
            //[df setDateFormat:@"yyyy-MM-ddTHH:mm:ss -> "];
            [df setDateStyle:NSDateFormatterLongStyle];
            [df setTimeStyle:NSDateFormatterLongStyle];
            break;
        }
    }
    
    return [df stringFromDate:[NSDate date]];
}

@end
