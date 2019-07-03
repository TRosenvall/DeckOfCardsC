//
//  CardViewController.m
//  DeckOfCardsC
//
//  Created by Timothy Rosenvall on 7/2/19.
//  Copyright © 2019 Timothy Rosenvall. All rights reserved.
//

#import "CardViewController.h"
#import "DVMCardController.h"
#import "DVMCard.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardSuitLabel;

@end

@implementation CardViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)updateViews
{
    [DVMCardController.sharedInstance drawNewCards:1 completion:^(NSArray<DVMCard *> *cards, NSError *error)
     {
         if (error)
         {
             NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
             return;
         }
         if (cards)
         {
             DVMCard* card = cards[0];
             [DVMCardController.sharedInstance fetchCardImage:card completion:^(UIImage *currImage, NSError *error)
              {
                  if (error)
                  {
                      NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
                      return;
                  }
                  if (currImage)
                  {
                      dispatch_async( dispatch_get_main_queue(), ^{
                          self.cardSuitLabel.text = card.suitName;
                          self.cardImageView.image = currImage;
                      });
                  }
              }];
         }
     }];
}


- (IBAction)ChooseNewCardButtonTapped:(id)sender {
    [self updateViews];
}

@end
