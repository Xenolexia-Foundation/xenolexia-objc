//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLEpubReader.h
//  Xenolexia
//
//  EPUB reader using libzip + libxml2 (FOSS). Replaces xenolexia-shared-c xenolexia_epub.
//

#import <Foundation/Foundation.h>

// Forward declarations for implementation ivars (no libzip/libxml in header)
struct zip;
struct _xmlDoc;
struct _xmlXPathContext;

NS_ASSUME_NONNULL_BEGIN

@interface XLEpubReader : NSObject {
@private
    struct zip *_zip;
    struct _xmlDoc *_opfDoc;
    struct _xmlXPathContext *_opfXpath;
    NSString *_rootPath;
    NSString *_rootDir;
    NSString *_title;
    NSString *_identifier;
    NSString *_language;
    NSArray<NSString *> *_spinePaths;
    NSArray<NSDictionary<NSString *, id> *> *_tocEntries;
}

/// Open EPUB at path. Returns nil on failure.
+ (nullable instancetype)openAtPath:(NSString *)path error:(NSError **)error;

/// Metadata
- (NSString *)title;
- (nullable NSString *)identifier;
- (nullable NSString *)language;
- (nullable NSString *)metaValueForName:(NSString *)name;

/// Spine (reading order)
- (NSInteger)spineCount;
- (nullable NSString *)spinePathAtIndex:(NSInteger)index;

/// Table of contents (flat). Returns NO if index out of range.
- (NSInteger)tocCount;
- (BOOL)tocAtIndex:(NSInteger)index getTitle:(NSString **)outTitle href:(NSString **)outHref level:(NSInteger *)outLevel;

/// Read file bytes (e.g. spine path). Returns nil on failure.
- (nullable NSData *)readFileAtPath:(NSString *)path;

/// Cover image bytes. Returns nil if not found.
- (nullable NSData *)copyCover;

@end

NS_ASSUME_NONNULL_END
