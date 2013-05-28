//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

-(Deck *)deck
{
    return [[SetCardDeck alloc] init];
}

-(int)matchCount
{
    return 3;
}

-(int)matchBonus
{
    return 8;
}

-(int)misMatchPenalty
{
    return 1;
}

-(NSString *)parseCardContentsForDisplay:(Card *)card
{
    
    
    
    return card.contents;
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
