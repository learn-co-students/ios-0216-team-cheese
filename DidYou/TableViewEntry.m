//
//  TableViewEntry.m
//  DidYou
//
//  Created by Zirui Branton on 4/4/16.
//  Copyright © 2016 Did You Nooglers. All rights reserved.
//

#import "TableViewEntry.h"
#import "DataStore.h"

//@interface TableViewEntry: UIView<UITableViewDelegate, UITableViewDataSource>
//
//@end

@implementation TableViewEntry


-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        [self setUpView];
    }
    
    return self;
}

-(void)setUpView
{
    
    
    [[NSBundle mainBundle] loadNibNamed:@"TableViewEntry" owner:self options:nil];
    
//    [self addSubview:self.contentView];
//    
//    
//    self.contentView.frame = self.bounds;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DataStore *dataStore = [[DataStore alloc]init];
    return [dataStore.emotions count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"" forIndexPath:indexPath];
    
    return cell;
}

@end
