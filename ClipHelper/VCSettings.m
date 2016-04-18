//
//  VCSettings.m
//  ClipHelper
//
//  Created by Rett Pop on 2015-08-30.
//  Copyright (c) 2015 SapiSoft. All rights reserved.
//

#import "VCSettings.h"
#import "ClipHelperConstants.h"
#import "CHOptionsHelper.h"
#import "UIView+SSUIViewCategory.h"


typedef enum : NSUInteger {
    SECTION_SETTINGS,
    SECTION_SETUP,
} TABLE_SECTIONS;

@interface VCSettings ()

@property (strong, nonatomic) IBOutlet UISwitch *swDTLong;
@property (strong, nonatomic) IBOutlet UILabel *lblDTLong;
@property (strong, nonatomic) IBOutlet UISwitch *swDTShort;
@property (strong, nonatomic) IBOutlet UILabel *lblDTShort;
@property (strong, nonatomic) IBOutlet UISwitch *swClearClilpboard;
@property (strong, nonatomic) IBOutlet UILabel *lblClearClilpboard;
@property (strong, nonatomic) IBOutlet UITextView *textSetup;

@end

@implementation VCSettings

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self customizeControls];
    [self setupControls];
}

-(void)customizeControls
{
    [_lblDTLong setText:LOC(@"title.DateTimeLongFormat")];
    [_lblDTShort setText:LOC(@"title.DateTimeShortFormat")];
    [_lblClearClilpboard setText:LOC(@"title.ClearClipboard")];
    [_textSetup setText:LOC(@"text.WidgetAdding")];
}

-(void)setupControls
{
    [_swDTLong setOn:[CHOptionsHelper optionValueForKey:kKeyNameSwDTLong]];
    [_swDTShort setOn:[CHOptionsHelper optionValueForKey:kKeyNameSwDTShort]];
    [_swClearClilpboard setOn:[CHOptionsHelper optionValueForKey:kKeyNameSwClearClipboard]];
}

- (IBAction)swValueChanged:(UISwitch *)sender
{
    NSString *keyName = (sender == _swDTLong) ? kKeyNameSwDTLong : kKeyNameSwClearClipboard;
    if( sender == _swDTShort ) {
        keyName = kKeyNameSwDTShort;
    }
    
    [CHOptionsHelper setOptionBoolValue:[sender isOn] forKey:keyName];
}

#pragma mark -
#pragma mark UITableView delegate

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if( SECTION_SETUP == section )
    {
        UILabel *lblVer = [[UILabel alloc] initWithFrame:[view bounds]];
        NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
        
        NSString *version = infoDictionary[@"CFBundleShortVersionString"];
        NSString *build = infoDictionary[(NSString*)kCFBundleVersionKey];
        NSString *bundleName = infoDictionary[(NSString *)kCFBundleNameKey];
        
        [lblVer setText:[NSString stringWithFormat:@"%@ v.%@(%@)", bundleName, version, build]];
        [lblVer changeFrameXDelta:10.f yDelta:.0f];
        [view addSubview:lblVer];
        [lblVer setFont:[UIFont systemFontOfSize:12.f]];
    }
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = @"";
    switch (section)
    {
        case SECTION_SETTINGS:
            title = LOC(@"title.section.Settings");
            break;
            
        case SECTION_SETUP:
            title = LOC(@"title.section.Setup");
            break;
            
        default:
            break;
    }

    return title;
}

@end
