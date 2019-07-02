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

- (NSMutableArray<DVMCard *>*)fetchFromDictionary:(NSDictionary<NSString *, id> *)topLevelDictionary;
{
    NSMutableArray<DVMCard*> *drawnCards = [NSMutableArray<DVMCard*> new];
    NSArray *cardsArray = topLevelDictionary[@"cards"];
    if (![cardsArray isKindOfClass:[NSArray class]]) {
        return nil;
    }
    for (NSDictionary *dictionary in cardsArray)
    {
        NSString *suitName = dictionary[@"image"];
        NSString *imagePath = dictionary[@"suit"];
        
        DVMCard *card = [[DVMCard alloc] initWithSuit:suitName imagePath:imagePath];
        
        [drawnCards addObject:card];
    }

    return drawnCards;
}

@end
