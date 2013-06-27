//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

// Private properties go in here
@interface CardGameViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

// An array  has a strong pointer to all the things in the arra


@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *cardViews;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UICollectionView *cardCollectionView;

// This is set to weak because the view points strongly to it
// so if the view isn't using this anymore you don't need it
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (nonatomic) int score;
@property (nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipMessageLabel;

@end

@implementation CardGameViewController

// For loading a game stine

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;//self.game.numberOfCards;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCard"  forIndexPath:indexPath];
    
    Card *card = [self.game cardAtIndex:indexPath.item];
    [self updateCell:cell usingCard:card];
    return cell;
}

- (void)updateCell:(UICollectionViewCell *)cell  usingCard:(Card *)card
{
    // Abstract
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    [self dealNewGame:nil];
}

-(void)setCardViews:(NSArray *)cardViews
{
    for(UIView *view in cardViews)
    {
        UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipCard:)];
        
        [view addGestureRecognizer:recognizer];
        
    }

    _cardViews = cardViews;
}

-(void)setCardButtons:(NSArray *)cardButtons
{

    
    for (UIButton *button in cardButtons) {
        
        [self buttonDisplay:button];
    }
    _cardButtons = cardButtons;
}

-(void)buttonDisplay:(UIButton *)button
{
    
    UIImage *cardImage = [UIImage imageNamed:@"playing-card-back.jpg"];
    UIImage *blank = [[UIImage alloc] init];
    
    [button setImage:cardImage forState:UIControlStateNormal];
    [button setImage:blank forState:UIControlStateSelected];
    [button setImage:blank forState:UIControlStateSelected|UIControlStateDisabled];
    button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
}




// This getter needs to be overriden in the sub classes for the appropraite game

- (CardMatchingGame *)game
{

    if (!_game)
            _game = [[ CardMatchingGame alloc] initWithCardCount:[self startingCardCount]
                                                   usingDeck:[self getDeck]
                                                   matchMode:self.matchCount matchBonus:self.matchBonus misMatchPenalty:self.misMatchPenalty];
    return _game;
}

- (Deck *)getDeck
{
    // abstract
    return nil;
}

- (NSUInteger)startingCardCount
{
    // abstract
    return 0;

}

-(NSAttributedString *)parseCardContentsForDisplay:(Card *)card
{
    return [[NSAttributedString alloc] initWithString:card.contents];
}

-(void)updateButtonUI:(UIButton *)button withLabel:(NSAttributedString *) attrString
{
    [button setAttributedTitle:attrString forState:UIControlStateSelected];
    [button setAttributedTitle:attrString forState:UIControlStateSelected|UIControlStateDisabled];
    
}

- (void)updateCardView:(UIView *)cardView withCard:(Card *)card
{
    // abstract
}


-(void)updateUI
{
    
    for (UIView *cardView in self.cardViews) {
        Card *card = [self.game cardAtIndex:[self.cardViews indexOfObject:cardView]];

        [self updateCardView:cardView withCard:card];
        
    }
    
//    for (UIView *cardView in self.cardViews) {
//       Card *card = [self.game cardAtIndex:[self.cardViews indexOfObject:cardView]];
        
//        
        
//    }
    
    /*
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayble;
        
        cardButton.alpha = card.isUnplayble ? 0.3 : 1.0;
        
        [self updateButtonUI:cardButton withLabel:[self parseCardContentsForDisplay:card]];
      
    }
    */
    
    
    self.score = [self.game  score];
    self.flipCount = [self.game flipCount];
    
    // Put the appropriate message
    if (self.game.lastMatchPoints > 0) {

        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
        [cardContents addObject:self.game.lastCardFliped];
        
        for (Card *card in self.game.lastMatchedAgainstCards) {
            [cardContents addObject:card];
        }
        
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
        for (Card *card in cardContents) {
            //            [cardContents addObject:[self parseCardContentsForDisplay:card]];
            
            [message appendAttributedString:[self parseCardContentsForDisplay:card]];
            
            if(card != self.game.lastMatchedAgainstCards[self.game.lastMatchedAgainstCards.count - 1])
                [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
            
        }
        
        NSString *points = [@[[NSString stringWithFormat:@"%d", self.game.lastMatchPoints], @" point!"] componentsJoinedByString:@""];
        
        [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:points]];
        
        
        self.flipMessageLabel.attributedText = message;

    }else if(self.game.lastMatchPoints < 0){

        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
        [cardContents addObject:self.game.lastCardFliped];
        
        for (Card *card in self.game.lastMatchedAgainstCards) {
            [cardContents addObject:card];
        }
        
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@""];
        for (Card *card in cardContents) {
//            [cardContents addObject:[self parseCardContentsForDisplay:card]];
            
            [message appendAttributedString:[self parseCardContentsForDisplay:card]];
            
            if(card != self.game.lastMatchedAgainstCards[self.game.lastMatchedAgainstCards.count - 1])
            [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:@" & "]];
        
        }
        
        NSString *points = [@[[NSString stringWithFormat:@"%d", self.game.lastMatchPoints], @" point penalty."] componentsJoinedByString:@""];
   
        [message appendAttributedString:[[NSMutableAttributedString alloc] initWithString:points]];

        
        self.flipMessageLabel.attributedText = message;

    }else if(self.game.lastMatchPoints == 0 && self.game.lastCardFliped)
    {
        NSMutableAttributedString *message = [[NSMutableAttributedString alloc] initWithString:@"Flipped up a "];
        
        [message appendAttributedString:[self parseCardContentsForDisplay:self.game.lastCardFliped]];
        
    }

    // If this is a new game but a "start flipping message"
    if (self.game.flipCount == 0) {
        self.flipMessageLabel.attributedText = [[NSAttributedString alloc] initWithString:@"Start Flipping!"];
    }

    
}

// Perhaps create a function that parsing for the fip message.

-(void)setScore:(int)score
{
    _score = score;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score %d", self.score];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)dealNewGame:(id)sender {
    
    // All we have to do is create a new game
    self.game = nil;
//    self.gameHistory = nil;
    [self updateUI];
    
}

- (IBAction)flipCard:(UITapGestureRecognizer *)sender {

    [self.game flipCardAtIndex:[self.cardViews indexOfObject:sender.view]];
    self.flipMessageLabel.alpha = 1;
    [self updateUI];

}

@end