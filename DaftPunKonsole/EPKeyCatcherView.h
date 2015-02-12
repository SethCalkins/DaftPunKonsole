//
//  EPKeyCatcherView.h
//  DaftPunKonsole
//
//  Created by Marvin Scholz on 12.02.15.
//  Copyright (c) 2015 ePirat. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@protocol EventDelegatingViewDelegate <NSObject>

- (void)view:(NSView *)aView didHandleKeyDownEvent:(NSEvent *)anEvent;

@end


@interface EPKeyCatcherView : NSView

@property id<EventDelegatingViewDelegate> keyEventDelegate;

@end
