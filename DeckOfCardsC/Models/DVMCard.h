//
//  DVMCard.h
//  DeckOfCardsC
//
//  Created by Timothy Rosenvall on 7/2/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DVMCard : NSObject

@property (nonatomic, copy) NSString *suitName;
@property (nonatomic, copy) NSString *imagePath;

-(instancetype)initWithSuit:(NSString *)suitName
                  imagePath:(NSString *)imagePath;

@end

@interface DVMCard (JSONConvertable)

- (NSMutableArray<DVMCard *>*)fetchFromDictionary:(NSDictionary<NSString *, id> *)topLevelDictionary;

@end

NS_ASSUME_NONNULL_END
