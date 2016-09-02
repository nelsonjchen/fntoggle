# fntoggle

A very, very badly hacked together executable that can turn on and off function keys on *my* Retina MacBook Pro 15" (Mid-2012). What I'm saying is that it WORKS4ME and with ControlPlane.

At least it does not use GUI scripting with Applescript to accomplish this goal.

## Usage

### Media Keys

`./fntoggle off`

### Standard Function Keys

`./fntoggle on`

### Toggle state

`./fntoggle`

*Note*: You may need to toggle the state on or off explicitly before toggle previous state invokation can work.

Note that the original F9-F11 keys are most likely still bound to the Expose stuff. This simple program does nothing to address that.

## References

https://github.com/davvid/schismtracker/blob/master/sys/macosx/ibook-support.c

http://stackoverflow.com/questions/6968677/cfnotificationcenter-usage-examples

http://blog.bignerdranch.com/729-notifications-part-2-handling-and-spying/

## Known Issues

The Keyboard Preference Pane does not update with values set by this tool while running. 

## License
The Schism tracker code is GPL2 but wow a bunch of it looks to be the product of disassembling the Keyboard Preference Pane anyway like me. Regardless, this project could be GPL2.
