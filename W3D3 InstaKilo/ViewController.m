//
//  ViewController.m
//  W3D3 InstaKilo
//
//  Created by Colin on 2018-04-25.
//  Copyright © 2018 Colin Russell. All rights reserved.
//

#import "ViewController.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController () <UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *mainLayout;
@property (nonatomic) BOOL orderByLocation;
@property (strong, nonatomic) NSArray *foodImagesArray;
@property (strong, nonatomic) NSArray *animalImagesArray;
@property (strong, nonatomic) NSArray *carImagesArray;
@property (strong, nonatomic) NSArray *zooLocationImagesArray;
@property (strong, nonatomic) NSArray *homeLocationArray;
@property (strong, nonatomic) NSArray *americaLocationArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    self.orderByLocation = NO;
    self.collectionView.dataSource = self;
    [super viewDidLoad];
    [self setupMainLayout];
    [self setupImageArrays];
    [self.collectionView setCollectionViewLayout:self.mainLayout];
}

- (void)setupMainLayout {
    self.mainLayout = [UICollectionViewFlowLayout new];
    self.mainLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.mainLayout.itemSize = CGSizeMake(150, 150);
    self.mainLayout.minimumInteritemSpacing = 5;
    self.mainLayout.minimumLineSpacing = 5;
    self.mainLayout.sectionInset = UIEdgeInsetsMake(10, 20, 5, 20);
    self.mainLayout.headerReferenceSize = CGSizeMake(0, 22);
}

- (void)setupImageArrays {
    // subjects
    self.foodImagesArray = @[[UIImage imageNamed:@"IMG_0124.JPG"], [UIImage imageNamed:@"IMG_0478.JPG"], [UIImage imageNamed:@"IMG_1724.JPG"]];
    self.animalImagesArray = @[[UIImage imageNamed:@"IMG_0217.jpg"], [UIImage imageNamed:@"IMG_0251.jpg"], [UIImage imageNamed:@"IMG_0255.jpg"], [UIImage imageNamed:@"IMG_0262.jpg"], [UIImage imageNamed:@"IMG_0292.jpg"]];
    self.carImagesArray = @[[UIImage imageNamed:@"592f4169b74af41b008b5977-750-563.jpg"], [UIImage imageNamed:@"images.jpeg"], [UIImage imageNamed:@"LamborghiniRoadsterTA.jpg"]];
    
    //locations: zoo, unknown, home, and restaurant
    self.zooLocationImagesArray = self.animalImagesArray;
    self.homeLocationArray = @[[UIImage imageNamed:@"IMG_0478.JPG"], [UIImage imageNamed:@"IMG_1724.JPG"]];
    self.americaLocationArray = @[[UIImage imageNamed:@"images.jpeg"], [UIImage imageNamed:@"LamborghiniRoadsterTA.jpg"]];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if (self.orderByLocation == NO){
        return 3;
    } else {
        return 4;
    }
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (self.orderByLocation == NO){
        if (section == 0 || section == 2) {
            return 3;
        } else {
            return 5;
        }
    } else {
        if (section == 0 || section == 1){// america or home
            return 2;
        } else if (section == 2 || section == 4){ // restaurant or unknown
            return 1;
        } else {
            return 5; // zoo
        }
        
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];
    
    cell.photoView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (self.orderByLocation == NO){
        if (indexPath.section == 0){
            cell.photoView.image = [self.foodImagesArray objectAtIndex:indexPath.item];
        } else if (indexPath.section == 1){
            cell.photoView.image = [self.animalImagesArray objectAtIndex:indexPath.item];
        } else {
            cell.photoView.image = [self.carImagesArray objectAtIndex:indexPath.item];
        }
    }else {
        if (indexPath.section == 0){
            cell.photoView.image = [self.americaLocationArray objectAtIndex:indexPath.item];
        } else if (indexPath.section == 1){
            cell.photoView.image = [self.homeLocationArray objectAtIndex:indexPath.item];
        } else if (indexPath.section == 2){
            cell.photoView.image = [UIImage imageNamed:@"IMG_0124.JPG"];
        } else if (indexPath.section == 3){
            cell.photoView.image = [self.zooLocationImagesArray objectAtIndex:indexPath.item];
        } else {
            cell.photoView.image = [UIImage imageNamed:@"592f4169b74af41b008b5977-750-563.jpg"];
        }
    }
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PhotoHeader"                                                                                     forIndexPath:indexPath];
        UILabel *label = [header viewWithTag:1];
        
        if (self.orderByLocation == NO) {
            if (indexPath.section == 0){
                label.text = @"Food";
            }else if (indexPath.section == 1){
                label.text = @"Animals";
            }else {
                label.text = @"Cars";
            }
        } else {
            if (indexPath.section == 0) {
                label.text = @"America";
            }else if (indexPath.section == 1){
                label.text = @"Home";
            }else if (indexPath.section == 2) {
                label.text = @"Restaurant";
            }else if (indexPath.section == 3) {
                label.text = @"Zoo";
            }else {
                label.text = @"Unknown Location";
            }
        }
        return header;
    }
    return nil;
}

#pragma mark - Actions

- (IBAction)segmentedControl:(UISegmentedControl *)sender {
    if (self.orderByLocation == NO) {
        self.orderByLocation = YES;
    } else {
        self.orderByLocation = NO;
    }
    [self.collectionView reloadData];
}


@end
