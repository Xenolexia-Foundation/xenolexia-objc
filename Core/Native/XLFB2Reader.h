//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLFB2Reader.h
//  Xenolexia
//
//  FictionBook 2 (FB2) reader using libxml2. Replaces xenolexia-shared-c xenolexia_fb2.
//

#import <Foundation/Foundation.h>

// Forward declarations for implementation ivars (no libxml in header)
struct _xmlDoc;
struct _xmlXPathContext;
struct _xmlXPathObject;
struct _xmlNodeSet;

NS_ASSUME_NONNULL_BEGIN

@interface XLFB2Reader : NSObject {
@private
    struct _xmlDoc *_doc;
    struct _xmlXPathContext *_xpathCtx;
    struct _xmlXPathObject *_sectionsXPathObj;
    struct _xmlNodeSet *_sections;
    NSInteger _sectionCount;
}

+ (nullable instancetype)openAtPath:(NSString *)path error:(NSError **)error;

- (NSString *)title;
- (nullable NSString *)author;
- (NSInteger)sectionCount;
- (nullable NSString *)sectionTitleAtIndex:(NSInteger)index;
- (nullable NSString *)sectionTextAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
