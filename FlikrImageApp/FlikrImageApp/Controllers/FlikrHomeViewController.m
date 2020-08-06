//
//  ViewController.m
//  FlikrImageApp
//
//  Created by Raunak Talwar on 20/05/19.
//  Copyright © 2019 Raunak Talwar. All rights reserved.
//

#import "FlikrHomeViewController.h"
#import "FlikrHomeViewModel.h"
#import "ImageCell.h"
#import "ImageServiceImpl.h"
#import "ImageStorageServiceImpl.h"
#import "UIView+AutoLayout.h"


@interface FlikrHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>
@property(nonatomic, strong) UISearchBar *searchBar;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UIActivityIndicatorView *fullScreenActivityIndicator;
@property(nonatomic, strong) FlikrHomeViewModel *viewModel;
@property(nonatomic, assign) NSInteger pageNumber;
@property(nonatomic, strong) NSString *lastSearchedText;
@end

@implementation FlikrHomeViewController

static NSString *const reuseIdentifier = @"ImageViewCell";
const CGFloat padding = 6.0;

-(instancetype)initWithViewModel: (FlikrHomeViewModel *)viewModel andPageNumber: (NSInteger) pageNumber {
  self = [super init];
  if(self) {
    self.viewModel = viewModel;
    self.pageNumber = pageNumber;
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
    self.view.backgroundColor = [UIColor whiteColor];
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
    cell.tag = indexPath.row;
    cell.imageView.image = nil;
    [cell.activityIndicator startAnimating];
    ImageModel *model = self.viewModel.imageModels[indexPath.row];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewModel getImageForImageModel:model completionHandler:^(UIImage *image, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(cell.tag == indexPath.row) {
                    [cell.activityIndicator stopAnimating];
                    cell.imageView.image = image;
                }
            });
        }];
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
    self.pageNumber +=1;
    [self.viewModel searchImageModelsWithText:self.lastSearchedText pageNumber:self.pageNumber completionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(error == NULL) {
                [self.collectionView reloadData];
            } else {
                [self showErrorAlertWithError: error];
            }
        });
    }];
}

- (void)startImagesSearchWithText:(NSString *)text {
    [self.fullScreenActivityIndicator startAnimating];
    [self.viewModel searchImageModelsWithText:text pageNumber:self.pageNumber completionHandler:^(NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.fullScreenActivityIndicator stopAnimating];
            if(error == NULL) {
                [self.collectionView reloadData];
            } else {
                [self showErrorAlertWithError: error];
            }
        });
    }];
}


- (void)showErrorAlertWithError: (NSError *)error {
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                   message:error.domain
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
