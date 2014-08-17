//
//  MainTableViewController.m
//  CreatingUITableViews
//
//  Created by John Malloy on 8/9/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import "MainTableViewController.h"
#import "CountryCell.h"

@interface MainTableViewController ()

@end

@implementation MainTableViewController

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
    self.title = @"Countries";
    self.countriesTableView.delegate = self;
    self.countriesTableView.dataSource = self;
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.countriesTableView registerClass:CountryCell.class  forCellReuseIdentifier:@"CountryCell"];
    
    Country * usa = [[Country alloc] init];
    usa.name = @"United States Of America";
    usa.motto = @"E Pluribus Unum";
    usa.capital = @"Washington DC";
    usa.flag = [UIImage imageNamed:@"usa.png"];
    
    Country * france = [[Country alloc] init];
    france.name = @"Frech Republic";
    france.motto = @"Liberte, Egalite, Fraternite";
    france.capital = @"Paris";
    france.flag = [UIImage imageNamed:@"france.png"];
    
    Country * england = [[Country alloc] init];
    england.name = @"England";
    england.motto = @"Dieu et mon droit";
    england.capital = @"London";
    england.flag = [UIImage imageNamed:@"england.png"];
    
    Country * scotland = [[Country alloc] init];
    scotland.name = @"Scotland";
    scotland.motto = @"In My Defens God Me Defend";
    scotland.capital = @"Edinburgh";
    scotland.flag = [UIImage imageNamed:@"scotland.png"];
    
    Country * spain = [[Country alloc] init];
    spain.name = @"Kingdom of Spain";
    spain.motto = @"Plus Ultra";
    spain.capital = @"Madrid";
    spain.flag = [UIImage imageNamed:@"Spain.png"];
    
    self.unitedKingdomCountries = [NSMutableArray arrayWithObjects:england,scotland, nil];
    self.nonUKCountries = [NSMutableArray arrayWithObjects:usa,france,spain,nil];
    self.countries = [NSMutableArray arrayWithObjects:self.unitedKingdomCountries,self.nonUKCountries,nil];

}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * group = [self.countries objectAtIndex:section];
    return [group count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CountryCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CountryCell"];
    NSArray * group = [self.countries objectAtIndex:indexPath.section];
    cell.country = [group objectAtIndex:indexPath.row];
    return cell;
    
    
    // The following code is used when we don't have a custome cell class for out project
    /*static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.font = [UIFont systemFontOfSize:19.0];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12]; 
     
        
    
         FYI!!!!!   Four Cell Accessory Types:
         UITableViewAccessoryNone = Specifies the lack of an accessory
         UiTableViewCellAccessoryDisclosureIndicator = Adds a gray area on the right side of the row
         UITableViewCellAccessoryDetailDisclosureButton = Specifies an iteraction eneabled button
         UITableViewCellAccessoryCheckmark = adds a checkmark on a given row, useful in conjunction with the taleView:didSelectRowAtIndexPath method to make it possible to add and remove check marks from a list
        
    }
    
    NSArray * group = [self.countries objectAtIndex:indexPath.section];
    Country * item = [group objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.detailTextLabel.text = item.capital;
    cell.imageView.image = [MainTableViewController scale:item.flag toSize:CGSizeMake(115, 75)];
    
    return cell;

    */
}


+ (UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}


//implementing the CountryDetailsViewController's delegate!!!! the beginUpdates and endUpdates are somewhat unesscary here but are useful for reloading the data in a table view

-(void)countryDetailsViewControllerDidFinish:(CountryDetailsViewController *)sender
{
    if (selectedIndexPath)
    {
        [self.countriesTableView beginUpdates];
        [self.countriesTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:selectedIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.countriesTableView endUpdates];
    }
    selectedIndexPath = nil;
}



/*
    the uitableview class has a multitude of other delegate methods for dealing with the selection or deselection of a row and they include the following
 
    tableView:willSelectRowAtIndexPath = Lets the delegate know that a row is about to be selected
    tableView:didSelectRowAtIndexPath = Lets the delegate know a row was selected
    tableView:willDeSelectRowRowAtIndexPath = Lets the delegate know that a row is about to de-selected
    tableView:didDeSelectRowAtIndexPath = lets the delegate know that a row was de- selected
 
    Using these four delegate methods, you can fully customize the behavior of a UITableView to fit any application
 
 */

//the following method, didSelectRowAtIndexPath is a UITableView delegate method. It allows you to act on the selection of a given row in a tableView.

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndexPath = indexPath;
    
    NSArray * group = [self.countries objectAtIndex:indexPath.section];
    Country * chosenCountry = [group objectAtIndex:indexPath.row];
    CountryDetailsViewController * detailedViewController = [[CountryDetailsViewController alloc] init];
    detailedViewController.delegate = self;
    detailedViewController.currentCountry = chosenCountry;
    
    [self.navigationController pushViewController:detailedViewController animated:YES];
}


-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    selectedIndexPath = indexPath;
    
    NSArray * group = [self.countries objectAtIndex:indexPath.section];
    Country * chosenCountry = [group objectAtIndex:indexPath.row];
    CountryDetailsViewController * detailedViewController = [[CountryDetailsViewController alloc] init];
    detailedViewController.delegate = self;
    detailedViewController.currentCountry = chosenCountry;
    
    NSLog(@"Accessory Button Was Tapped");
    [self.navigationController pushViewController:detailedViewController animated:YES];
}

//The following 2 methods need to be implemented so you can edit a UITableView

-(void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.countriesTableView setEditing:editing animated:animated];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle ==  UITableViewCellEditingStyleDelete)
    {
        NSMutableArray * group = [self.countries objectAtIndex:indexPath.section];
        Country * deletedCountry = [group objectAtIndex:indexPath.row];
        [group removeObject:deletedCountry];
        
        [self.countriesTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
    }
        else if (editingStyle == UITableViewCellEditingStyleInsert)
        {
            NSMutableArray * group = [self.countries objectAtIndex:indexPath.section];
            Country * copiedCountry = [self.countries objectAtIndex:indexPath.row];
            Country * newCountry = [[Country alloc] init];
            newCountry.name = copiedCountry.name;
            newCountry.flag = copiedCountry.flag;
            newCountry.capital = copiedCountry.capital;
            newCountry.motto = copiedCountry.motto;
            
            [group insertObject:newCountry atIndex:indexPath.row + 1];
            
            [self.countriesTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationRight];
        }
        
        //Other paramaters for Row Animation are: UITableViewRowAnimationBottom, UITableViewRowAnimationFade, UITableViewRowAnimationLeft, UITableViewRowAnimationMiddle, UITableViewRowAnimationNone, UITableViewRowAnimationRight, UITableViewRowAnimationTop
    }



-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.row % 2) == 1)
    {
        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}

//The following 2 methods are needed to allow the user to ReOrder a UITableView

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    //Assume the same section
    NSMutableArray * group = [self.countries objectAtIndex:sourceIndexPath.section];
    if (destinationIndexPath.row < [group count])
    {
        [group exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
    }
    [self.countriesTableView reloadData];
}

//The following 2 methods need to be implemented for a "Grouped" UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.countries count];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"United Kingdom Countries";
    }
    return @"Non United Kingdom Countries";
}

//The following method allows the developer to customize the text displayed in a "Delete" button when editing a UITableView. The method is optional and varies on use by the needs of the application
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NSLocalizedString(@"Remove", @"Delete");
}

//The following method will add footers to your tableView cell's
-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (section == 0)
        return @"United Kingdom Countries";
    return @"Non United Kingdom Countries";
        
    
}

@end
