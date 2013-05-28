//
//  Card.h
//  Matchismo
//
//  Created by Edgar Miranda on 5/22/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (nonatomic, strong) NSString *contents;
@property (nonatomic, getter = isFaceUp) BOOL faceUp;
@property (nonatomic, getter = isUnplayble) BOOL unplayable;
    
-(int)match:(NSArray *)otherCards;

@end
