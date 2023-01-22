//
//  Artist.h
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Artist : Person{
    NSString *artistID;
}

-(id) initartistID: (NSString *)artID initFN:(NSString *)FN initLN:(NSString *)LN;

-(NSString *) toString;

-(NSString *) getArtistID;

@end

NS_ASSUME_NONNULL_END
