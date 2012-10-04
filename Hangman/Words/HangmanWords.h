//
//  HangmanWords.h
//  
//
//  Created by Kevin Jorgensen on 2/22/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HangmanWords : NSObject {
	NSArray *words;
}

/**
 Return a randomly chosen phrase from the words.plist file (which consists of uppercase letters and spaces only)
 */
- (NSString *) getWord;

@end
