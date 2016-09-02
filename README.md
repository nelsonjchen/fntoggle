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

## References

https://github.com/davvid/schismtracker/blob/master/sys/macosx/ibook-support.c

http://stackoverflow.com/questions/6968677/cfnotificationcenter-usage-examples

http://blog.bignerdranch.com/729-notifications-part-2-handling-and-spying/

## Known Issues

The Keyboard Preference Pane does not update with values set by this tool while running. I don't know Cocoa but this probably has something to do with not expecting outsiders to change that setting. Either way, it's minor.

## License
The Schism tracker code is GPL2 but wow a bunch of it looks to be the product of disassembling the Keyboard Preference Pane anyway like me. Regardless, this project is probably GPL2.

I don't know if the CC-BY-SA code I used from the StackOverflow example counts. It's very reference material and the Oracle v. Google legal battle judgement would have probably said this is just me looking at how to use an API and not like making a mathematical representation or something. 

