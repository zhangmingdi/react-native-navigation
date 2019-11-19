<!-- panels:start -->
<!-- div:left-panel -->
# BottomTabs
This is docs
## Selecting Tabs Programmatically
Tabs can be selected programmatically by updating the `currentTabIndex` or `currentTabId` options.

We'll use the following BottomTabs layout to demonstrate programmatic tab selection.

```js
bottomTabs: {
  id: 'BOTTOM_TABS_LAYOUT',
  children: [
    {
      stack: {
        id: 'HOME_TAB',
        children: [
          {
            component: {
              id: 'HOME_SCREEN'
              name: 'HomeScreen'
            }
          }
        ]
      }
    },
    stack: {
      id: 'PROFILE_TAB',
      children: [
        {
          component: {
            id: 'PROFILE_SCREEN',
            name: 'ProfileScreen'
          }
        },
        {
          component: {
            id: 'SETTINGS_SCREEN',
            name: 'SettingsScreen'
          }
        }
      ]
    }
  ]
}
```

### Selecting a tab by index
The following mergeOptions command will select the second tab. We're passing the id of our BottomTabs layout, but we could also use the id of any of the child components, for example `PROFILE_TAB` or `PROFILE_SCREEN`.

```js
Navigation.mergeOptions('BOTTOM_TABS_LAYOUT', {
  bottomTabs: {
    currentTabIndex: 1
  }
});
```

### Selecting a tab by id
Tabs can also be selected by id (`componentId`). This is particularly useful in cases where you don't know in which tab a screen is contained.
For example, if invoked from one of the child components; `HOME_SCREEN` or `SETTINGS_SCREEN`, the following merge command will select the tab containing the child.
```js
Navigation.mergeOptions(this.props.componentId, {
  bottomTabs: {
    currentTabId: this.props.componentId
  }
});
```

## Changing BottomTabs visibility
The `visible` property is used to control the BottomTab visibility. Visibility can be toggled dynamically using the `mergeOptions` command.
```js
Navigation.mergeOptions(componentId, {
  bottomTabs: {
    visible: false
  },
});
```

visibility can also be changed when pushing screens.
```js
Navigation.push(componentId, {
  component: {
    name: 'pushedScreen',
    options: {
      bottomTabs: {
        visible: false
      }
    }
  }
});
```

## Options
### BottomTabs
#### animate?: boolean :id=animate
Controls wether toggling visibility states will be animated.
___
#### backgroundColor?: color :id=backgroundColor
Change the background color.
___
#### barStyle?: 'default' | 'black' :id=barStyle
Controls wether the BottomTabs use dark (black) or light (default) visual style. Requires `translucent: true`.
___
#### currentTabId?: number :id=currentTabId
Select a tab by the id (componentId) of a child contained in it. See [Selecting tabs programmatically](#selectingtabsprogrammatically) for details explanation.
___
#### currentTabIndex?: number :id=currentTabIndex
___
#### drawBehind?: boolean :id=drawBehind
___
#### elevation?: number (Android specific) :id=elevation
___
#### hideShadow?: boolean (iOS specific) :id=hideShadow
___
#### preferLargeIcons?: boolean (Android specific) :id=preferLargeIcons
___
#### tabsAttachMode?: 'together' | 'afterInitialTab' | 'onSwitchToTab' (Android specific) :id=tabsAttachMode
___
#### testID?: string :id=testID
___
#### titleDisplayMode?: 'alwaysShow' | 'showWhenActive' | 'alwaysHide' (Android specific) :id=titleDisplayMode
___
#### translucent?: boolean (iOS specific) :id=translucent
___
#### visible?: boolean :id=visible
___
### BottomTab
#### badge?: string :id=badge
___
#### badgeColor?: Color :id=badgeColor
___
#### disableIconTint?: boolean :id=disableIconTint
___
#### dotIndicator?: DotIndicator :id=dotIndicator
___
#### fontFamily?: string :id=fontFamily
___
#### fontSize?: number :id=fontSize
___
#### icon: number :id=icon
___
#### iconColor?: color :id=iconColor
___
#### selectedFontSize?: number :id=selectedFontSize
____
#### selectedIcon?: number :id=selectedIcon
____
#### selectedIconColor?: color :id=selectedIconColor
___
#### iconInsets?: IconInsets :id=iconInsets
___
#### disableSelectedIconTint?: boolean :id=disableSelectedIconTint
___
#### disableSelectedIconTint?: boolean :id=disableSelectedIconTint
___
#### selectedTextColor?: color :id=selectedTextColor
___
#### testID?: string :id=bottomtabtestid
___
#### text?: string :id=text
___
#### textColor?: color :id=textColor
___
#### DotIndicator
##### color?: color :id=dotIndicatorColor
##### size?: number :id=dotIndicatorSize
##### visible?: boolean :id=dotIndicatorVisible
##### animate?: boolean :id=dotIndicatorAnimate
___
#### IconInsets
##### top?: number :id=iconInsetsTop
##### left?: number :id=iconInsetsLeft
##### right?: number :id=iconInsetsRight
##### bottom?: number :id=iconInsetsBottom

<!-- div:right-panel -->
<ul id="optionsUl">
  <li><span class="caret">BottomTabs</span>
    <ul class="nested active">
      <li><a href="#/docs/bottomTabs?id=animate">animate</a></li>
      <li><a href="#/docs/bottomTabs?id=backgroundcolor">backgroundColor</a></li>
      <li><a href="#/docs/bottomTabs?id=barstyle">barStyle</a></li>
      <li><a href="#/docs/bottomTabs?id=currenttabid">currentTabId</a></li>
      <li><a href="#/docs/bottomTabs?id=currenttabindex">currentTabIndex</a></li>
      <li><a href="#/docs/bottomTabs?id=drawbehind">drawBehind</a></li>
      <li><a href="#/docs/bottomTabs?id=elevation">elevation</a></li>
      <li><a href="#/docs/bottomTabs?id=hideshadow">hideShadow</a></li>
      <li><a href="#/docs/bottomTabs?id=preferlargeicons">preferLargeIcons</a></li>
      <li><a href="#/docs/bottomTabs?id=tabsattachmode">tabsAttachMode</a></li>
      <li><a href="#/docs/bottomTabs?id=testid">testID</a></li>
      <li><a href="#/docs/bottomTabs?id=titledisplaymode">titleDisplayMode</a></li>
      <li><a href="#/docs/bottomTabs?id=translucent">translucent</a></li>
      <li><a href="#/docs/bottomTabs?id=visible">visible</a></li>
    </ul>
    </li>
    <br>
    <li><span class="caret">BottomTab</span>
    <ul class="nested active">
      <li><a href="#/docs/bottomTabs?id=badge">badge</a></li>
      <li><a href="#/docs/bottomTabs?id=badgecolor">badgeColor</a></li>
      <li><a href="#/docs/bottomTabs?id=disableicontint">disableIconTint</a></li>
      <li><a href="#/docs/bottomTabs?id=dotindicator">dotIndicator</a></li>
      <li><a href="#/docs/bottomTabs?id=fontfamily">fontFamily</a></li>
      <li><a href="#/docs/bottomTabs?id=fontsize">fontSize</a></li>
      <li><a href="#/docs/bottomTabs?id=icon">icon</a></li>
      <li><a href="#/docs/bottomTabs?id=iconcolor">iconColor</a></li>
      <li><a href="#/docs/bottomTabs?id=selectedfontsize">selectedFontSize</a></li>
      <li><a href="#/docs/bottomTabs?id=selectedicon">selectedIcon</a></li>
      <li><a href="#/docs/bottomTabs?id=selectediconcolor">selectedIconColor</a></li>
      <li><a href="#/docs/bottomTabs?id=iconinsets">iconInsets</a></li>
      <li><a href="#/docs/bottomTabs?id=disableselectedicontint">disableSelectedIconTint</a></li>
      <li><a href="#/docs/bottomTabs?id=selectedtextcolor">selectedTextColor</a></li>
      <li><a href="#/docs/bottomTabs?id=bottomtabtestid">testID</a></li>
      <li><a href="#/docs/bottomTabs?id=text">text</a></li>
      <li><a href="#/docs/bottomTabs?id=textcolor">textColor</a></li>
    </ul>
    </li>
</ul>
<!-- panels:end -->