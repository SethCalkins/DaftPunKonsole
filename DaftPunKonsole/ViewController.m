//
//  ViewController.m
//  DaftPunKonsole
//
//  Created by Marvin Scholz on 12.02.15.
//  Copyright (c) 2015 ePirat. All rights reserved.
//

#import "ViewController.h"
#include <Carbon/Carbon.h>

@implementation ViewController

/* Returns string representation of key, if it is printable.
 * Ownership follows the Create Rule; that is, it is the caller's
 * responsibility to release the returned object. */
NSString* createStringForKey(CGKeyCode keyCode) {
    TISInputSourceRef currentKeyboard = TISCopyCurrentKeyboardInputSource();
    CFDataRef layoutData =
    TISGetInputSourceProperty(currentKeyboard,
                              kTISPropertyUnicodeKeyLayoutData);
    const UCKeyboardLayout *keyboardLayout =
    (const UCKeyboardLayout *)CFDataGetBytePtr(layoutData);
    
    UInt32 keysDown = 0;
    UniChar chars[4];
    UniCharCount realLength;
    
    UCKeyTranslate(keyboardLayout,
                   keyCode,
                   kUCKeyActionDisplay,
                   0,
                   LMGetKbdType(),
                   kUCKeyTranslateNoDeadKeysBit,
                   &keysDown,
                   sizeof(chars) / sizeof(chars[0]),
                   &realLength,
                   chars);
    CFRelease(currentKeyboard);
    
    return (__bridge NSString *)CFStringCreateWithCharacters(kCFAllocatorDefault, chars, 1);
}

- (void)awakeFromNib {
    [(EPKeyCatcherView *)self.view setKeyEventDelegate:self];
    [super awakeFromNib];
    
    // Init our players Array
    self.players = [NSMutableArray new];
    
    // INIT ALL THE PATHS!!!
    self.samples = @[
                     [self getSampleWithName:@"WorkIt1"],
                     [self getSampleWithName:@"MakeIt1"],
                     [self getSampleWithName:@"DoIt1"],
                     [self getSampleWithName:@"MakesUs1"],
                     [self getSampleWithName:@"MoreThan1"],
                     [self getSampleWithName:@"Hour1"],
                     [self getSampleWithName:@"Our1"],
                     [self getSampleWithName:@"Never1"],
                     [self getSampleWithName:@"Harder1"],
                     [self getSampleWithName:@"Better1"],
                     [self getSampleWithName:@"Faster1"],
                     [self getSampleWithName:@"Stronger1"],
                     [self getSampleWithName:@"Ever1"],
                     [self getSampleWithName:@"After1"],
                     [self getSampleWithName:@"WorkIs1"],
                     [self getSampleWithName:@"Over1"]
                    ];
    self.samples_2 = @[
                       [self getSampleWithName:@"WorkIt2"],
                       [self getSampleWithName:@"MakeIt2"],
                       [self getSampleWithName:@"DoIt2"],
                       [self getSampleWithName:@"MakesUs2"],
                       [self getSampleWithName:@"MoreThan2"],
                       [self getSampleWithName:@"Hour2"],
                       [self getSampleWithName:@"Our2"],
                       [self getSampleWithName:@"Never2"],
                       [self getSampleWithName:@"Harder2"],
                       [self getSampleWithName:@"Better2"],
                       [self getSampleWithName:@"Faster2"],
                       [self getSampleWithName:@"Stronger2"],
                       [self getSampleWithName:@"Ever2"],
                       [self getSampleWithName:@"After2"],
                       [self getSampleWithName:@"WorkIs2"],
                       [self getSampleWithName:@"Over2"]
                      ];
    self.samples_3 = @[
                       [self getSampleWithName:@"WorkIt1"],
                       [self getSampleWithName:@"MakeIt1"],
                       [self getSampleWithName:@"DoIt1"],
                       [self getSampleWithName:@"MakesUs1"],
                       [self getSampleWithName:@"MoreThan3"],
                       [self getSampleWithName:@"Hour3"],
                       [self getSampleWithName:@"Our3"],
                       [self getSampleWithName:@"Never3"],
                       [self getSampleWithName:@"Harder1"],
                       [self getSampleWithName:@"Better1"],
                       [self getSampleWithName:@"Faster1"],
                       [self getSampleWithName:@"Stronger1"],
                       [self getSampleWithName:@"Ever3"],
                       [self getSampleWithName:@"After3"],
                       [self getSampleWithName:@"WorkIs3"],
                       [self getSampleWithName:@"Over3"]
                       ];
    // Prepare the buttons with the right keys
    // Q
    [_ButtonQ setTitle:[createStringForKey(kVK_ANSI_Q) uppercaseString]];
    // W
    [_ButtonW setTitle:[createStringForKey(kVK_ANSI_W) uppercaseString]];
    // E
    [_ButtonE setTitle:[createStringForKey(kVK_ANSI_E) uppercaseString]];
    // R
    [_ButtonR setTitle:[createStringForKey(kVK_ANSI_R) uppercaseString]];
    // U
    [_ButtonU setTitle:[createStringForKey(kVK_ANSI_U) uppercaseString]];
    // I
    [_ButtonI setTitle:[createStringForKey(kVK_ANSI_I) uppercaseString]];
    // O
    [_ButtonO setTitle:[createStringForKey(kVK_ANSI_O) uppercaseString]];
    // P
    [_ButtonP setTitle:[createStringForKey(kVK_ANSI_P) uppercaseString]];
    // A
    [_ButtonA setTitle:[createStringForKey(kVK_ANSI_A) uppercaseString]];
    // S
    [_ButtonS setTitle:[createStringForKey(kVK_ANSI_S) uppercaseString]];
    // D
    [_ButtonD setTitle:[createStringForKey(kVK_ANSI_D) uppercaseString]];
    // F
    [_ButtonF setTitle:[createStringForKey(kVK_ANSI_F) uppercaseString]];
    // J
    [_ButtonJ setTitle:[createStringForKey(kVK_ANSI_J) uppercaseString]];
    // K
    [_ButtonK setTitle:[createStringForKey(kVK_ANSI_K) uppercaseString]];
    // L
    [_ButtonL setTitle:[createStringForKey(kVK_ANSI_L) uppercaseString]];
    // Semicolon
    [_ButtonSemicolon setTitle:[createStringForKey(kVK_ANSI_Semicolon) uppercaseString]];
    // Z
    [_ButtonZ setTitle:[createStringForKey(kVK_ANSI_Z) uppercaseString]];
    // X
    [_ButtonX setTitle:[createStringForKey(kVK_ANSI_X) uppercaseString]];
    // N
    [_ButtonN setTitle:[createStringForKey(kVK_ANSI_N) uppercaseString]];
    
    // Prepare main player
    NSURL *url = [self getSampleWithName:@"instru"];
    _mainplayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    [_mainplayer setNumberOfLoops:-1];
    [_mainplayer prepareToPlay];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
}

- (NSURL *)getSampleWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name
                                                     ofType:@"mp3"
                                                inDirectory:@"samples"];
    if (!path) {
        return nil;
    }
    return [NSURL fileURLWithPath:path];
}

- (IBAction)soundboardClick:(NSButton *)sender {
    [self playWithId:sender.tag];
}

- (IBAction)modifierClick:(NSButton *)sender {
    if (sender.tag == _modifier) {
        [sender setState:NSOnState];
        return;
    }
    _modifier = sender.tag;
    if (sender != _ButtonZ)
        [_ButtonZ setState:NSOffState];
    if (sender != _ButtonX)
        [_ButtonX setState:NSOffState];
    if (sender != _ButtonN)
        [_ButtonN setState:NSOffState];
}

- (IBAction)spaceClick:(NSButton *)sender {
    if (_mainplayer.playing) {
        [_mainplayer stop];
        [_mainplayer setCurrentTime:0];
    } else {
        [_mainplayer play];
    }
}

- (void)playWithId:(NSInteger)theId {
    NSError *err;
    
    // Init the audio player object
    NSURL *fileurl = [self.samples objectAtIndex:theId];
    
    if (_modifier == 2) {
        if ([self.samples_2 objectAtIndex:theId])
            fileurl = [self.samples_2 objectAtIndex:theId];
    } else if (_modifier == 3) {
        if ([self.samples_3 objectAtIndex:theId])
            fileurl = [self.samples_3 objectAtIndex:theId];
    }
    
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileurl
                                                                   error:&err];
    
    // Add it to our players array to keep a reference to them
    [self.players addObject:player];
    [player setDelegate:self];
    [player prepareToPlay];
    [player play];
}

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    // Remove player from players array when finished playback
    [self.players removeObject:player];
}

- (void)view:(NSView *)aView didHandleKeyDownEvent:(NSEvent *)anEvent {
    // Now let's handle our key stuff, finally!
    switch (anEvent.keyCode) {
        case kVK_ANSI_Q:
            // Q - Work it!
            [_ButtonQ performClick:self];
            break;
        case kVK_ANSI_W:
            // W - Make it!
            [_ButtonW performClick:self];
            break;
        case kVK_ANSI_E:
            // E - Do it!
            [_ButtonE performClick:self];
            break;
        case kVK_ANSI_R:
            // R - Make us!
            [_ButtonR performClick:self];
            break;
        case kVK_ANSI_U:
            // U - More than!
            [_ButtonU performClick:self];
            break;
        case kVK_ANSI_I:
            // I - Hour!
            [_ButtonI performClick:self];
            break;
        case kVK_ANSI_O:
            // O - Our!
            [_ButtonO performClick:self];
            break;
        case kVK_ANSI_P:
            // P - Never!
            [_ButtonP performClick:self];
            break;
        case kVK_ANSI_A:
            // A - Harder!
            [_ButtonA performClick:self];
            break;
        case kVK_ANSI_S:
            // S - Better!
            [_ButtonS performClick:self];
            break;
        case kVK_ANSI_D:
            // D - Faster!
            [_ButtonD performClick:self];
            break;
        case kVK_ANSI_F:
            // F - Stronger!
            [_ButtonF performClick:self];
            break;
        case kVK_ANSI_J:
            // J - Ever
            [_ButtonJ performClick:self];
            break;
        case kVK_ANSI_K:
            // K - after
            [_ButtonK performClick:self];
            break;
        case kVK_ANSI_L:
            // L - work is
            [_ButtonL performClick:self];
            break;
        case kVK_ANSI_Semicolon:
            // ; - over!
            [_ButtonSemicolon performClick:self];
            break;
        case kVK_ANSI_Z:
            // Z Modifier
            [_ButtonZ performClick:self];
            break;
        case kVK_ANSI_X:
            // X Modifier
            [_ButtonX performClick:self];
            break;
        case kVK_ANSI_N:
            // N Modifier
            [_ButtonN performClick:self];
            break;
        case kVK_Space:
            // Space!
            [_ButtonSpace performClick:self];
            break;
            
        default:
            break;
    }
}

@end
