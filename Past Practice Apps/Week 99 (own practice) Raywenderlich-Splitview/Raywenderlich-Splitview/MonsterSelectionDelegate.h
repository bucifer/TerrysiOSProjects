//
//  MonsterSelectionDelegate.h
//  Raywenderlich-Splitview
//
//  Created by Aditya Narayan on 9/30/14.
//  Copyright (c) 2014 NM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Monster;
@protocol MonsterSelectionDelegate <NSObject>
@required
-(void)selectedMonster:(Monster *)newMonster;


@end
