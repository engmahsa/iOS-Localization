//
//  ViewController.m
//  Localization
//
//  Created by Mahsa on 12/16/17.

#import "ViewController.h"
#import "LocalizationSystem.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *hiLbl;
@property (weak, nonatomic) IBOutlet UILabel *welcomLbl;
@property (weak, nonatomic) IBOutlet UIButton *pushBtn;
@property (weak, nonatomic) IBOutlet UILabel *nextLbl;

@end

@implementation ViewController

-(void)viewWillAppear:(BOOL)animated{
    
    LocalizationSetLanguage([[NSUserDefaults standardUserDefaults] objectForKey:@"language"]);
    
    [self.hiLbl setText:AMLocalizedString(@"hi", nil)];
    [self.welcomLbl setText:AMLocalizedString(@"welcome", nil)];

    self.pushBtn.layer.cornerRadius = 8.0;
    self.pushBtn.layer.borderColor = [UIColor grayColor].CGColor;
    self.pushBtn.layer.borderWidth = 1.0;
    self.pushBtn.layer.masksToBounds = YES;

    self.nextLbl.text = AMLocalizedString(@"Change language", nil);
    self.nextLbl.textColor = [UIColor grayColor];
    
    if (LocalizationIsLanguageRightToLeft) {
        self.hiLbl.textAlignment = NSTextAlignmentRight;
        self.welcomLbl.textAlignment = NSTextAlignmentRight;
        self.nextLbl.textAlignment  = NSTextAlignmentRight;
    }else{
        self.hiLbl.textAlignment = NSTextAlignmentLeft;
        self.welcomLbl.textAlignment = NSTextAlignmentLeft;
        self.nextLbl.textAlignment  = NSTextAlignmentLeft;
    }
        [[self.tabBarController.tabBar.items objectAtIndex:0] setTitle:AMLocalizedString(@"First", nil)];
        [[self.tabBarController.tabBar.items objectAtIndex:1] setTitle:AMLocalizedString(@"Second", nil)];

}

@end
