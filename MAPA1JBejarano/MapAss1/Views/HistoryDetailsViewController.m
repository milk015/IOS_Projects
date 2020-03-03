//
//  HistoryDetailsViewController.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "HistoryDetailsViewController.h"

@interface HistoryDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *qtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *TotalLabel;

@end

@implementation HistoryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ticketNameLabel.text = self.ticketName;
    self.ticketIDLabel.text = self.ticketID;
    self.qtyLabel.text = self.ticketqty;
    self.dateLabel.text = self.ticketDate;
    self.TotalLabel.text = self.ticketPrice;
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
