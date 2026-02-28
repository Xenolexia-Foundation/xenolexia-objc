//
//  Copyright (C) 2016-2026 Husain Alamri (H4n) and Xenolexia Foundation.
//  Licensed under the GNU Affero General Public License v3.0 (AGPL-3.0). See LICENSE.
//

//
//  DownloadService.h
//  DownloadAndDisplayLocalHTML
//

#import <Foundation/Foundation.h>

@class SSFileSystem;

@interface DownloadService : NSObject {
    SSFileSystem *_fileSystem;
}

//@property (strong,nonatomic) NSString* documentsDirectory;
//@property (strong,nonatomic) NSURL* fileURL;

//- (void)fakeManager;
// manager not needed - expose the services
- (void)listFilesInDirectory:(NSString*)documentsDirectory;
- (void)downloadFrom:(NSURL*)fileURL toDirectory:(NSString*)documentsDirectory;

@end
