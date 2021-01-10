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
    [self test2]; // kNilOptions = 0
    [self test3]; // NSJSONWritingFragmentsAllowed
    [self test4]; // NSJSONWritingPrettyPrinted
    [self test5]; // NSJSONWritingSortedKeys
    [self test6]; // NSJSONWritingWithoutEscapingSlashes
    
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
    
    NSLog(@"===== Test 1 Start =====");
    NSLog(@"isValidJSONObject(Number) : %@",     [NSJSONSerialization isValidJSONObject:number] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(String) : %@",     [NSJSONSerialization isValidJSONObject:string] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Null) : %@",       [NSJSONSerialization isValidJSONObject:null] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Dictionary) : %@", [NSJSONSerialization isValidJSONObject:dictionary] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Array) : %@",      [NSJSONSerialization isValidJSONObject:array] ? @"YES" : @"NO");
    NSLog(@"===== Test 1 End =====");
}

// options 파라미터
- (void)test2
{
    // kNilOptions = 0
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions // 0
                                                         error:nil];
    
    NSLog(@"===== Test 2 Start =====");
    NSLog(@"\noptions(0) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test 2 End =====");
}

- (void)test3
{
    // NSJSONWritingFragmentsAllowed
    NSString *string = @"string value";
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string
                                                       options:NSJSONWritingFragmentsAllowed // 0을 넣을 경우 크래시 발생
                                                         error:nil];
    
    NSLog(@"===== Test 3 Start =====");
    NSLog(@"\noptions(NSJSONReadingAllowFragments) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test 3 End =====");
}

- (void)test4
{
    // NSJSONWritingPrettyPrinted
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"===== Test 4 Start =====");
    NSLog(@"\noptions(NSJSONWritingPrettyPrinted) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test 4 End =====");
}

- (void)test5
{
    // NSJSONWritingSortedKeys
    NSDictionary *dictionary = @{@"C":@"value1", @"A":@"value2", @"B":@"value3"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingSortedKeys
                                                         error:nil];
    
    NSLog(@"===== Test 5 Start =====");
    NSLog(@"\noptions(NSJSONWritingSortedKeys) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test 5 End =====");
}

- (void)test6
{
    // NSJSONWritingWithoutEscapingSlashes
    NSDictionary *dictionary = @{@"url":@"https://google.com"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingWithoutEscapingSlashes
                                                         error:nil];
    
    NSLog(@"===== Test 6 Start =====");
    NSLog(@"\noptions(NSJSONWritingWithoutEscapingSlashes) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test 6 End =====");
}
}

@end
