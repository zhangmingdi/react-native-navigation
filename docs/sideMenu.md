---
id: sideMenu
title: Side Menu
sidebar_label: Side Menu
---

https://material.io/components/navigation-drawer/

## Adding a menu icon
To add a menu icon to the TopBar, add it to the TopBar as you would add any other button, and handle it's press event to open the SideMenu either in each component or with a global event listener.

```js
class SideMenuCenterScreen extends React.Component {
  static options() {
    return {
      topBar: {
        leftButtons: {
          id: 'sideMenu',
          icon: require('./img/menu.png')
        }
      }
    };
  }
}
```

### Opening the menu from a component
```js
class SideMenuCenterScreen extends React.Component {
  constructor(props) {
    super(props);
    Navigation.events().bindComponent(this); // Listen to Navigation events in the component
  }

  navigationButtonPressed({ buttonId }) {
    if (buttonId === 'sideMenu') {
      this.openSideMenu(); // Open the Side Menu when the menu button is clicked
    }
  }

  openSideMenu = () => Navigation.mergeOptions(this, {
    sideMenu: {
      left: {
        visible: true // Open the menu by calling mergeOptions and specifying `visible: true`
        }
    }
  });
}
```

### Opening the menu globally
To avoid having SideMenu specific logic in each screen, you can handle the menu button press event globally with a `navigationButtonPressedListener`.

```js
Navigation.events().registerNavigationButtonPressedListener(({ buttonId, componentId }) => {
  if (buttonId === 'sideMenu') {
    this.openSideMenu(componentId);
  }
});

this.openSideMenu = (componentId) => Navigation.mergeOptions(componentId, {
  sideMenu: {
    left: {
      visible: true // Open the menu by calling mergeOptions and specifying `visible: true`
      }
  }
});
```

## Opening the menu programmatically
