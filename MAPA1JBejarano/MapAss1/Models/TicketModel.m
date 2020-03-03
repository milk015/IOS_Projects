//
//  TicketModel.m
//  MapAss1
//
//  Created by Jorge Bejarano on 2020-02-19.
//  Copyright © 2020 Jorge Bejarano Lucas. All rights reserved.
//

#import "TicketModel.h"
#import "Ticket.h"

@implementation TicketModel

-(NSMutableArray *) allTickets{
    if(_allTickets == nil){
        
        Ticket* t1 = [[Ticket alloc]init];
        [t1 setTicketName:@"Court Side"];
        [t1 setTicketID:1];
        [t1 setTicketPrice:1000];
        [t1 setTicketQty:20];
        
        Ticket* t2 = [[Ticket alloc]init];
        [t2 setTicketName:@"Lower Section"];
        [t2 setTicketID:2];
        [t2 setTicketPrice:500];
        [t2 setTicketQty:20];
        
        Ticket* t3 = [[Ticket alloc]init];
        [t3 setTicketName:@"Middle Section"];
        [t3 setTicketID:3];
        [t3 setTicketPrice:250];
        [t3 setTicketQty:20];
        
        _allTickets = [[NSMutableArray alloc]initWithObjects:t1,t2,t3,nil];
    }
    
    return _allTickets;
}

-(NSMutableArray *) allPurchasedTickets{
    
    if(_allPurchasedTickets == nil){
        _allPurchasedTickets = [[NSMutableArray alloc]init];
    }
    return _allPurchasedTickets;
}

-(void)buyTicket:(int)qty atSeat:(int)ID{
    
    Ticket * tixToBuy = [self.allTickets objectAtIndex:ID];
    
    [tixToBuy setTicketQty:qty];
    [self.allTickets replaceObjectAtIndex:(NSUInteger)ID withObject:tixToBuy];
}

-(void) addTicketToList:(Ticket *)ticketbought NumberOf:(int)qty WithPrices:(double)price{
    
    Ticket * addTicket = [[Ticket alloc]init];
    [addTicket setTicketName:ticketbought.ticketName];
    [addTicket setTicketQty:qty];
    [addTicket setTicketPrice:price];
    [addTicket setTicketID:ticketbought.ticketID];
    [addTicket setTicketDate:[NSDate date]];
    [self.allPurchasedTickets addObject:addTicket];
}



@end
