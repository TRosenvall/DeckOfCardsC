//
//  DVMCardController.m
//  DeckOfCardsC
//
//  Created by Timothy Rosenvall on 7/2/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

#import "DVMCardController.h"
#import <UIKit/UIKit.h>

static NSString * const baseURLString = @"https://deckofcardsapi.com/api/deck/new/draw/";

@implementation DVMCardController

+ (instancetype)sharedInstance {
    static DVMCardController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [DVMCardController new];
    });
    return shared;
}

- (void)drawNewCards:(NSInteger)numberOfCards completion:(void (^)(NSArray<DVMCard *> *, NSError *))completion
{
    NSString *cardCount = [@(numberOfCards) stringValue];
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURLQueryItem *searchQuery = [NSURLQueryItem queryItemWithName:@"count" value:cardCount];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:true];
    
    
    NSArray<NSURLQueryItem*> *queryItems = [[NSArray<NSURLQueryItem*> alloc] initWithObjects:searchQuery, nil];
    
    
    components.queryItems = queryItems;
    NSURL *finalURL = components.URL;
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:2 error:&error];
            if (!topLevelDictionary)
            {
                NSLog(@"Error parsing the JSON: %@", error);
                completion(nil, error);
                return;
            }
            NSMutableArray<DVMCard*> *cards = [[DVMCard alloc] fetchFromDictionary:topLevelDictionary];
            completion(cards, nil);
        }
    }]resume];
}

- (void)fetchCardImage:(DVMCard *)currCard completion:(void (^)(UIImage *, NSError *))completion
{
    NSURL *imageURL = [NSURL URLWithString:currCard.imagePath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:imageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil, error);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            UIImage *cardImage = [[UIImage alloc] initWithData:data];
            completion(cardImage, nil);
        }
    }]resume];
}

@end
