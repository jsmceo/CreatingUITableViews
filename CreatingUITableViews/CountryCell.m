//
//  CountryCell.m
//  CreatingUITableViews
//
//  Created by John Malloy on 8/16/14.
//  Copyright (c) 2014 BigRedINC. All rights reserved.
//

#import "CountryCell.h"

@implementation CountryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        self.textLabel.font = [UIFont systemFontOfSize:19.0];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    
    return self;
}

+(UIImage *)scale:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



-(void)setCountry:(Country *)country
{
    if (country != _country)
    {
        _country = country;
        self.textLabel.text = country.name;
        self.detailTextLabel.text = _country.capital;
        self.imageView.image = [CountryCell scale: _country.flag toSize:CGSizeMake(115, 75)];
    }
}


@end
