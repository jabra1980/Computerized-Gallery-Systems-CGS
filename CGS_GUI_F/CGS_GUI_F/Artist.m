//
//  Artist.m
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import "Artist.h"

@implementation Artist

-(id) initartistID:(NSString *)artID initFN:(NSString *)FN initLN:(NSString *)LN{
    artistID = artID;
    firstName = FN;
    lastName = LN;
    return self;
}

-(NSString *) toString{
    return [NSString stringWithFormat:@"%@%@%@%@%@", artistID, @", ", firstName, @", ", lastName];
}

-(NSString *) getArtistID{
    return artistID;
}

@end
