//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"
#import "SetCardCollectionViewCell.h"


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

- (void)updateCell:(UICollectionViewCell *)cell usingCard:(Card *)card
{
    // Abstract
    
    if([cell isKindOfClass:[SetCardCollectionViewCell class]] && [card isKindOfClass:[SetCard class]])
    {
        SetCardView *setCardView = ((SetCardCollectionViewCell *)cell).setCardView;
        SetCard *setCard = (SetCard *)card;
        
        setCardView.shade = setCard.shade;
        setCardView.shape = setCard.shape;
        setCardView.count = setCard.count;
        setCardView.color = setCard.color;
    }
}

- (NSUInteger)startingCardCount
{
    // abstract
    return 4;
    
}

- (Deck *)getDeck
{
    // abstract
    return [[SetCardDeck alloc] init];
}

- (void)updateCardView:(UIView *)cardView withCard:(Card *)card
{
    if([cardView isMemberOfClass:[SetCardView class]] && [card isMemberOfClass:[SetCard class]])
    {
        SetCardView *setCardView = (SetCardView *)cardView;
        SetCard *setCard = (SetCard *)card;
        
        setCardView.shape = setCard.shape;
        setCardView.shade = setCard.shade;
        setCardView.color = setCard.color;
        setCardView.count = setCard.count;
        
        setCardView.selected = setCard.isFaceUp;
        
        setCardView.alpha = setCard.isUnplayble ? 0.3 : 1.0;
        
//        playingCardView.rank = playingCard.rank;
//        playingCardView.suit = playingCard.suit;
//        playingCardView.faceUp = playingCard.isFaceUp;
        
//        playingCardView.alpha = playingCard.isUnplayble ? 0.3 : 1.0;
    }
}

-(void)buttonDisplay:(UIButton *)button
{

    [button setBackgroundColor:[UIColor grayColor]];
    button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
}

-(void)updateButtonUI:(UIButton *)button withLabel:(NSAttributedString *) attrString
{
    [button setAttributedTitle:attrString forState:UIControlStateSelected];
    [button setAttributedTitle:attrString forState:UIControlStateNormal];
    
    [button setAttributedTitle:attrString forState:UIControlStateSelected|UIControlStateDisabled];
    if (button.selected) 
        [button setBackgroundColor:[UIColor grayColor]];
    else
        [button setBackgroundColor:[UIColor clearColor]];
}

-(NSMutableAttributedString *)parseCardContentsForDisplay:(Card *)card
{
    NSMutableString *displayText = [[NSMutableString alloc] initWithString:@""];
    NSMutableAttributedString *attString;
    if([card isMemberOfClass:[SetCard class]])
    {
        SetCard *setCard = (SetCard *)card;
        
        // Put the appropriate number of symboles
        for (int i = 1; i <= setCard.count; i++) {
            [displayText appendString:setCard.shape];
        }
        
        attString = [[NSMutableAttributedString alloc] initWithString:displayText];
        
        SEL colorSelector = NSSelectorFromString([setCard.color stringByAppendingString:@"Color"]);
        UIColor *color;
        
        if([UIColor respondsToSelector:NSSelectorFromString (@"blueColor")])
            color = [UIColor performSelector:colorSelector];
        color = [color colorWithAlphaComponent:1];
        
        NSRange range = NSMakeRange([@0 unsignedIntegerValue], attString.length);

        
        UIColor *forGround = [color colorWithAlphaComponent:[SetCard shadeFloatValues:setCard.shade]];
        
        [attString addAttribute:NSForegroundColorAttributeName value:forGround range: range];
        
        [attString addAttribute:NSStrokeWidthAttributeName value:[NSNumber numberWithFloat: -2.0] range:range];
    
        [attString addAttribute:NSStrokeColorAttributeName value:color range: range];
    
    }
    
    return attString;
}
@end
