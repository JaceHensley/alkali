part of alkali.browser;

typedef DomEventCallback(html.Event event);
typedef KeyboardEventCallback(html.KeyboardEvent event);
typedef FrameEventCallback(html.Event event);
typedef FormEventCallback(html.Event event);
typedef DragEventCallback(html.Event event);
typedef ClipboardEventCallback(html.Event event);
typedef PrintEventCallback(html.Event event);
typedef MediaEventCallback(html.Event event);
typedef AnimationEventCallback(html.AnimationEvent event);
typedef TransitionEventCallback(html.TransitionEvent event);
typedef ServerSentEventCallback(html.Event event);
typedef TouchEventCallback(html.TouchEvent event);
typedef FocusEventCallback(html.FocusEvent event);
typedef MouseEventCallback(html.MouseEvent event);
typedef UIEventCallback(html.UIEvent event);
typedef WheelEventCallback(html.WheelEvent event);
typedef EventKeyCallback(html.Event event, Object eventKey);

final Map<html.Element, Set<String>> _registeredListeners = {};

void _applyEventListeners(Node node, Map props) {
  props.forEach((String eventType, listener) {
    if (_allowedListeners.contains(eventType)) {
      Node parent = node;
      while (parent.parent?.domNode != null) {
        parent = parent.parent;
      }

      var element = parent.domNode;
      Set registeredListeners = _registeredListeners[element];
      if (registeredListeners == null) {
        registeredListeners = _registeredListeners[element] = new Set();
      }
      if (!registeredListeners.contains(eventType)) {
        _applyEventListener(element, node, eventType);
        registeredListeners.add(eventType);
      }
    }
  });
}

void _applyEventListener(html.Element element, Node node, String eventType) {
  if (_mouseEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleMouseEvent(eventType, node));
  } else if (_keyboardEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleKeyboardEvent(eventType, node));
  } else if (_frameEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleFrameEvent(eventType, node));
  } else if (_formEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleFormEvent(eventType, node));
  } else if (_dragEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleDragEvent(eventType, node));
  } else if (_clipboardEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleClipboardEvent(eventType, node));
  } else if (_printEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handlePrintEvent(eventType, node));
  } else if (_mediaEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleMediaEvent(eventType, node));
  } else if (_animationEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleAnimationEvent(eventType, node));
  } else if (_transitionEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleTransitionEvent(eventType, node));
  } else if (_serverSentEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleServerSentEvent(eventType, node));
  } else if (_miscEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleDomEvent(eventType, node));
  } else if (_touchEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleTouchEvent(eventType, node));
  } else if (_selectEvents.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(_handleSelectEvent(eventType, node));
  } else {
    element.on[_normalizeListener(eventType)].listen(_handleDomEvent(eventType, node));
  }
}

String _normalizeListener(String eventType) {
  String result = eventType;
  result = result.replaceAll(new RegExp(r'^on'), '');

  if (result.isNotEmpty) {
    result = result[0].toLowerCase() + result.substring(1);
  }

  return result;
}

final Set<String> _allowedListeners = new Set()
  ..addAll(_mouseEvents)
  ..addAll(_keyboardEvents)
  ..addAll(_frameEvents)
  ..addAll(_formEvents)
  ..addAll(_dragEvents)
  ..addAll(_clipboardEvents)
  ..addAll(_printEvents)
  ..addAll(_mediaEvents)
  ..addAll(_animationEvents)
  ..addAll(_transitionEvents)
  ..addAll(_serverSentEvents)
  ..addAll(_miscEvents)
  ..addAll(_touchEvents)
  ..addAll(_selectEvents);

final Set<String> _mouseEvents = new Set.from([
  'onClick',
  'onContextMenu',
  'onDblClick',
  'onMouseDown',
  'onMouseEnter',
  'onMouseLeave',
  'onMouseMove',
  'onMouseOver',
  'onMouseOut',
  'onMoudeUp'
]);

final Set<String> _keyboardEvents = new Set.from([
  'onKeyDown',
  'onKeyPress',
  'onKeyUp'
]);

final Set<String> _frameEvents = new Set.from([
  'onAbort',
  'onBeforeUnload',
  'onError',
  'onHashChange',
  'onLoad',
  'onPageShow',
  'onPageHide',
  'onResize',
  'onScroll',
  'onUnload'
]);

final Set<String> _formEvents = new Set.from([
  'onChange',
  'onInput',
  'onInvalid',
  'onReset',
  'onSearch',
  'onSelect',
  'onSubmit'
]);

final Set<String> _dragEvents = new Set.from([
  'onDrag',
  'onDragEnd',
  'onDragLeave',
  'onDragOver',
  'onDragStart',
  'onDrop'
]);

final Set<String> _clipboardEvents = new Set.from([
  'onCopy',
  'onCut',
  'onPaste'
]);

final Set<String> _printEvents = new Set.from([
  'onAfterPrint',
  'onBeforePrint'
]);

final Set<String> _mediaEvents = new Set.from([
  'onAbort',
  'onCanPlay',
  'onCanPlayThrough',
  'onDurationChange',
  'onEmptied',
  'onEnded',
  'onError',
  'onLoadedData',
  'onLoadedMetaData',
  'onLoadStart',
  'onPause',
  'onPlay',
  'onPlaying',
  'onProgress',
  'onRateChange',
  'onSeeked',
  'onSeeking',
  'onStalled',
  'onSuspend',
  'onTimeUpdate',
  'onVolumeChange',
  'onWaiting'
]);

final Set<String> _animationEvents = new Set.from([
  'animationEnd',
  'animationIteration',
  'animationStart'
]);

final Set<String> _transitionEvents = new Set.from([
  'transitionEnd'
]);

final Set<String> _serverSentEvents = new Set.from([
  'onError',
  'onMessage',
  'onOpen'
]);

final Set<String> _miscEvents = new Set.from([
  'onMessage',
  'onOnline',
  'onPopState',
  'onShow',
  'onStorage',
  'onToggle',
]);

final Set<String> _touchEvents = new Set.from([
  'onTouchCancel',
  'onTouchEnd',
  'onTouchMove',
  'onTouchStart'
]);

final Set<String> _focusEvents = new Set.from([
  'onFocus',
  'onBlur',
  'onFocusIn',
  'onFocusOut'
]);

final Set<String> _wheelEvents = new Set.from([
  'onMouseWheel',
  'onWheel'
]);

final Set<String> _selectEvents = new Set.from([
  'onSelect'
]);
