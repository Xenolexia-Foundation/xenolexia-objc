//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLTranslationEngine.m
//  Xenolexia
//

#import "XLTranslationEngine.h"
#import "XLTranslationService.h"

@interface XLTranslationEngine ()

@property (nonatomic, strong) XLTranslationOptions *options;
@property (nonatomic, strong) NSMutableDictionary<NSString *, XLWordEntry *> *wordCache;

@end

@implementation XLTranslationEngine
@synthesize options = _options, wordCache = _wordCache;

- (instancetype)initWithOptions:(XLTranslationOptions *)options {
    self = [super init];
    if (self) {
        _options = options;
        _wordCache = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)processChapter:(XLChapter *)chapter
        withCompletion:(void(^)(XLProcessedChapter * _Nullable processedChapter, NSError * _Nullable error))completion {
    [self processContent:chapter.content withCompletion:^(NSString * _Nullable processedContent, NSArray<XLForeignWordData *> * _Nullable foreignWords, NSError * _Nullable error) {
        if (error) {
            if (completion) completion(nil, error);
            return;
        }
        
        XLProcessedChapter *processedChapter = [[XLProcessedChapter alloc] init];
        processedChapter.chapterId = chapter.chapterId;
        processedChapter.title = chapter.title;
        processedChapter.index = chapter.index;
        processedChapter.content = chapter.content;
        processedChapter.wordCount = chapter.wordCount;
        processedChapter.href = chapter.href;
        processedChapter.processedContent = processedContent ? processedContent : @"";
        processedChapter.foreignWords = foreignWords ? foreignWords : [[NSArray alloc] init];
        
        if (completion) {
            completion(processedChapter, nil);
        }
    }];
}

- (void)processContent:(NSString *)content
        withCompletion:(void(^)(NSString * _Nullable processedContent, NSArray<XLForeignWordData *> * _Nullable foreignWords, NSError * _Nullable error))completion {
    // Tokenize text
    NSArray<NSString *> *words = [self tokenizeText:content];
    
    // Select words to replace based on proficiency and density
    NSArray<NSString *> *wordsToReplace = [self selectWordsToReplace:words];
    
    // Process replacements sequentially (no libdispatch dependency for GNUStep/Linux)
    NSMutableString *processedContent = [content mutableCopy];
    NSMutableArray<XLForeignWordData *> *foreignWords = [NSMutableArray array];
    NSInteger offset = 0;
    
    if ([wordsToReplace count] == 0) {
        if (completion) completion([processedContent copy], [foreignWords copy], nil);
        return;
    }
    
    NSEnumerator *wordEnumerator = [wordsToReplace objectEnumerator];
    __block NSMutableString *proc = processedContent;
    __block NSMutableArray *fwords = foreignWords;
    __block NSInteger off = offset;
    
    typedef void (^NextWordBlock)(void);
    __block NextWordBlock nextBlock = nil;
    nextBlock = ^{
        NSString *word = [wordEnumerator nextObject];
        if (!word) {
            if (completion) completion([proc copy], [fwords copy], nil);
            nextBlock = nil;
            return;
        }
        [self getTranslationForWord:word completion:^(XLWordEntry * _Nullable entry, NSError * _Nullable error) {
            if (entry && !error) {
                NSRange range = [proc rangeOfString:word
                                            options:NSCaseInsensitiveSearch
                                              range:NSMakeRange(off, proc.length - off)];
                if (range.location != NSNotFound) {
                    [proc replaceCharactersInRange:range withString:entry.targetWord];
                    XLForeignWordData *data = [XLForeignWordData dataWithOriginalWord:word
                                                                          foreignWord:entry.targetWord
                                                                           startIndex:range.location
                                                                             endIndex:range.location + entry.targetWord.length
                                                                            wordEntry:entry];
                    [fwords addObject:data];
                    off = range.location + entry.targetWord.length;
                }
            }
            if (nextBlock) nextBlock();
        }];
    };
    nextBlock();
}

#pragma mark - Private Methods

- (NSArray<NSString *> *)tokenizeText:(NSString *)text {
    // Simple tokenization - split by whitespace and punctuation
    NSCharacterSet *wordBoundarySet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r.,!?;:()[]{}\"'-"];
    NSArray<NSString *> *components = [text componentsSeparatedByCharactersInSet:wordBoundarySet];
    
    NSMutableArray<NSString *> *words = [NSMutableArray array];
    for (NSString *component in components) {
        NSString *trimmed = [component stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimmed length] > 0 && [trimmed length] >= 2 && [trimmed length] <= 25) {
            [words addObject:[trimmed lowercaseString]];
        }
    }
    
    return words;
}

- (NSArray *)selectWordsToReplace:(NSArray *)words {
    // Filter by frequency rank based on proficiency level
    NSInteger minRank, maxRank;
    switch (self.options.proficiencyLevel) {
        case XLProficiencyLevelBeginner:
            minRank = 1;
            maxRank = 500;
            break;
        case XLProficiencyLevelIntermediate:
            minRank = 501;
            maxRank = 2000;
            break;
        case XLProficiencyLevelAdvanced:
            minRank = 2001;
            maxRank = 5000;
            break;
    }
    
    // Select words based on density
    NSInteger targetCount = (NSInteger)([words count] * self.options.wordDensity);
    NSMutableArray<NSString *> *selected = [NSMutableArray array];
    
    // Simple selection: take first N words that meet criteria
    for (NSString *word in words) {
        if (selected.count >= targetCount) break;
        
        // Skip excluded words
        if ([self.options.excludeWords containsObject:word]) {
            continue;
        }
        
        // For now, accept all words (frequency filtering would require a database)
        [selected addObject:word];
    }
    
    return selected;
}

- (void)getTranslationForWord:(NSString *)word
                    completion:(void(^)(XLWordEntry *entry, NSError *error))completion {
    // Check cache first
    NSString *cacheKey = [NSString stringWithFormat:@"%@_%ld_%ld",
                         word,
                         (long)self.options.languagePair.sourceLanguage,
                         (long)self.options.languagePair.targetLanguage];
    
    XLWordEntry *cached = [self.wordCache objectForKey:cacheKey];
    if (cached) {
        if (completion) completion(cached, nil);
        return;
    }
    
    // Get translation from service
    XLTranslationService *translationService = [XLTranslationService sharedService];
    [translationService translateWord:word
                            fromLanguage:self.options.languagePair.sourceLanguage
                              toLanguage:self.options.languagePair.targetLanguage
                          withCompletion:^(NSString * _Nullable translatedWord, NSError * _Nullable error) {
        if (error || !translatedWord) {
            if (completion) completion(nil, error);
            return;
        }
        
        // Create word entry
        XLWordEntry *entry = [XLWordEntry entryWithSourceWord:word
                                                    targetWord:translatedWord
                                                sourceLanguage:self.options.languagePair.sourceLanguage
                                                targetLanguage:self.options.languagePair.targetLanguage];
        entry.proficiencyLevel = self.options.proficiencyLevel;
        
        // Cache it
        [self.wordCache setObject:entry forKey:cacheKey];
        
        if (completion) completion(entry, nil);
    }];
}

@end

@implementation XLTranslationOptions
@synthesize languagePair = _languagePair, proficiencyLevel = _proficiencyLevel, wordDensity = _wordDensity, excludeWords = _excludeWords;

+ (instancetype)optionsWithLanguagePair:(XLLanguagePair *)languagePair
                       proficiencyLevel:(XLProficiencyLevel)proficiencyLevel
                           wordDensity:(double)wordDensity {
    XLTranslationOptions *options = [[XLTranslationOptions alloc] init];
    options.languagePair = languagePair;
    options.proficiencyLevel = proficiencyLevel;
    options.wordDensity = wordDensity;
        options.excludeWords = [[NSArray alloc] init];
    return options;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _languagePair = [XLLanguagePair pairWithSource:XLLanguageEnglish target:XLLanguageFrench];
        _proficiencyLevel = XLProficiencyLevelBeginner;
        _wordDensity = 0.3;
        _excludeWords = @[];
    }
    return self;
}

@end
