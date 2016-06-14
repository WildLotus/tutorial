//
//  ViewController.m
//  GET用户登录
//
//  Created by 韩其 on 16/6/6.
//  Copyright © 2016年 Compass. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNumber;
@property (weak, nonatomic) IBOutlet UITextField *passNumber;
@property (weak, nonatomic) IBOutlet UIButton *login;

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.userNumber.text = @"zhangsan";
    self.passNumber.text = @"zhang";
    
    [self.login addTarget:self action:@selector(loginWeb) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginWeb
{
    NSURL *url = [NSURL URLWithString:@"http://localhost/login.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataDontLoad timeoutInterval:15];
    
    request.HTTPMethod = @"POST";
    NSString *bodystr = [NSString stringWithFormat:@"username=%@&password=%@",self.userNumber.text,self.passNumber.text];
    request.HTTPBody = [bodystr dataUsingEncoding:NSUTF8StringEncoding];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue ] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dic);
        
    }];
}

-(void)saveString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.userNumber.text forKey:@"user"];
    [defaults setObject:[self base64EncodeWithString:self.userNumber.text] forKey:@"pass"];
}

-(NSString *)getString
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    return [defaults objectForKey:@"user"];
}

-(NSString *)base64EncodeWithString:(NSString *)str
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
-(NSString *)base64DecodeWithString:(NSString *)str
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}


@end
