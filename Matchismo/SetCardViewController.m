//
//  SetCardViewController.m
//  Matchismo
//
//  Created by Edgar Miranda on 6/5/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetCardViewController.h"
#import "SetCardView.h"

@interface SetCardViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *setCardView;

@end

@implementation SetCardViewController

- (void)setSetCardView:(SetCardView *)setCardView
{
//    @"▲", @"●", @"■"];
    _setCardView = setCardView;
    _setCardView.color = @"red";
    _setCardView.shade = @"striped";
    _setCardView.shape = @"▲";
    _setCardView.count = 3;
    
//        return @[@"solid", @"striped", @"open"];
}

@end
