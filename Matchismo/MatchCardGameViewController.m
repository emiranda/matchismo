//
//  MatchCardGameViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "MatchCardGameViewController.h"
#import "PlayingCardDeck.h"


@interface MatchCardGameViewController ()

@end

@implementation MatchCardGameViewController

-(int)matchBonus
{
    return 4;
}

-(int)misMatchPenalty
{
    return 1;
}

-(Deck *)deck
{
    return [[PlayingCardDeck alloc] init];
}

-(int)matchCount
{
    return 2;
}

// For this view control the actual contents is perfectly fine
-(NSAttributedString *)parseCardContentsForDisplay:(Card *)card
{
    return [[NSAttributedString alloc]initWithString:card.contents];
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
