//
//  AsynCView.m
//  AFNetworkingTest
//
//  Created by aru oreki on 2020/3/12.
//  Copyright © 2020 aru oreki. All rights reserved.
//

#import "AsynCView.h"

@implementation AsynCView




- (IBAction)compute:(id)sender
{
    NSLog(@"asdas");

    [self asyncConcurrent];
    [self sumOfList];
}

- (void)asyncConcurrent {
    NSLog(@"currentThread---%@",[NSThread currentThread]);  // 打印当前线程
    static long sum;
    dispatch_queue_t queue = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_semaphore_t semaphoreLock = dispatch_semaphore_create(1);
    
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    for (long i = 1 ;i < 1000000000 ;i+=1000000)
    {
        dispatch_group_async(group, queue, ^{
            /// 追加任务
            dispatch_semaphore_wait(semaphoreLock, DISPATCH_TIME_FOREVER);
            sum += [self addContWithStart:i end:i+9999];
            dispatch_semaphore_signal(semaphoreLock);
        });
    }
    dispatch_group_notify(group, queue, ^{
        NSLog(@"%ld",sum);
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        NSLog(@"Linked in %f ms", linkTime *1000.0);
    });

}

- (long)addContWithStart:(int)start end:(int)end
{
    long sum = 0;
    for(long i=start; i <= end ;i++)
    {
        sum += i;
    }
    return sum;
}
- (void)sumOfList
{
    long sum = 0;
    CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
    for (long i = 1 ;i < 1000000000 ;i++)
    {
        sum +=i;
    }
    NSLog(@"%ld",sum);
    CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
    NSLog(@"Linked in %f ms", linkTime *1000.0);
}

@end
