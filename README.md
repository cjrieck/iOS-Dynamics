iOS-Dynamics
============

Mini app that shows vairous animations. Included are

- UIKit Dynamics (spring behavior on the collection view when scroll)
- Drawing of strokes using UIBezierPath
- UIMotionEffects to give the collection view a little more depth
- Use of CGTransforms for the image views on the cells
- Shrink, expand, wiggle effect on cells when selected! (Because why not?)
- UIView animations

**NOTE:** It's best to run this on a device. The simulator displays some lag whereas the device gives the animations more justice.

Colors were meant to be more nuetral. Had a more 'mature' theme in mind, yet mature is relative in this context.

Borders are used around the cells to impose some degree of separation from the background and the UIMotionEffects further emphasize this.

There's a delay simulation button indicating the current state of the delay simulator. It lies on the navigation bar. You can turn this on and off, but the setting will *not* persist between app termination and relaunch. This is meant to simulate potential, slow connections (assumes the download will always succeed)

Animations are awesome! The ones displayed here are subtle, but they add an extra level of complexity to the UI. They can add that "wow" factor to your app, but an overuse of animations can be a bad thing. I chose these animations because they meshed well together in this context. With the main content being the images, you want to focus the user's attention on them. So the animations are built *for* the images and not around them. Hope you enjoy!