//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/23/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic) int score;
@property (strong, readwrite) NSString *flipMessage;
@property (nonatomic) int flipCount;
@property (nonatomic) int matchMode; // Will be either 2 or 3
@property (nonatomic) int matchBonus;
@property (nonatomic) int misMatchPenalty;
@property (strong, readwrite) Card *lastCardFliped;
@property (nonatomic, readwrite) NSArray *lastMatchedAgainstCards;
@property (nonatomic, readwrite) int lastMatchPoints;

@end

@implementation CardMatchingGame

#define FLIP_COST 1

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

// Pass a default flip message if there is no message yet
// this is used so that we see something when the user hits deal
- (NSString *)flipMessage
{
    return _flipMessage ? _flipMessage : @"Start Flipping!";
}


- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck
              matchMode:(int) matchMode
             matchBonus:(int) matchBonus
        misMatchPenalty:(int) misMatchPenalty
{
    self = [super init];
    
    self.matchMode = matchMode;
    self.matchBonus = matchBonus;
    self.misMatchPenalty = misMatchPenalty;
    
    if (self){
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(!card){
                self = nil;
            }else {
                
                // how are we able to just add
                // to whatever index we decide to?
                self.cards[i] = card;
            }
        }
        
    }
    
    return self;
}

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < self.cards.count) ? self.cards[index] : nil;
}


-(void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    NSArray *flipMessageArray = nil;
    NSMutableArray *otherFaceUpPlayableCards;
    
    // Set these values to nothing by default
    self.lastMatchedAgainstCards = 0;
    self.lastMatchPoints = 0;
    self.lastCardFliped = nil;
    
    if(!card.isUnplayble){
        if(!card.isFaceUp){
            // see if flipping this card up creates a match
            otherFaceUpPlayableCards = [[NSMutableArray alloc] init];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayble) {
                    
                    // Keep track of how many other cards that are face up and playable we have
                    // come across
                    [otherFaceUpPlayableCards addObject:otherCard];
                    
                    // Only check for matches if we have the appropriate number of cards face up.
                    // +layable cards has to be one less then match mode, since if we are matching 2
                    // cards we only need one other card, and for 3 we need two other cards
                    if(otherFaceUpPlayableCards.count == self.matchMode - 1){
                    
                        int matchScore = [card match:otherFaceUpPlayableCards];
                        
                        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
                        self.lastMatchedAgainstCards = otherFaceUpPlayableCards;

                        [cardContents addObject:card.contents];
                        
                        for (Card *card in otherFaceUpPlayableCards) {
                            [cardContents addObject:card.contents];
                        }
                        
                        NSString *allFlipedCards = [cardContents componentsJoinedByString:@" & "];
                        
                        if(matchScore){
                            
                            for (Card *otherFaceUpCards in otherFaceUpPlayableCards) {
                                otherFaceUpCards.unplayable = YES;
                            }
                            card.unplayable = YES;
                            
                            // Multiply the score by the number of other cards you have to flip
                            // so if it's 3 = matchScore * matchBonus * 2
                            int pointsEarned = matchScore * self.matchBonus * otherFaceUpPlayableCards.count;
                            self.score += pointsEarned;
                            
                            self.lastMatchPoints = pointsEarned;
                            
                            flipMessageArray = @[@"Matched ", allFlipedCards, @" for ",
                                                 [NSString stringWithFormat:@"%d", pointsEarned]
                                                 , @" points!"];
                        }else{
                            int pointsLost = self.misMatchPenalty;
                            self.score -= pointsLost;
                            
                            self.lastMatchPoints = -pointsLost;
                            
                            flipMessageArray = @[allFlipedCards, @" don't match! ",
                                                  [NSString stringWithFormat:@"%d", pointsLost],
                                                  @" point penalty!"];
                            
                            for (Card *otherFaceUpCards in otherFaceUpPlayableCards) {
                                otherFaceUpCards.faceUp = NO;
                            }
                        }
                    }
                }
            }
            
            // If no flip message, means the user did not find a match
            if(!flipMessageArray){
                flipMessageArray = @[@"Flipped up a ", card.contents];
            }
            
            self.flipMessage = [flipMessageArray componentsJoinedByString:@""];
            self.score -= FLIP_COST;
            self.lastCardFliped = card;
        }
        
        
        card.faceUp = !card.isFaceUp;
        self.flipCount++;
    }
}

@end














