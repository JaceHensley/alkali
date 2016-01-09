part of alkali.browser;

DomEventCallback _handleDomEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      DomEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

KeyboardEventCallback _handleKeyboardEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      KeyboardEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

FrameEventCallback _handleFrameEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      FrameEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

FormEventCallback _handleFormEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      FormEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

DragEventCallback _handleDragEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      DragEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

ClipboardEventCallback _handleClipboardEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      ClipboardEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

PrintEventCallback _handlePrintEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      PrintEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

MediaEventCallback _handleMediaEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      MediaEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

AnimationEventCallback _handleAnimationEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      AnimationEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

TransitionEventCallback _handleTransitionEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      TransitionEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

ServerSentEventCallback _handleServerSentEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      ServerSentEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

TouchEventCallback _handleTouchEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      TouchEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

FocusEventCallback _handleFocusEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    if (eventType == 'onBlur' || eventType == 'onFocus') {
      FrameEventCallback listener = targetNode.component.props[eventType];

      if (listener != null) {
        listener(event);
      }
    } else {
      while (targetNode != null) {
        FrameEventCallback listener = targetNode.component.props[eventType];

        if (listener != null && listener(event) == false) {
          return;
        }

        targetNode = targetNode.parent;
      }
    }
  };
}

MouseEventCallback _handleMouseEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    if (eventType == 'onClick') {
      _handleSelectEvent('onSelect', targetNode)(event);
    }

    while (targetNode != null) {
      MouseEventCallback listener = targetNode.component.props[eventType];
      if (listener == null) {
        return;
      }

      if (listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

UIEventCallback _handleUIEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      UIEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

WheelEventCallback _handleWheelEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    while (targetNode != null) {
      WheelEventCallback listener = targetNode.component.props[eventType];

      if (listener != null && listener(event) == false) {
        return;
      }

      targetNode = targetNode.parent;
    }
  };
}

ServerSentEventCallback _handleSelectEvent(String eventType, Node node) {
  return (html.Event event) {
    assert(node.domNode == event.target);
    Node targetNode = node;

    EventKeyCallback listener = targetNode.component.props[eventType];

    if (listener != null) {
      listener(event, node.component.props['eventKey']);
    }
  };
}
