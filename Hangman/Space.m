//
//  Space.m
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import "Space.h"


@implementation Space

@synthesize _xPosition;
@synthesize _yPosition;
@synthesize _size;
@synthesize _image;
@synthesize _tag;
@synthesize _character;

//NSInteger tag = 100;

-(id)initWithXPosition:(NSInteger)xPos yPosition:(NSInteger)yPos character:(NSString*)c
{
    self = [super init];
    
    if (self)
    {
        _xPosition = xPos;
        _yPosition = yPos;
        
        _size = 15.0f;
        
        _image = [[UIImage alloc] initWithContentsOfFile:@"placeholder.png"];
        
        _character = c;
        
        //tag = tag + 1;
        unichar x = [c characterAtIndex:0];
        _tag = x;
    }
    return (self);
}

-(CGRect)bounds
{
    CGRect boundsRect = CGRectMake(_xPosition,_yPosition,_size,_size);
    
    return(boundsRect);
}

-(NSString*)getCharacter
{
    return _character;
}

-(NSInteger)getTag
{
    return _tag;
}

-(void)dealloc
{
    [_image release];
    [super dealloc];
}

@end

