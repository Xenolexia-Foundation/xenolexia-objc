//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLMobiReader.h
//  Xenolexia
//
//  MOBI/Kindle reader using libmobi (FOSS). Replaces xenolexia-shared-c xenolexia_mobi.
//  When libmobi is not linked, openAtPath: returns nil.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLMobiReader : NSObject

+ (nullable instancetype)openAtPath:(NSString *)path error:(NSError **)error;

- (nullable NSString *)title;
- (nullable NSString *)author;
- (NSInteger)partCount;
- (nullable NSString *)fullText;
- (nullable NSString *)partAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
