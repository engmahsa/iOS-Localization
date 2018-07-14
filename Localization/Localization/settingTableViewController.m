//
//  settingTableViewController.m
//  Localization
//
//  Created by Mahsa on 12/17/17.
//

#import "settingTableViewController.h"
#import "LocalizationSystem.h"

@interface settingTableViewController ()

@property(nonatomic,strong) NSArray *dataSource;
@end

@implementation settingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [UIView new];
    self.dataSource = [[NSArray alloc] initWithObjects:@"فارسی",@"English",@"German",@"French", nil];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell.textLabel setText: [self.dataSource objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        LocalizationSetLanguage(@"fa-CN");
        [[NSUserDefaults standardUserDefaults] setObject:@"fa-CN" forKey:@"language"];
    }else if (indexPath.row == 1){
         LocalizationSetLanguage(@"en");
        [[NSUserDefaults standardUserDefaults] setObject:@"en" forKey:@"language"];
    } else if (indexPath.row == 2) {
        [[NSUserDefaults standardUserDefaults] setObject:@"german" forKey:@"language"];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:@"french" forKey:@"language"];
    }
    // set a delegate to update tabbar
    [self.navigationController popViewControllerAnimated:YES];
}

@end
