//
//  ClipHelperConstants.h
//  ClipHelper
//
//  Created by Rett Pop on 2015-12-13.
//  Copyright © 2015 SapiSoft. All rights reserved.
//

#ifndef ClipHelperConstants_h
#define ClipHelperConstants_h

#ifdef DEBUG
#define DLog( s, ... ) NSLog( @"%@%s:(%d)> %@", [[self class] description], __PRETTY_FUNCTION__ , __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define DAssert(A, B, ...) NSAssert(A, B, ##__VA_ARGS__);
#define DLogv( var ) NSLog( @"%@%s:(%d)> "# var "=%@", [[self class] description], __PRETTY_FUNCTION__ , __LINE__, var ] )
#elif DEBUG_PROD
#define DLog( s, ... ) NSLog( @"%@%s:(%d)> %@", [[self class] description], __PRETTY_FUNCTION__ , __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#define DLogv( var ) NSLog( @"%@%s:(%d)> "# var "=%@", [[self class] description], __PRETTY_FUNCTION__ , __LINE__, var ] )
#define DAssert(A, B, ...) NSAssert(A, B, ##__VA_ARGS__);
#else
#define DLog( s, ... )
#define DAssert(...)
#define DLogv(...)
#endif


#define LOC(key) NSLocalizedString((key), @"")

#define kKeyNameSwDTLong @"showDTLong"
#define kKeyNameSwClearClipboard @"showClearClipboard"
#define kAppGroupName @"group.com.sapisoft.ClipHelper"


#endif /* ClipHelperConstants_h */
