//
//  studyView.h
//  Presidential Quiz
//
//  Created by Robert Crosby on 9/6/17.
//  Copyright © 2017 fully toasted. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "studyCell.h"
#import "References.h"

@interface studyView : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSArray *presidents;
    __weak IBOutlet UIScrollView *scroll;
    __weak IBOutlet UITableView *table;
    __weak IBOutlet UILabel *blur;
    bool blurVisible;
}

@end
