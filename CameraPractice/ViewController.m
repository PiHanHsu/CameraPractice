//
//  ViewController.m
//  CameraPractice
//
//  Created by PiHan Hsu on 2014/12/18.
//  Copyright (c) 2014年 PiHan Hsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIImagePickerControllerDelegate,
UINavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
- (IBAction)selectPhotoBtnPressed:(id)sender {
    //使用內建相簿
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;//使用內建相簿
        //modal
        [self presentViewController:picker animated:YES completion:nil];
    }
}

- (IBAction)saveBtnPressed:(id)sender {
    
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
    //save完之後，畫面回到空白
    self.imageView.image = nil;
    
}

- (IBAction)takePhotoBtnPressed:(id)sender {
    
    //先檢查是否有照相機功能
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypeSavedPhotosAlbum)]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.showsCameraControls =YES;
        
        [self presentViewController:picker animated:YES completion:nil];
    }
}
//delegate 方法
#pragma mark - delegte
//使用相機照相或是相簿選照片此delegate方法會被呼叫
//info是一個NSDictionary，包含原始圖像以及讓UIImagePickerControllerEditedImage標籤來存取的編輯後圖像
//，當app允許使用者編輯圖片時，就會用編輯後的圖片來取代原始的圖片

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
   
    if (picker.sourceType == UIImagePickerControllerSourceTypeSavedPhotosAlbum){
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        self.imageView.frame = CGRectMake(0, 20, 375, 450);
        self.imageView.image = chosenImage;
        self.saveBtn.hidden = NO;
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);

        [picker dismissViewControllerAnimated:YES completion:nil];
    }else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera){
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
        self.imageView.frame = CGRectMake(0, 20, 375, 450);
        self.imageView.image = chosenImage;
        self.saveBtn.hidden = NO;
         UIImageWriteToSavedPhotosAlbum(self.imageView.image, nil, nil, nil);
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
    
   
    
    
}

//user有可能會按"cancel"取消操作
//只要移除PickerController就可以了
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
