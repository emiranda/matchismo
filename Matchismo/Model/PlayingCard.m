//
//  PlayingCard.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// Override super class contents so we provide a suit and rank
- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit]; 
}

@synthesize suit = _suit;

-(int)match:(NSArray *)otherCards
{
    int score = 0;

    // Keeps track of the count to see how many valid matches we have
    int rankCount = 0;
    int suitCount = 0;
    
    for (PlayingCard *otherCard in otherCards) {
        if([self.suit isEqualToString:otherCard.suit])
            suitCount++;
        
        if(self.rank == otherCard.rank)
            rankCount++;
    }
    
    if (suitCount == otherCards.count)
        score = 1;
    
    if(rankCount == otherCards.count)
        score = 4;
    
    return score;
}

// Use the suit getter to make a default suit
- (NSString *)suit
{
    return (_suit) ? _suit : @"?";
}

// Use the suit getter to only set valid suits
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit])
    {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [PlayingCard rankStrings].count - 1;
}

+ (NSArray *)validSuits
{
    return @[@"♥", @"♦", @"♠", @"♣"];
}

@end
