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

void _applyEventListener(Node node, html.Element element, String eventType, handler(String eventTye, Node node)) {
  Set registeredListeners = _registeredListeners[element];

  if (registeredListeners == null) {
    registeredListeners = _registeredListeners[element] = new Set();
  }

  if (!registeredListeners.contains(eventType)) {
    element.on[_normalizeListener(eventType)].listen(handler(eventType, node));
    registeredListeners.add(eventType);
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

final Map<String, dynamic> _allListeners = {}
  ..addAll(_mouseEventListeners)
  ..addAll(_keyboardEventListeners)
  ..addAll(_frameEventListeners)
  ..addAll(_formEventListeners)
  ..addAll(_dragEventListeners)
  ..addAll(_clipboardEventListeners)
  ..addAll(_printEventListeners)
  ..addAll(_mediaEventListeners)
  ..addAll(_animationEventListeners)
  ..addAll(_transitionEventListeners)
  ..addAll(_serverSentEventListeners)
  ..addAll(_miscEventListeners)
  ..addAll(_touchEventListeners)
  ..addAll(_selectEventListeners);

final Map<String, dynamic> _mouseEventListeners = {
  'onClick': _handleMouseEvent,
  'onContextMenu': _handleMouseEvent,
  'onDblClick': _handleMouseEvent,
  'onMouseDown': _handleMouseEvent,
  'onMouseEnter': _handleMouseEvent,
  'onMouseLeave': _handleMouseEvent,
  'onMouseMove': _handleMouseEvent,
  'onMouseOver': _handleMouseEvent,
  'onMouseOut': _handleMouseEvent,
  'onMoudeUp': _handleMouseEvent
};

final Map<String, dynamic> _keyboardEventListeners = {
  'onKeyDown': _handleKeyboardEvent,
  'onKeyPress': _handleKeyboardEvent,
  'onKeyUp': _handleKeyboardEvent
};

final Map<String, dynamic> _frameEventListeners = {
  'onAbort': _handleFrameEvent,
  'onBeforeUnload': _handleFrameEvent,
  'onError': _handleFrameEvent,
  'onHashChange': _handleFrameEvent,
  'onLoad': _handleFrameEvent,
  'onPageShow': _handleFrameEvent,
  'onPageHide': _handleFrameEvent,
  'onResize': _handleFrameEvent,
  'onScroll': _handleFrameEvent,
  'onUnload': _handleFrameEvent
};

final Map<String, dynamic> _formEventListeners = {
  'onChange': _handleFormEvent,
  'onInput': _handleFormEvent,
  'onInvalid': _handleFormEvent,
  'onReset': _handleFormEvent,
  'onSearch': _handleFormEvent,
  'onSelect': _handleFormEvent,
  'onSubmit': _handleFormEvent
};

final Map<String, dynamic> _dragEventListeners = {
  'onDrag': _handleDragEvent,
  'onDragEnd': _handleDragEvent,
  'onDragLeave': _handleDragEvent,
  'onDragOver': _handleDragEvent,
  'onDragStart': _handleDragEvent,
  'onDrop': _handleDragEvent
};

final Map<String, dynamic> _clipboardEventListeners = {
  'onCopy': _handleClipboardEvent,
  'onCut': _handleClipboardEvent,
  'onPaste': _handleClipboardEvent
};

final Map<String, dynamic> _printEventListeners = {
  'onAfterPrint': _handlePrintEvent,
  'onBeforePrint': _handlePrintEvent
};

final Map<String, dynamic> _mediaEventListeners = {
  'onAbort': _handleMediaEvent,
  'onCanPlay': _handleMediaEvent,
  'onCanPlayThrough': _handleMediaEvent,
  'onDurationChange': _handleMediaEvent,
  'onEmptied': _handleMediaEvent,
  'onEnded': _handleMediaEvent,
  'onError': _handleMediaEvent,
  'onLoadedData': _handleMediaEvent,
  'onLoadedMetaData': _handleMediaEvent,
  'onLoadStart': _handleMediaEvent,
  'onPause': _handleMediaEvent,
  'onPlay': _handleMediaEvent,
  'onPlaying': _handleMediaEvent,
  'onProgress': _handleMediaEvent,
  'onRateChange': _handleMediaEvent,
  'onSeeked': _handleMediaEvent,
  'onSeeking': _handleMediaEvent,
  'onStalled': _handleMediaEvent,
  'onSuspend': _handleMediaEvent,
  'onTimeUpdate': _handleMediaEvent,
  'onVolumeChange': _handleMediaEvent,
  'onWaiting': _handleMediaEvent
};

final Map<String, dynamic> _animationEventListeners = {
  'animationEnd': _handleAnimationEvent,
  'animationIteration': _handleAnimationEvent,
  'animationStart': _handleAnimationEvent
};

final Map<String, dynamic> _transitionEventListeners = {
  'transitionEnd': _handleTransitionEvent
};

final Map<String, dynamic> _serverSentEventListeners = {
  'onError': _handleServerSentEvent,
  'onMessage': _handleServerSentEvent,
  'onOpen': _handleServerSentEvent
};

final Map<String, dynamic> _miscEventListeners = {
  'onMessage': _handleDomEvent,
  'onOnline': _handleDomEvent,
  'onPopState': _handleDomEvent,
  'onShow': _handleDomEvent,
  'onStorage': _handleDomEvent,
  'onToggle': _handleDomEvent
};

final Map<String, dynamic> _touchEventListeners = {
  'onTouchCancel': _handleTouchEvent,
  'onTouchEnd': _handleTouchEvent,
  'onTouchMove': _handleTouchEvent,
  'onTouchStart': _handleTouchEvent
};

final Map<String, dynamic> _selectEventListeners = {
  'onSelect': _handleSelectEvent
};
