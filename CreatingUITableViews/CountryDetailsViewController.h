//
//  CountryDetailsViewController.h
//  CreatingUITableViews
//
//  Created by John Malloy on 8/11/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"

//Forward declaration needed for the protocol to use the CountryDetailsViewController type

@class CountryDetailsViewController;

@protocol CountryDetailsViewControllerDelegate <NSObject>
-(void)countryDetailsViewControllerDidFinish:(CountryDetailsViewController *)sender;
@end


@interface CountryDetailsViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *capitolTextField;
@property (weak, nonatomic) IBOutlet UITextField *mottoTextField;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;

@property (strong, nonatomic) Country * currentCountry;
@property (strong, nonatomic) id <CountryDetailsViewControllerDelegate> delegate;


@end
