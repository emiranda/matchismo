//
//  PlayingCard.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

// Valid suits are "♥", "♦", "♠", "♣"
@property (strong, nonatomic) NSString *suit;

// Ranks range from 1-13
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
