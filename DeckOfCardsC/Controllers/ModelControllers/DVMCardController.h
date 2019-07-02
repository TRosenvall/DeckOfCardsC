//
//  DVMCardController.h
//  DeckOfCardsC
//
//  Created by Timothy Rosenvall on 7/2/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVMCard.h"

@interface DVMCardController : NSObject

// Singleton
+(DVMCardController *)sharedInstance;

-(void)drawNewCards:(NSInteger)numberOfCards completion:(void(^) (NSArray<DVMCard *> *cards, NSError *error))completion;

-(void)fetchCardImage:(DVMCard *)currCard completion:(void(^) (UIImage *currImage, NSError *error))completion;

@end
