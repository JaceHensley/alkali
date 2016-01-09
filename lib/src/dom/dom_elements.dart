library alkali.dom.dom_elements;

import 'package:alkali/src/core.dart';
import 'dom_component.dart';
import 'dom_text_component.dart';

ComponentDescriptionFactory _registerDomComponent(String tagName) {
  var factory = ([Map props]) {
    return new DomComponent(props, tagName);
  };

  return registerComponent(factory);
}

List parseChildren(dynamic children) {
  if (children == null) {
    return [];
  }

  if (!(children is Iterable)) {
    children = [children];
  }

  List newChildren = [];

  children.forEach((child) {
    if (child is ComponentDescription) {
      newChildren.add(child);
    } else if (child is String) {
      newChildren.add(domTextComponentDescriptionFactory({'children': child}));
    } else if (child is Iterable) {
      newChildren.addAll(parseChildren(child));
    } else {
      throw 'Children should only be Strings or ComponentDescriptions';
    }
  });
  return newChildren;
}

ComponentDescriptionFactory a = _registerDomComponent('a');
ComponentDescriptionFactory abbr = _registerDomComponent('abbr');
ComponentDescriptionFactory address = _registerDomComponent('address');
ComponentDescriptionFactory article = _registerDomComponent('article');
ComponentDescriptionFactory aside = _registerDomComponent('aside');
ComponentDescriptionFactory audio = _registerDomComponent('audio');
ComponentDescriptionFactory b = _registerDomComponent('b');
ComponentDescriptionFactory bdi = _registerDomComponent('bdi');
ComponentDescriptionFactory bdo = _registerDomComponent('bdo');
ComponentDescriptionFactory big = _registerDomComponent('big');
ComponentDescriptionFactory blockquote = _registerDomComponent('blockquote');
ComponentDescriptionFactory body = _registerDomComponent('body');
ComponentDescriptionFactory button = _registerDomComponent('button');
ComponentDescriptionFactory canvas = _registerDomComponent('canvas');
ComponentDescriptionFactory caption = _registerDomComponent('caption');
ComponentDescriptionFactory cite = _registerDomComponent('cite');
ComponentDescriptionFactory code = _registerDomComponent('code');
ComponentDescriptionFactory colgroup = _registerDomComponent('colgroup');
ComponentDescriptionFactory data = _registerDomComponent('data');
ComponentDescriptionFactory datalist = _registerDomComponent('datalist');
ComponentDescriptionFactory dd = _registerDomComponent('dd');
ComponentDescriptionFactory del = _registerDomComponent('del');
ComponentDescriptionFactory details = _registerDomComponent('details');
ComponentDescriptionFactory dfn = _registerDomComponent('dfn');
ComponentDescriptionFactory dialog = _registerDomComponent('dialog');
ComponentDescriptionFactory div = _registerDomComponent('div');
ComponentDescriptionFactory dl = _registerDomComponent('dl');
ComponentDescriptionFactory dt = _registerDomComponent('dt');
ComponentDescriptionFactory em = _registerDomComponent('em');
ComponentDescriptionFactory fieldset = _registerDomComponent('fieldset');
ComponentDescriptionFactory figcaption = _registerDomComponent('figcaption');
ComponentDescriptionFactory figure = _registerDomComponent('figure');
ComponentDescriptionFactory footer = _registerDomComponent('footer');
ComponentDescriptionFactory form = _registerDomComponent('form');
ComponentDescriptionFactory h1 = _registerDomComponent('h1');
ComponentDescriptionFactory h2 = _registerDomComponent('h2');
ComponentDescriptionFactory h3 = _registerDomComponent('h3');
ComponentDescriptionFactory h4 = _registerDomComponent('h4');
ComponentDescriptionFactory h5 = _registerDomComponent('h5');
ComponentDescriptionFactory h6 = _registerDomComponent('h6');
ComponentDescriptionFactory head = _registerDomComponent('head');
ComponentDescriptionFactory header = _registerDomComponent('header');
ComponentDescriptionFactory html = _registerDomComponent('html');
ComponentDescriptionFactory i = _registerDomComponent('i');
ComponentDescriptionFactory iframe = _registerDomComponent('iframe');
ComponentDescriptionFactory ins = _registerDomComponent('ins');
ComponentDescriptionFactory kbd = _registerDomComponent('kbd');
ComponentDescriptionFactory label = _registerDomComponent('label');
ComponentDescriptionFactory legend = _registerDomComponent('legend');
ComponentDescriptionFactory li = _registerDomComponent('li');
ComponentDescriptionFactory main = _registerDomComponent('main');
ComponentDescriptionFactory map = _registerDomComponent('map');
ComponentDescriptionFactory mark = _registerDomComponent('mark');
ComponentDescriptionFactory menu = _registerDomComponent('menu');
ComponentDescriptionFactory menuitem = _registerDomComponent('menuitem');
ComponentDescriptionFactory meter = _registerDomComponent('meter');
ComponentDescriptionFactory nav = _registerDomComponent('nav');
ComponentDescriptionFactory noscript = _registerDomComponent('noscript');
ComponentDescriptionFactory object = _registerDomComponent('object');
ComponentDescriptionFactory ol = _registerDomComponent('ol');
ComponentDescriptionFactory optgroup = _registerDomComponent('optgroup');
ComponentDescriptionFactory option = _registerDomComponent('option');
ComponentDescriptionFactory output = _registerDomComponent('output');
ComponentDescriptionFactory p = _registerDomComponent('p');
ComponentDescriptionFactory picture = _registerDomComponent('picture');
ComponentDescriptionFactory pre = _registerDomComponent('pre');
ComponentDescriptionFactory progress = _registerDomComponent('progress');
ComponentDescriptionFactory q = _registerDomComponent('q');
ComponentDescriptionFactory rp = _registerDomComponent('rp');
ComponentDescriptionFactory rt = _registerDomComponent('rt');
ComponentDescriptionFactory ruby = _registerDomComponent('ruby');
ComponentDescriptionFactory s = _registerDomComponent('s');
ComponentDescriptionFactory samp = _registerDomComponent('samp');
ComponentDescriptionFactory script = _registerDomComponent('script');
ComponentDescriptionFactory section = _registerDomComponent('section');
ComponentDescriptionFactory select = _registerDomComponent('select');
ComponentDescriptionFactory small = _registerDomComponent('small');
ComponentDescriptionFactory span = _registerDomComponent('span');
ComponentDescriptionFactory strong = _registerDomComponent('strong');
ComponentDescriptionFactory style = _registerDomComponent('style');
ComponentDescriptionFactory sub = _registerDomComponent('sub');
ComponentDescriptionFactory summary = _registerDomComponent('summary');
ComponentDescriptionFactory sup = _registerDomComponent('sup');
ComponentDescriptionFactory table = _registerDomComponent('table');
ComponentDescriptionFactory tbody = _registerDomComponent('tbody');
ComponentDescriptionFactory td = _registerDomComponent('td');
ComponentDescriptionFactory textarea = _registerDomComponent('textarea');
ComponentDescriptionFactory tfoot = _registerDomComponent('tfoot');
ComponentDescriptionFactory th = _registerDomComponent('th');
ComponentDescriptionFactory thead = _registerDomComponent('thead');
ComponentDescriptionFactory time = _registerDomComponent('time');
ComponentDescriptionFactory title = _registerDomComponent('title');
ComponentDescriptionFactory tr = _registerDomComponent('tr');
ComponentDescriptionFactory u = _registerDomComponent('u');
ComponentDescriptionFactory ul = _registerDomComponent('ul');
/// We need to use variable because var is reserved keyword
ComponentDescriptionFactory variable = _registerDomComponent('var');
ComponentDescriptionFactory video = _registerDomComponent('video');

// SVG ELEMENTS
ComponentDescriptionFactory g = _registerDomComponent('g');
ComponentDescriptionFactory defs = _registerDomComponent('defs');
ComponentDescriptionFactory linearGradient = _registerDomComponent('linearGradient');
ComponentDescriptionFactory pattern = _registerDomComponent('pattern');
ComponentDescriptionFactory radialGradient = _registerDomComponent('radialGradient');
ComponentDescriptionFactory svg = _registerDomComponent('svg');
ComponentDescriptionFactory text = _registerDomComponent('text');
ComponentDescriptionFactory tspan = _registerDomComponent('tspan');

// NOT PAIR ELEMENTS
ComponentDescriptionFactory area = _registerDomComponent('area');
ComponentDescriptionFactory base = _registerDomComponent('base');
ComponentDescriptionFactory br = _registerDomComponent('br');
ComponentDescriptionFactory col = _registerDomComponent('col');
ComponentDescriptionFactory embed = _registerDomComponent('embed');
ComponentDescriptionFactory hr = _registerDomComponent('hr');
ComponentDescriptionFactory img = _registerDomComponent('img');
ComponentDescriptionFactory input = _registerDomComponent('input');
ComponentDescriptionFactory keygen = _registerDomComponent('keygen');
ComponentDescriptionFactory link = _registerDomComponent('link');
ComponentDescriptionFactory meta = _registerDomComponent('meta');
ComponentDescriptionFactory param = _registerDomComponent('param');
ComponentDescriptionFactory source = _registerDomComponent('source');
ComponentDescriptionFactory track = _registerDomComponent('track');
ComponentDescriptionFactory wbr = _registerDomComponent('wbr');

// SVG NOT PAIR ELEMENTS
ComponentDescriptionFactory circle = _registerDomComponent('circle');
ComponentDescriptionFactory ellipse = _registerDomComponent('ellipse');
ComponentDescriptionFactory line = _registerDomComponent('line');
ComponentDescriptionFactory path = _registerDomComponent('path');
ComponentDescriptionFactory polygon = _registerDomComponent('polygon');
ComponentDescriptionFactory polyline = _registerDomComponent('polyline');
ComponentDescriptionFactory rect = _registerDomComponent('rect');
ComponentDescriptionFactory stop = _registerDomComponent('stop');
