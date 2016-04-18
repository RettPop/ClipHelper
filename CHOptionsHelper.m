//
//  CHOptionsHelper.m
//  ClipHelper
//
//  Created by Rett Pop on 2015-12-20.
//  Copyright © 2015 SapiSoft. All rights reserved.
//

#import "CHOptionsHelper.h"
#import "ClipHelperConstants.h"


@implementation CHOptionsHelper

+(BOOL)optionValueForKey:(NSString *)keyName
{
    NSUserDefaults *def = [[NSUserDefaults alloc] initWithSuiteName:kAppGroupName];
    BOOL boolValue = [[def valueForKey:keyName] boolValue];
    def = nil;
    return boolValue;
}

+(void)setOptionBoolValue:(BOOL)value forKey:(NSString *)keyName
{
    NSUserDefaults *def = [[NSUserDefaults alloc] initWithSuiteName:kAppGroupName];
    [def setValue:[NSNumber numberWithBool:value] forKey:keyName];
    def = nil;
}


@end
