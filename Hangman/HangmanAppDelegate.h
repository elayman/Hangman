//
//  HangmanAppDelegate.h
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HangmanViewController;

@interface HangmanAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) HangmanViewController *viewController;

@end
