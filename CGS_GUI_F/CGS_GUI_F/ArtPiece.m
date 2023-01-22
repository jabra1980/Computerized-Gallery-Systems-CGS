//
//  ArtPiece.m
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import "ArtPiece.h"

@implementation ArtPiece

-(id) initartPieceID: (NSString *) artpID initcuratorID: (NSString *) curID initartistID: (NSString *) artID inittitle: (NSString *) ti inityear: (int) ye initvalue: (float) val initestimate: (float) estim initstatus: (char) stat{
    
    artPieceID = artpID;
    curatorID = curID;
    artistID = artID;
    title = ti;
    year = ye;
    value = val;
    estimate = estim;
    status = stat;
    return self;
}

-(NSString *) toString{
    
    return [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%d%@%.2f%@%.2f%@%c", artPieceID, @", ", curatorID, @", ", artistID, @", ", title, @", ", year, @", ", value, @", ", estimate, @", ", status];
}

-(NSString*) getID{
    return artPieceID;
}

-(char) getStatus{
    return status;
}

-(void) setEstimate: (float) estim{
    estimate = estim;
}

-(void) changeStatus: (char) stat{
    status = stat;
}

-(float) getValue{
    return value;
}

@end
