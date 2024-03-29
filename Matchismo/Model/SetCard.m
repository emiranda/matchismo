//
//  SetCard.m
//  Matchismo
//
//  Created by Edgar Miranda on 5/27/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

// Override super class contents so we provide a suit and rank
- (NSString *)contents
{
    NSString *countString = [NSString stringWithFormat:@"%d", self.count];
    
    NSArray *arrayContents = @[self.color, self.shape, self.shape, countString];
    
    return [arrayContents componentsJoinedByString:@""];
}



-(int)match:(NSArray *)otherCards
{
    int score = 1;
    
    // I could improve this by just not subtracting and settin gallDifferent to 0
    int allSame = 2; // should match exactly twice in the same category for a match
    int allDifferent = -2; // Should match never for in the same category for being different within the category
    
    // Keeps track of the count to see how many valid matches we have
    int colorMatches = 0;
    int shapeMatches = 0;
    int shadeMatches = 0;
    int countMatches = 0;
    
    SetCard *c2, *c3;
    
    if (otherCards.count == 2) {
        c2 = otherCards[0];
        c3 = otherCards[1];
    }

        
    
    for (SetCard *otherCard in otherCards) {

        [self.color isEqualToString:otherCard.color] ? colorMatches++ : colorMatches--;
        [self.shape isEqualToString:otherCard.shape] ? shapeMatches++ : shapeMatches--;
        [self.shade isEqualToString:otherCard.shade] ? shadeMatches++ : shadeMatches--;
        self.count == otherCard.count ? countMatches++ : countMatches--;
    }
    

    
    if(!(colorMatches == allSame || colorMatches == allDifferent))
        return 0;
    
    if(!(shapeMatches == allSame || shapeMatches == allDifferent))
        return 0;
    
    if(!(shadeMatches == allSame || shadeMatches == allDifferent))
        return 0;
    
    if(!(countMatches == allSame || countMatches == allDifferent))
        return 0;
    

    return score;
}


+ (NSArray *)validColors
{
    return @[@"red", @"green", @"blue"];
}

+ (NSArray *)validShapes
{
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShades
{
    return @[@"solid", @"striped", @"open"];
}

+(float)shadeFloatValues:(NSString *)shade
{
    if([shade isEqualToString:[SetCard validShades][0]])
        return 0;
    
    if([shade isEqualToString:[SetCard validShades][1]])
        return .1;
    
    if([shade isEqualToString:[SetCard validShades][2]])
        return 1;
    
    return 0;
}

+ (NSUInteger)maxCount
{
    return 3;
}


@end
