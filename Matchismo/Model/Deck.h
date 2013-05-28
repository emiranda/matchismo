//
//  Deck.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
