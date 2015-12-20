//
//  ViewController.m
//  ClipHelper
//
//  Created by Rett Pop on 2015-08-30.
//  Copyright (c) 2015 SapiSoft. All rights reserved.
//

#import "ViewController.h"
#import "ClipHelperConstants.h"
#import "CHOptionsHelper.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *swDTLong;
@property (strong, nonatomic) IBOutlet UISwitch *swClearClilpboard;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_swDTLong setOn:[CHOptionsHelper optionValueForKey:kKeyNameSwDTLong]];
    [_swClearClilpboard setOn:[CHOptionsHelper optionValueForKey:kKeyNameSwClearClipboard]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)swValueChanged:(UISwitch *)sender
{
    NSString *keyName = (sender == _swDTLong) ? kKeyNameSwDTLong : kKeyNameSwClearClipboard;
    [CHOptionsHelper setOptionBoolValue:[sender isOn] forKey:keyName];
}

@end
