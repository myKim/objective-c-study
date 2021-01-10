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
    // *** JSON 인코딩 ***
    // JSON 인코딩 가능 여부
    [self testJSONEncoding1];
    
    // options 파라미터
    [self testJSONEncoding2]; // kNilOptions = 0
    [self testJSONEncoding3]; // NSJSONWritingFragmentsAllowed
    [self testJSONEncoding4]; // NSJSONWritingPrettyPrinted
    [self testJSONEncoding5]; // NSJSONWritingSortedKeys
    [self testJSONEncoding6]; // NSJSONWritingWithoutEscapingSlashes
    
    // *** JSON 디코딩 ***
    // options 파라미터
    [self testJSONDecoding1]; // kNilOptions = 0
    [self testJSONDecoding2]; // NSJSONReadingMutableContainers
    [self testJSONDecoding3]; // NSJSONReadingMutableLeaves
    [self testJSONDecoding4]; // NSJSONReadingFragmentsAllowed
}

#pragma mark - Internal

#pragma mark JSON Encoding

// JSON 인코딩 가능 여부
- (void)testJSONEncoding1
{
    // 생성 불가, Exception 발생
    NSNumber *number = @1;
    NSString *string = @"Hello world!";
    NSNull *null = [NSNull null];
    
    // 생성 가능 (top-level type은 Array, Dictionary만 가능
    NSArray *array = @[@"1", @"2", @"2"];
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2"};
    
    NSLog(@"===== Test JSONEncoding 1 Start =====");
    NSLog(@"isValidJSONObject(Number) : %@",     [NSJSONSerialization isValidJSONObject:number] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(String) : %@",     [NSJSONSerialization isValidJSONObject:string] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Null) : %@",       [NSJSONSerialization isValidJSONObject:null] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Dictionary) : %@", [NSJSONSerialization isValidJSONObject:dictionary] ? @"YES" : @"NO");
    NSLog(@"isValidJSONObject(Array) : %@",      [NSJSONSerialization isValidJSONObject:array] ? @"YES" : @"NO");
    NSLog(@"===== Test JSONEncoding 1 End =====");
}

// options 파라미터
- (void)testJSONEncoding2
{
    // kNilOptions = 0
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions // 0
                                                         error:nil];
    
    NSLog(@"===== Test JSONEncoding 2 Start =====");
    NSLog(@"\noptions(kNilOptions = 0) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test JSONEncoding 2 End =====");
}

- (void)testJSONEncoding3
{
    // NSJSONWritingFragmentsAllowed
    NSString *string = @"string value";
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string
                                                       options:NSJSONWritingFragmentsAllowed // 0을 넣을 경우 Exception 발생
                                                         error:nil];
    
    NSLog(@"===== Test JSONEncoding 3 Start =====");
    NSLog(@"\noptions(NSJSONReadingAllowFragments) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test JSONEncoding 3 End =====");
}

- (void)testJSONEncoding4
{
    // NSJSONWritingPrettyPrinted
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    
    NSLog(@"===== Test JSONEncoding 4 Start =====");
    NSLog(@"\noptions(NSJSONWritingPrettyPrinted) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test JSONEncoding 4 End =====");
}

- (void)testJSONEncoding5
{
    // NSJSONWritingSortedKeys
    NSDictionary *dictionary = @{@"C":@"value1", @"A":@"value2", @"B":@"value3"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingSortedKeys
                                                         error:nil];
    
    NSLog(@"===== Test JSONEncoding 5 Start =====");
    NSLog(@"\noptions(NSJSONWritingSortedKeys) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test JSONEncoding 5 End =====");
}

- (void)testJSONEncoding6
{
    // NSJSONWritingWithoutEscapingSlashes
    NSDictionary *dictionary = @{@"url":@"https://google.com"};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingWithoutEscapingSlashes
                                                         error:nil];
    
    NSLog(@"===== Test JSONEncoding 6 Start =====");
    NSLog(@"\noptions(NSJSONWritingWithoutEscapingSlashes) : \n%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSLog(@"===== Test JSONEncoding 6 End =====");
}

#pragma mark JSON Decoding

- (void)testJSONDecoding1
{
    // kNilOptions = 0
    // Decode 불가, Exception은 발생하지 않으나 nil 리턴
    NSNumber *number = @100;
    NSString *string = @"string";
    NSNull *null = [NSNull null];
    
    // Decode 가능
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSArray *array = @[@{@"key1":@"value1"}, @{@"key2":@"value2"}, @{@"key3":@"value3"}];
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingFragmentsAllowed
                                                         error:nil];
    
    id decodedJSONObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:kNilOptions
                                                      error:nil];
    
    NSLog(@"===== Test JSONDecoding 1 Start =====");
    NSLog(@"\noptions(kNilOptions = 0) : \n%@", decodedJSONObject);
    NSLog(@"===== Test JSONDecoding 1 End =====");
}

- (void)testJSONDecoding2
{
    // NSJSONReadingMutableContainers
    NSDictionary *dictionary = @{@"key1":@"value1", @"key2":@"value2", @"key3":@[@1, @2, @3]};
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:kNilOptions
                                                         error:nil];
    
    NSMutableDictionary *decodedDictionary = [NSJSONSerialization JSONObjectWithData:jsonData
                                                                      options:NSJSONReadingMutableContainers // 0일 경우 데이터 추가 시 Exception 발생
                                                                        error:nil];
    
    decodedDictionary[@"newKey"] = @"newValue";
    
    NSLog(@"===== Test JSONDecoding 2 Start =====");
    NSLog(@"\noptions(NSJSONReadingMutableContainers) : \n%@", decodedDictionary);
    NSLog(@"===== Test JSONDecoding 2 End =====");
}

- (void)testJSONDecoding3
{
    // NSJSONReadingMutableLeaves
    NSArray *array = @[@"value1", @"value2", @"value3"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:kNilOptions
                                                         error:nil];
    
    NSArray *decodedArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableLeaves // 0일 경우 Exception은 발생하지 않으나 nil이 리턴
                                                              error:nil];
    
    NSMutableString *value1 = decodedArray[0]; // NSMutableString이 안나오는 이유?
    NSMutableString *value2 = decodedArray[1]; // NSMutableString이 안나오는 이유?
    NSMutableString *value3 = decodedArray[2]; // NSMutableString이 안나오는 이유?
    
    NSLog(@"===== Test JSONDecoding 3 Start =====");
    NSLog(@"value1 is NSMutableString : %@", [value1 isKindOfClass:[NSMutableString class]] ? @"YES" : @"NO");
    NSLog(@"value2 is NSMutableString : %@", [value2 isKindOfClass:[NSMutableString class]] ? @"YES" : @"NO");
    NSLog(@"value3 is NSMutableString : %@", [value3 isKindOfClass:[NSMutableString class]] ? @"YES" : @"NO");
    NSLog(@"===== Test JSONDecoding 3 End =====");
}

- (void)testJSONDecoding4
{
    // NSJSONReadingFragmentsAllowed
    NSString *string = @"string value";
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:string
                                                       options:NSJSONWritingFragmentsAllowed
                                                         error:nil];
    
    id decodedString = [NSJSONSerialization JSONObjectWithData:jsonData
                                                       options:NSJSONReadingFragmentsAllowed // 0일 경우 Exception은 발생하지 않으나 nil이 리턴
                                                         error:nil];

    NSLog(@"===== Test JSONDecoding 4 Start =====");
    NSLog(@"\noptions(NSJSONReadingFragmentsAllowed) : \n%@", decodedString);
    NSLog(@"===== Test JSONDecoding 4 End =====");
}

@end
