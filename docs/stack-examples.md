## Examples
### Single child
A stack declared with a single child.
```js
const stack = {
  children: [
    {
      component: {
        name: 'MyComponent'
      }
    }
  ]
}
```

### Multiple children
A stack can be initialized with more than one child, in which case the last child will be the currently displayed child and the first child will be hidden. In this case the back button will be visible automatically, clicking it will go back in the stack revealing the first (previous) child.
Once the root child becomes visible, the back button is hidden.

```js
const stack = {
  children: [
    {
      component: {
        name: 'RootComponent'
      }
    },
    {
      component: {
        name: 'SecondComponent'
      }
    }
  ]
}
```