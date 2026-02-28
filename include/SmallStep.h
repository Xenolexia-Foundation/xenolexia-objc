//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  SmallStep.h
//  SmallStep
//
//  Main header for SmallStep framework

#import <Foundation/Foundation.h>

// Platform detection
#import "SSPlatform.h"

// File system
#import "SSFileSystem.h"

// Window style
#import "SSWindowStyle.h"

// Concurrency
#import "SSConcurrency.h"

// File dialogs
#import "SSFileDialog.h"

// Application menu
#import "SSApplicationMenu.h"

// App lifecycle (desktop + iOS)
#import "SSAppDelegate.h"
#import "SSHostApplication.h"

// Generic desktop main menu
#import "SSMainMenu.h"

// Version
FOUNDATION_EXPORT double SmallStepVersionNumber;
FOUNDATION_EXPORT const unsigned char SmallStepVersionString[];
