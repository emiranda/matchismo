//
//  PlayingCardGameSnapShot.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/25/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardMatchingGame.h"


// Same thing as CardMatchingGame.h except you can read and write to the properties
// This is to allows to create a state for each game
@interface CardMatchingGameSnapshot : CardMatchingGame
@property (nonatomic, readwrite) int score;
@property (nonatomic, readwrite) NSString *flipMessage;
@property (nonatomic, readwrite) int flipCount;

-(void)setCardAtIndex:(NSUInteger)index;

@end
