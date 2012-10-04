//
//  Space.h
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Space : NSObject
{
@private
    NSInteger _xPosition;
    NSInteger _yPosition;
    NSInteger _size;
    UIImage* _image;
    NSString* _character;
    NSInteger _tag;
}

@property (assign) NSInteger _xPosition;
@property (assign) NSInteger _yPosition;
@property (assign) NSInteger _size;
@property (retain) UIImage* _image;
@property (assign) NSString* _character;
@property (assign) NSInteger _tag;

-(id)initWithXPosition:(NSInteger)xPos yPosition:(NSInteger)yPos character:(NSString*)c;
-(CGRect)bounds;
-(NSString*)getCharacter;
-(NSInteger)getTag;

@end

