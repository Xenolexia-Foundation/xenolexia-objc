//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  SSLinuxPlatform.h
//  SmallStep
//
//  Linux (GNUStep) specific platform implementations

#import <Foundation/Foundation.h>
#import "../../Core/SSPlatform.h"

NS_ASSUME_NONNULL_BEGIN

/// Linux-specific platform utilities
@interface SSLinuxPlatform : NSObject

/// Get XDG base directory (data home)
+ (NSString *)xdgDataHome;

/// Get XDG base directory (config home)
+ (NSString *)xdgConfigHome;

/// Get XDG base directory (cache home)
+ (NSString *)xdgCacheHome;

@end

NS_ASSUME_NONNULL_END
