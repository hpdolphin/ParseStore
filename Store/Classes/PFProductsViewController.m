//
//  PFProductsViewController.m
//  Stripe
//
//  Created by Andrew Wang on 2/26/13.
//  Copyright (c) 2013 Parse Inc. All rights reserved.
//

#import "PFProductsViewController.h"
#import "PFShippingViewController.h"

#define ROW_MARGIN 6.0f
#define ROW_HEIGHT 173.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface PFProductsViewController ()
@property (nonatomic, strong) UIPickerView *pickerView;
@end

@implementation PFProductsViewController


#pragma mark - Life cycle

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Product"];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.rowHeight = ROW_HEIGHT;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *poweredImage = [UIImage imageNamed:@"Powered.png"];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake((self.tableView.frame.size.width - poweredImage.size.width)/2.0f, 0.0f, self.tableView.frame.size.width, poweredImage.size.height + ROW_MARGIN * 2.0f)];
    UIButton * poweredButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [poweredButton setImage:poweredImage forState:UIControlStateNormal];
    [poweredButton addTarget:self action:@selector(openBrowser:) forControlEvents:UIControlEventTouchUpInside];
    poweredButton.frame = CGRectMake(0.0f, -4.0f, poweredImage.size.width, poweredImage.size.height + 20.0f);
    [footer addSubview:poweredButton];
    self.tableView.tableFooterView = footer;

    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0.0f, self.view.frame.size.height, self.tableView.frame.size.width, 216.0f)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    self.pickerView.hidden = YES;
    [self.view addSubview:self.pickerView];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Product";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    } else {
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view removeFromSuperview];
        }];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CGFloat x = ROW_MARGIN;
    CGFloat y = indexPath.row == 0 ? ROW_MARGIN : ROW_MARGIN/2.0f;
    
    UIImage *backgroundImage = [UIImage imageNamed:@"Product.png"];
    UIEdgeInsets backgroundInsets = UIEdgeInsetsMake(backgroundImage.size.height/2.0f, backgroundImage.size.width/2.0f, backgroundImage.size.height/2.0f, backgroundImage.size.width/2.0f);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:[backgroundImage resizableImageWithCapInsets:backgroundInsets]];
    backgroundImageView.frame = CGRectMake(x, y, tableView.frame.size.width - ROW_MARGIN*2.0f, 167.0f);
    [cell.contentView addSubview:backgroundImageView];
    x += 10.0f;
    
    NSDictionary *info = [PFProducts productInfo][indexPath.row];
    UIImage *productImage = [UIImage imageNamed:info[@"internalName"]];
    UIImageView *productImageView = [[UIImageView alloc] initWithImage:productImage];
    productImageView.frame = CGRectMake(x, y + 1.0f, productImage.size.width, productImage.size.height);
    [cell.contentView addSubview:productImageView];
    x += productImage.size.width + 5.0f;
    y += 10.0f;
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    priceLabel.text = [NSString stringWithFormat:@"$%d", [info[@"price"] intValue]];
    priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
    priceLabel.textColor = [UIColor colorWithRed:14.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    priceLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    priceLabel.backgroundColor = [UIColor clearColor];
    [priceLabel sizeToFit];
    CGFloat priceX = tableView.frame.size.width - priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
    priceLabel.frame = CGRectMake(priceX, ROW_MARGIN + 10.0f, priceLabel.frame.size.width, priceLabel.frame.size.height);
    [cell.contentView addSubview:priceLabel];

    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    nameLabel.text = info[@"name"];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    nameLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    nameLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    nameLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    nameLabel.backgroundColor = [UIColor clearColor];
    [nameLabel sizeToFit];
    y = indexPath.row == PFProductNameMug ? 55.0f : 45.0f;
    nameLabel.frame = CGRectMake(x + 2.0f, y, nameLabel.frame.size.width, nameLabel.frame.size.height);
    [cell.contentView addSubview:nameLabel];
    y += nameLabel.frame.size.height + 2.0f;
    
    if (indexPath.row != PFProductNameMug) {
        UIButton *sizeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sizeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [sizeButton setTitle:NSLocalizedString(@"Select Size", @"Select Size") forState:UIControlStateNormal];
        [sizeButton setTitleColor:[UIColor colorWithRed:95.0f/255.0f green:95.0f/255.0f blue:95.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
        [sizeButton setTitleEdgeInsets:UIEdgeInsetsMake(0.0f, 16.0f, 0.0f, 0.0f)];
        sizeButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];
        [sizeButton setTitleShadowColor:[UIColor whiteColor] forState:UIControlStateNormal]; 
        sizeButton.titleLabel.textColor = [UIColor colorWithRed:95.0f/255.0f green:95.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
        sizeButton.titleLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        
        UIImage *sizeImage = [UIImage imageNamed:@"DropdownButton.png"];
        UIImage *sizePressedImage = [UIImage imageNamed:@"DropdownButtonPressed.png"];
        UIEdgeInsets insets = UIEdgeInsetsMake(sizeImage.size.height/2, sizeImage.size.width/2, sizeImage.size.height/2, sizeImage.size.width/2);
        [sizeButton setBackgroundImage:[sizeImage resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
        [sizeButton setBackgroundImage:[sizePressedImage resizableImageWithCapInsets:insets] forState:UIControlStateHighlighted];
        sizeButton.frame = CGRectMake(x, y, 157.0f, sizeImage.size.height);
        
        UIImage *arrowImage = [UIImage imageNamed:@"Arrow.png"];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:arrowImage];
        arrowView.frame = CGRectMake(140.0f, (sizeButton.frame.size.height - arrowImage.size.height)/2.0f, arrowImage.size.width, arrowImage.size.height);
        [sizeButton addSubview:arrowView];
        [sizeButton addTarget:self action:@selector(selectSize:) forControlEvents:UIControlEventTouchUpInside];
        sizeButton.tag = SIZE_BUTTON_TAG_OFFSET + indexPath.row;
        [cell.contentView addSubview:sizeButton];
        y += sizeButton.frame.size.height + 5.0f;
    } else {
        y += 6.0f;
    }
    
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderButton setTitle:NSLocalizedString(@"Order", @"Order") forState:UIControlStateNormal];
    orderButton.titleLabel.shadowColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    orderButton.titleLabel.shadowOffset = CGSizeMake(0.0f, -0.5f);
    orderButton.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0f];

    UIImage *orderImage = [UIImage imageNamed:@"ButtonOrder.png"];
    UIImage *orderPressedImage = [UIImage imageNamed:@"ButtonOrderPressed.png"];
    UIEdgeInsets insets = UIEdgeInsetsMake(orderImage.size.height/2, orderImage.size.width/2, orderImage.size.height/2, orderImage.size.width/2);
    [orderButton setBackgroundImage:[orderImage resizableImageWithCapInsets:insets] forState:UIControlStateNormal];
    [orderButton setBackgroundImage:[orderPressedImage resizableImageWithCapInsets:insets] forState:UIControlStateHighlighted];
    orderButton.frame = CGRectMake(x, y, 80.0f, orderImage.size.height);
    [orderButton addTarget:self action:@selector(next:) forControlEvents:UIControlEventTouchUpInside];
    orderButton.tag = indexPath.row;
    [cell.contentView addSubview:orderButton];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return ROW_HEIGHT + ROW_MARGIN/2.0f;
    } else {
        return ROW_HEIGHT;
    }
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // When any cell is selected, we dismiss the picker view.
    // If you want the cell selection to do some useful work, you can dismiss the picker view in the callback of a gesture recognizer, or implement an accessory control to the picker view that dismisses it.
    [UIView animateWithDuration:0.1f animations:^{
        self.pickerView.frame = CGRectMake(0.0f, self.view.frame.size.height, tableView.frame.size.width, 216.0f);
    } completion:^(BOOL finished) {
        self.pickerView.hidden = YES;
        // The table view's scrolling is disabled when the picker view is shown. Re-enable it here.
        self.tableView.scrollEnabled = YES;
    }];
}


#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // We show all product names and "Select Size".
    return [PFProducts sizes].count + 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return row == 0 ? NSLocalizedString(@"Select Size", @"Select Size") : [PFProducts sizes][row - 1];
}


#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    UIButton *sizeButton = (UIButton *)[self.tableView viewWithTag:pickerView.tag];
    NSString *title = [self pickerView:pickerView titleForRow:row forComponent:component];
    [sizeButton setTitle:title forState:UIControlStateNormal];
}


#pragma mark - Event handlers

- (void)next:(UIButton *)button {
    UIButton *sizeButton = (UIButton *)[self.tableView viewWithTag:(button.tag + SIZE_BUTTON_TAG_OFFSET)];
    NSString *size = sizeButton ? [sizeButton titleForState:UIControlStateNormal] : nil;
    
    if (button.tag != PFProductNameMug && [size isEqualToString:NSLocalizedString(@"Select Size", @"Select Size")]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Missing Size", @"Missing Size") message:NSLocalizedString(@"Please select a size.", @"Please select a size.") delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", @"OK") otherButtonTitles:nil];
        [alertView show];
    } else {
        PFShippingViewController *shippingController = [[PFShippingViewController alloc] initWithProductName:button.tag size:size];
        [self.navigationController pushViewController:shippingController animated:YES];        
    }
}

- (void)selectSize:(id)sender {
    // This method shows the picker view for size selection.
    
    // Scroll to the top so that the picker view does not conceal any input.
    [self.tableView setContentOffset:CGPointZero animated:YES];
    
    // Disable scrolling in the table view so that user stays focused on the picker view.
    self.tableView.scrollEnabled = NO;
    
    // Assign the tag to the picker so that the picker knows which product's size it is selecting.
    self.pickerView.tag = ((UIButton *)sender).tag;

    self.pickerView.hidden = NO;
    
    // Default for picker view's initial selection.
    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    [UIView animateWithDuration:0.1f animations:^{
        self.pickerView.frame = CGRectMake(0.0f, self.view.frame.size.height - 216.0f, self.tableView.frame.size.width, 216.0f);
    }];
}

- (void)openBrowser:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.parse.com/store"]];
}

@end
