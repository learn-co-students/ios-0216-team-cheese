//
//  TableViewEntry.h
//  DidYou
//
//  Created by Zirui Branton on 4/4/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataStore.h"

@interface TableViewEntry: UIView<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TableViewEntry

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataStore *dataStore = [[DataStore alloc]init];
    return [dataStore.emotions[key] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    return cell;    
}


@end


