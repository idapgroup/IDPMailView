//
//  IDPMailViewCell.m
//  IDPMailView
//
//  Created by Artem Chabanniy on 2/9/15.
//  Copyright (c) 2015 IDAP Group. All rights reserved.
//

#import "IDPMailViewCell.h"
#import "IDPMailMessageModel.h"

@implementation IDPMailViewCell

#pragma mark -
#pragma mark Public methods

- (void)fillFromObject:(id)object {
    if ([object isKindOfClass:[IDPMailMessageModel class]]) {
        IDPMailMessageModel *mailMessage = (IDPMailMessageModel *)object;
        self.senderTextField.stringValue = [mailMessage senderString];
        [[self.content mainFrame] loadHTMLString:mailMessage.content baseURL:nil];
        
        self.readMark.wantsLayer = YES;
        self.readMark.layer.backgroundColor = mailMessage.isRead ? [[NSColor greenColor] CGColor] : [[NSColor blueColor] CGColor];
        self.readMark.layer.cornerRadius = CGRectGetWidth(self.readMark.frame)/2;
    }
}

@end
