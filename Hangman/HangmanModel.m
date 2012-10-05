//
//  HangmanModel.m
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import "HangmanModel.h"
#import "HangmanWords.h"
#import "Space.h"

@implementation HangmanModel

-(id)initWithBounds:(CGRect)rect
{
    self = [super init];
    if (self)
    {
        _spaces = [[NSMutableArray alloc] init];
        _bounds = rect;
        
        [self generateWord];
        _numGuessesLeft = 6;
        _currentState = 5;
        
    }
    
    return self;
}

-(void)createAndAddSpaceInBounds:(CGRect)bounds withCharacter:(NSString *)c
{
    Space* newSpace;
    
    NSInteger _xPosition = bounds.origin.x;
    NSInteger _yPosition = bounds.origin.y;
    
//    if ([_spaces count] == 0){
//    
////        NSInteger leftEdge = 
////        NSInteger topEdge = 
////        NSInteger rightEdge = ( _bounds.origin.x + _bounds.size.width );
////        NSInteger bottomEdge = ( _bounds.origin.x + _bounds.size.height );
//        
//        _xPosition = _bounds.origin.x + 10.0f;
//        _yPosition = _bounds.origin.y + 100.0f;
//        
//        newSpace = [[Space alloc] initWithXPosition:_xPosition yPosition:_yPosition];
//        [_spaces addObject:newSpace];
//    
//    } else{
//    
//    Space *lastObject = [_spaces objectAtIndex:([_spaces count]-1)];
//    _xPosition = [lastObject bounds].origin.x + 35.0f;
//    _yPosition = [lastObject bounds].origin.y;
    
    
    newSpace = [[Space alloc] initWithXPosition:_xPosition yPosition:_yPosition character:c];
    
//    }
    [_spaces addObject:newSpace];
    
    [newSpace release];
}

-(void)generateWord
{
    HangmanWords* words = [[HangmanWords alloc] init];
    _word = [[words getWord] retain];
    [words release];
}

-(NSString*)getCurrentWord
{
    return _word;
}

-(NSMutableArray*)getSpaces
{
    return _spaces;
}

-(NSInteger)getNumGuessesLeft
{
    return _numGuessesLeft;
}

-(NSMutableArray*)guessedLetter:(NSString*)guess
{
    NSMutableArray *toBeRemovedItems = [[NSMutableArray alloc] init];
    if ([_word rangeOfString:guess].location == NSNotFound) {
        NSLog(@"%@ does not contain %@", _word, guess);
        //Subtract one guess
        _numGuessesLeft = _numGuessesLeft - 1;
        //Add currentState to remove view and add next one
        [toBeRemovedItems addObject:[[NSNumber alloc] initWithInteger:_currentState]];
        _currentState = _currentState + 1;
    } else {
        NSLog(@"string contains character");
        BOOL guessedCorrect = NO;
        for (Space *s in _spaces)
        {
            NSLog(@"space's character is %@",[s getCharacter]);
            if ([guess isEqualToString:[s getCharacter]])
            {
                //Add to array to be removed in controller
                [toBeRemovedItems addObject:s];

                guessedCorrect = YES;     
            }
        }
    }
    return toBeRemovedItems;
}

-(void)removeSpace:(Space*)s
{
    //Remove space from array
    [_spaces removeObject:s];
}
-(void)dealloc
{
    [_word release];
    [_spaces release];
    [super dealloc];
}

@end
