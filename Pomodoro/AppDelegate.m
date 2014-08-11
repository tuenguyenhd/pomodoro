//
//  AppDelegate.m
//  Pomodoro
//
//  Created by Tue Nguyen on 8/11/14.
//  Copyright (c) 2014 Tue Nguyen. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    NSMenu *statusMenu;
    NSStatusItem *statusMenuItem;
    NSTimer *pomoTimer;
    int countTimer;
}
@end

#define POM_TIME_SECOND 1500

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    [self setupStatusMenu];
}

- (void) setupStatusMenu {
    NSMenuItem *startItem = [[NSMenuItem alloc] initWithTitle:@"Start" action:@selector(start) keyEquivalent:@"StartAction"];
    NSMenuItem *stopItem = [[NSMenuItem alloc] initWithTitle:@"Stop" action:@selector(stop) keyEquivalent:@"StopAction"];
    NSMenuItem *quitItem = [[NSMenuItem alloc] initWithTitle:@"Quit" action:@selector(quit) keyEquivalent:@"StopAction"];
    
    [stopItem setEnabled:NO];
    statusMenu = [[NSMenu alloc] initWithTitle:@"Pomodoro"];
    statusMenuItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [statusMenuItem setTitle:@"Pomodoro"];
    [statusMenuItem setMenu:statusMenu];
    [statusMenuItem setHighlightMode:YES];
    [statusMenu addItem:startItem];
    [statusMenu addItem:stopItem];
    [statusMenu addItem:quitItem];
    
    [self.window setMenu:statusMenu];
}

- (void) start {
    NSMenuItem *stopItem = [statusMenu itemWithTitle:@"Stop"];
    NSMenuItem *startItem = [statusMenu itemWithTitle:@"Start"];
    [stopItem setEnabled:YES];
    [startItem setEnabled:NO];
    countTimer = 0;
    pomoTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                 target:self selector:@selector(pomodoroTick) userInfo:nil repeats:YES];
}

- (void) stop {
    NSMenuItem *stopItem = [statusMenu itemWithTitle:@"Stop"];
    NSMenuItem *startItem = [statusMenu itemWithTitle:@"Start"];
    [statusMenuItem setTitle:@"Pomodoro"];
    [stopItem setEnabled:NO];
    [startItem setEnabled:YES];
    countTimer = 0;
    if (pomoTimer) {
        [pomoTimer invalidate];
        pomoTimer = nil;
    }
}

- (void) quit {
    [NSApp terminate:self];
}

- (void) pomodoroTick {
    countTimer ++;
    if (countTimer == POM_TIME_SECOND) {
        /**
         *  Play sound also
         */
        [[NSSound soundNamed:@"beep"] play];
    }
    else {
        int minute = (POM_TIME_SECOND - countTimer)/60;
        int second = (POM_TIME_SECOND - countTimer) - minute*60;
        [statusMenuItem setTitle:[NSString stringWithFormat:@"%d:%d", minute, second]];
    }
    
}
@end
