//
//  Card.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    

    for (Card *card in otherCards)
    {
        if([card.contents isEqualToString:self.contents])
        {
            score =  1;
        }else
        {
    
            // In case we are testing multiple cards, return 0 as
            // we find a card that doesn't match
            return 0;
        }
    }
    return score;
}

@end
