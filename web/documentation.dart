// Copyright (c) 2016, the Hugo Project Homepage Authors.
// Please see the AUTHORS file for details.
// This program is free software. It comes without any warranty, to
// the extent permitted by applicable law. You can redistribute it
// and/or modify it under the terms of the Do What The Fuck You Want
// To Public License, Version 2, as published by Sam Hocevar. See
// http://www.wtfpl.net/ for more details.

//---------------------------------------------------------------------
// Standard libraries
//---------------------------------------------------------------------

import 'dart:html' as html;

//---------------------------------------------------------------------
// Library contents
//---------------------------------------------------------------------

void _expand(html.Element header, html.Element view, html.Element content) {
  var expanded = false;
  header.onClick.listen((_) {
    var height = expanded ? 0 : view.scrollHeight;

    view.style.height = '${height}px';
    content.style.visibility = 'visible';

    expanded = !expanded;

    var headerClasses = header.classes;

    if (expanded) {
      headerClasses.add('expanded');
    } else {
      headerClasses.remove('expanded');
    }
  });
}

bool _isHeader(html.Element element) {
  var tagName = element.tagName.toLowerCase();

  return tagName == 'h1';
}

void _createGroups(html.Element article) {
  var children = article.children;
  var childCount = children.length;
  var i;

  for (i = 0; i < childCount; ++i) {
    if (_isHeader(children[i])) {
      break;
    }
  }

  // Nothing to do if there aren't any sections
  if (i == childCount) {
    return;
  }

  var end = childCount - 1;

  while (end > i) {
    var start = end;

    while (!_isHeader(children[start])) {
      --start;
    }

    if (start != end) {
      // Get the number of elements to remove
      var count = end - start;

      // Move in front of the header element
      var insert = start + 1;

      // Create the group
      var group = new html.DivElement();
      var groupChildren = group.children;

      // Remove the elements
      for (var j = 0; j < count; ++j) {
        var child = children.removeAt(insert);

        groupChildren.add(child);
      }

      print(group.children.length);

      // Create the view
      var view = new html.DivElement();
      view.classes.add('view');
      view.children.add(group);

      // Insert the group
      children.insert(insert, view);

      _expand(children[start], view, group);
    }

    // Move behind the header element
    end = start - 1;
  }
}

void main() {
  var article = html.querySelector('article');

  _createGroups(article);

  html.window.requestAnimationFrame((_) { article.classes.remove('hide'); });
}
