//
//  Person.m
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import "Person.h"

@implementation Person
-(id) initFN: (NSString *) FN initLN: (NSString *) LN{
    firstName = FN;
    lastName = LN;
    return self;
}

-(NSString *) toString{
    return [NSString stringWithFormat:@"%@%@%@", firstName, @" ", lastName];
}

@end
