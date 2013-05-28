//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/23/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// The designated initializer 
-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(Deck *)deck
             matchMode:(int) matchMode
            matchBonus:(int) matchBonus
       misMatchPenalty:(int) misMatchPenalty;

-(void)flipCardAtIndex:(NSUInteger)index;

-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, readonly) NSString *flipMessage;
@property (nonatomic, readonly) int flipCount;
@property (nonatomic, readonly) Card *lastCardFliped;
@property (nonatomic, readonly) NSArray *lastMatchedAgainstCards;
@property (nonatomic, readonly) int lastMatchPoints;


@end
