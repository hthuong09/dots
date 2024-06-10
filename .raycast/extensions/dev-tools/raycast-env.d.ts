/// <reference types="@raycast/api">

/* 🚧 🚧 🚧
 * This file is auto-generated from the extension's manifest.
 * Do not modify manually. Instead, update the `package.json` file.
 * 🚧 🚧 🚧 */

/* eslint-disable @typescript-eslint/ban-types */

type ExtensionPreferences = {}

/** Preferences accessible in all the extension's commands */
declare type Preferences = ExtensionPreferences

declare namespace Preferences {
  /** Preferences accessible in the `wezterm` command */
  export type Wezterm = ExtensionPreferences & {}
  /** Preferences accessible in the `kitty` command */
  export type Kitty = ExtensionPreferences & {}
  /** Preferences accessible in the `dev-tools` command */
  export type DevTools = ExtensionPreferences & {}
}

declare namespace Arguments {
  /** Arguments passed to the `wezterm` command */
  export type Wezterm = {}
  /** Arguments passed to the `kitty` command */
  export type Kitty = {}
  /** Arguments passed to the `dev-tools` command */
  export type DevTools = {}
}


