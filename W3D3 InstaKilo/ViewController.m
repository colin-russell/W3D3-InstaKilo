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
@property (strong, nonatomic) NSArray *foodImagesArray;
@property (strong, nonatomic) NSArray *animalImagesArray;
@property (strong, nonatomic) NSArray *carImagesArray;

@end

@implementation ViewController

- (void)viewDidLoad {
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
    self.mainLayout.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.mainLayout.headerReferenceSize = CGSizeMake(0, 22);
}

- (void)setupImageArrays {
    self.foodImagesArray = @[[UIImage imageNamed:@"IMG_0124.JPG"], [UIImage imageNamed:@"IMG_0478.JPG"], [UIImage imageNamed:@"IMG_1724.JPG"]];
    self.animalImagesArray = @[[UIImage imageNamed:@"IMG_0217.jpg"], [UIImage imageNamed:@"IMG_0251.jpg"], [UIImage imageNamed:@"IMG_0255.jpg"], [UIImage imageNamed:@"IMG_0262.jpg"], [UIImage imageNamed:@"IMG_0292.jpg"]];
    self.carImagesArray = @[[UIImage imageNamed:@"592f4169b74af41b008b5977-750-563.jpg"], [UIImage imageNamed:@"images.jpeg"], [UIImage imageNamed:@"LamborghiniRoadsterTA.jpg"]];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0 || section == 2) {
        return 3;
    } else {
        return 5;
    }
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCell" forIndexPath:indexPath];

    cell.photoView.contentMode = UIViewContentModeScaleAspectFit;
    
    if (indexPath.section == 0){
        cell.photoView.image = [self.foodImagesArray objectAtIndex:indexPath.item];
    } else if (indexPath.section == 1){
        cell.photoView.image = [self.animalImagesArray objectAtIndex:indexPath.item];
    } else {
        cell.photoView.image = [self.carImagesArray objectAtIndex:indexPath.item];
    }
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView* header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PhotoHeader"                                                                                     forIndexPath:indexPath];
        UILabel *label = [header viewWithTag:1];
        if (indexPath.section == 0){
            label.text = @"Food";
        } else if (indexPath.section == 1){
            label.text = @"Animals";
        } else {
            label.text = @"Cars";
        }
        
        return header;
    }
    return nil;
}

@end
