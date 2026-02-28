//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLPDFReader.h
//  Xenolexia
//
//  PDF reader using MuPDF (FOSS). Replaces xenolexia-shared-c xenolexia_pdf.
//  When MuPDF is not linked, openAtPath: returns nil.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLPDFReader : NSObject

+ (nullable instancetype)openAtPath:(NSString *)path error:(NSError **)error;

- (nullable NSString *)title;
- (nullable NSString *)author;
- (NSInteger)pageCount;
- (nullable NSString *)pageTextAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
