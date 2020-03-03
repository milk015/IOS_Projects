//
//  ViewController.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "ViewController.h"
#import "TicketModel.h"
#import "Ticket.h"
#import "ManagerViewController.h"
#import "ResetViewController.h"


@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UpdatingTicketsDele>

@property (weak, nonatomic) IBOutlet UILabel *TotalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *QtyLabel;
@property (weak, nonatomic) IBOutlet UIButton *BuyButton;
@property (weak, nonatomic) IBOutlet UIPickerView *TicketPicker;
@property (weak, nonatomic) IBOutlet UILabel *TicketNameLabel;
@property (strong, nonatomic) TicketModel * ticketManager;

@end

@implementation ViewController


//needed Vars
Ticket * t = nil;
int IDForTickets;
int TicketsToBuyToday;


-(TicketModel *) ticketManager {
    
    if(_ticketManager == nil){
        _ticketManager = [[TicketModel alloc]init];
    }
    
    return _ticketManager;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return self.ticketManager.allTickets.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent: (NSInteger)component{
    t = nil;
    t =  [self.ticketManager.allTickets objectAtIndex:(int)row];
    NSString* ticketString = [[NSString alloc]initWithFormat:@"%d Seats of %@ $%.2f",t.ticketQty,t.ticketName,t.ticketPrice ];
    return ticketString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
     t =  [self.ticketManager.allTickets objectAtIndex:(int) row];
    IDForTickets =(int) row;
    self.TicketNameLabel.text = t.ticketName;
    [self calculate:t];
}

-(void) calculate :(Ticket*) ticket{
    self.TotalPriceLabel.text = [[NSString alloc]initWithFormat:@"%.2f",[self.QtyLabel.text doubleValue] * ticket.ticketPrice];
}

- (IBAction)buyTicket:(id)sender {
        
    if(t == nil){
        t = [self.ticketManager.allTickets objectAtIndex:0];
    }
    
    if(t.ticketQty == 0){
        self.TotalPriceLabel.text = @"Out Of Tickets!";
    }
    
    else{
        int qtyAfterBuy = t.ticketQty - (int)[self.QtyLabel.text integerValue];
        if(qtyAfterBuy <= -1 || [self.TotalPriceLabel.text doubleValue] == 0){
            self.TotalPriceLabel.text = @"ERROR!!";
        }
        else{
            [self.ticketManager buyTicket:qtyAfterBuy atSeat:IDForTickets];
            [self.TicketPicker reloadAllComponents];
            Ticket * ticketBuying = t;
            //NSLog(@"%@ Cost %d",ticketBuying.ticketName,ticketBuying.ticketQty);
            
            [self.ticketManager addTicketToList:ticketBuying NumberOf:(int)[self.QtyLabel.text integerValue] WithPrices:[self.TotalPriceLabel.text doubleValue ]];
            //NSLog(@"%lu", (unsigned long)self.ticketManager.allPurchasedTickets.count );
        }
    }
    
}

- (IBAction)numberPressed:(UIButton*)sender {
    if( ((int)[_TotalPriceLabel.text length]) < 2 ){
        self.QtyLabel.text = [[NSString alloc]initWithFormat:@"%@%@",self.QtyLabel.text, [[sender titleLabel] text] ];
    }
    else{
        self.QtyLabel.text  = [[sender titleLabel] text];
    }
    [self calculate:t];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  
    if([[segue identifier] isEqualToString:@"ManagerSegue"]){
        
        ManagerViewController * managerView = [segue destinationViewController];
        managerView.gate = self.ticketManager;
        NSLog(@"MANASEGUE %lu",self.ticketManager.allPurchasedTickets.count);
        managerView.delegate = self;
        

    }
}

-(void) managerReset:(Ticket *)ticket atID:(int)ID{
    
    [self.ticketManager.allTickets replaceObjectAtIndex:ID withObject:ticket];
    [self.TicketPicker reloadAllComponents];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
