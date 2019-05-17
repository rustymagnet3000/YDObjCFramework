/*********************************************************************************
 Malloc Gobbler
 *********************************************************************************/
#import <Foundation/Foundation.h>
#define MB(x)   ((size_t) (x) << 20)

@interface YDMallocGobbler: NSObject
@end

@implementation YDMallocGobbler

+ (void)load
{
    int count = 0;
    
    while (1) {
        int *p = malloc(MB(100));
        if (p == NULL) {
            NSLog(@"[+] malloc request failed");
        } else {
            if (count >= 10){
                NSLog(@"[+] 👹 Gobbler ate: %.1f GB\n", (float)(++count * 100)/1000);
            }
            else {
                NSLog(@"[+] 👹 Gobbler ate: %d MB\n", ++count * 100);
            }
        }
        memset(p, 'A', MB(100));
        NSLog(@"[+] 👹 Gobbler finished setting memory");
    }
}

@end
