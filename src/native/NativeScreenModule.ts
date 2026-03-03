import { NativeModules, Platform } from 'react-native';

const { NativeScreenModule: NativeScreenModuleImpl } = NativeModules;

export interface NativeScreenModuleSpec {
  openNativeScreen(title: string, callback: () => void): void;
  openNativeSwiftUIScreen?(title: string, callback: () => void): void;
  openNativeModalScreen?(title: string, callback: () => void): void;
  openNativeSwiftUIModalScreen?(title: string, callback: () => void): void;
  openNativeComposeScreen?(title: string, callback: () => void): void;
}

export const NativeScreenModule = NativeScreenModuleImpl as NativeScreenModuleSpec | null;

/** Opens a native screen directly. No RN navigation; onClose runs when the user dismisses it. */
export function openNativeScreen(title: string, onClose: () => void): void {
  const mod = NativeScreenModule;
  if (mod == null) {
    if (__DEV__) {
      console.warn(
        `NativeScreenModule is not available on ${Platform.OS}. Add the native bridge to use native screens.`
      );
    }
    onClose();
    return;
  }
  const fn = mod.openNativeScreen;
  if (typeof fn !== 'function') {
    onClose();
    return;
  }
  fn.call(mod, title, onClose);
}

export function openNativeSwiftUIScreen(title: string, onClose: () => void): void {
  const mod = NativeScreenModule;
  if (mod == null) {
    onClose();
    return;
  }
  const fn = mod.openNativeSwiftUIScreen;
  if (typeof fn !== 'function') {
    onClose();
    return;
  }
  fn.call(mod, title, onClose);
}

export function openNativeModalScreen(title: string, onClose: () => void): void {
  const mod = NativeScreenModule;
  if (mod == null) {
    onClose();
    return;
  }
  const fn = mod.openNativeModalScreen;
  if (typeof fn !== 'function') {
    onClose();
    return;
  }
  fn.call(mod, title, onClose);
}

export function openNativeSwiftUIModalScreen(title: string, onClose: () => void): void {
  const mod = NativeScreenModule;
  if (mod == null) {
    onClose();
    return;
  }
  const fn = mod.openNativeSwiftUIModalScreen;
  if (typeof fn !== 'function') {
    onClose();
    return;
  }
  fn.call(mod, title, onClose);
}

export function openNativeComposeScreen(title: string, onClose: () => void): void {
  const mod = NativeScreenModule;
  if (mod == null) {
    if (__DEV__) {
      console.warn(
        `NativeScreenModule is not available on ${Platform.OS}. Add the native bridge to use native screens.`
      );
    }
    onClose();
    return;
  }
  const fn = mod.openNativeComposeScreen;
  if (typeof fn !== 'function') {
    onClose();
    return;
  }
  fn.call(mod, title, onClose);
}
