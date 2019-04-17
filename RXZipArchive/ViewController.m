//
//  ViewController.m
//  RXZipArchive
//
//  Created by srx on 2017/7/11.
//  Copyright © 2017年 https://github.com/srxboys. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"

@interface ViewController ()
{
    NSString * _zipFilePath;//压缩后的路径
    
    UIButton * _btn;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _btn = [UIButton buttonWithType:UIButtonTypeCustom];
    _btn.frame = CGRectMake(10, 40, 100, 50);
    [_btn setTitle:@"压缩" forState:UIControlStateNormal];
    [_btn setTitle:@"解压" forState:UIControlStateSelected];
    [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    _btn.backgroundColor = [UIColor redColor];
    [_btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    _btn.selected = NO;
    [self.view addSubview:_btn];
}

- (void)buttonClick:(UIButton *)sender {
    NSString * path = [self getFile:@"hello" type:@"zip"];
    NSString * path1 = [path pathExtension];
    NSString * path2 = [path lastPathComponent];
    NSString * path3 = [[path pathComponents] lastObject];
    return;
    if(sender.selected) {
        //解压
        [self getZipFilePath];
    }
    else {
        //压缩
        [self getFilePathToZip];
    }
    sender.selected = !sender.isSelected;
}

- (void)getZipFilePath {
    //去解压

    NSString * fileName = [self doucumentFilePath];
    _zipFilePath = [self getFile:@"hello" type:@"zip"];
    
    BOOL success = [SSZipArchive unzipFileAtPath:_zipFilePath
                                   toDestination:fileName];

    if (!success) {
        NSLog(@"解压失败 no success");
        return;
    }
    
    NSError *error = nil;
    NSMutableArray<NSString *> *items = [[[NSFileManager defaultManager]
                                          contentsOfDirectoryAtPath:fileName
                                          error:&error] mutableCopy];
    if (error) {
        NSLog(@"解压失败error");
        return;
    }
    [items enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"objc%zd =fileName=%@", idx, obj);
//        switch (idx) {
//            case 0: {
//                NSLog(@"obj0=%@", obj);
//                break;
//            }
//            case 1: {
//                NSLog(@"obj1=%@", obj);
//                break;
//            }
//            case 2: {
//                NSLog(@"obj2=%@", obj);
//                break;
//            }
//            default: {
//                NSLog(@"Went beyond index of assumed files");
//                break;
//            }
//        }
    }];
    NSLog(@"解压成功=%@",fileName);
}

- (void)getFilePathToZip {
    NSString * sampleDataPath = [self getZipfilesPath];
    _zipFilePath = [self downCacheFilePath];
    _zipFilePath = [_zipFilePath stringByAppendingPathComponent:@"z.zip"];
    //去压缩
    BOOL success = [SSZipArchive createZipFileAtPath:_zipFilePath
                             withContentsOfDirectory:sampleDataPath];
    if (success) {
        NSLog(@"压缩成功 _zipFilePath=%@ \n压缩成功", _zipFilePath);
    }
    else {
        NSLog(@"压缩失败 sampleDataPath=%@ \n _zipFilePath=%@ \n压缩失败 ", sampleDataPath, _zipFilePath);
    }
}


- (NSString *)getFile:(NSString *)file type:(NSString *)type {
    NSString * path = [[NSBundle mainBundle] pathForResource:file ofType:type];
    return path;
}

- (NSString *)getZipfilesPath {
    NSString *sampleDataPath = [[NSBundle mainBundle].bundleURL
                                URLByAppendingPathComponent:@"Multi_Zip_Test"
                                isDirectory:YES].path;
    return sampleDataPath;
}

- (NSString *)doucumentFilePath {
    /*
     获取Document目录
    NSArray*documentArr =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    获取Caches目录
        NSArray*cachesArr =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
     */
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:@"gotoUnZip"];
    [self isFileExistesAtPath:filePath];
    
    return filePath;
}

- (NSString *)downCacheFilePath {
    //我写的就错误
    NSString * filePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    filePath = [filePath stringByAppendingPathComponent:@"gotoZip"];
    [self isFileExistesAtPath:filePath];
   return filePath;
    
    //作者写的就对
//    NSString *path = [NSString stringWithFormat:@"%@/\%@.zip",
//                      NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0],
//                      [NSUUID UUID].UUIDString];
//    return path;
}

- (BOOL)isFileExistesAtPath:(NSString *)filePath {
    NSFileManager * fileManger = [NSFileManager defaultManager];
    if(![fileManger fileExistsAtPath:filePath]) {
        NSError *error = nil;
        [fileManger createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
        if(error) {
            NSLog(@"创建目录失败");
            return NO;
        }
        return YES;
    }
    else {
        NSLog(@"目录 已存在");
        return NO;
    }
}
//测试分支

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
