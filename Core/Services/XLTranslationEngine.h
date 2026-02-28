//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLTranslationEngine.h
//  Xenolexia
//
//  Translation engine for processing text and replacing words

#import <Foundation/Foundation.h>
#import "../Models/Book.h"
#import "../Models/Reader.h"
#import "../Models/Language.h"
#import "../Models/Vocabulary.h"

NS_ASSUME_NONNULL_BEGIN

/// Translation options
@interface XLTranslationOptions : NSObject

@property (nonatomic) XLLanguagePair *languagePair;
@property (nonatomic) XLProficiencyLevel proficiencyLevel;
@property (nonatomic) double wordDensity; // 0.0 - 1.0
@property (nonatomic, retain) NSArray *excludeWords;

+ (instancetype)optionsWithLanguagePair:(XLLanguagePair *)languagePair
                       proficiencyLevel:(XLProficiencyLevel)proficiencyLevel
                           wordDensity:(double)wordDensity;

@end

/// Translation engine
@interface XLTranslationEngine : NSObject

- (instancetype)initWithOptions:(XLTranslationOptions *)options;

/// Process chapter content and replace words based on proficiency level
- (void)processChapter:(XLChapter *)chapter
        withCompletion:(void(^)(XLProcessedChapter * _Nullable processedChapter, NSError * _Nullable error))completion;

/// Process HTML content string
- (void)processContent:(NSString *)content
        withCompletion:(void(^)(NSString *processedContent, NSArray *foreignWords, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
