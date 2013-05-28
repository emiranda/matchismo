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
@interface CardGameViewController ()


// An array  has a strong pointer to all the things in the array
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

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

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self dealNewGame:nil];
}


-(void)setCardButtons:(NSArray *)cardButtons
{
    UIImage *cardImage = [UIImage imageNamed:@"playing-card-back.jpg"];
    UIImage *blank = [[UIImage alloc] init];
    
    for (UIButton *button in cardButtons) {
        [button setImage:cardImage forState:UIControlStateNormal];
        [button setImage:blank forState:UIControlStateSelected];
        [button setImage:blank forState:UIControlStateSelected|UIControlStateDisabled];
        button.imageEdgeInsets = UIEdgeInsetsMake(3, 3, 3, 3);
    }

    
    _cardButtons = cardButtons;
}


// This getter needs to be overriden in the sub classes for the appropraite game

- (CardMatchingGame *)game
{

    if (!_game)
            _game = [[ CardMatchingGame alloc] initWithCardCount:self.cardButtons.count
                                                   usingDeck:self.deck
                                                   matchMode:self.matchCount matchBonus:self.matchBonus misMatchPenalty:self.misMatchPenalty];
    return _game;
}

-(NSString *)parseCardContentsForDisplay:(Card *)card
{
    return card.contents;
}



-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons)
    {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        [cardButton setTitle:[self parseCardContentsForDisplay:card] forState:UIControlStateSelected];
        
        [cardButton setTitle:[self parseCardContentsForDisplay:card] forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayble;
        
        cardButton.alpha = card.isUnplayble ? 0.3 : 1.0;
    }
    self.score = [self.game  score];
    self.flipCount = [self.game flipCount];
    
    // Put the appropriate message
    if (self.game.lastMatchPoints > 0) {
        
        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
        [cardContents addObject:self.game.lastCardFliped.contents];
        
        for (Card *card in self.game.lastMatchedAgainstCards) {
            [cardContents addObject:card.contents];
        }
        
        self.flipMessageLabel.text = [@[@"Matched ", [cardContents componentsJoinedByString:@"&"], [NSString stringWithFormat:@"%d", self.game.lastMatchPoints], @" point!"] componentsJoinedByString:@""];
        
   
    
    }else if(self.game.lastMatchPoints < 0){
        
        NSMutableArray *cardContents = [[NSMutableArray alloc] init];
        [cardContents addObject:self.game.lastCardFliped.contents];
        
        for (Card *card in self.game.lastMatchedAgainstCards) {
            [cardContents addObject:card.contents];
        }
        
        self.flipMessageLabel.text = [@[[cardContents componentsJoinedByString:@"&"], @" Don't match! ",[NSString stringWithFormat:@"%d", self.game.lastMatchPoints], @" point penalty."] componentsJoinedByString:@""];
        

    }else if(self.game.lastMatchPoints == 0 && self.game.lastCardFliped)
    {
        self.flipMessageLabel.text = [@[@"Flipped up a ", self.game.lastCardFliped.contents] componentsJoinedByString:@""];
    }

    // If this is a new game but a "start flipping message"
    if (self.game.flipCount == 0) {
        self.flipMessageLabel.text = @"Start Flipping!";
    }

    
}

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
- (IBAction)changeMatchMode:(UISegmentedControl *)sender {
    
    // This should never be called when the game is going on since
    // the component would be disabled
    // Call dealNewGame so we start a new game with the new
    // value of the component
    
    [self dealNewGame:nil];
    
}

- (IBAction)flipCard:(UIButton *)sender {
    
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipMessageLabel.alpha = 1;
    [self updateUI];


}


@end
