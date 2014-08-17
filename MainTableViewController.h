//
//  MainTableViewController.h
//  CreatingUITableViews
//
//  Created by John Malloy on 8/9/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Country.h"
#import "CountryDetailsViewController.h"

@interface MainTableViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, CountryDetailsViewControllerDelegate>

//Create an instance variable that refers to the index path of whichever row was selected so that you can save processing power by only refreshing the selected row (selectedPath)

{
    NSIndexPath * selectedIndexPath;
}

@property (weak, nonatomic) IBOutlet UITableView *countriesTableView;

@property (strong,nonatomic) NSMutableArray * countries;
@property (strong,nonatomic) NSMutableArray * unitedKingdomCountries;
@property (strong,nonatomic) NSMutableArray * nonUKCountries;



@end
