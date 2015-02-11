//
//  AppDelegate.m
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "AppDelegate.h"
#import "IDPMailHistoryChainModel.h"

static NSInteger kMailInChain = 1000;
static NSInteger  kMailCount = 20;

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@property (nonatomic, strong) NSMutableArray    *testMailObjects;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [self generateTestData];
    self.mailListViewController.mailObjects = [NSArray arrayWithArray:self.testMailObjects];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

#pragma mark -
#pragma mark Private methods

- (void)generateTestData {
    self.testMailObjects = [NSMutableArray array];
    NSString *contentString = [NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"testEmailFile" ofType:@"html"] encoding:NSUTF8StringEncoding error:nil];
    for (NSInteger index = 0; index < kMailCount; index++) {
        IDPMailHistoryChainModel *chainModel = [IDPMailHistoryChainModel new];
        for (NSInteger kIndex = 0; kIndex < kMailInChain; kIndex++) {
            IDPMailMessageModel *model = [IDPMailMessageModel new];
            model.subject = [NSString stringWithFormat:@"Test subject %ld-%ld", (long)index, (long)kIndex];
            model.recipients = @[@"test.test@recipient.com"];
            model.sender = @[@"test.test@sender.com"];
            model.date = [NSDate date];
            model.content = contentString;
            [chainModel addNewMailMessage:model];
        }
        [self.testMailObjects addObject:chainModel];
    }
}

@end
