//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  XLiOSAppDelegate.h
//  Xenolexia (iOS)
//
//  iOS (UIKit) app delegate. Forwards lifecycle to shared XLAppLogic (SSAppDelegate) and sets up window/root VC.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XLiOSAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong, nullable) UIWindow *window;
@end

NS_ASSUME_NONNULL_END
