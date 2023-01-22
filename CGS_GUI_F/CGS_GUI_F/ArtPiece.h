//
//  ArtPiece.h
//  test_CGS
//
//  Created by user220600 on 11/22/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ArtPiece : NSObject{
    
    NSString *artPieceID;
    NSString *curatorID;
    NSString *artistID;
    NSString *title;
    int year;
    float value;
    float estimate;
    char status;
}
-(id) initartPieceID: (NSString *) artpID initcuratorID: (NSString *) curID initartistID: (NSString *) artID inittitle: (NSString *) ti inityear: (int) ye initvalue: (float) val initestimate: (float) estim initstatus: (char) stat;

-(NSString *) toString;

-(NSString*) getID;

-(char) getStatus;

-(void) setEstimate: (float) estim;

-(void) changeStatus: (char) stat;

-(float) getValue;

@end

NS_ASSUME_NONNULL_END
