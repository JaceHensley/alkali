part of alkali.browser;

bool _browserConfigurationInitialized = false;

var scheduler;

void initAlkaliBrowserConfiguration() {
  if (!_browserConfigurationInitialized) {
    html.window.animationFrame.then(_update);
    _browserConfigurationInitialized = true;
  }
}

void _update(num data) {
  try {
    _updateTrees(data);
  } finally {
    html.window.animationFrame.then(_update);
  }
}

void _updateTrees(_) {
  _rootNodes.forEach((Node node) {
    if (node.isDirty || node.hasDirtyDescendant) {
      node.update();
    }
  });
}
