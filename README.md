# Alkali
[![Build Status](https://travis-ci.org/JaceHensley/alkali.svg?branch=master)](https://travis-ci.org/JaceHensley/alkali)
[![codecov.io](http://codecov.io/github/JaceHensley/alkali/coverage.svg?branch=master)](http://codecov.io/github/JaceHensley/alkali?branch=master)

Library to build reusable component, inspired by React.js.

- [__Basic Usage__](#basic-usage)
  - [`Component`](#component)
    - [`props`](#props)
    - [`state`](#state)
    - [Lifecycle Methods](#lifecyle-methods)
      - [`render`](#render)
      - [`willMount`](#willMount)
      - [`didMount`](#didMount)
      - [`willReceiveProps`](#willReceiveProps)
      - [`shouldUpdate`](#shouldUpdate)
      - [`willUpdate`](#willUpdate)
      - [`didUpdate`](#didUpdate)
      - [`willUnmount`](#willUnmount)
  - [`registerComponent`](#registerComponent)
  - [`initAlkaliBrowserConfiguration`](#initAlkaliBrowserConfiguration)
  - [`mountComponent`](#mountComponent)

# Basic Usage

## `Component`
All UI logic will live within a `Component`. `Component` is abstract and should be extended for each new component you wish to create.

With `Component` you are given `props` and `state`, as well as the lifecycle methods.

### `props`
`props` are an `UnmodifiableMapView` that are passed into the `Component` by whatever is rendering. Within a `Component` you have no control over the values within `props`.

### `state`
`state` is a `UnmodifiableMapView` that is internal to the `Component`, whatever is rendering it has no control over the value of `state`. Within the `Component` you can only change the value of `state` by using the `setState` method.

### Lifecycle Methods

#### `getDefaultProps`
Used to set the values to the used for `Component.props` if they are not set by the whatever is rendering the `Component`.

```dart
@override
Map getDefaultProps() => {
  'someCustomProp': 'defaultValue'
};
```

#### `getInitialState`
Used to set the default values used in `Component.state`. Since `state` is not set externally it is important to override this method.

```dart
@override
Map getInitialState() => {
  'someCustomState': `defaultValue`
}
```

#### `render`
`render` is the most important lifecycle method as this is used to build the UI. Should either return `ComponentDescription` or `List<ComponentDescription>` (_if returning a List `Component.domNode` will not be set_).

```dart
class CustomComponent extends Component {
  ComponentDescription render() {
    return h1({
      'children': 'Hello World!'
    });
  }
}
```

#### `willMount`
`willMount` is called once, right before initial rendering of the `Component`.

#### `didMount`
`didMount` is called once, right after the initial rendering of the `Component`.

#### `willReceiveProps`
`willReceiveProps` is called when the component is receiving new props from whatever is rendering it.

#### `shouldUpdate`
`shouldUpdate` is called right before applying new `props` and `state` if it returns `false` the `Component` will not be updated.

#### `willUpdate`
`willUpdate` is called right before applying new `props` and `state`.

#### `didUpdate`
`didiUpdate` is called right after applying new `props` and `state`.

#### `willUnmount`
`willUnmount` is called right before the `Component` is remove from the DOM.
