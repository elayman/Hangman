//
//  HangmanViewController.h
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HangmanModel.h"


@interface HangmanViewController : UIViewController
{
@private
    UIView* _ourView;
    HangmanModel* _ourModel;
}
@property (retain) UIView* _ourView;
@property (retain) HangmanModel* _ourModel;



-(void)setUpWord;
-(void)guessedLetter:(UIButton*)sender;

@end
