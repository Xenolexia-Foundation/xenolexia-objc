//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  main.m
//  Xenolexia
//
//  Linux (GNUStep) application entry point

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "UI/XLLinuxApp.h"

int main(int argc, const char * argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    XLLinuxApp *app = [XLLinuxApp sharedApp];
    [app run];
    
    [pool drain];
    return 0;
}
