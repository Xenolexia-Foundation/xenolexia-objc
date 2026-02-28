//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  Language.m
//  Xenolexia
//

#import "Language.h"

@implementation XLLanguageInfo

+ (instancetype)infoWithCode:(XLLanguage)code
                        name:(NSString *)name
                  nativeName:(NSString *)nativeName
                       flag:(NSString *)flag
                         rtl:(BOOL)rtl {
    XLLanguageInfo *info = [[XLLanguageInfo alloc] init];
    if (info) {
        info->_code = code;
        info->_name = [name copy];
        info->_nativeName = [nativeName copy];
        info->_flag = [flag copy];
        info->_rtl = rtl;
    }
    return info;
}

+ (NSArray *)supportedLanguages {
    static NSArray *languages = nil;
    if (languages == nil) {
        NSMutableArray *langs = [[NSMutableArray alloc] init];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageEnglish name:@"English" nativeName:@"English" flag:@"🇬🇧" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageSpanish name:@"Spanish" nativeName:@"Español" flag:@"🇪🇸" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageFrench name:@"French" nativeName:@"Français" flag:@"🇫🇷" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageGerman name:@"German" nativeName:@"Deutsch" flag:@"🇩🇪" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageItalian name:@"Italian" nativeName:@"Italiano" flag:@"🇮🇹" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguagePortuguese name:@"Portuguese" nativeName:@"Português" flag:@"🇵🇹" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageRussian name:@"Russian" nativeName:@"Русский" flag:@"🇷🇺" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageGreek name:@"Greek" nativeName:@"Ελληνικά" flag:@"🇬🇷" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageDutch name:@"Dutch" nativeName:@"Nederlands" flag:@"🇳🇱" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguagePolish name:@"Polish" nativeName:@"Polski" flag:@"🇵🇱" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageTurkish name:@"Turkish" nativeName:@"Türkçe" flag:@"🇹🇷" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageSwedish name:@"Swedish" nativeName:@"Svenska" flag:@"🇸🇪" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageDanish name:@"Danish" nativeName:@"Dansk" flag:@"🇩🇰" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageFinnish name:@"Finnish" nativeName:@"Suomi" flag:@"🇫🇮" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageNorwegian name:@"Norwegian" nativeName:@"Norsk" flag:@"🇳🇴" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageCzech name:@"Czech" nativeName:@"Čeština" flag:@"🇨🇿" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageHungarian name:@"Hungarian" nativeName:@"Magyar" flag:@"🇭🇺" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageRomanian name:@"Romanian" nativeName:@"Română" flag:@"🇷🇴" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageUkrainian name:@"Ukrainian" nativeName:@"Українська" flag:@"🇺🇦" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageJapanese name:@"Japanese" nativeName:@"日本語" flag:@"🇯🇵" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageChinese name:@"Chinese" nativeName:@"中文" flag:@"🇨🇳" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageKorean name:@"Korean" nativeName:@"한국어" flag:@"🇰🇷" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageArabic name:@"Arabic" nativeName:@"العربية" flag:@"🇵🇸" rtl:YES]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageHebrew name:@"Hebrew" nativeName:@"עברית" flag:@"🇮🇱" rtl:YES]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageHindi name:@"Hindi" nativeName:@"हिन्दी" flag:@"🇮🇳" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageThai name:@"Thai" nativeName:@"ไทย" flag:@"🇹🇭" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageVietnamese name:@"Vietnamese" nativeName:@"Tiếng Việt" flag:@"🇻🇳" rtl:NO]];
        [langs addObject:[XLLanguageInfo infoWithCode:XLLanguageIndonesian name:@"Indonesian" nativeName:@"Bahasa Indonesia" flag:@"🇮🇩" rtl:NO]];
        languages = [langs copy];
    }
    return languages;
}

+ (XLLanguageInfo *)infoForCode:(XLLanguage)code {
    NSArray *languages = [self supportedLanguages];
    NSEnumerator *enumerator = [languages objectEnumerator];
    XLLanguageInfo *info;
    while ((info = [enumerator nextObject])) {
        if (info.code == code) {
            return info;
        }
    }
    return nil;
}

+ (NSString *)codeStringForLanguage:(XLLanguage)language {
    NSArray *codes = [NSArray arrayWithObjects:
        @"en", @"el", @"es", @"fr", @"de", @"it", @"pt", @"ru", @"ja", @"zh",
        @"ko", @"ar", @"nl", @"pl", @"tr", @"sv", @"da", @"fi", @"no", @"cs",
        @"hu", @"ro", @"uk", @"he", @"hi", @"th", @"vi", @"id", nil];
    if (language >= 0 && language < [codes count]) {
        return [codes objectAtIndex:language];
    }
    return @"en";
}

+ (XLLanguage)languageForCodeString:(NSString *)codeString {
    NSDictionary *codeMap = [NSDictionary dictionaryWithObjectsAndKeys:
        [NSNumber numberWithInteger:XLLanguageEnglish], @"en",
        [NSNumber numberWithInteger:XLLanguageGreek], @"el",
        [NSNumber numberWithInteger:XLLanguageSpanish], @"es",
        [NSNumber numberWithInteger:XLLanguageFrench], @"fr",
        [NSNumber numberWithInteger:XLLanguageGerman], @"de",
        [NSNumber numberWithInteger:XLLanguageItalian], @"it",
        [NSNumber numberWithInteger:XLLanguagePortuguese], @"pt",
        [NSNumber numberWithInteger:XLLanguageRussian], @"ru",
        [NSNumber numberWithInteger:XLLanguageJapanese], @"ja",
        [NSNumber numberWithInteger:XLLanguageChinese], @"zh",
        [NSNumber numberWithInteger:XLLanguageKorean], @"ko",
        [NSNumber numberWithInteger:XLLanguageArabic], @"ar",
        [NSNumber numberWithInteger:XLLanguageDutch], @"nl",
        [NSNumber numberWithInteger:XLLanguagePolish], @"pl",
        [NSNumber numberWithInteger:XLLanguageTurkish], @"tr",
        [NSNumber numberWithInteger:XLLanguageSwedish], @"sv",
        [NSNumber numberWithInteger:XLLanguageDanish], @"da",
        [NSNumber numberWithInteger:XLLanguageFinnish], @"fi",
        [NSNumber numberWithInteger:XLLanguageNorwegian], @"no",
        [NSNumber numberWithInteger:XLLanguageCzech], @"cs",
        [NSNumber numberWithInteger:XLLanguageHungarian], @"hu",
        [NSNumber numberWithInteger:XLLanguageRomanian], @"ro",
        [NSNumber numberWithInteger:XLLanguageUkrainian], @"uk",
        [NSNumber numberWithInteger:XLLanguageHebrew], @"he",
        [NSNumber numberWithInteger:XLLanguageHindi], @"hi",
        [NSNumber numberWithInteger:XLLanguageThai], @"th",
        [NSNumber numberWithInteger:XLLanguageVietnamese], @"vi",
        [NSNumber numberWithInteger:XLLanguageIndonesian], @"id",
        nil];
    NSNumber *langNumber = [codeMap objectForKey:[codeString lowercaseString]];
    return langNumber ? langNumber.integerValue : XLLanguageEnglish;
}

+ (NSString *)codeStringForProficiency:(XLProficiencyLevel)level {
    switch (level) {
        case XLProficiencyLevelBeginner: return @"beginner";
        case XLProficiencyLevelIntermediate: return @"intermediate";
        case XLProficiencyLevelAdvanced: return @"advanced";
    }
    return @"beginner";
}

+ (XLProficiencyLevel)proficiencyForCodeString:(NSString *)codeString {
    NSString *s = [codeString lowercaseString];
    if ([s isEqualToString:@"intermediate"]) return XLProficiencyLevelIntermediate;
    if ([s isEqualToString:@"advanced"]) return XLProficiencyLevelAdvanced;
    return XLProficiencyLevelBeginner;
}

@end

@implementation XLLanguagePair

+ (instancetype)pairWithSource:(XLLanguage)source target:(XLLanguage)target {
    XLLanguagePair *pair = [[XLLanguagePair alloc] init];
    pair.sourceLanguage = source;
    pair.targetLanguage = target;
    return pair;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.sourceLanguage = [aDecoder decodeIntegerForKey:@"sourceLanguage"];
        self.targetLanguage = [aDecoder decodeIntegerForKey:@"targetLanguage"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:self.sourceLanguage forKey:@"sourceLanguage"];
    [aCoder encodeInteger:self.targetLanguage forKey:@"targetLanguage"];
}

@end
