//
//  MHMHealthModel.h
//  MyHealthModule
//
//  Created by L on 16/2/27.
//  Copyright © 2016年. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MHMHealthModel : NSObject

@property (nonatomic, strong) NSDateComponents *startDateComponents;
@property (nonatomic, strong) NSDateComponents *endDateComponents;
@property (nonatomic, assign) NSInteger stepCount;
@property (nonatomic, assign) NSInteger distanceCount;
@property(strong,nonatomic) NSArray *array;

@end
