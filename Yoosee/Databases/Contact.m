//
//  Contact.m
//  Yoosee
//
//  Created by guojunyi on 14-4-14.
//  Copyright (c) 2014年 guojunyi. All rights reserved.
//

#import "Contact.h"

@implementation Contact

-(id)init{
    self = [super init];
    if (self) {
        self.messageCount = 0;
        self.defenceState = DEFENCE_STATE_LOADING;
        self.isClickDefenceStateBtn = NO;
    }
    return self;
}

- (NSString*)getName {
    return _contactName;
}

- (NSString*)deviceId {
    return _contactId;
}

- (NSString *)saveToString {
    
    NSDictionary *contactInfo = @{@"contactID":             _contactId,
                                  @"contactName":           _contactName,
                                  @"contactPass":           _contactPassword,
                                  @"contactType":           @(_contactType),
                                  @"contactCloudProjectId": _contactCloudProjectId,
                                  @"contactIsOwner":        _isOwner ? @"1" : @"0",
                                  @"isSoundDisabled":       _isSoundDisabled ? @"1" : @"0"
                                  };
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:contactInfo
                                                       options:(NSJSONWritingOptions)NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

+ (Contact *)loadFromString:(NSString *)jsonString {
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:nil];
    if (json && [json isKindOfClass:NSDictionary.class]) {
        Contact *contact = [[Contact alloc] init];
        if ([json[@"contactID"] length] > 0) {
            contact.contactId = json[@"contactID"];
            contact.contactName = json[@"contactName"];
            contact.contactPassword = json[@"contactPass"];
            contact.contactType = [json[@"contactType"] intValue];
            contact.contactCloudProjectId = json[@"contactCloudProjectId"];
            contact.isOwner = [json[@"contactIsOwner"] boolValue];
            contact.isSoundDisabled = [json[@"isSoundDisabled"] boolValue];

            return contact;
        }
    }
    return nil;
    
}

@end
