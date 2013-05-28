//
//  Deck.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "Deck.h"

@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

// Implement the getter of cards so we also
// get at the very least an empty array
- (NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(Card *)card atTop:(BOOL)atTop
{
    if(atTop)
    {
        [self.cards insertObject:card atIndex:0];
    }else
    {
        [self.cards addObject:card];
    }
    
}

-(Card *)drawRandomCard
{
    Card *randomCard = nil;
    
    if (self.cards.count){
        
        unsigned index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
