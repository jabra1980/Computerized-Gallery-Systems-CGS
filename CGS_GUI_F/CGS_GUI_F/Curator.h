//
//  Curator.h
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Curator : Person{
    
    NSString *curatorID;
    float commssion;
}

-(id) initcurID: (NSString *) curID initFN: (NSString *) FN initLN: (NSString *) LN initcomm: (float) comm;

-(NSString *) toString;

-(NSString *) getID;

-(void) setCommission: (float) comm;


	
@end

NS_ASSUME_NONNULL_END
