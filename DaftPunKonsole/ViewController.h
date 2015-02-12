//
//  ViewController.h
//  DaftPunKonsole
//
//  Created by Marvin Scholz on 12.02.15.
//  Copyright (c) 2015 ePirat. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AVFoundation/AVAudioPlayer.h>

#import "EPKeyCatcherView.h"

@interface ViewController : NSViewController <AVAudioPlayerDelegate, EventDelegatingViewDelegate>
@property (weak) IBOutlet NSButton *ButtonQ;
@property (weak) IBOutlet NSButton *ButtonW;
@property (weak) IBOutlet NSButton *ButtonE;
@property (weak) IBOutlet NSButton *ButtonR;
@property (weak) IBOutlet NSButton *ButtonU;
@property (weak) IBOutlet NSButton *ButtonI;
@property (weak) IBOutlet NSButton *ButtonO;
@property (weak) IBOutlet NSButton *ButtonP;
@property (weak) IBOutlet NSButton *ButtonA;
@property (weak) IBOutlet NSButton *ButtonS;
@property (weak) IBOutlet NSButton *ButtonD;
@property (weak) IBOutlet NSButton *ButtonF;
@property (weak) IBOutlet NSButton *ButtonJ;
@property (weak) IBOutlet NSButton *ButtonK;
@property (weak) IBOutlet NSButton *ButtonL;
@property (weak) IBOutlet NSButton *ButtonSemicolon;
@property (weak) IBOutlet NSButton *ButtonZ;
@property (weak) IBOutlet NSButton *ButtonX;
@property (weak) IBOutlet NSButton *ButtonN;
@property (weak) IBOutlet NSButton *ButtonSpace;

@property NSMutableArray *players;
@property NSArray *samples;
@property NSArray *samples_2;
@property NSArray *samples_3;
@property NSInteger modifier;
@property AVAudioPlayer *mainplayer;

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                        successfully:(BOOL)flag;

- (void)view:(NSView *)aView didHandleKeyDownEvent:(NSEvent *)anEvent;

@end

