//
//  UploadViewController.m
//  ultraimg
//
//  Created by jrrr on 6/6/15.
//  Copyright (c) 2015 Matt Channon. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation UploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)uploadTapped:(id)sender {
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    // Displays saved pictures and movies, if both are available, from the
    // Camera Roll album.
    mediaUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = NO;
    mediaUI.delegate = self;
    [self presentViewController:mediaUI animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {    
    [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation([info objectForKey:@"UIImagePickerControllerOriginalImage"]) forKey:@"portrait"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [ self uploadImage: info ];
    [ self dismissViewControllerAnimated:YES completion:nil];
}

- (void)uploadImage:(NSDictionary *)info
{
    NSString *stringData = [NSString stringWithString:[[info valueForKey:UIImagePickerControllerReferenceURL] absoluteString]];
    
    NSArray *strArray = [ stringData componentsSeparatedByString:@"="];
    NSArray *strArray2 = [ strArray[1] componentsSeparatedByString:@"&"];
    
    NSString *title = [[ self.accountTextField.text stringByAppendingString:@"" ] stringByAppendingString:strArray2[0]];
    
    NSString *rString = [[[@"http://ultraimg.com/api/1/upload/?key=3374fa58c672fcaad8dab979f7687397&format=json&source=FILES['" stringByAppendingString:title ] stringByAppendingString: @".jpg']"] stringByAddingPercentEscapesUsingEncoding : NSUTF8StringEncoding];
   
    NSLog( @"url: %@", rString);
    
    NSURL *url = [NSURL URLWithString:rString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:60.0];
    [request setHTTPMethod:@"POST"];
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSData *imageData = UIImageJPEGRepresentation(img, 0.3);

    if (imageData != nil)
    {
        NSString *filenames = [NSString stringWithFormat:@"%@.jpg", title];      //set name here
        NSLog(@"%@", filenames);
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"filenames\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[filenames dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"userfile\"; filename=\".jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[NSData dataWithData:imageData]];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        // setting the body of the post to the reqeust
        [request setHTTPBody:body];
        // now lets make the connection to the web
        NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
        NSLog(@"%@", returnString);
        NSLog(@"finish");
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithFrame:CGRectMake(0, 0, 400, 40)];
    
    cell.backgroundColor = [UIColor greenColor];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

@end
