---
id: bottomTabs-options
title: Options
sidebarlabel: Options
---

## BottomTabs
### animate?: boolean
Controls wether toggling visibility states will be animated.

### backgroundColor?: color
Change the background color.

### barStyle?: 'default' | 'black'
Controls wether the BottomTabs use dark (black) or light (default) visual style. Requires `translucent: true`.

### currentTabId?: number
Select a tab by the id (componentId) of a child contained in it. See [Selecting tabs programmatically](#selectingtabsprogrammatically) for details explanation.

### currentTabIndex?: number

### drawBehind?: boolean

### elevation?: number (Android specific)

### hideShadow?: boolean (iOS specific)

### preferLargeIcons?: boolean (Android specific)

### tabsAttachMode?: 'together' | 'afterInitialTab' | 'onSwitchToTab' (Android specific)

### testID?: string

### titleDisplayMode?: 'alwaysShow' | 'showWhenActive' | 'alwaysHide' (Android specific)

### translucent?: boolean (iOS specific)

### visible?: boolean

## BottomTab
### badge?: string

### badgeColor?: Color

### disableIconTint?: boolean

### dotIndicator?: DotIndicator

### fontFamily?: string

### fontSize?: number

### icon: number

### iconColor?: color

### selectedFontSize?: number

### selectedIcon?: number

### selectedIconColor?: color

### iconInsets?: IconInsets

### disableSelectedIconTint?: boolean

### disableSelectedIconTint?: boolean

### selectedTextColor?: color

### testID?: string

### text?: string

### textColor?: color

### DotIndicator
##### color?: color
##### size?: number
##### visible?: boolean
##### animate?: boolean

### IconInsets
##### top?: number
##### left?: number
##### right?: number
##### bottom?: number