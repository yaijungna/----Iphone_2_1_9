//
//  MemCache.m
//  PeopleNewsReaderPhone
//
//  Created by lygn128 on 13-11-18.
//
//

#import "MemCache.h"
#import <mach/mach.h>
#import <mach/host_info.h>
static MemCache * staticMemCache = nil;
static NSInteger cacheMaxCacheAge = 60*60*24*7; // 1 week
static natural_t minFreeMemLeft = 1024*1024*12; // reserve 12MB RAM

// inspired by http://stackoverflow.com/questions/5012886/knowing-available-ram-on-an-ios-device
static natural_t get_free_memory(void)
{
    mach_port_t host_port;
    mach_msg_type_number_t host_size;
    vm_size_t pagesize;
    
    host_port = mach_host_self();
    host_size = sizeof(vm_statistics_data_t) / sizeof(integer_t);
    host_page_size(host_port, &pagesize);
    
    vm_statistics_data_t vm_stat;
    
    if (host_statistics(host_port, HOST_VM_INFO, (host_info_t)&vm_stat, &host_size) != KERN_SUCCESS)
    {
        NSLog(@"Failed to fetch vm statistics");
        return 0;
    }
    
    /* Stats in bytes */
    natural_t mem_free = vm_stat.free_count * pagesize;
    return mem_free;
}
@implementation MemCache
-(id)init
{
    if (self = [super init]) {
        _cacheDict = [[NSMutableDictionary alloc]init];
        //[NSNotificationCenter defaultCenter] addObserver:self selector:<#(SEL)#> name:<#(NSString *)#> object:<#(id)#>
        //[NSNotificationCenter defaultCenter] add
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];
        
    }
    return self;
}
-(void)clearMemory
{
    [_cacheDict removeAllObjects];
}
+(MemCache*)sharedMemCache
{
    if (!staticMemCache) {
        staticMemCache = [[MemCache alloc]init];
    }
    return  staticMemCache;
}
-(void)insertUIImage:(UIImage*)aImage forKey:(NSString*)urlString
{
    if (get_free_memory() < minFreeMemLeft) {
        [self clearMemory];
    }
    [_cacheDict setValue:aImage forKey:urlString];
}
-(UIImage*)getImageWithUrl:(NSURL*)aUrl
{
    return [_cacheDict valueForKey:aUrl.absoluteString];
}
@end
