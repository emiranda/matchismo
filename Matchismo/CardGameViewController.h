//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (nonatomic) int matchCount;
@property (nonatomic) int matchBonus;
@property (nonatomic) int misMatchPenalty;


-(NSString *)parseCardContentsForDisplay:(Card *)card;

@end
