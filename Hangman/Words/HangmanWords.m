//
//  HangmanWords.m
//  
//
//  Created by Kevin Jorgensen on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HangmanWords.h"


@implementation HangmanWords

- (id) init {
	if ((self = [super init])) {
		words = [[NSArray alloc] initWithContentsOfFile: [[NSBundle mainBundle] pathForResource: @"words" ofType: @"plist"]];
		
		srand(time(NULL));
	}
	return self;
}


- (NSString *) getWord {
	int index = rand() % [words count];
	return [words objectAtIndex: index];
}


- (void) dealloc {
	[words release];
	[super dealloc];
}

@end
