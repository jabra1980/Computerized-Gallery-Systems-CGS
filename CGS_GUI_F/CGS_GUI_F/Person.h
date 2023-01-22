//
//  Person.h
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject{
    NSString *firstName;
    NSString *lastName;
}
    



-(id) initFN: (NSString *) FN initLN: (NSString *) LN;

-(NSString *) toString;


@end

NS_ASSUME_NONNULL_END
