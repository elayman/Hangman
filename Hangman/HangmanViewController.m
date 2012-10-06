//
//  HangmanViewController.m
//  Hangman
//
//  Created by Evan Layman on 10/3/12.
//  Copyright (c) 2012 Evan Layman. All rights reserved.
//

#import "HangmanViewController.h"
#import "HangmanModel.h"
#import "Space.h"

@interface HangmanViewController ()

@end

@implementation HangmanViewController

@synthesize _ourView;
@synthesize _ourModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    _ourModel = [[HangmanModel alloc] initWithBounds:[_ourView bounds]];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    _ourView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, width, height)];
    [_ourView setBackgroundColor:[UIColor whiteColor]];
    self.view = _ourView;
    //Set up first hangman image
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    UIImage *hangManImage = [[UIImage alloc] initWithContentsOfFile:[thisBundle pathForResource:@"hang0" ofType:@"jpg"]];

    UIImageView *hangManSubview = [[UIImageView alloc] initWithImage:hangManImage];
    [hangManImage release];
    [hangManSubview setTag:5];
    CGRect hangManBounds = CGRectMake([_ourView bounds].origin.x,[_ourView bounds].origin.y,272.0f,150.0f);
    [hangManSubview setBounds:hangManBounds];
    hangManSubview.center = CGPointMake(272/2+25, 75.0f);
    [_ourView addSubview:hangManSubview];
    [_ourView setNeedsDisplay];
    [self setUpWord];
    [self setUpKeyboard];
}

-(void)setUpWord
{
    //Place word and placeholders on page
    NSString *word = [_ourModel getCurrentWord];
    CGRect labelBounds = CGRectMake(0.0f,0.0f,20.0f,20.0f);
    CGPoint center = CGPointMake([_ourView bounds].origin.x,[_ourView bounds].origin.y + 175.0f);
    
    NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
    UIImage *placeholderImage = [[UIImage alloc] initWithContentsOfFile:[thisBundle pathForResource:@"placeholder" ofType:@"png"]];
    for (NSInteger i=0; i<[word length]; i++)
    {
        //charactersAvailableForString
        NSRange range = NSMakeRange(i, 1);
        NSString* s = [word substringWithRange:range];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGPoint newCenter;
        
        if (center.x < screenWidth - 60.0f)
        {
            if ([s isEqualToString:@" "])
            {
                center = CGPointMake(center.x + 25.0f, center.y);
                continue;
            } else
            {
                newCenter = CGPointMake(center.x + 30.0f, center.y);
            }
        } else
        {
            //shift letters to a new line
            newCenter = CGPointMake([_ourView bounds].origin.x + 30.0f, center.y + 35.0f);
        }
        center = newCenter;
        //Place label
        UILabel *l = [[UILabel alloc] initWithFrame:labelBounds];
        l.backgroundColor = [UIColor clearColor];
        l.center = center;
        l.textColor = [UIColor blackColor];
        l.text = s;
        [_ourView addSubview:l];
        //Place Space over it
        [_ourModel createAndAddSpaceInBounds:labelBounds withCharacter:s];
        
        UIImageView *placeholderSubview = [[UIImageView alloc] initWithImage:placeholderImage];
        [placeholderImage release];
        [placeholderSubview setBounds:labelBounds];

        unichar x = [s characterAtIndex:0];
        [placeholderSubview setTag:x];
        placeholderSubview.center = center;
        [_ourView addSubview:placeholderSubview];
    }

    [_ourView setNeedsDisplay];
}

-(void)setUpKeyboard
{
    CGRect keyBounds = CGRectMake(0.0f,0.0f,35.0f,35.0f);
    CGPoint center = CGPointMake([_ourView bounds].origin.x - 20,[_ourView bounds].origin.y + 300.0f);

    NSArray* letters = [[NSArray alloc] initWithObjects:@"P", @"Y", @"F", @"G", @"C", @"R", @"L", @"A", @"O", @"E", @"U", @"I", @"D", @"H", @"T", @"N", @"S", @"Q", @"J", @"K", @"X", @"B", @"M", @"W", @"V", @"Z", nil];
    for (NSInteger i=0; i<26; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGPoint newCenter;
        
        if (center.x < screenWidth - 60.0f)
        {
            newCenter = CGPointMake(center.x + 45.0f, center.y);
        } else
        {
            //shift letters to a new line
            newCenter = CGPointMake([_ourView bounds].origin.x + 25.0f, center.y + 45.0f);
        }
        center = newCenter;
        //Place label
        [button setTitle:letters[i] forState:UIControlStateNormal];
        //unichar x = [letters[i] characterAtIndex:0];
        //[button setTag:0];
        button.center = center;
        button.bounds = keyBounds;
        
        //Set button trigger event
        [button addTarget:self action:@selector(guessedLetter:) forControlEvents:UIControlEventTouchUpInside];
        
        [_ourView addSubview:button];
    }
    
    [_ourView setNeedsDisplay];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)guessedLetter:(UIButton*)sender
{
    NSLog(@"text is %@ and tag is %d", sender.titleLabel.text, sender.tag);

    //Update model and get an array of spaces to be removed
    NSMutableArray *toBeRemovedItems = [_ourModel guessedLetter:[sender titleLabel].text];

    for (id obj in toBeRemovedItems)
    {
        if ([obj isKindOfClass:[Space class]]){
            //Remove all spaces over letters equal to our guess
            //This also removes your guess since it has same tag
            [[_ourView viewWithTag:[obj getTag]] removeFromSuperview];
            [_ourModel removeSpace:(Space*)obj];
        } else{
            //Remove the hangman view and add next one
            if ([obj isKindOfClass:[NSNumber class]]){
                NSInteger o = [obj intValue];
                UIView *hangmanView = [_ourView viewWithTag:o];
                //hangmanView.hidden = YES;
                NSLog(@"Button superview is %@, Removing view: %@", sender.superview, hangmanView);
                [_ourView bringSubviewToFront:hangmanView];
                [hangmanView removeFromSuperview];
    
                NSBundle *thisBundle = [NSBundle bundleForClass:[self class]];
                UIImage *hangManImage = [[UIImage alloc] initWithContentsOfFile:[thisBundle pathForResource:[[NSString alloc] initWithFormat:@"hang%d", o+1] ofType:@"jpg"]];
                UIImageView *hangManSubview = [[UIImageView alloc] initWithImage:hangManImage];
                [hangManImage release];
                [hangManSubview setTag:o+1];
                CGRect hangManBounds = CGRectMake([_ourView bounds].origin.x,[_ourView bounds].origin.y,272.0f,150.0f);
                hangManSubview.center = CGPointMake(272/2+25, 75.0f);
                [hangManSubview setBounds:hangManBounds];
                [_ourView addSubview:hangManSubview];
                
                //Remove letter from keyboard by tag: unichar ASCII value of the char
                //[sender removeFromSuperview];
            }
        }
    }
    [sender setHidden:YES];
    [_ourView bringSubviewToFront:sender];
    
    NSLog(@"numguessesleft is %d", [_ourModel getNumGuessesLeft]);
    //Check if game is over
    if ([[_ourModel getSpaces] count] == 0)
    {
        //You won!
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Won!" message:@"Congratulations" delegate:self cancelButtonTitle:@"New Game" otherButtonTitles:nil, nil];
        [alert setAlertViewStyle:UIAlertViewStyleDefault];
        [alert show];
        
    } else if ([_ourModel getNumGuessesLeft] == 0)
    {
        //You Lost
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Lost!" message:[NSString stringWithFormat:@"Better luck next time. The word was %@", [_ourModel getCurrentWord]] delegate:self cancelButtonTitle:@"New Game" otherButtonTitles:nil, nil];
        [alert setAlertViewStyle:UIAlertViewStyleDefault];
        [alert show];
    }
    
    
    [_ourView setNeedsDisplay];
    
}

#pragma mark - Alert View Delegate

//Restart game
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == [alertView cancelButtonIndex]) {
		[self viewDidLoad];
	}
}

-(void)dealloc
{
    [_ourModel release];
    [_ourView release];
    [super dealloc];
}

@end
