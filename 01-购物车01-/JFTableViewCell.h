//
//  JFTableViewCell.h
//  01-购物车01-
//
//  Created by GaoFan on 2020/7/9.
//  Copyright © 2020 GaoFan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JFModel,JFTableViewCell;
NS_ASSUME_NONNULL_BEGIN

@protocol JFTableViewDelegate <NSObject>

@optional
-(void)jfTableViewCellDidClickPlusButton:(JFTableViewCell *)cell;
-(void)jfTableViewCellDidClickMinusButton:(JFTableViewCell *)cell;

@end


@interface JFTableViewCell : UITableViewCell
@property (nonatomic,strong) JFModel *model;

@property (nonatomic,weak) id<JFTableViewDelegate> delegate;//解耦
@end

NS_ASSUME_NONNULL_END
