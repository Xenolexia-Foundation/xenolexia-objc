//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLBookDetailWindowController.h
//  Xenolexia
//
//  Book detail window controller for Linux

#import <AppKit/AppKit.h>
#import "../../../Core/Models/Book.h"

@protocol XLBookDetailWindowDelegate <NSObject>
- (void)bookDetailDidRequestStartReading:(XLBook *)book;
- (void)bookDetailDidRequestDelete:(XLBook *)book;
- (void)bookDetailDidClose;
@end

@interface XLBookDetailWindowController : NSWindowController {
    id _delegate;
    XLBook *_book;
    NSTextField *_titleLabel;
    NSTextField *_authorLabel;
    NSTextField *_progressLabel;
    NSProgressIndicator *_progressBar;
    NSTextField *_formatLabel;
    NSTextField *_languageLabel;
    NSTextField *_proficiencyLabel;
    NSTextField *_wordDensityLabel;
    NSTextField *_fileSizeLabel;
    NSTextField *_addedAtLabel;
    NSButton *_startReadingButton;
    NSButton *_deleteButton;
}

- (instancetype)initWithBook:(XLBook *)book;

@end
