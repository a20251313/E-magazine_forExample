//
//  OCReflection.m
//  Register
//
//  Created by zbq on 13-2-6.
//  Copyright (c) 2013年 zbq. All rights reserved.
//

#import "OCReflection.h"
#import <objc/runtime.h>

@implementation OCReflection

static const char * getPropertyType(objc_property_t property) {
    const char *attributes = property_getAttributes(property);
    
    char buffer[1 + strlen(attributes)];
    strcpy(buffer, attributes);
    char *state = buffer, *attribute;
    while ((attribute = strsep(&state, ",")) != NULL) {
        if (attribute[0] == 'T' && attribute[1] != '@') {
            // it's a C primitive type:
            /*
             if you want a list of what will be returned for these primitives, search online for
             "objective-c" "Property Attribute Description Examples"
             apple docs list plenty of examples of what you get for int "i", long "l", unsigned "I", struct, etc.
             */
            return (const char *)[[NSData dataWithBytes:(attribute + 1) length:strlen(attribute) - 1] bytes];
        }
        else if (attribute[0] == 'T' && attribute[1] == '@' && strlen(attribute) == 2) {
            // it's an ObjC id type:
            return "id";
        }
        else if (attribute[0] == 'T' && attribute[1] == '@') {
            // it's another ObjC object type:
            return (const char *)[[NSData dataWithBytes:(attribute + 3) length:strlen(attribute) - 4] bytes];
        }
    }
    return "";
}

+ (NSDictionary *)getDictionaryFromClass:(id)classInstance{
    NSString *className = NSStringFromClass([classInstance class]);
    const char *cClassName = [className UTF8String];
    id theClass = objc_getClass(cClassName);
    
    unsigned int propertyCounts = 0;
    
    objc_property_t *properties = class_copyPropertyList(theClass, &propertyCounts);
    NSMutableDictionary *finalDic = [[NSMutableDictionary alloc] init];
    
    for (int i=0; i<propertyCounts; i++) {
        objc_property_t property = properties[i];
        
        NSString *name = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        NSString *type = [[NSString alloc] initWithCString:getPropertyType(property) encoding:NSUTF8StringEncoding];
        
        SEL selector = NSSelectorFromString(name);//get方法
        id value = [classInstance performSelector:selector];
        if ([type isEqualToString:@"NSMutableArray"]) {
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:value];
            NSMutableArray *results = [[NSMutableArray alloc] init];
            for (id onceId in array) {
                [results addObject:[self getDictionaryFromClass:onceId]];
            }
            [finalDic setObject:results forKey:name];
            [array release];
            [results release];
        }else if([type isEqualToString:@"NSString"]){
            if (value != nil) {
                [finalDic setObject:value forKey:name];
            }
        }
        
        [name release];
        [type release];
    }
    free(properties);
    
    return finalDic;
}

+ (id)getClassFromDictionary:(NSMutableDictionary *)dict className:(NSString *)className{
    if (dict == nil) {
        return nil;
    }else{
        unsigned int propertyCounts = 0;
        Class class = NSClassFromString(className);
        id classObj = [[class alloc] init];
        
        objc_property_t *properties = class_copyPropertyList([class class], &propertyCounts);
        for (int i=0; i<propertyCounts; i++) {
            objc_property_t property = properties[i];
            if (property == NULL) {
                break;
            }
            
            const char *propType = getPropertyType(property);
            const char *propName = property_getName(property);
            NSString *name = [[NSString alloc] initWithCString:propName encoding:NSUTF8StringEncoding];
            NSString *type = [[NSString alloc] initWithCString:propType encoding:NSUTF8StringEncoding];
            if (type == nil) {
                type = name;
            }
            if (propName) {
                id obj = [dict objectForKey:name];
                if (obj == nil || obj == [NSNull null]) continue;
                if ([type isEqualToString:@"NSString"]) {
                    [classObj setValue:obj forKey:name];
                }else if ([type isEqualToString:@"NSMutableArray"]){
                    NSMutableArray *arrObjs = [[NSMutableArray alloc] init];
                    for (NSMutableDictionary *dic in obj) {
                        id anObj = [self getClassFromDictionary:dic className:name];
                        [arrObjs addObject:anObj];
                    }
                    [classObj setValue:arrObjs forKey:name];
                    [arrObjs release];
                }
            }
            [name release];
            [type release];
        }
        free(properties);
        return [classObj autorelease];
    }
}

@end
