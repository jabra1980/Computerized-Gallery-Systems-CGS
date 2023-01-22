//
//  Curator.m
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import "Curator.h"

@implementation Curator

-(id) initcurID:(NSString *)curID initFN:(NSString *)FN initLN:(NSString *)LN initcomm:(float)comm{
    curatorID = curID;
    firstName = FN;
    lastName = LN;
    commssion = comm;
    return self;
}

-(NSString *) toString{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@%.2f",curatorID, @", ", firstName, @", ", lastName, @", ", 0.0];
}


-(NSString *) getID{
    return curatorID;
}

-(void) setCommission:(float)comm{
    commssion += comm;
}


@end
