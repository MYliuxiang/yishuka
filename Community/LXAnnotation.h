//
//  LXAnnotation.h
//  Community
//
//  Created by Viatom on 16/6/22.
//  Copyright © 2016年 李江. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKAnnotation.h>
#import "MapJG.h"
@interface LXAnnotation : BMKPointAnnotation

@property (nonatomic,retain)MapJG *model;
@end
