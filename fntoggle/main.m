#include "utils.h"

int main(int argc, const char * argv[]) {
    unsigned int res = -1;
    
    if (argc == 2) {
        if (strcmp(argv[1], "on") == 0) res = enable();
        else if (strcmp(argv[1], "off") == 0) res = disable();
    }
    else if (argc == 1) {   // toggle to alternate state
        Boolean validValue;
        Boolean result = CFPreferencesGetAppBooleanValue(CFSTR("fnState"), CFSTR("com.apple.keyboard"), &validValue);
        
        if (result && validValue) res = disable();
        else if (!result && validValue) res = enable();
        else return -1;
    }
    else {
        return -1;
    }
    
    printf("res: %d\n", res);
    return res;
}

