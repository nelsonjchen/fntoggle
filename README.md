# fntoggle

A very, very badly hacked together executable that can turn on and off function keys on *my* Retina MacBook Pro 15" (Mid-2012). What I'm saying is that it WORKS4ME and with ControlPlane.

At least it does not use GUI scripting with Applescript to accomplish this goal.

**If you know C, or basic Objective-C, feel free to fork and make this not stupid. My C and non-existent Objective-C experience has since atrophied to near-amputation levels.**

## Usage

### Media Keys

`./fntoggle off`

### Standard Function Keys

`./fntoggle on`

Note that the original F9-F11 keys are most likely still bound to the Expose stuff. This simple program does nothing to address that.

## A Song of Laziness and GTD

The Tomb Raider reboot is out for Mac! And I already bought it on Steam for PC! I fire it up and the nice guys at Feral Interactive who ported the new Tomb Raider game pop a warning notice for having "Use all F1, F2, etc. keys as standard function keys". It would be nice to have ControlPlane disable function keys while I'm playing Tomb Raider so this is not an issue at all. I open up ControlPlane, and a built-in option isn't there. I'll have to run an external script.

Alright, so maybe I can find something out there that will do this for me. My search brings up nothing but AppleScripts that open up System Preferences, goes to the Keyboard preference pane, and toggles the box. Okay, that is GUI scripting and that is rather intrusive for my goal. I would like my toggling of this issue to be a bit more surgical. I did find mention of a layout manager for keyboards that recently had this function but took it out to conform to Mac App Store guidelines of which I've since forgotten its name. If they can do it, I'm pretty sure I can too.

So, I have had my eyes on Hopper Disassembler for quite a while because I like tearing stuff apart to find out how things work. I caved in and bought a copy. Then, I loaded the Keyboard Preference Pane executable and pressed the Psuedo-code button because my x86 ASM has also atrophied from the time when I actually did know it. I then find this block.

```objective-c
function methImpl_KeyboardTabController_fnFlipper_ {
    r12 = *objc_msgSend;
    rax = [rdi.mFNFlipper state];
    asm{ sete       al };
    rbx = rax & 0xff;
    var_8 = rbx;
    rax = _openIOCOnnection();
    IOHIDSetParameter(rax, @"HIDFKeyMode", &var_8, 0x8);
    rax = [NSCFPrefManager standardPrefManager];
    rbx = rbx & 0xff;
    [rax setBoolean:rbx forKey:**FNStateKey];
    rax = [NSDistributedNotificationCenter defaultCenter];
    r14 = rax;
    rax = [NSNumber numberWithBool:rbx];
    rax = [NSDictionary dictionaryWithObject:rax forKey:@"state"];
    rax = [r14 postNotificationName:@"com.apple.keyboard.fnstatedidchange" object:0x0 userInfo:rax deliverImmediately:0x1];
    return rax;
}

```
What's `_openIOCOnnection()`? By now, I've opened up `IORegistryExplorer` and watched it change the `HIDFKeyMode` from `0x00` to `0x01` and so on.

```objective-c
function _openIOCOnnection {
    if (*(int32_t *)0x2a9c4 != 0x0) goto loc_2fb3;
    goto loc_2f47;

loc_2fb3:
    return *(int32_t *)0x2a9c4;

loc_2f47:
    rax = IOMasterPort(*(int32_t *)*bootstrap_port, &var_4);
    if (rax == 0x0) goto loc_2f75;
    goto loc_2fac;

loc_2f75:
    rax = IOServiceMatching("IOHIDSystem");
    rax = IOServiceGetMatchingServices(var_4, rax, &var_0);
    if (rax == 0x0) goto loc_2fc0;
    goto loc_2f96;

loc_2fc0:
    rax = IOIteratorNext(var_0);
    rax = IOServiceOpen(rax, *(int32_t *)*mach_task_self_, 0x1, 0x2a9c4);
    if (rax != 0x0) {
            rsi = SIGN_EXTEND(rax);
            NSLog(@"### Error:%lu File:%s Line:%i", rsi, "/SourceCache/KeyboardPref/KeyboardPref-373/Utilities/Utilities.m", 0x82);
    }
    IOObjectRelease(rbx);
    rax = IOObjectRelease(var_0);
    goto loc_2fb3;

loc_2f96:

loc_2fac:
    rax = NSLog();
    goto loc_2fb3;
}
```

Actually, I have no idea what's going on here. I know it's IOKit but I have no experience with it whatsover. By now, it's 12:30AM and I want to sleep I searched the internet for code similar to this with similar terms. I found this:

https://github.com/davvid/schismtracker/blob/master/sys/macosx/ibook-support.c

This is *the only open source non-Apple* piece of software out there that can turn the function key functionality on and off on a Mac keyboard on the fly. It's in a chiptune tracker though so I hurried to extract the code out to a standalone application with a simple `main()` function. And, it worked!

But, all it did was replicate setting some value through IOKit that System Preferences does. All the other embellishments from the decompiled code of the Keyboard preference pane weren't there. I confirmed this by setting them to off and checking out the checkbox in the preference pane. With a bit more Googling I found the Apple documentation with the code needed to set that from my hacked up `main()` function.

At this point, I noticed that the Keyboard Preference Pane does not update with values set by this tool while running. The last part of the decompiled code sent notifications to the distributed notification center. I replicated and confirmed that the same notifications were sent but this did not help. 

Oh well, but at least I got a tool that ControlPlane can now use and that's an edge case anyway. I'm going to sleep now.

## References

https://github.com/davvid/schismtracker/blob/master/sys/macosx/ibook-support.c

http://stackoverflow.com/questions/6968677/cfnotificationcenter-usage-examples

http://blog.bignerdranch.com/729-notifications-part-2-handling-and-spying/

## Known Issues

The Keyboard Preference Pane does not update with values set by this tool while running. I don't know Cocoa but this probably has something to do with not expecting outsiders to change that setting. Either way, it's minor.

## License
The Schism tracker code is GPL2 but wow a bunch of it looks to be the product of disassembling the Keyboard Preference Pane anyway like me. Regardless, this project is probably GPL2.

I don't know if the CC-BY-SA code I used from the StackOverflow example counts. It's very reference material and the Oracle v. Google legal battle judgement would have probably said this is just me looking at how to use an API and not like making a mathematical representation or something. 

