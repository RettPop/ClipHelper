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
{
    NSDictionary *_switches;
    NSDictionary *_fields;
}
@property (strong, nonatomic) IBOutlet UISwitch *swDTLong;
@property (strong, nonatomic) IBOutlet UILabel *lblDTLong;
@property (strong, nonatomic) IBOutlet UISwitch *swDTShort;
@property (strong, nonatomic) IBOutlet UILabel *lblDTShort;
@property (strong, nonatomic) IBOutlet UISwitch *swClearClilpboard;
@property (strong, nonatomic) IBOutlet UILabel *lblClearClilpboard;
@property (strong, nonatomic) IBOutlet UITextView *textSetup;

@property (strong, nonatomic) IBOutlet UITextField *textCustom1;
@property (strong, nonatomic) IBOutlet UITextField *textCustom2;
@property (strong, nonatomic) IBOutlet UITextField *textCustom3;
@property (strong, nonatomic) IBOutlet UISwitch *swCustom1;
@property (strong, nonatomic) IBOutlet UISwitch *swCustom2;
@property (strong, nonatomic) IBOutlet UISwitch *swCustom3;


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
    
    for (UITextField *oneField in @[_textCustom1, _textCustom2, _textCustom3])
    {
        [oneField setPlaceholder:LOC(@"text.Placeholder.CustomText")];
    }
}

-(void)setupControls
{
    // let it warn. Not going to serialize it, so keys can be non NSString
    _switches = @{kKeyNameSwDTShort:_swDTShort,
                  kKeyNameSwDTLong:_swDTLong,
                  kKeyNameSwClearClipboard:_swClearClilpboard,
                  kKeyNameSwCustomText1:_swCustom1,
                  kKeyNameSwCustomText2:_swCustom2,
                  kKeyNameSwCustomText3:_swCustom3};
    for (UISwitch *oneSw in [_switches allValues]) {
        [oneSw setOn:[CHOptionsHelper optionValueForKey:[[_switches allKeysForObject:oneSw] firstObject]]];
    }
    
    _fields = @{kKeyNameCustomText1:_textCustom1,
                kKeyNameCustomText2:_textCustom2,
                kKeyNameCustomText3:_textCustom3};
    for (UITextField *oneField in [_fields allValues]) {
        [oneField setText:[CHOptionsHelper optionStringValueForKey:[[_fields allKeysForObject:oneField] firstObject]]];
        [oneField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        [oneField setReturnKeyType:UIReturnKeyDone];
    }
}
- (IBAction)textFieldDidChange:(UITextField *)sender
{
    [CHOptionsHelper setOptionStringValue:[sender text] forKey:[[_fields allKeysForObject:sender] firstObject]];
}

- (IBAction)swValueChanged:(UISwitch *)sender
{
    [CHOptionsHelper setOptionBoolValue:[sender isOn] forKey:[[_switches allKeysForObject:sender] firstObject]];
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

#pragma mark -
#pragma mark UITextField
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}


@end
