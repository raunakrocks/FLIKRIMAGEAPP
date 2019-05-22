//
//  ViewController.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 20/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "FlikrHomeViewController.h"
#import "ImageCell.h"
#import "UIView+AutoLayout.h"
#import "FlikrHomeViewModel.h"
#import "ImageService.h"
#import "ImageServiceImpl.h"
#import "ImageFetcherService.h"
#import "ImageCache.h"
#import "ImageStorageHelper.h"

@interface FlikrHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIActivityIndicatorView *fullScreenActivityIndicator;
@property(nonatomic, strong) FlikrHomeViewModel *viewModel;
@property(nonatomic, assign) NSInteger pageNumber;
@property(nonatomic, strong) NSString *lastSearchedText;
@property(nonatomic, assign) NSInteger imageNameCounter;
@end

@implementation FlikrHomeViewController

static NSString * const reuseIdentifier = @"ImageViewCell";
const NSInteger padding = 6;

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        id<ImageService> service = [[ImageServiceImpl alloc] init];
        self.viewModel = [[FlikrHomeViewModel alloc] initWithImageService:service];
        self.pageNumber=1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
    [self setupConstraints];
    [self setupDelegates];
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

- (void)setupViews {
    self.searchBar = [self getSearchBar];
    self.collectionView = [self getCollectionView];
    self.fullScreenActivityIndicator = [self getActivityIndicatorView];
    [self.view addSubview:self.searchBar];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.fullScreenActivityIndicator];
}

- (void)setupConstraints {
    NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
    
    //Search Bar Constraints:
    [constraints addObject: [self.searchBar.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor]];
    [constraints addObject: [self.searchBar.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor]];
    [constraints addObject: [self.searchBar.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor]];
    [constraints addObject: [self.searchBar.heightAnchor constraintEqualToConstant:48.0]];
    
    //Collection View Constraints:
    [constraints addObject: [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:padding]];
    [constraints addObject: [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant: -padding]];
    [constraints addObject: [self.collectionView.topAnchor constraintEqualToAnchor: self.searchBar.bottomAnchor]];
    [constraints addObject: [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:padding]];
    
    //ActivityIndicator View Contraints:
    [constraints addObject:[self.fullScreenActivityIndicator.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor]];
    [constraints addObject:[self.fullScreenActivityIndicator.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]];

    [NSLayoutConstraint activateConstraints:constraints];
}

- (void)setupDelegates {
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
}

- (UISearchBar *)getSearchBar {
    UISearchBar *searchBar = [UISearchBar withAutolayout];
    searchBar.placeholder = @"Search images";
    return searchBar;
}

- (UICollectionView *)getCollectionView {
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionView.backgroundColor = self.view.backgroundColor;
    collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    return collectionView;
}

- (UIActivityIndicatorView *)getActivityIndicatorView {
    UIActivityIndicatorView *view =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    view.color = [UIColor blackColor];
    view.translatesAutoresizingMaskIntoConstraints = NO;
    return view;
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.imageModels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = (ImageCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ImageModel *model = self.viewModel.imageModels[indexPath.row];
    cell.tag = indexPath.row;
    cell.imageView.image = nil;
    [cell.activityIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *filePath = [[ImageCache shared] getImageFilePathForImageURLString:model.imageURLString];
        if(filePath == NULL) {
            UIImage *image = [ImageFetcherService imageForImageURLString:model.imageURLString];
            NSString *imagePath = [NSString stringWithFormat:@"%ld.png", self.imageNameCounter];
            [ImageStorageHelper saveImage:image withName:[NSString stringWithFormat:@"%ld.png", self.imageNameCounter]];
            [[ImageCache shared] setImageFilePathForImageURLString:model.imageURLString imagePath:imagePath];
        }
        filePath = [[ImageCache shared] getImageFilePathForImageURLString:model.imageURLString];
        UIImage *image = [ImageStorageHelper loadImage:filePath];
            dispatch_async(dispatch_get_main_queue(), ^{
                 if(cell.tag == indexPath.row) {
                     [cell.activityIndicator stopAnimating];
                     cell.imageView.image = image;
                     self.imageNameCounter+=1;
                 }
                 });
    });
    if(indexPath.row==self.viewModel.imageModels.count-3) {
        //if we are going to render last row. search the next batch of images
        [self searchMoreImages];
    }
    return cell;
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //LAYOUT
    /*padding-CELL-padding-CELL-padding-CELL-padding*/
    /**
     4 padding and 3 cells, w=width of the collection view
     4*p+3*c=w
     therfore, c = (w-4*p)/3
     **/
    NSInteger cellWidth = (self.collectionView.frame.size.width-4*padding)/3;
    return CGSizeMake(cellWidth, cellWidth);
}

#pragma mark <UISearchBarDelegate>

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.pageNumber = 1;
    [self startImagesSearchWithText:searchBar.text];
    self.lastSearchedText = searchBar.text;
}

- (void)searchMoreImages {
    self.pageNumber+=1;
    [self.viewModel searchImagesWithText:self.lastSearchedText
                              pageNumber: self.pageNumber
                       completionHandler:^{
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [self.collectionView reloadData];
                           });
                       }];
}

- (void)startImagesSearchWithText:(NSString *)text {
    [self.fullScreenActivityIndicator startAnimating];
    [self.viewModel searchImagesWithText:text
                               pageNumber: self.pageNumber
                       completionHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.fullScreenActivityIndicator stopAnimating];
            [self.collectionView reloadData];
        });
    }];
}
@end
