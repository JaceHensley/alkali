part of alkali.browser;

void _applyAttributes(html.Element element, Map props, {Map oldProps}) {
  if (oldProps == null) {
    oldProps = {};
  } else {
    oldProps = new Map.from(oldProps);
  }

  props.forEach((String key, value) {
    if (_isValidAttribute(element, key)) {
      if (key == 'className') {
        key = 'class';
      }

      if (oldProps[key] != value &&
          element.getAttribute(key) != value) {
        _applyAttribute(element, key, value);
      }
      oldProps.remove(key);
    }
  });

  oldProps.forEach((key, value) {
    element.attributes.remove(key);
  });
}

void _applyAttribute(html.Element element, String key, dynamic value) {
  if (key == 'style') {
    (value as Map).forEach((String propertyName, value) {
      element.style.setProperty(propertyName, value);
    });
  } else {
    element.setAttribute(key, value.toString());
  }
}

bool _isValidAttribute(html.Element element, String attribute) {
  return (!_svgComponents.contains(element.tagName) && _allowAttributes.contains(attribute))
      || (_svgComponents.contains(element.tagName) && _allowedSvgAttributes.contains(attribute))
      || _hasValidPrefix(attribute);
}

bool _hasValidPrefix(String attribute) {
  bool match = false;

  _allowedAttributePrefixes.forEach((prefix) {
    if (attribute.startsWith(prefix)) {
      match = true;
    }
  });

  return match;
}

final Set<String> _allowAttributes = new Set.from([
  'accept',
  'accessKey',
  'action',
  'allowFullScreen',
  'allowTransparency',
  'alt',
  'autoCapitalize',
  'autoComplete',
  'autoFocus',
  'autoPlay',
  'cellPadding',
  'cellSpacing',
  'charSet',
  'checked',
  'className',
  'cols',
  'colSpan',
  'content',
  'contentEditable',
  'contextMenu',
  'controls',
  'data',
  'dateTime',
  'dir',
  'disabled',
  'draggable',
  'encType',
  'for',
  'form',
  'frameBorder',
  'height',
  'hidden',
  'href',
  'htmlFor',
  'httpEquiv',
  'icon',
  'id',
  'label',
  'lang',
  'list',
  'loop',
  'max',
  'maxLength',
  'method',
  'min',
  'multiple',
  'name',
  'pattern',
  'placeholder',
  'poster',
  'preload',
  'radioGroup',
  'readOnly',
  'rel',
  'required',
  'role',
  'rows',
  'rowSpan',
  'scrollLeft',
  'scrollTop',
  'selected',
  'size',
  'spellCheck',
  'src',
  'step',
  'style',
  'tabIndex',
  'target',
  'title',
  'type',
  'value',
  'defaultValue',
  'width',
  'wmode'
]);

final Set<String> _allowedSvgAttributes = new Set.from([
  'cx',
  'cy',
  'd',
  'fill',
  'fx',
  'fy',
  'gradientTransform',
  'gradientUnits',
  'offset',
  'points',
  'r',
  'rx',
  'ry',
  'spreadMethod',
  'stopColor',
  'stopOpacity',
  'stroke',
  'strokeLinecap',
  'strokeWidth',
  'transform',
  'version',
  'viewBox',
  'x1',
  'x2',
  'x',
  'y1',
  'y2',
  'y'
]);

final Set<String> _allowedAttributePrefixes = new Set.from([
  'data-',
  'aria-'
]);

final Set<String> _svgComponents = new Set.from([
  'g',
  'defs',
  'linear',
  'pattern',
  'radial',
  'svg',
  'text',
  'tspan'
  'circle',
  'ellipse',
  'line',
  'path',
  'polygon',
  'polyline',
  'rect',
  'stop'
]);
