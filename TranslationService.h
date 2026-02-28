//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  TranslationService.h
//  DownloadAndDisplayLocalHTML
//

#import <Foundation/Foundation.h>

@interface TranslationService : NSObject

+ (id)sharedTranslator;

- (void)doSayWord:(NSString*)input;
- (void)doTranslateWord:(NSString*)input withCompletion:(void(^)(NSString *))completion;
- (void)doTranslateWord:(NSString*)input from:(NSString*)lang1 to:(NSString*)lang2 withCompletion:(void(^)(NSString *))completion;
- (void)doTranslateArray:(NSArray*)keysArray withCompletion:(void(^)(NSArray *))completion;

@end
