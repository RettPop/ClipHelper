//
//  CHOptionsHelper.h
//  ClipHelper
//
//  Created by Rett Pop on 2015-12-20.
//  Copyright © 2015 SapiSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHOptionsHelper : NSObject

+(BOOL)optionValueForKey:(NSString *)keyName;
+(NSString *)optionStringValueForKey:(NSString *)keyName;
+(NSString *)optionStringValueForKey:(NSString *)keyName defValue:(NSString *)defValue;
+(void)setOptionBoolValue:(BOOL)value forKey:(NSString *)keyName;
+(void)setOptionStringValue:(NSString *)value forKey:(NSString *)keyName;

@end
