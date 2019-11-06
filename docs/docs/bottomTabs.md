<!-- panels:start -->
<!-- div:left-panel -->
# BottomTabs
This is docs
## Selecting Tabs Programmatically
```js
bottomTabs: {
  children: [
    {
      stack: {
        id: 'HOME_TAB',
        children: [
          {
            component: {
              id: 'HOME'
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
            id: 'PROFILE',
            name: 'ProfileScreen'
          }
        },
        {
          component: {
            id: 'SETTINGS',
            name: 'SettingsScreen'
          }
        }
      ]
    }
  ]
}
```

## Options
### animate?: boolean
Controls wether toggling visibility states will be animated.
___
### backgroundColor?: color
Change the background color.
___
### barStyle?: 'default' | 'black'
Controls wether the BottomTabs use dark (black) or light (default) visual style. Requires `translucent: true`.
___
### currentTabId?: number
Select a tab by the id (componentId) of a child contained in it. See [Selecting tabs programmatically](#selectingtabsprogrammatically) for details explanation.


<!-- div:right-panel -->
<ul id="optionsUl">
  <li><span class="caret">BottomTabs</span>
    <ul class="nested active">
      <li><a href="">animate</a></li>
      <li><a href="">backgroundColor</a></li>
      <li><a href="">barStyle</a></li>
      <li><a href="">currentTabId</a></li>
      <li><a href="">currentTabIndex</a></li>
      <li><a href="">drawBehind</a></li>
      <li><a href="">elevation</a></li>
      <li><a href="">hideShadow</a></li>
      <li><a href="">tabsAttachMode</a></li>
      <li><a href="">testID</a></li>
      <li><a href="">titleDisplayMode</a></li>
      <li><a href="">translucent</a></li>
      <li><a href="">visible</a></li>
    </ul>
    </li>
    <li><span class="caret">BottomTab</span>
    <ul class="nested active">
      <li><a href="">badge</a></li>
      <li><a href="">badgeColor</a></li>
      <li><a href="">disableIconTint</a></li>
      <li><a href="">dotIndicator</a></li>
      <li><a href="">fontFamily</a></li>
      <li><a href="">fontSize</a></li>
      <li><a href="">icon</a></li>
      <li><a href="">iconColor</a></li>
      <li><a href="">selectedFontSize</a></li>
      <li><a href="">selectedIcon</a></li>
      <li><a href="">selectedIconColor</a></li>
      <li><a href="">iconInsets</a></li>
      <li><a href="">disableSelectedIconTint</a></li>
      <li><a href="">selectedTextColor</a></li>
      <li><a href="">testID</a></li>
      <li><a href="">text</a></li>
      <li><a href="">textColor</a></li>
    </ul>
    </li>
</ul>
<!-- panels:end -->