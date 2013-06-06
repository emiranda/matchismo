//
//  MatchCardGameViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "MatchCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"


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

- (void)updateCardView:(UIView *)cardView withCard:(Card *)card
{
   if([cardView isMemberOfClass:[PlayingCardView class]] && [card isMemberOfClass:[PlayingCard class]])
   {
       PlayingCardView *playingCardView = (PlayingCardView *)cardView;
       PlayingCard *playingCard = (PlayingCard *)card;
       
       playingCardView.rank = playingCard.rank;
       playingCardView.suit = playingCard.suit;
       playingCardView.faceUp = playingCard.isFaceUp;
       
       playingCardView.alpha = playingCard.isUnplayble ? 0.3 : 1.0;
   }
}

@end
