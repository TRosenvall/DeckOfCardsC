//
//  DVMCard.m
//  DeckOfCardsC
//
//  Created by Timothy Rosenvall on 7/2/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

#import "DVMCard.h"

@implementation DVMCard

- (instancetype)initWithSuit:(NSString *)suitName imagePath:(NSString *)imagePath
{
    self = [super init];
    if (self) {
        _suitName = suitName;
        _imagePath = imagePath;
    }
    return self;
}

@end

@implementation DVMCard (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary<NSString *,id> *)topLevelDictionary
{
    NSArray *cardsDictionary = topLevelDictionary[@"cards"];
    if (![cardsDictionary isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSMutableArray<NSString *> *card = [NSMutableArray new];
    // let abilities : [String] = []
    for (NSDictionary *dictionary in card)
    {
        NSString *suitName = dictionary[@"image"];
        NSString *imagePath = dictionary[@"suit"];
        
        return [self initWithSuit:suitName imagePath:imagePath];
    }
    return nil;
}

@end
