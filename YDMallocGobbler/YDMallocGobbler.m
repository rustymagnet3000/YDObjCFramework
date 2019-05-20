/*********************************************************************************
 Malloc Gobbler
 *********************************************************************************/
#import <Foundation/Foundation.h>
#include <pthread.h>
#include <assert.h>
#include <unistd.h>
#define MB(x)   ((size_t) (x) << 20)
#define MEGABYTES 1
const unsigned int yddelay = 10;

void *gobble(void *voidptr) {
    uint64_t tid;
    assert(pthread_threadid_np(NULL, &tid)== 0);
    NSLog(@"[+] 👹 Gobbler Thread ID: %#08x\n", (unsigned int) tid);
    int count = 0;
    if ([NSThread isMainThread]){
        NSLog(@"[+] 👹 Gobbler exiting, by design.\n");
    }
    else {
        while (1) {
            int *p = malloc(MB(MEGABYTES));
            if (p == NULL) {
                NSLog(@"[+] 👹 Malloc request failed");
            } else {
                if (count >= 1000){
                    NSLog(@"[+] 👹 Gobbler ate: %.2f GB\n", (float)(++count)/1000);
                }
                else {
                    NSLog(@"[+] 👹 Gobbler ate: %d MB\n", ++count);
                }
            }
            memset(p, 'A', MB(MEGABYTES));
            NSLog(@"[+] 👹 Gobbler finished setting memory. Micro-delay: %d", yddelay);
            usleep(yddelay);
        }
    }
    
    return NULL;
}

@interface YDMallocGobbler: NSObject
@end

@implementation YDMallocGobbler

+ (void)load
{
    NSLog(@"[+] 👹LOAD WINS!? ");
}

@end

static void __attribute__((constructor)) initialize(void){
    pthread_t gobblersThread = NULL;
    assert(pthread_create(&gobblersThread, NULL, gobble, NULL) == 0);
    assert(pthread_join(gobblersThread, NULL) == 0);
}
