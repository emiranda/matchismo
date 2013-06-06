//
//  SetCardView.m
//  Matchismo
//
//  Created by Edgar Miranda on 6/5/13.
//  Copyright (c) 2013 Edgar Miranda. All rights reserved.
//

#import "SetCardView.h"

@implementation SetCardView

#define shapePadding 5



- (void)drawRect:(CGRect)rect
{
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12.0];
    
    [roundedRect addClip];

    
    if(self.selected)
    {
        [[UIColor grayColor] setFill];

    }else{
        [[UIColor whiteColor] setFill];
    }
    [roundedRect fill];

    if([self.color isEqualToString:[SetCardView validColors][0]])
    {
        [[UIColor redColor] setFill];
        [[UIColor redColor] setStroke];
    }else if([self.color isEqualToString:[SetCardView validColors][1]])
    {
        [[UIColor greenColor] setFill];
        [[UIColor greenColor] setStroke];
    }else if([self.color isEqualToString:[SetCardView validColors][0]])
    {
        [[UIColor blueColor] setFill];
        [[UIColor blueColor] setStroke];
    }

    
    float shapeSize = ((self.bounds.size.height / [SetCardView maxCount]) - shapePadding  * [SetCardView maxCount]);
    
    
    for (int i = 0; i < self.count; i++) {
        
        float yValue =  (self.bounds.size.height / (self.count + 1) * (i + 1)) + (i *  shapePadding);
        
        if ([self.shape isEqualToString:[SetCardView validShapes][0]]) {
            [self drawTriangle:CGPointMake(self.bounds.size.width / 2, yValue) withSize:shapeSize];
        }else if([self.shape isEqualToString:[SetCardView validShapes][1]]){
            [self drawCircle:CGPointMake(self.bounds.size.width / 2, yValue) withRadius:shapeSize];
        }else if([self.shape isEqualToString:[SetCardView validShapes][2]]){
                // Square
            [self drawSquare:CGPointMake(self.bounds.size.width / 2, yValue) withWidth:shapeSize];
        }
    }
    
    
        
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
}

- (void)drawTriangle:(CGPoint)center withSize:(float)length
{
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    
    [triangle moveToPoint:CGPointMake(center.x, center.y - length / 2)];
    [triangle addLineToPoint:CGPointMake(center.x + length,center.y + length)];
    [triangle addLineToPoint:CGPointMake(center.x - length,center.y + length)];
    [triangle closePath];
    
    
    [triangle stroke];
    [triangle fillWithBlendMode:0 alpha:[SetCardView shadeFloatValues:self.shade]];
    
}

- (void)drawCircle:(CGPoint)center withRadius:(float)radius
{

    UIBezierPath *circle = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:180 clockwise:YES];
    
    [circle stroke];
    [circle fillWithBlendMode:0 alpha:[SetCardView shadeFloatValues:self.shade]];
}

- (void)drawSquare:(CGPoint)center withWidth:(float)width
{
    UIBezierPath *square = [UIBezierPath bezierPathWithRect:CGRectMake(center.x - width, center.y - width, width * 2, width * 2)];
    
    [square stroke];
    [square fillWithBlendMode:0 alpha:[SetCardView shadeFloatValues:self.shade]];
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

+ (NSUInteger)maxCount
{
    return 3;
}

+(float)shadeFloatValues:(NSString *)shade
{
    if([shade isEqualToString:[SetCardView validShades][0]])
        return 0;
    
    if([shade isEqualToString:[SetCardView validShades][1]])
        return .1;
    
    if([shade isEqualToString:[SetCardView validShades][2]])
        return 1;
    
    return 0;
}


- (void)setColor:(NSString *)color
{
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShape:(NSString *)shape
{
    _shape = shape;
    [self setNeedsDisplay];
}

- (void)setShade:(NSString *)shade
{
    _shade = shade;
    [self setNeedsDisplay];
}

- (void)setCount:(NSUInteger)count
{
    _count = count;
    [self setNeedsDisplay];
}

- (void)setup
{
    
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    [self setup];
    return self;
}

@end
