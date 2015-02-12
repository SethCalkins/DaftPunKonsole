//
//  EPKeyCatcherView.m
//  DaftPunKonsole
//
//  Created by Marvin Scholz on 12.02.15.
//  Copyright (c) 2015 ePirat. All rights reserved.
//

#import "EPKeyCatcherView.h"

@implementation EPKeyCatcherView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
}

- (void)keyDown:(NSEvent *)theEvent {
    if (theEvent.type == NSKeyDown) {
        [self.keyEventDelegate view:self
              didHandleKeyDownEvent:theEvent];
    }
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

@end
