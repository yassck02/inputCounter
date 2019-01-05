# inputCounter
A menubar app for MacOS that counts keypresses and clicks

|                                       |                                       |
|                  :---:                |                   :---:               |
| ![img00001.png](/images/img00001.png) | ![img00002.png](/images/img00002.png) |
|                                       |                                       |

Clicks and keypresses are counted globaly throughout the whole operating system. 
It also works well with multiple external monitors. 
It can easily be set up to automaticaly run when your computer boots up.

### Languages + Tools + Platforms + Frameworks
- Swift
- Xcode
- MacOS
- Cocoa, UIKit, AppKit

### Future
Currently, this app does not collect any information like which key was pressed, or where the click occured on the screen. The only information collected is whether or not a key or mouse button is pressed
This relatively simple application could be updated in the fufture to:
- Capture click location on the screen and present the user with a 'heat map' of where they click
- Same could be done with the keyboard (eg: visualize which keys are pressed most frequently)
- Same could be done for the mouse (eg: which button - left, right, middle - is pressed the most...)

### Related Links
- https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/EventOverview/MonitoringEvents/MonitoringEvents.html
- https://developer.apple.com/documentation/appkit/nsevent?language=swift