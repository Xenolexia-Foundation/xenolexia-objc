//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLLibreTranslateClient.h
//  Xenolexia
//
//  FOSS translation backend using LibreTranslate HTTP API (libcurl).
//

#import <Foundation/Foundation.h>

/// Calls LibreTranslate API (POST /translate). Base URL e.g. https://libretranslate.com
@interface XLLibreTranslateClient : NSObject
+ (void)translateText:(NSString *)text
       fromLanguage:(NSString *)sourceCode
         toLanguage:(NSString *)targetCode
            baseURL:(NSString *)baseURL
         completion:(void(^)(NSString *translatedText, NSError *error))completion;
@end
