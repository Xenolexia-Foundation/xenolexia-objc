//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLExportService.h
//  Xenolexia
//
//  Export service for vocabulary (CSV, JSON, Anki formats)

#import <Foundation/Foundation.h>
#import "../Models/Vocabulary.h"

NS_ASSUME_NONNULL_BEGIN

/// Export formats
typedef NS_ENUM(NSInteger, XLExportFormat) {
    XLExportFormatCSV = 0,
    XLExportFormatJSON,
    XLExportFormatAnki
};

/// Export service
@interface XLExportService : NSObject

/// Export vocabulary items to a file
- (void)exportVocabularyItems:(NSArray *)items
                        format:(XLExportFormat)format
                    toFilePath:(NSString *)filePath
                withCompletion:(void(^)(BOOL success, NSError *error))completion;

/// Export to CSV format
- (NSString *)exportToCSV:(NSArray *)items;

/// Export to JSON format
- (NSString *)exportToJSON:(NSArray *)items;

/// Export to Anki TSV format
- (NSString *)exportToAnki:(NSArray *)items;

@end

NS_ASSUME_NONNULL_END
