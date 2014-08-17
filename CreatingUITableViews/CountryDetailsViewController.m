//
//  CountryDetailsViewController.m
//  CreatingUITableViews
//
//  Created by John Malloy on 8/11/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import "CountryDetailsViewController.h"

@interface CountryDetailsViewController ()

@end

@implementation CountryDetailsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.mottoTextField.delegate = self;
    self.capitolTextField.delegate = self;
    
    //the following barButtonItem is a button to revert to the original data if the user wishes to not save the changes they made
    
    UIBarButtonItem * revertButton = [[UIBarButtonItem alloc] initWithTitle:@"Revert"
                                                                      style:UIBarButtonItemStyleBordered
                                                                     target:self
                                                                     action:@selector(revert)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObject:revertButton];

}


//Following method populates the view

-(void)populateViewWithCountry:(Country *)country
{
    self.currentCountry = country;
    
    self.flagImageView.image = country.flag;
    self.nameLabel.text = country.name;
    self.capitolTextField.text = country.capital;
    self.mottoTextField.text = country.motto;
}

//You want the previous method to be called after your view is loaded, but right before it is displayed which is the following method viewWillAppear:animated method

-(void)viewDidAppear:(BOOL)animated
{
    [self populateViewWithCountry:self.currentCountry];
}

//dismiss the keyboard when the user is done editing, so the following method needs to be implemented

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

//this will populate the view with the data from the currentCountry property

-(void)revert
{
    [self populateViewWithCountry:self.currentCountry];
}

//Implementing functionality to save any changes to the given country upon returning to your MainTableViewController, the viewWillDisappear method will do that

-(void)viewWillDisappear:(BOOL)animated
{
    //End any editing that might be in progress at this point
    [self.view.window endEditing:YES];
    
    //Update the country object with the new values
    self.currentCountry.capital = self.capitolTextField.text;
    self.currentCountry.motto = self.mottoTextField.text;
    [self.delegate countryDetailsViewControllerDidFinish:self];
}







@end
