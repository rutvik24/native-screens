/**
 * Placeholder screen pushed when opening a native (UIKit/SwiftUI/Compose) screen.
 * Native is presented from HomeScreen before navigating here, so this is never visible—
 * it only exists so goBack() has something to pop when the user closes the native screen.
 */
export function NativeExampleScreen() {
  return null;
}
