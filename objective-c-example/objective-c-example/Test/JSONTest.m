//
//  JSONTest.m
//  objective-c-example
//
//  Created by 김명유 on 2021/01/08.
//

#import "JSONTest.h"

@implementation JSONTest

- (void)test
{
    // JSON 인코딩 가능 여부
    [self test1];
    
    // options 파라미터
    [self test2]; // NSJSONWritingFragmentsAllowed
    [self test3]; // NSJSONWritingPrettyPrinted
    [self test4]; // NSJSONWritingSortedKeys
    [self test5]; // NSJSONWritingWithoutEscapingSlashes
}

#pragma mark - Internal

#pragma mark JSON Encoding

// JSON 인코딩 가능 여부
- (void)test1
{
    // 생성 불가, 크래시 발생
    NSNumber *number = @1;
    NSString *string = @"Hello world!";
    NSNull *null = [NSNull null];
    
    // 생성 가능 (top-level type은 Array, Dictionary만 가능
    NSArray *array = @[@"1", @"2", @"2"];
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:0
                                                         error:nil];
}

// options 파라미터
- (void)test2
{
    // NSJSONWritingFragmentsAllowed
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingFragmentsAllowed
                                                         error:nil];
    
    NSLog(@"\noptions(NSJSONWritingFragmentsAllowed) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (void)test3
{
    // NSJSONWritingPrettyPrinted
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"\noptions(NSJSONWritingPrettyPrinted) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (void)test4
{
    // NSJSONWritingSortedKeys
    NSDictionary *dictionary = @{@"C":@"value1", @"A":@"value2", @"B":@"value3"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingSortedKeys
                                                         error:nil];
    
    NSLog(@"\noptions(NSJSONWritingSortedKeys) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

- (void)test5
{
    // NSJSONWritingWithoutEscapingSlashes
    NSDictionary *dictionary = @{@"url":@"https://google.com"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingWithoutEscapingSlashes
                                                         error:nil];
    
    NSLog(@"\noptions(NSJSONWritingWithoutEscapingSlashes) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
}

@end
