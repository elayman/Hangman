//
//  HangmanModel.h
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Space.h"

@interface HangmanModel : NSObject
{
@private
    NSMutableArray* _spaces;
    CGRect _bounds;
    NSString* _word;
    NSInteger _numGuessesLeft;
    NSInteger _currentState;
}

-(id)initWithBounds:(CGRect)rect;
-(void)createAndAddSpaceInBounds:(CGRect)bounds withCharacter:(NSString*)c;
-(void)generateWord;
-(NSString*)getCurrentWord;
-(NSMutableArray*)getSpaces;
-(NSInteger)getNumGuessesLeft;
-(NSMutableArray*)guessedLetter:(NSString*)guess;
-(void)removeSpace:(Space*)s;

@end
