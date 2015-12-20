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
+(void)setOptionBoolValue:(BOOL)value forKey:(NSString *)keyName;

@end
