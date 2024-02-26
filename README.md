# Quick tour
In this case study, we used the BBC News dataset (Greene and Cunningham, 2006) that constitutes a benchmark dataset in previous studies for validation purposes on topic classification tasks. This dataset contains a total of 2225 articles (*bbc dataset*), where each article is labeled under one of the following five classes or categories: business, entertainment, politics, sport and tech. This dataset is associated with two main tasks that both match the utilities of *ClickTMtool*. The first task is to identify the primary topics by providing coherent and reasonable results while the second one is to build machine learning models to predict the classes of new records. We initially create a training and a testing dataset using the random split option included in the *File Tab*. Also, the process of label encoding and the frequency of the labels across the dataset are shown in the following figures.

![bbc case study 1](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_1.jpg?raw=true)



![bbc case study 2](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_2.jpg?raw=true)


In the next step, we select different thresholds for the minimum and maximum proportion of documents that a word should occur to be included in the Document Term Matrix (*DTM*), as the default options led in extracting more than 5000 words. After experimentations, we discovered that the selection of these two thresholds is a decisive step that significantly affects the subsequent text mining approaches as both frequent and infrequent words may lead in several issues. These issues are mostly related to producing non-satisfactory topic coherence evaluations, discovering redundant or lackluster topics as well as extracting overlapping and not distinct topics. As a result, for the following experiments we set the first threshold equal to 0.8% and the second threshold equal to 10%, gathering 2108 words in total to form the <a name="_hlk126142903"></a>DTM ([Figure 18](#_ref127565487)). Furthermore, we present the results of the feature evaluation, using the Conditional Mutual Information maximization (*CMI*) criterion (Fleuret, 2004), where we identify some very meaningful words that are strongly related to only one of the five topics e.g. film, coach, music, technolog, econom etc. 

![bbc case study 3](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_3.jpg?raw=true)


![bbc case study 4](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_4.jpg?raw=true)



In combination to the selection of the two main thresholds (discussed previously), the selection of the appropriate algorithms as well as the investigation of several alternatives and options is necessary. Indicatively, in this case the *FKM* and *GMM* approaches produced topics with low coherence evaluations due to the occurrence and inclusion of too many words in the *DTM*. Thus, in this case study we present our experiments using the *Leiden* algorithm for network clustering, using the Inclusion Index, as it helps us extract interpretable results with high coherence evaluations and relatively few topics. The main network of the extracted model, some of the most probable words per topics well as the visualization of the topic divergence and prevalence are presented below.

![bbc case study 5](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_5.jpg?raw=true)


![bbc case study 6](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_6.jpg?raw=true)



![bbc case study 7]

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>LDAvis</title>

<script>
d3 = function() {
  var d3 = {
    version: "3.2.7"
  };
  if (!Date.now) Date.now = function() {
    return +new Date();
  };
  var d3_document = document, d3_documentElement = d3_document.documentElement, d3_window = window;
  try {
    d3_document.createElement("div").style.setProperty("opacity", 0, "");
  } catch (error) {
    var d3_element_prototype = d3_window.Element.prototype, d3_element_setAttribute = d3_element_prototype.setAttribute, d3_element_setAttributeNS = d3_element_prototype.setAttributeNS, d3_style_prototype = d3_window.CSSStyleDeclaration.prototype, d3_style_setProperty = d3_style_prototype.setProperty;
    d3_element_prototype.setAttribute = function(name, value) {
      d3_element_setAttribute.call(this, name, value + "");
    };
    d3_element_prototype.setAttributeNS = function(space, local, value) {
      d3_element_setAttributeNS.call(this, space, local, value + "");
    };
    d3_style_prototype.setProperty = function(name, value, priority) {
      d3_style_setProperty.call(this, name, value + "", priority);
    };
  }
  d3.ascending = function(a, b) {
    return a < b ? -1 : a > b ? 1 : a >= b ? 0 : NaN;
  };
  d3.descending = function(a, b) {
    return b < a ? -1 : b > a ? 1 : b >= a ? 0 : NaN;
  };
  d3.min = function(array, f) {
    var i = -1, n = array.length, a, b;
    if (arguments.length === 1) {
      while (++i < n && !((a = array[i]) != null && a <= a)) a = undefined;
      while (++i < n) if ((b = array[i]) != null && a > b) a = b;
    } else {
      while (++i < n && !((a = f.call(array, array[i], i)) != null && a <= a)) a = undefined;
      while (++i < n) if ((b = f.call(array, array[i], i)) != null && a > b) a = b;
    }
    return a;
  };
  d3.max = function(array, f) {
    var i = -1, n = array.length, a, b;
    if (arguments.length === 1) {
      while (++i < n && !((a = array[i]) != null && a <= a)) a = undefined;
      while (++i < n) if ((b = array[i]) != null && b > a) a = b;
    } else {
      while (++i < n && !((a = f.call(array, array[i], i)) != null && a <= a)) a = undefined;
      while (++i < n) if ((b = f.call(array, array[i], i)) != null && b > a) a = b;
    }
    return a;
  };
  d3.extent = function(array, f) {
    var i = -1, n = array.length, a, b, c;
    if (arguments.length === 1) {
      while (++i < n && !((a = c = array[i]) != null && a <= a)) a = c = undefined;
      while (++i < n) if ((b = array[i]) != null) {
        if (a > b) a = b;
        if (c < b) c = b;
      }
    } else {
      while (++i < n && !((a = c = f.call(array, array[i], i)) != null && a <= a)) a = undefined;
      while (++i < n) if ((b = f.call(array, array[i], i)) != null) {
        if (a > b) a = b;
        if (c < b) c = b;
      }
    }
    return [ a, c ];
  };
  d3.sum = function(array, f) {
    var s = 0, n = array.length, a, i = -1;
    if (arguments.length === 1) {
      while (++i < n) if (!isNaN(a = +array[i])) s += a;
    } else {
      while (++i < n) if (!isNaN(a = +f.call(array, array[i], i))) s += a;
    }
    return s;
  };
  function d3_number(x) {
    return x != null && !isNaN(x);
  }
  d3.mean = function(array, f) {
    var n = array.length, a, m = 0, i = -1, j = 0;
    if (arguments.length === 1) {
      while (++i < n) if (d3_number(a = array[i])) m += (a - m) / ++j;
    } else {
      while (++i < n) if (d3_number(a = f.call(array, array[i], i))) m += (a - m) / ++j;
    }
    return j ? m : undefined;
  };
  d3.quantile = function(values, p) {
    var H = (values.length - 1) * p + 1, h = Math.floor(H), v = +values[h - 1], e = H - h;
    return e ? v + e * (values[h] - v) : v;
  };
  d3.median = function(array, f) {
    if (arguments.length > 1) array = array.map(f);
    array = array.filter(d3_number);
    return array.length ? d3.quantile(array.sort(d3.ascending), .5) : undefined;
  };
  d3.bisector = function(f) {
    return {
      left: function(a, x, lo, hi) {
        if (arguments.length < 3) lo = 0;
        if (arguments.length < 4) hi = a.length;
        while (lo < hi) {
          var mid = lo + hi >>> 1;
          if (f.call(a, a[mid], mid) < x) lo = mid + 1; else hi = mid;
        }
        return lo;
      },
      right: function(a, x, lo, hi) {
        if (arguments.length < 3) lo = 0;
        if (arguments.length < 4) hi = a.length;
        while (lo < hi) {
          var mid = lo + hi >>> 1;
          if (x < f.call(a, a[mid], mid)) hi = mid; else lo = mid + 1;
        }
        return lo;
      }
    };
  };
  var d3_bisector = d3.bisector(function(d) {
    return d;
  });
  d3.bisectLeft = d3_bisector.left;
  d3.bisect = d3.bisectRight = d3_bisector.right;
  d3.shuffle = function(array) {
    var m = array.length, t, i;
    while (m) {
      i = Math.random() * m-- | 0;
      t = array[m], array[m] = array[i], array[i] = t;
    }
    return array;
  };
  d3.permute = function(array, indexes) {
    var permutes = [], i = -1, n = indexes.length;
    while (++i < n) permutes[i] = array[indexes[i]];
    return permutes;
  };
  d3.zip = function() {
    if (!(n = arguments.length)) return [];
    for (var i = -1, m = d3.min(arguments, d3_zipLength), zips = new Array(m); ++i < m; ) {
      for (var j = -1, n, zip = zips[i] = new Array(n); ++j < n; ) {
        zip[j] = arguments[j][i];
      }
    }
    return zips;
  };
  function d3_zipLength(d) {
    return d.length;
  }
  d3.transpose = function(matrix) {
    return d3.zip.apply(d3, matrix);
  };
  d3.keys = function(map) {
    var keys = [];
    for (var key in map) keys.push(key);
    return keys;
  };
  d3.values = function(map) {
    var values = [];
    for (var key in map) values.push(map[key]);
    return values;
  };
  d3.entries = function(map) {
    var entries = [];
    for (var key in map) entries.push({
      key: key,
      value: map[key]
    });
    return entries;
  };
  d3.merge = function(arrays) {
    return Array.prototype.concat.apply([], arrays);
  };
  d3.range = function(start, stop, step) {
    if (arguments.length < 3) {
      step = 1;
      if (arguments.length < 2) {
        stop = start;
        start = 0;
      }
    }
    if ((stop - start) / step === Infinity) throw new Error("infinite range");
    var range = [], k = d3_range_integerScale(Math.abs(step)), i = -1, j;
    start *= k, stop *= k, step *= k;
    if (step < 0) while ((j = start + step * ++i) > stop) range.push(j / k); else while ((j = start + step * ++i) < stop) range.push(j / k);
    return range;
  };
  function d3_range_integerScale(x) {
    var k = 1;
    while (x * k % 1) k *= 10;
    return k;
  }
  function d3_class(ctor, properties) {
    try {
      for (var key in properties) {
        Object.defineProperty(ctor.prototype, key, {
          value: properties[key],
          enumerable: false
        });
      }
    } catch (e) {
      ctor.prototype = properties;
    }
  }
  d3.map = function(object) {
    var map = new d3_Map();
    for (var key in object) map.set(key, object[key]);
    return map;
  };
  function d3_Map() {}
  d3_class(d3_Map, {
    has: function(key) {
      return d3_map_prefix + key in this;
    },
    get: function(key) {
      return this[d3_map_prefix + key];
    },
    set: function(key, value) {
      return this[d3_map_prefix + key] = value;
    },
    remove: function(key) {
      key = d3_map_prefix + key;
      return key in this && delete this[key];
    },
    keys: function() {
      var keys = [];
      this.forEach(function(key) {
        keys.push(key);
      });
      return keys;
    },
    values: function() {
      var values = [];
      this.forEach(function(key, value) {
        values.push(value);
      });
      return values;
    },
    entries: function() {
      var entries = [];
      this.forEach(function(key, value) {
        entries.push({
          key: key,
          value: value
        });
      });
      return entries;
    },
    forEach: function(f) {
      for (var key in this) {
        if (key.charCodeAt(0) === d3_map_prefixCode) {
          f.call(this, key.substring(1), this[key]);
        }
      }
    }
  });
  var d3_map_prefix = "\0", d3_map_prefixCode = d3_map_prefix.charCodeAt(0);
  d3.nest = function() {
    var nest = {}, keys = [], sortKeys = [], sortValues, rollup;
    function map(mapType, array, depth) {
      if (depth >= keys.length) return rollup ? rollup.call(nest, array) : sortValues ? array.sort(sortValues) : array;
      var i = -1, n = array.length, key = keys[depth++], keyValue, object, setter, valuesByKey = new d3_Map(), values;
      while (++i < n) {
        if (values = valuesByKey.get(keyValue = key(object = array[i]))) {
          values.push(object);
        } else {
          valuesByKey.set(keyValue, [ object ]);
        }
      }
      if (mapType) {
        object = mapType();
        setter = function(keyValue, values) {
          object.set(keyValue, map(mapType, values, depth));
        };
      } else {
        object = {};
        setter = function(keyValue, values) {
          object[keyValue] = map(mapType, values, depth);
        };
      }
      valuesByKey.forEach(setter);
      return object;
    }
    function entries(map, depth) {
      if (depth >= keys.length) return map;
      var array = [], sortKey = sortKeys[depth++];
      map.forEach(function(key, keyMap) {
        array.push({
          key: key,
          values: entries(keyMap, depth)
        });
      });
      return sortKey ? array.sort(function(a, b) {
        return sortKey(a.key, b.key);
      }) : array;
    }
    nest.map = function(array, mapType) {
      return map(mapType, array, 0);
    };
    nest.entries = function(array) {
      return entries(map(d3.map, array, 0), 0);
    };
    nest.key = function(d) {
      keys.push(d);
      return nest;
    };
    nest.sortKeys = function(order) {
      sortKeys[keys.length - 1] = order;
      return nest;
    };
    nest.sortValues = function(order) {
      sortValues = order;
      return nest;
    };
    nest.rollup = function(f) {
      rollup = f;
      return nest;
    };
    return nest;
  };
  d3.set = function(array) {
    var set = new d3_Set();
    if (array) for (var i = 0; i < array.length; i++) set.add(array[i]);
    return set;
  };
  function d3_Set() {}
  d3_class(d3_Set, {
    has: function(value) {
      return d3_map_prefix + value in this;
    },
    add: function(value) {
      this[d3_map_prefix + value] = true;
      return value;
    },
    remove: function(value) {
      value = d3_map_prefix + value;
      return value in this && delete this[value];
    },
    values: function() {
      var values = [];
      this.forEach(function(value) {
        values.push(value);
      });
      return values;
    },
    forEach: function(f) {
      for (var value in this) {
        if (value.charCodeAt(0) === d3_map_prefixCode) {
          f.call(this, value.substring(1));
        }
      }
    }
  });
  d3.behavior = {};
  d3.rebind = function(target, source) {
    var i = 1, n = arguments.length, method;
    while (++i < n) target[method = arguments[i]] = d3_rebind(target, source, source[method]);
    return target;
  };
  function d3_rebind(target, source, method) {
    return function() {
      var value = method.apply(source, arguments);
      return value === source ? target : value;
    };
  }
  function d3_vendorSymbol(object, name) {
    if (name in object) return name;
    name = name.charAt(0).toUpperCase() + name.substring(1);
    for (var i = 0, n = d3_vendorPrefixes.length; i < n; ++i) {
      var prefixName = d3_vendorPrefixes[i] + name;
      if (prefixName in object) return prefixName;
    }
  }
  var d3_vendorPrefixes = [ "webkit", "ms", "moz", "Moz", "o", "O" ];
  var d3_array = d3_arraySlice;
  function d3_arrayCopy(pseudoarray) {
    var i = -1, n = pseudoarray.length, array = [];
    while (++i < n) array.push(pseudoarray[i]);
    return array;
  }
  function d3_arraySlice(pseudoarray) {
    return Array.prototype.slice.call(pseudoarray);
  }
  try {
    d3_array(d3_documentElement.childNodes)[0].nodeType;
  } catch (e) {
    d3_array = d3_arrayCopy;
  }
  function d3_noop() {}
  d3.dispatch = function() {
    var dispatch = new d3_dispatch(), i = -1, n = arguments.length;
    while (++i < n) dispatch[arguments[i]] = d3_dispatch_event(dispatch);
    return dispatch;
  };
  function d3_dispatch() {}
  d3_dispatch.prototype.on = function(type, listener) {
    var i = type.indexOf("."), name = "";
    if (i >= 0) {
      name = type.substring(i + 1);
      type = type.substring(0, i);
    }
    if (type) return arguments.length < 2 ? this[type].on(name) : this[type].on(name, listener);
    if (arguments.length === 2) {
      if (listener == null) for (type in this) {
        if (this.hasOwnProperty(type)) this[type].on(name, null);
      }
      return this;
    }
  };
  function d3_dispatch_event(dispatch) {
    var listeners = [], listenerByName = new d3_Map();
    function event() {
      var z = listeners, i = -1, n = z.length, l;
      while (++i < n) if (l = z[i].on) l.apply(this, arguments);
      return dispatch;
    }
    event.on = function(name, listener) {
      var l = listenerByName.get(name), i;
      if (arguments.length < 2) return l && l.on;
      if (l) {
        l.on = null;
        listeners = listeners.slice(0, i = listeners.indexOf(l)).concat(listeners.slice(i + 1));
        listenerByName.remove(name);
      }
      if (listener) listeners.push(listenerByName.set(name, {
        on: listener
      }));
      return dispatch;
    };
    return event;
  }
  d3.event = null;
  function d3_eventPreventDefault() {
    d3.event.preventDefault();
  }
  function d3_eventSource() {
    var e = d3.event, s;
    while (s = e.sourceEvent) e = s;
    return e;
  }
  function d3_eventDispatch(target) {
    var dispatch = new d3_dispatch(), i = 0, n = arguments.length;
    while (++i < n) dispatch[arguments[i]] = d3_dispatch_event(dispatch);
    dispatch.of = function(thiz, argumentz) {
      return function(e1) {
        try {
          var e0 = e1.sourceEvent = d3.event;
          e1.target = target;
          d3.event = e1;
          dispatch[e1.type].apply(thiz, argumentz);
        } finally {
          d3.event = e0;
        }
      };
    };
    return dispatch;
  }
  d3.requote = function(s) {
    return s.replace(d3_requote_re, "\\$&");
  };
  var d3_requote_re = /[\\\^\$\*\+\?\|\[\]\(\)\.\{\}]/g;
  var d3_subclass = {}.__proto__ ? function(object, prototype) {
    object.__proto__ = prototype;
  } : function(object, prototype) {
    for (var property in prototype) object[property] = prototype[property];
  };
  function d3_selection(groups) {
    d3_subclass(groups, d3_selectionPrototype);
    return groups;
  }
  var d3_select = function(s, n) {
    return n.querySelector(s);
  }, d3_selectAll = function(s, n) {
    return n.querySelectorAll(s);
  }, d3_selectMatcher = d3_documentElement[d3_vendorSymbol(d3_documentElement, "matchesSelector")], d3_selectMatches = function(n, s) {
    return d3_selectMatcher.call(n, s);
  };
  if (typeof Sizzle === "function") {
    d3_select = function(s, n) {
      return Sizzle(s, n)[0] || null;
    };
    d3_selectAll = function(s, n) {
      return Sizzle.uniqueSort(Sizzle(s, n));
    };
    d3_selectMatches = Sizzle.matchesSelector;
  }
  d3.selection = function() {
    return d3_selectionRoot;
  };
  var d3_selectionPrototype = d3.selection.prototype = [];
  d3_selectionPrototype.select = function(selector) {
    var subgroups = [], subgroup, subnode, group, node;
    selector = d3_selection_selector(selector);
    for (var j = -1, m = this.length; ++j < m; ) {
      subgroups.push(subgroup = []);
      subgroup.parentNode = (group = this[j]).parentNode;
      for (var i = -1, n = group.length; ++i < n; ) {
        if (node = group[i]) {
          subgroup.push(subnode = selector.call(node, node.__data__, i, j));
          if (subnode && "__data__" in node) subnode.__data__ = node.__data__;
        } else {
          subgroup.push(null);
        }
      }
    }
    return d3_selection(subgroups);
  };
  function d3_selection_selector(selector) {
    return typeof selector === "function" ? selector : function() {
      return d3_select(selector, this);
    };
  }
  d3_selectionPrototype.selectAll = function(selector) {
    var subgroups = [], subgroup, node;
    selector = d3_selection_selectorAll(selector);
    for (var j = -1, m = this.length; ++j < m; ) {
      for (var group = this[j], i = -1, n = group.length; ++i < n; ) {
        if (node = group[i]) {
          subgroups.push(subgroup = d3_array(selector.call(node, node.__data__, i, j)));
          subgroup.parentNode = node;
        }
      }
    }
    return d3_selection(subgroups);
  };
  function d3_selection_selectorAll(selector) {
    return typeof selector === "function" ? selector : function() {
      return d3_selectAll(selector, this);
    };
  }
  var d3_nsPrefix = {
    svg: "http://www.w3.org/2000/svg",
    xhtml: "http://www.w3.org/1999/xhtml",
    xlink: "http://www.w3.org/1999/xlink",
    xml: "http://www.w3.org/XML/1998/namespace",
    xmlns: "http://www.w3.org/2000/xmlns/"
  };
  d3.ns = {
    prefix: d3_nsPrefix,
    qualify: function(name) {
      var i = name.indexOf(":"), prefix = name;
      if (i >= 0) {
        prefix = name.substring(0, i);
        name = name.substring(i + 1);
      }
      return d3_nsPrefix.hasOwnProperty(prefix) ? {
        space: d3_nsPrefix[prefix],
        local: name
      } : name;
    }
  };
  d3_selectionPrototype.attr = function(name, value) {
    if (arguments.length < 2) {
      if (typeof name === "string") {
        var node = this.node();
        name = d3.ns.qualify(name);
        return name.local ? node.getAttributeNS(name.space, name.local) : node.getAttribute(name);
      }
      for (value in name) this.each(d3_selection_attr(value, name[value]));
      return this;
    }
    return this.each(d3_selection_attr(name, value));
  };
  function d3_selection_attr(name, value) {
    name = d3.ns.qualify(name);
    function attrNull() {
      this.removeAttribute(name);
    }
    function attrNullNS() {
      this.removeAttributeNS(name.space, name.local);
    }
    function attrConstant() {
      this.setAttribute(name, value);
    }
    function attrConstantNS() {
      this.setAttributeNS(name.space, name.local, value);
    }
    function attrFunction() {
      var x = value.apply(this, arguments);
      if (x == null) this.removeAttribute(name); else this.setAttribute(name, x);
    }
    function attrFunctionNS() {
      var x = value.apply(this, arguments);
      if (x == null) this.removeAttributeNS(name.space, name.local); else this.setAttributeNS(name.space, name.local, x);
    }
    return value == null ? name.local ? attrNullNS : attrNull : typeof value === "function" ? name.local ? attrFunctionNS : attrFunction : name.local ? attrConstantNS : attrConstant;
  }
  function d3_collapse(s) {
    return s.trim().replace(/\s+/g, " ");
  }
  d3_selectionPrototype.classed = function(name, value) {
    if (arguments.length < 2) {
      if (typeof name === "string") {
        var node = this.node(), n = (name = name.trim().split(/^|\s+/g)).length, i = -1;
        if (value = node.classList) {
          while (++i < n) if (!value.contains(name[i])) return false;
        } else {
          value = node.getAttribute("class");
          while (++i < n) if (!d3_selection_classedRe(name[i]).test(value)) return false;
        }
        return true;
      }
      for (value in name) this.each(d3_selection_classed(value, name[value]));
      return this;
    }
    return this.each(d3_selection_classed(name, value));
  };
  function d3_selection_classedRe(name) {
    return new RegExp("(?:^|\\s+)" + d3.requote(name) + "(?:\\s+|$)", "g");
  }
  function d3_selection_classed(name, value) {
    name = name.trim().split(/\s+/).map(d3_selection_classedName);
    var n = name.length;
    function classedConstant() {
      var i = -1;
      while (++i < n) name[i](this, value);
    }
    function classedFunction() {
      var i = -1, x = value.apply(this, arguments);
      while (++i < n) name[i](this, x);
    }
    return typeof value === "function" ? classedFunction : classedConstant;
  }
  function d3_selection_classedName(name) {
    var re = d3_selection_classedRe(name);
    return function(node, value) {
      if (c = node.classList) return value ? c.add(name) : c.remove(name);
      var c = node.getAttribute("class") || "";
      if (value) {
        re.lastIndex = 0;
        if (!re.test(c)) node.setAttribute("class", d3_collapse(c + " " + name));
      } else {
        node.setAttribute("class", d3_collapse(c.replace(re, " ")));
      }
    };
  }
  d3_selectionPrototype.style = function(name, value, priority) {
    var n = arguments.length;
    if (n < 3) {
      if (typeof name !== "string") {
        if (n < 2) value = "";
        for (priority in name) this.each(d3_selection_style(priority, name[priority], value));
        return this;
      }
      if (n < 2) return d3_window.getComputedStyle(this.node(), null).getPropertyValue(name);
      priority = "";
    }
    return this.each(d3_selection_style(name, value, priority));
  };
  function d3_selection_style(name, value, priority) {
    function styleNull() {
      this.style.removeProperty(name);
    }
    function styleConstant() {
      this.style.setProperty(name, value, priority);
    }
    function styleFunction() {
      var x = value.apply(this, arguments);
      if (x == null) this.style.removeProperty(name); else this.style.setProperty(name, x, priority);
    }
    return value == null ? styleNull : typeof value === "function" ? styleFunction : styleConstant;
  }
  d3_selectionPrototype.property = function(name, value) {
    if (arguments.length < 2) {
      if (typeof name === "string") return this.node()[name];
      for (value in name) this.each(d3_selection_property(value, name[value]));
      return this;
    }
    return this.each(d3_selection_property(name, value));
  };
  function d3_selection_property(name, value) {
    function propertyNull() {
      delete this[name];
    }
    function propertyConstant() {
      this[name] = value;
    }
    function propertyFunction() {
      var x = value.apply(this, arguments);
      if (x == null) delete this[name]; else this[name] = x;
    }
    return value == null ? propertyNull : typeof value === "function" ? propertyFunction : propertyConstant;
  }
  d3_selectionPrototype.text = function(value) {
    return arguments.length ? this.each(typeof value === "function" ? function() {
      var v = value.apply(this, arguments);
      this.textContent = v == null ? "" : v;
    } : value == null ? function() {
      this.textContent = "";
    } : function() {
      this.textContent = value;
    }) : this.node().textContent;
  };
  d3_selectionPrototype.html = function(value) {
    return arguments.length ? this.each(typeof value === "function" ? function() {
      var v = value.apply(this, arguments);
      this.innerHTML = v == null ? "" : v;
    } : value == null ? function() {
      this.innerHTML = "";
    } : function() {
      this.innerHTML = value;
    }) : this.node().innerHTML;
  };
  d3_selectionPrototype.append = function(name) {
    name = d3_selection_creator(name);
    return this.select(function() {
      return this.appendChild(name.apply(this, arguments));
    });
  };
  function d3_selection_creator(name) {
    return typeof name === "function" ? name : (name = d3.ns.qualify(name)).local ? function() {
      return d3_document.createElementNS(name.space, name.local);
    } : function() {
      return d3_document.createElementNS(this.namespaceURI, name);
    };
  }
  d3_selectionPrototype.insert = function(name, before) {
    name = d3_selection_creator(name);
    before = d3_selection_selector(before);
    return this.select(function() {
      return this.insertBefore(name.apply(this, arguments), before.apply(this, arguments));
    });
  };
  d3_selectionPrototype.remove = function() {
    return this.each(function() {
      var parent = this.parentNode;
      if (parent) parent.removeChild(this);
    });
  };
  d3_selectionPrototype.data = function(value, key) {
    var i = -1, n = this.length, group, node;
    if (!arguments.length) {
      value = new Array(n = (group = this[0]).length);
      while (++i < n) {
        if (node = group[i]) {
          value[i] = node.__data__;
        }
      }
      return value;
    }
    function bind(group, groupData) {
      var i, n = group.length, m = groupData.length, n0 = Math.min(n, m), updateNodes = new Array(m), enterNodes = new Array(m), exitNodes = new Array(n), node, nodeData;
      if (key) {
        var nodeByKeyValue = new d3_Map(), dataByKeyValue = new d3_Map(), keyValues = [], keyValue;
        for (i = -1; ++i < n; ) {
          keyValue = key.call(node = group[i], node.__data__, i);
          if (nodeByKeyValue.has(keyValue)) {
            exitNodes[i] = node;
          } else {
            nodeByKeyValue.set(keyValue, node);
          }
          keyValues.push(keyValue);
        }
        for (i = -1; ++i < m; ) {
          keyValue = key.call(groupData, nodeData = groupData[i], i);
          if (node = nodeByKeyValue.get(keyValue)) {
            updateNodes[i] = node;
            node.__data__ = nodeData;
          } else if (!dataByKeyValue.has(keyValue)) {
            enterNodes[i] = d3_selection_dataNode(nodeData);
          }
          dataByKeyValue.set(keyValue, nodeData);
          nodeByKeyValue.remove(keyValue);
        }
        for (i = -1; ++i < n; ) {
          if (nodeByKeyValue.has(keyValues[i])) {
            exitNodes[i] = group[i];
          }
        }
      } else {
        for (i = -1; ++i < n0; ) {
          node = group[i];
          nodeData = groupData[i];
          if (node) {
            node.__data__ = nodeData;
            updateNodes[i] = node;
          } else {
            enterNodes[i] = d3_selection_dataNode(nodeData);
          }
        }
        for (;i < m; ++i) {
          enterNodes[i] = d3_selection_dataNode(groupData[i]);
        }
        for (;i < n; ++i) {
          exitNodes[i] = group[i];
        }
      }
      enterNodes.update = updateNodes;
      enterNodes.parentNode = updateNodes.parentNode = exitNodes.parentNode = group.parentNode;
      enter.push(enterNodes);
      update.push(updateNodes);
      exit.push(exitNodes);
    }
    var enter = d3_selection_enter([]), update = d3_selection([]), exit = d3_selection([]);
    if (typeof value === "function") {
      while (++i < n) {
        bind(group = this[i], value.call(group, group.parentNode.__data__, i));
      }
    } else {
      while (++i < n) {
        bind(group = this[i], value);
      }
    }
    update.enter = function() {
      return enter;
    };
    update.exit = function() {
      return exit;
    };
    return update;
  };
  function d3_selection_dataNode(data) {
    return {
      __data__: data
    };
  }
  d3_selectionPrototype.datum = function(value) {
    return arguments.length ? this.property("__data__", value) : this.property("__data__");
  };
  d3_selectionPrototype.filter = function(filter) {
    var subgroups = [], subgroup, group, node;
    if (typeof filter !== "function") filter = d3_selection_filter(filter);
    for (var j = 0, m = this.length; j < m; j++) {
      subgroups.push(subgroup = []);
      subgroup.parentNode = (group = this[j]).parentNode;
      for (var i = 0, n = group.length; i < n; i++) {
        if ((node = group[i]) && filter.call(node, node.__data__, i)) {
          subgroup.push(node);
        }
      }
    }
    return d3_selection(subgroups);
  };
  function d3_selection_filter(selector) {
    return function() {
      return d3_selectMatches(this, selector);
    };
  }
  d3_selectionPrototype.order = function() {
    for (var j = -1, m = this.length; ++j < m; ) {
      for (var group = this[j], i = group.length - 1, next = group[i], node; --i >= 0; ) {
        if (node = group[i]) {
          if (next && next !== node.nextSibling) next.parentNode.insertBefore(node, next);
          next = node;
        }
      }
    }
    return this;
  };
  d3_selectionPrototype.sort = function(comparator) {
    comparator = d3_selection_sortComparator.apply(this, arguments);
    for (var j = -1, m = this.length; ++j < m; ) this[j].sort(comparator);
    return this.order();
  };
  function d3_selection_sortComparator(comparator) {
    if (!arguments.length) comparator = d3.ascending;
    return function(a, b) {
      return !a - !b || comparator(a.__data__, b.__data__);
    };
  }
  d3_selectionPrototype.each = function(callback) {
    return d3_selection_each(this, function(node, i, j) {
      callback.call(node, node.__data__, i, j);
    });
  };
  function d3_selection_each(groups, callback) {
    for (var j = 0, m = groups.length; j < m; j++) {
      for (var group = groups[j], i = 0, n = group.length, node; i < n; i++) {
        if (node = group[i]) callback(node, i, j);
      }
    }
    return groups;
  }
  d3_selectionPrototype.call = function(callback) {
    var args = d3_array(arguments);
    callback.apply(args[0] = this, args);
    return this;
  };
  d3_selectionPrototype.empty = function() {
    return !this.node();
  };
  d3_selectionPrototype.node = function() {
    for (var j = 0, m = this.length; j < m; j++) {
      for (var group = this[j], i = 0, n = group.length; i < n; i++) {
        var node = group[i];
        if (node) return node;
      }
    }
    return null;
  };
  d3_selectionPrototype.size = function() {
    var n = 0;
    this.each(function() {
      ++n;
    });
    return n;
  };
  function d3_selection_enter(selection) {
    d3_subclass(selection, d3_selection_enterPrototype);
    return selection;
  }
  var d3_selection_enterPrototype = [];
  d3.selection.enter = d3_selection_enter;
  d3.selection.enter.prototype = d3_selection_enterPrototype;
  d3_selection_enterPrototype.append = d3_selectionPrototype.append;
  d3_selection_enterPrototype.empty = d3_selectionPrototype.empty;
  d3_selection_enterPrototype.node = d3_selectionPrototype.node;
  d3_selection_enterPrototype.call = d3_selectionPrototype.call;
  d3_selection_enterPrototype.size = d3_selectionPrototype.size;
  d3_selection_enterPrototype.select = function(selector) {
    var subgroups = [], subgroup, subnode, upgroup, group, node;
    for (var j = -1, m = this.length; ++j < m; ) {
      upgroup = (group = this[j]).update;
      subgroups.push(subgroup = []);
      subgroup.parentNode = group.parentNode;
      for (var i = -1, n = group.length; ++i < n; ) {
        if (node = group[i]) {
          subgroup.push(upgroup[i] = subnode = selector.call(group.parentNode, node.__data__, i, j));
          subnode.__data__ = node.__data__;
        } else {
          subgroup.push(null);
        }
      }
    }
    return d3_selection(subgroups);
  };
  d3_selection_enterPrototype.insert = function(name, before) {
    if (arguments.length < 2) before = d3_selection_enterInsertBefore(this);
    return d3_selectionPrototype.insert.call(this, name, before);
  };
  function d3_selection_enterInsertBefore(enter) {
    var i0, j0;
    return function(d, i, j) {
      var group = enter[j].update, n = group.length, node;
      if (j != j0) j0 = j, i0 = 0;
      if (i >= i0) i0 = i + 1;
      while (!(node = group[i0]) && ++i0 < n) ;
      return node;
    };
  }
  d3_selectionPrototype.transition = function() {
    var id = d3_transitionInheritId || ++d3_transitionId, subgroups = [], subgroup, node, transition = d3_transitionInherit || {
      time: Date.now(),
      ease: d3_ease_cubicInOut,
      delay: 0,
      duration: 250
    };
    for (var j = -1, m = this.length; ++j < m; ) {
      subgroups.push(subgroup = []);
      for (var group = this[j], i = -1, n = group.length; ++i < n; ) {
        if (node = group[i]) d3_transitionNode(node, i, id, transition);
        subgroup.push(node);
      }
    }
    return d3_transition(subgroups, id);
  };
  d3.select = function(node) {
    var group = [ typeof node === "string" ? d3_select(node, d3_document) : node ];
    group.parentNode = d3_documentElement;
    return d3_selection([ group ]);
  };
  d3.selectAll = function(nodes) {
    var group = d3_array(typeof nodes === "string" ? d3_selectAll(nodes, d3_document) : nodes);
    group.parentNode = d3_documentElement;
    return d3_selection([ group ]);
  };
  var d3_selectionRoot = d3.select(d3_documentElement);
  d3_selectionPrototype.on = function(type, listener, capture) {
    var n = arguments.length;
    if (n < 3) {
      if (typeof type !== "string") {
        if (n < 2) listener = false;
        for (capture in type) this.each(d3_selection_on(capture, type[capture], listener));
        return this;
      }
      if (n < 2) return (n = this.node()["__on" + type]) && n._;
      capture = false;
    }
    return this.each(d3_selection_on(type, listener, capture));
  };
  function d3_selection_on(type, listener, capture) {
    var name = "__on" + type, i = type.indexOf("."), wrap = d3_selection_onListener;
    if (i > 0) type = type.substring(0, i);
    var filter = d3_selection_onFilters.get(type);
    if (filter) type = filter, wrap = d3_selection_onFilter;
    function onRemove() {
      var l = this[name];
      if (l) {
        this.removeEventListener(type, l, l.$);
        delete this[name];
      }
    }
    function onAdd() {
      var l = wrap(listener, d3_array(arguments));
      onRemove.call(this);
      this.addEventListener(type, this[name] = l, l.$ = capture);
      l._ = listener;
    }
    function removeAll() {
      var re = new RegExp("^__on([^.]+)" + d3.requote(type) + "$"), match;
      for (var name in this) {
        if (match = name.match(re)) {
          var l = this[name];
          this.removeEventListener(match[1], l, l.$);
          delete this[name];
        }
      }
    }
    return i ? listener ? onAdd : onRemove : listener ? d3_noop : removeAll;
  }
  var d3_selection_onFilters = d3.map({
    mouseenter: "mouseover",
    mouseleave: "mouseout"
  });
  d3_selection_onFilters.forEach(function(k) {
    if ("on" + k in d3_document) d3_selection_onFilters.remove(k);
  });
  function d3_selection_onListener(listener, argumentz) {
    return function(e) {
      var o = d3.event;
      d3.event = e;
      argumentz[0] = this.__data__;
      try {
        listener.apply(this, argumentz);
      } finally {
        d3.event = o;
      }
    };
  }
  function d3_selection_onFilter(listener, argumentz) {
    var l = d3_selection_onListener(listener, argumentz);
    return function(e) {
      var target = this, related = e.relatedTarget;
      if (!related || related !== target && !(related.compareDocumentPosition(target) & 8)) {
        l.call(target, e);
      }
    };
  }
  var d3_event_dragSelect = d3_vendorSymbol(d3_documentElement.style, "userSelect"), d3_event_dragId = 0;
  function d3_event_dragSuppress() {
    var name = ".dragsuppress-" + ++d3_event_dragId, touchmove = "touchmove" + name, selectstart = "selectstart" + name, dragstart = "dragstart" + name, click = "click" + name, w = d3.select(d3_window).on(touchmove, d3_eventPreventDefault).on(selectstart, d3_eventPreventDefault).on(dragstart, d3_eventPreventDefault), style = d3_documentElement.style, select = style[d3_event_dragSelect];
    style[d3_event_dragSelect] = "none";
    return function(suppressClick) {
      w.on(name, null);
      style[d3_event_dragSelect] = select;
      if (suppressClick) {
        function off() {
          w.on(click, null);
        }
        w.on(click, function() {
          d3_eventPreventDefault();
          off();
        }, true);
        setTimeout(off, 0);
      }
    };
  }
  d3.mouse = function(container) {
    return d3_mousePoint(container, d3_eventSource());
  };
  var d3_mouse_bug44083 = /WebKit/.test(d3_window.navigator.userAgent) ? -1 : 0;
  function d3_mousePoint(container, e) {
    var svg = container.ownerSVGElement || container;
    if (svg.createSVGPoint) {
      var point = svg.createSVGPoint();
      if (d3_mouse_bug44083 < 0 && (d3_window.scrollX || d3_window.scrollY)) {
        svg = d3.select("body").append("svg").style({
          position: "absolute",
          top: 0,
          left: 0,
          margin: 0,
          padding: 0,
          border: "none"
        }, "important");
        var ctm = svg[0][0].getScreenCTM();
        d3_mouse_bug44083 = !(ctm.f || ctm.e);
        svg.remove();
      }
      if (d3_mouse_bug44083) {
        point.x = e.pageX;
        point.y = e.pageY;
      } else {
        point.x = e.clientX;
        point.y = e.clientY;
      }
      point = point.matrixTransform(container.getScreenCTM().inverse());
      return [ point.x, point.y ];
    }
    var rect = container.getBoundingClientRect();
    return [ e.clientX - rect.left - container.clientLeft, e.clientY - rect.top - container.clientTop ];
  }
  d3.touches = function(container, touches) {
    if (arguments.length < 2) touches = d3_eventSource().touches;
    return touches ? d3_array(touches).map(function(touch) {
      var point = d3_mousePoint(container, touch);
      point.identifier = touch.identifier;
      return point;
    }) : [];
  };
  d3.behavior.drag = function() {
    var event = d3_eventDispatch(drag, "drag", "dragstart", "dragend"), origin = null, mousedown = dragstart(d3_noop, d3.mouse, "mousemove", "mouseup"), touchstart = dragstart(touchid, touchposition, "touchmove", "touchend");
    function drag() {
      this.on("mousedown.drag", mousedown).on("touchstart.drag", touchstart);
    }
    function touchid() {
      return d3.event.changedTouches[0].identifier;
    }
    function touchposition(parent, id) {
      return d3.touches(parent).filter(function(p) {
        return p.identifier === id;
      })[0];
    }
    function dragstart(id, position, move, end) {
      return function() {
        var target = this, parent = target.parentNode, event_ = event.of(target, arguments), eventTarget = d3.event.target, eventId = id(), drag = eventId == null ? "drag" : "drag-" + eventId, origin_ = position(parent, eventId), dragged = 0, offset, w = d3.select(d3_window).on(move + "." + drag, moved).on(end + "." + drag, ended), dragRestore = d3_event_dragSuppress();
        if (origin) {
          offset = origin.apply(target, arguments);
          offset = [ offset.x - origin_[0], offset.y - origin_[1] ];
        } else {
          offset = [ 0, 0 ];
        }
        event_({
          type: "dragstart"
        });
        function moved() {
          if (!parent) return ended();
          var p = position(parent, eventId), dx = p[0] - origin_[0], dy = p[1] - origin_[1];
          dragged |= dx | dy;
          origin_ = p;
          event_({
            type: "drag",
            x: p[0] + offset[0],
            y: p[1] + offset[1],
            dx: dx,
            dy: dy
          });
        }
        function ended() {
          w.on(move + "." + drag, null).on(end + "." + drag, null);
          dragRestore(dragged && d3.event.target === eventTarget);
          event_({
            type: "dragend"
          });
        }
      };
    }
    drag.origin = function(x) {
      if (!arguments.length) return origin;
      origin = x;
      return drag;
    };
    return d3.rebind(drag, event, "on");
  };
  d3.behavior.zoom = function() {
    var translate = [ 0, 0 ], translate0, scale = 1, scaleExtent = d3_behavior_zoomInfinity, mousedown = "mousedown.zoom", mousemove = "mousemove.zoom", mouseup = "mouseup.zoom", event = d3_eventDispatch(zoom, "zoom"), x0, x1, y0, y1, touchtime;
    function zoom() {
      this.on(mousedown, mousedowned).on(d3_behavior_zoomWheel + ".zoom", mousewheeled).on(mousemove, mousewheelreset).on("dblclick.zoom", dblclicked).on("touchstart.zoom", touchstarted);
    }
    zoom.translate = function(x) {
      if (!arguments.length) return translate;
      translate = x.map(Number);
      rescale();
      return zoom;
    };
    zoom.scale = function(x) {
      if (!arguments.length) return scale;
      scale = +x;
      rescale();
      return zoom;
    };
    zoom.scaleExtent = function(x) {
      if (!arguments.length) return scaleExtent;
      scaleExtent = x == null ? d3_behavior_zoomInfinity : x.map(Number);
      return zoom;
    };
    zoom.x = function(z) {
      if (!arguments.length) return x1;
      x1 = z;
      x0 = z.copy();
      translate = [ 0, 0 ];
      scale = 1;
      return zoom;
    };
    zoom.y = function(z) {
      if (!arguments.length) return y1;
      y1 = z;
      y0 = z.copy();
      translate = [ 0, 0 ];
      scale = 1;
      return zoom;
    };
    function location(p) {
      return [ (p[0] - translate[0]) / scale, (p[1] - translate[1]) / scale ];
    }
    function point(l) {
      return [ l[0] * scale + translate[0], l[1] * scale + translate[1] ];
    }
    function scaleTo(s) {
      scale = Math.max(scaleExtent[0], Math.min(scaleExtent[1], s));
    }
    function translateTo(p, l) {
      l = point(l);
      translate[0] += p[0] - l[0];
      translate[1] += p[1] - l[1];
    }
    function rescale() {
      if (x1) x1.domain(x0.range().map(function(x) {
        return (x - translate[0]) / scale;
      }).map(x0.invert));
      if (y1) y1.domain(y0.range().map(function(y) {
        return (y - translate[1]) / scale;
      }).map(y0.invert));
    }
    function dispatch(event) {
      rescale();
      event({
        type: "zoom",
        scale: scale,
        translate: translate
      });
    }
    function mousedowned() {
      var target = this, event_ = event.of(target, arguments), eventTarget = d3.event.target, dragged = 0, w = d3.select(d3_window).on(mousemove, moved).on(mouseup, ended), l = location(d3.mouse(target)), dragRestore = d3_event_dragSuppress();
      function moved() {
        dragged = 1;
        translateTo(d3.mouse(target), l);
        dispatch(event_);
      }
      function ended() {
        w.on(mousemove, d3_window === target ? mousewheelreset : null).on(mouseup, null);
        dragRestore(dragged && d3.event.target === eventTarget);
      }
    }
    function touchstarted() {
      var target = this, event_ = event.of(target, arguments), touches = d3.touches(target), locations = {}, distance0 = 0, scale0 = scale, now = Date.now(), name = "zoom-" + d3.event.changedTouches[0].identifier, touchmove = "touchmove." + name, touchend = "touchend." + name, w = d3.select(d3_window).on(touchmove, moved).on(touchend, ended), t = d3.select(target).on(mousedown, null), dragRestore = d3_event_dragSuppress();
      touches.forEach(function(t) {
        locations[t.identifier] = location(t);
      });
      if (touches.length === 1) {
        if (now - touchtime < 500) {
          var p = touches[0], l = location(touches[0]);
          scaleTo(scale * 2);
          translateTo(p, l);
          d3_eventPreventDefault();
          dispatch(event_);
        }
        touchtime = now;
      } else if (touches.length > 1) {
        var p = touches[0], q = touches[1], dx = p[0] - q[0], dy = p[1] - q[1];
        distance0 = dx * dx + dy * dy;
      }
      function moved() {
        var touches = d3.touches(target), p0 = touches[0], l0 = locations[p0.identifier];
        if (p1 = touches[1]) {
          var p1, l1 = locations[p1.identifier], scale1 = d3.event.scale;
          if (scale1 == null) {
            var distance1 = (distance1 = p1[0] - p0[0]) * distance1 + (distance1 = p1[1] - p0[1]) * distance1;
            scale1 = distance0 && Math.sqrt(distance1 / distance0);
          }
          p0 = [ (p0[0] + p1[0]) / 2, (p0[1] + p1[1]) / 2 ];
          l0 = [ (l0[0] + l1[0]) / 2, (l0[1] + l1[1]) / 2 ];
          scaleTo(scale1 * scale0);
        }
        touchtime = null;
        translateTo(p0, l0);
        dispatch(event_);
      }
      function ended() {
        w.on(touchmove, null).on(touchend, null);
        t.on(mousedown, mousedowned);
        dragRestore();
      }
    }
    function mousewheeled() {
      d3_eventPreventDefault();
      if (!translate0) translate0 = location(d3.mouse(this));
      scaleTo(Math.pow(2, d3_behavior_zoomDelta() * .002) * scale);
      translateTo(d3.mouse(this), translate0);
      dispatch(event.of(this, arguments));
    }
    function mousewheelreset() {
      translate0 = null;
    }
    function dblclicked() {
      var p = d3.mouse(this), l = location(p), k = Math.log(scale) / Math.LN2;
      scaleTo(Math.pow(2, d3.event.shiftKey ? Math.ceil(k) - 1 : Math.floor(k) + 1));
      translateTo(p, l);
      dispatch(event.of(this, arguments));
    }
    return d3.rebind(zoom, event, "on");
  };
  var d3_behavior_zoomInfinity = [ 0, Infinity ];
  var d3_behavior_zoomDelta, d3_behavior_zoomWheel = "onwheel" in d3_document ? (d3_behavior_zoomDelta = function() {
    return -d3.event.deltaY * (d3.event.deltaMode ? 120 : 1);
  }, "wheel") : "onmousewheel" in d3_document ? (d3_behavior_zoomDelta = function() {
    return d3.event.wheelDelta;
  }, "mousewheel") : (d3_behavior_zoomDelta = function() {
    return -d3.event.detail;
  }, "MozMousePixelScroll");
  function d3_Color() {}
  d3_Color.prototype.toString = function() {
    return this.rgb() + "";
  };
  d3.hsl = function(h, s, l) {
    return arguments.length === 1 ? h instanceof d3_Hsl ? d3_hsl(h.h, h.s, h.l) : d3_rgb_parse("" + h, d3_rgb_hsl, d3_hsl) : d3_hsl(+h, +s, +l);
  };
  function d3_hsl(h, s, l) {
    return new d3_Hsl(h, s, l);
  }
  function d3_Hsl(h, s, l) {
    this.h = h;
    this.s = s;
    this.l = l;
  }
  var d3_hslPrototype = d3_Hsl.prototype = new d3_Color();
  d3_hslPrototype.brighter = function(k) {
    k = Math.pow(.7, arguments.length ? k : 1);
    return d3_hsl(this.h, this.s, this.l / k);
  };
  d3_hslPrototype.darker = function(k) {
    k = Math.pow(.7, arguments.length ? k : 1);
    return d3_hsl(this.h, this.s, k * this.l);
  };
  d3_hslPrototype.rgb = function() {
    return d3_hsl_rgb(this.h, this.s, this.l);
  };
  function d3_hsl_rgb(h, s, l) {
    var m1, m2;
    h = isNaN(h) ? 0 : (h %= 360) < 0 ? h + 360 : h;
    s = isNaN(s) ? 0 : s < 0 ? 0 : s > 1 ? 1 : s;
    l = l < 0 ? 0 : l > 1 ? 1 : l;
    m2 = l <= .5 ? l * (1 + s) : l + s - l * s;
    m1 = 2 * l - m2;
    function v(h) {
      if (h > 360) h -= 360; else if (h < 0) h += 360;
      if (h < 60) return m1 + (m2 - m1) * h / 60;
      if (h < 180) return m2;
      if (h < 240) return m1 + (m2 - m1) * (240 - h) / 60;
      return m1;
    }
    function vv(h) {
      return Math.round(v(h) * 255);
    }
    return d3_rgb(vv(h + 120), vv(h), vv(h - 120));
  }
  var π = Math.PI, ε = 1e-6, ε2 = ε * ε, d3_radians = π / 180, d3_degrees = 180 / π;
  function d3_sgn(x) {
    return x > 0 ? 1 : x < 0 ? -1 : 0;
  }
  function d3_acos(x) {
    return x > 1 ? 0 : x < -1 ? π : Math.acos(x);
  }
  function d3_asin(x) {
    return x > 1 ? π / 2 : x < -1 ? -π / 2 : Math.asin(x);
  }
  function d3_sinh(x) {
    return (Math.exp(x) - Math.exp(-x)) / 2;
  }
  function d3_cosh(x) {
    return (Math.exp(x) + Math.exp(-x)) / 2;
  }
  function d3_haversin(x) {
    return (x = Math.sin(x / 2)) * x;
  }
  d3.hcl = function(h, c, l) {
    return arguments.length === 1 ? h instanceof d3_Hcl ? d3_hcl(h.h, h.c, h.l) : h instanceof d3_Lab ? d3_lab_hcl(h.l, h.a, h.b) : d3_lab_hcl((h = d3_rgb_lab((h = d3.rgb(h)).r, h.g, h.b)).l, h.a, h.b) : d3_hcl(+h, +c, +l);
  };
  function d3_hcl(h, c, l) {
    return new d3_Hcl(h, c, l);
  }
  function d3_Hcl(h, c, l) {
    this.h = h;
    this.c = c;
    this.l = l;
  }
  var d3_hclPrototype = d3_Hcl.prototype = new d3_Color();
  d3_hclPrototype.brighter = function(k) {
    return d3_hcl(this.h, this.c, Math.min(100, this.l + d3_lab_K * (arguments.length ? k : 1)));
  };
  d3_hclPrototype.darker = function(k) {
    return d3_hcl(this.h, this.c, Math.max(0, this.l - d3_lab_K * (arguments.length ? k : 1)));
  };
  d3_hclPrototype.rgb = function() {
    return d3_hcl_lab(this.h, this.c, this.l).rgb();
  };
  function d3_hcl_lab(h, c, l) {
    if (isNaN(h)) h = 0;
    if (isNaN(c)) c = 0;
    return d3_lab(l, Math.cos(h *= d3_radians) * c, Math.sin(h) * c);
  }
  d3.lab = function(l, a, b) {
    return arguments.length === 1 ? l instanceof d3_Lab ? d3_lab(l.l, l.a, l.b) : l instanceof d3_Hcl ? d3_hcl_lab(l.l, l.c, l.h) : d3_rgb_lab((l = d3.rgb(l)).r, l.g, l.b) : d3_lab(+l, +a, +b);
  };
  function d3_lab(l, a, b) {
    return new d3_Lab(l, a, b);
  }
  function d3_Lab(l, a, b) {
    this.l = l;
    this.a = a;
    this.b = b;
  }
  var d3_lab_K = 18;
  var d3_lab_X = .95047, d3_lab_Y = 1, d3_lab_Z = 1.08883;
  var d3_labPrototype = d3_Lab.prototype = new d3_Color();
  d3_labPrototype.brighter = function(k) {
    return d3_lab(Math.min(100, this.l + d3_lab_K * (arguments.length ? k : 1)), this.a, this.b);
  };
  d3_labPrototype.darker = function(k) {
    return d3_lab(Math.max(0, this.l - d3_lab_K * (arguments.length ? k : 1)), this.a, this.b);
  };
  d3_labPrototype.rgb = function() {
    return d3_lab_rgb(this.l, this.a, this.b);
  };
  function d3_lab_rgb(l, a, b) {
    var y = (l + 16) / 116, x = y + a / 500, z = y - b / 200;
    x = d3_lab_xyz(x) * d3_lab_X;
    y = d3_lab_xyz(y) * d3_lab_Y;
    z = d3_lab_xyz(z) * d3_lab_Z;
    return d3_rgb(d3_xyz_rgb(3.2404542 * x - 1.5371385 * y - .4985314 * z), d3_xyz_rgb(-.969266 * x + 1.8760108 * y + .041556 * z), d3_xyz_rgb(.0556434 * x - .2040259 * y + 1.0572252 * z));
  }
  function d3_lab_hcl(l, a, b) {
    return l > 0 ? d3_hcl(Math.atan2(b, a) * d3_degrees, Math.sqrt(a * a + b * b), l) : d3_hcl(NaN, NaN, l);
  }
  function d3_lab_xyz(x) {
    return x > .206893034 ? x * x * x : (x - 4 / 29) / 7.787037;
  }
  function d3_xyz_lab(x) {
    return x > .008856 ? Math.pow(x, 1 / 3) : 7.787037 * x + 4 / 29;
  }
  function d3_xyz_rgb(r) {
    return Math.round(255 * (r <= .00304 ? 12.92 * r : 1.055 * Math.pow(r, 1 / 2.4) - .055));
  }
  d3.rgb = function(r, g, b) {
    return arguments.length === 1 ? r instanceof d3_Rgb ? d3_rgb(r.r, r.g, r.b) : d3_rgb_parse("" + r, d3_rgb, d3_hsl_rgb) : d3_rgb(~~r, ~~g, ~~b);
  };
  function d3_rgbNumber(value) {
    return d3_rgb(value >> 16, value >> 8 & 255, value & 255);
  }
  function d3_rgbString(value) {
    return d3_rgbNumber(value) + "";
  }
  function d3_rgb(r, g, b) {
    return new d3_Rgb(r, g, b);
  }
  function d3_Rgb(r, g, b) {
    this.r = r;
    this.g = g;
    this.b = b;
  }
  var d3_rgbPrototype = d3_Rgb.prototype = new d3_Color();
  d3_rgbPrototype.brighter = function(k) {
    k = Math.pow(.7, arguments.length ? k : 1);
    var r = this.r, g = this.g, b = this.b, i = 30;
    if (!r && !g && !b) return d3_rgb(i, i, i);
    if (r && r < i) r = i;
    if (g && g < i) g = i;
    if (b && b < i) b = i;
    return d3_rgb(Math.min(255, ~~(r / k)), Math.min(255, ~~(g / k)), Math.min(255, ~~(b / k)));
  };
  d3_rgbPrototype.darker = function(k) {
    k = Math.pow(.7, arguments.length ? k : 1);
    return d3_rgb(~~(k * this.r), ~~(k * this.g), ~~(k * this.b));
  };
  d3_rgbPrototype.hsl = function() {
    return d3_rgb_hsl(this.r, this.g, this.b);
  };
  d3_rgbPrototype.toString = function() {
    return "#" + d3_rgb_hex(this.r) + d3_rgb_hex(this.g) + d3_rgb_hex(this.b);
  };
  function d3_rgb_hex(v) {
    return v < 16 ? "0" + Math.max(0, v).toString(16) : Math.min(255, v).toString(16);
  }
  function d3_rgb_parse(format, rgb, hsl) {
    var r = 0, g = 0, b = 0, m1, m2, name;
    m1 = /([a-z]+)\((.*)\)/i.exec(format);
    if (m1) {
      m2 = m1[2].split(",");
      switch (m1[1]) {
       case "hsl":
        {
          return hsl(parseFloat(m2[0]), parseFloat(m2[1]) / 100, parseFloat(m2[2]) / 100);
        }

       case "rgb":
        {
          return rgb(d3_rgb_parseNumber(m2[0]), d3_rgb_parseNumber(m2[1]), d3_rgb_parseNumber(m2[2]));
        }
      }
    }
    if (name = d3_rgb_names.get(format)) return rgb(name.r, name.g, name.b);
    if (format != null && format.charAt(0) === "#") {
      if (format.length === 4) {
        r = format.charAt(1);
        r += r;
        g = format.charAt(2);
        g += g;
        b = format.charAt(3);
        b += b;
      } else if (format.length === 7) {
        r = format.substring(1, 3);
        g = format.substring(3, 5);
        b = format.substring(5, 7);
      }
      r = parseInt(r, 16);
      g = parseInt(g, 16);
      b = parseInt(b, 16);
    }
    return rgb(r, g, b);
  }
  function d3_rgb_hsl(r, g, b) {
    var min = Math.min(r /= 255, g /= 255, b /= 255), max = Math.max(r, g, b), d = max - min, h, s, l = (max + min) / 2;
    if (d) {
      s = l < .5 ? d / (max + min) : d / (2 - max - min);
      if (r == max) h = (g - b) / d + (g < b ? 6 : 0); else if (g == max) h = (b - r) / d + 2; else h = (r - g) / d + 4;
      h *= 60;
    } else {
      h = NaN;
      s = l > 0 && l < 1 ? 0 : h;
    }
    return d3_hsl(h, s, l);
  }
  function d3_rgb_lab(r, g, b) {
    r = d3_rgb_xyz(r);
    g = d3_rgb_xyz(g);
    b = d3_rgb_xyz(b);
    var x = d3_xyz_lab((.4124564 * r + .3575761 * g + .1804375 * b) / d3_lab_X), y = d3_xyz_lab((.2126729 * r + .7151522 * g + .072175 * b) / d3_lab_Y), z = d3_xyz_lab((.0193339 * r + .119192 * g + .9503041 * b) / d3_lab_Z);
    return d3_lab(116 * y - 16, 500 * (x - y), 200 * (y - z));
  }
  function d3_rgb_xyz(r) {
    return (r /= 255) <= .04045 ? r / 12.92 : Math.pow((r + .055) / 1.055, 2.4);
  }
  function d3_rgb_parseNumber(c) {
    var f = parseFloat(c);
    return c.charAt(c.length - 1) === "%" ? Math.round(f * 2.55) : f;
  }
  var d3_rgb_names = d3.map({
    aliceblue: 15792383,
    antiquewhite: 16444375,
    aqua: 65535,
    aquamarine: 8388564,
    azure: 15794175,
    beige: 16119260,
    bisque: 16770244,
    black: 0,
    blanchedalmond: 16772045,
    blue: 255,
    blueviolet: 9055202,
    brown: 10824234,
    burlywood: 14596231,
    cadetblue: 6266528,
    chartreuse: 8388352,
    chocolate: 13789470,
    coral: 16744272,
    cornflowerblue: 6591981,
    cornsilk: 16775388,
    crimson: 14423100,
    cyan: 65535,
    darkblue: 139,
    darkcyan: 35723,
    darkgoldenrod: 12092939,
    darkgray: 11119017,
    darkgreen: 25600,
    darkgrey: 11119017,
    darkkhaki: 12433259,
    darkmagenta: 9109643,
    darkolivegreen: 5597999,
    darkorange: 16747520,
    darkorchid: 10040012,
    darkred: 9109504,
    darksalmon: 15308410,
    darkseagreen: 9419919,
    darkslateblue: 4734347,
    darkslategray: 3100495,
    darkslategrey: 3100495,
    darkturquoise: 52945,
    darkviolet: 9699539,
    deeppink: 16716947,
    deepskyblue: 49151,
    dimgray: 6908265,
    dimgrey: 6908265,
    dodgerblue: 2003199,
    firebrick: 11674146,
    floralwhite: 16775920,
    forestgreen: 2263842,
    fuchsia: 16711935,
    gainsboro: 14474460,
    ghostwhite: 16316671,
    gold: 16766720,
    goldenrod: 14329120,
    gray: 8421504,
    green: 32768,
    greenyellow: 11403055,
    grey: 8421504,
    honeydew: 15794160,
    hotpink: 16738740,
    indianred: 13458524,
    indigo: 4915330,
    ivory: 16777200,
    khaki: 15787660,
    lavender: 15132410,
    lavenderblush: 16773365,
    lawngreen: 8190976,
    lemonchiffon: 16775885,
    lightblue: 11393254,
    lightcoral: 15761536,
    lightcyan: 14745599,
    lightgoldenrodyellow: 16448210,
    lightgray: 13882323,
    lightgreen: 9498256,
    lightgrey: 13882323,
    lightpink: 16758465,
    lightsalmon: 16752762,
    lightseagreen: 2142890,
    lightskyblue: 8900346,
    lightslategray: 7833753,
    lightslategrey: 7833753,
    lightsteelblue: 11584734,
    lightyellow: 16777184,
    lime: 65280,
    limegreen: 3329330,
    linen: 16445670,
    magenta: 16711935,
    maroon: 8388608,
    mediumaquamarine: 6737322,
    mediumblue: 205,
    mediumorchid: 12211667,
    mediumpurple: 9662683,
    mediumseagreen: 3978097,
    mediumslateblue: 8087790,
    mediumspringgreen: 64154,
    mediumturquoise: 4772300,
    mediumvioletred: 13047173,
    midnightblue: 1644912,
    mintcream: 16121850,
    mistyrose: 16770273,
    moccasin: 16770229,
    navajowhite: 16768685,
    navy: 128,
    oldlace: 16643558,
    olive: 8421376,
    olivedrab: 7048739,
    orange: 16753920,
    orangered: 16729344,
    orchid: 14315734,
    palegoldenrod: 15657130,
    palegreen: 10025880,
    paleturquoise: 11529966,
    palevioletred: 14381203,
    papayawhip: 16773077,
    peachpuff: 16767673,
    peru: 13468991,
    pink: 16761035,
    plum: 14524637,
    powderblue: 11591910,
    purple: 8388736,
    red: 16711680,
    rosybrown: 12357519,
    royalblue: 4286945,
    saddlebrown: 9127187,
    salmon: 16416882,
    sandybrown: 16032864,
    seagreen: 3050327,
    seashell: 16774638,
    sienna: 10506797,
    silver: 12632256,
    skyblue: 8900331,
    slateblue: 6970061,
    slategray: 7372944,
    slategrey: 7372944,
    snow: 16775930,
    springgreen: 65407,
    steelblue: 4620980,
    tan: 13808780,
    teal: 32896,
    thistle: 14204888,
    tomato: 16737095,
    turquoise: 4251856,
    violet: 15631086,
    wheat: 16113331,
    white: 16777215,
    whitesmoke: 16119285,
    yellow: 16776960,
    yellowgreen: 10145074
  });
  d3_rgb_names.forEach(function(key, value) {
    d3_rgb_names.set(key, d3_rgbNumber(value));
  });
  function d3_functor(v) {
    return typeof v === "function" ? v : function() {
      return v;
    };
  }
  d3.functor = d3_functor;
  function d3_identity(d) {
    return d;
  }
  d3.xhr = d3_xhrType(d3_identity);
  function d3_xhrType(response) {
    return function(url, mimeType, callback) {
      if (arguments.length === 2 && typeof mimeType === "function") callback = mimeType, 
      mimeType = null;
      return d3_xhr(url, mimeType, response, callback);
    };
  }
  function d3_xhr(url, mimeType, response, callback) {
    var xhr = {}, dispatch = d3.dispatch("progress", "load", "error"), headers = {}, request = new XMLHttpRequest(), responseType = null;
    if (d3_window.XDomainRequest && !("withCredentials" in request) && /^(http(s)?:)?\/\//.test(url)) request = new XDomainRequest();
    "onload" in request ? request.onload = request.onerror = respond : request.onreadystatechange = function() {
      request.readyState > 3 && respond();
    };
    function respond() {
      var status = request.status, result;
      if (!status && request.responseText || status >= 200 && status < 300 || status === 304) {
        try {
          result = response.call(xhr, request);
        } catch (e) {
          dispatch.error.call(xhr, e);
          return;
        }
        dispatch.load.call(xhr, result);
      } else {
        dispatch.error.call(xhr, request);
      }
    }
    request.onprogress = function(event) {
      var o = d3.event;
      d3.event = event;
      try {
        dispatch.progress.call(xhr, request);
      } finally {
        d3.event = o;
      }
    };
    xhr.header = function(name, value) {
      name = (name + "").toLowerCase();
      if (arguments.length < 2) return headers[name];
      if (value == null) delete headers[name]; else headers[name] = value + "";
      return xhr;
    };
    xhr.mimeType = function(value) {
      if (!arguments.length) return mimeType;
      mimeType = value == null ? null : value + "";
      return xhr;
    };
    xhr.responseType = function(value) {
      if (!arguments.length) return responseType;
      responseType = value;
      return xhr;
    };
    xhr.response = function(value) {
      response = value;
      return xhr;
    };
    [ "get", "post" ].forEach(function(method) {
      xhr[method] = function() {
        return xhr.send.apply(xhr, [ method ].concat(d3_array(arguments)));
      };
    });
    xhr.send = function(method, data, callback) {
      if (arguments.length === 2 && typeof data === "function") callback = data, data = null;
      request.open(method, url, true);
      if (mimeType != null && !("accept" in headers)) headers["accept"] = mimeType + ",*/*";
      if (request.setRequestHeader) for (var name in headers) request.setRequestHeader(name, headers[name]);
      if (mimeType != null && request.overrideMimeType) request.overrideMimeType(mimeType);
      if (responseType != null) request.responseType = responseType;
      if (callback != null) xhr.on("error", callback).on("load", function(request) {
        callback(null, request);
      });
      request.send(data == null ? null : data);
      return xhr;
    };
    xhr.abort = function() {
      request.abort();
      return xhr;
    };
    d3.rebind(xhr, dispatch, "on");
    return callback == null ? xhr : xhr.get(d3_xhr_fixCallback(callback));
  }
  function d3_xhr_fixCallback(callback) {
    return callback.length === 1 ? function(error, request) {
      callback(error == null ? request : null);
    } : callback;
  }
  d3.dsv = function(delimiter, mimeType) {
    var reFormat = new RegExp('["' + delimiter + "\n]"), delimiterCode = delimiter.charCodeAt(0);
    function dsv(url, row, callback) {
      if (arguments.length < 3) callback = row, row = null;
      var xhr = d3.xhr(url, mimeType, callback);
      xhr.row = function(_) {
        return arguments.length ? xhr.response((row = _) == null ? response : typedResponse(_)) : row;
      };
      return xhr.row(row);
    }
    function response(request) {
      return dsv.parse(request.responseText);
    }
    function typedResponse(f) {
      return function(request) {
        return dsv.parse(request.responseText, f);
      };
    }
    dsv.parse = function(text, f) {
      var o;
      return dsv.parseRows(text, function(row, i) {
        if (o) return o(row, i - 1);
        var a = new Function("d", "return {" + row.map(function(name, i) {
          return JSON.stringify(name) + ": d[" + i + "]";
        }).join(",") + "}");
        o = f ? function(row, i) {
          return f(a(row), i);
        } : a;
      });
    };
    dsv.parseRows = function(text, f) {
      var EOL = {}, EOF = {}, rows = [], N = text.length, I = 0, n = 0, t, eol;
      function token() {
        if (I >= N) return EOF;
        if (eol) return eol = false, EOL;
        var j = I;
        if (text.charCodeAt(j) === 34) {
          var i = j;
          while (i++ < N) {
            if (text.charCodeAt(i) === 34) {
              if (text.charCodeAt(i + 1) !== 34) break;
              ++i;
            }
          }
          I = i + 2;
          var c = text.charCodeAt(i + 1);
          if (c === 13) {
            eol = true;
            if (text.charCodeAt(i + 2) === 10) ++I;
          } else if (c === 10) {
            eol = true;
          }
          return text.substring(j + 1, i).replace(/""/g, '"');
        }
        while (I < N) {
          var c = text.charCodeAt(I++), k = 1;
          if (c === 10) eol = true; else if (c === 13) {
            eol = true;
            if (text.charCodeAt(I) === 10) ++I, ++k;
          } else if (c !== delimiterCode) continue;
          return text.substring(j, I - k);
        }
        return text.substring(j);
      }
      while ((t = token()) !== EOF) {
        var a = [];
        while (t !== EOL && t !== EOF) {
          a.push(t);
          t = token();
        }
        if (f && !(a = f(a, n++))) continue;
        rows.push(a);
      }
      return rows;
    };
    dsv.format = function(rows) {
      if (Array.isArray(rows[0])) return dsv.formatRows(rows);
      var fieldSet = new d3_Set(), fields = [];
      rows.forEach(function(row) {
        for (var field in row) {
          if (!fieldSet.has(field)) {
            fields.push(fieldSet.add(field));
          }
        }
      });
      return [ fields.map(formatValue).join(delimiter) ].concat(rows.map(function(row) {
        return fields.map(function(field) {
          return formatValue(row[field]);
        }).join(delimiter);
      })).join("\n");
    };
    dsv.formatRows = function(rows) {
      return rows.map(formatRow).join("\n");
    };
    function formatRow(row) {
      return row.map(formatValue).join(delimiter);
    }
    function formatValue(text) {
      return reFormat.test(text) ? '"' + text.replace(/\"/g, '""') + '"' : text;
    }
    return dsv;
  };
  d3.csv = d3.dsv(",", "text/csv");
  d3.tsv = d3.dsv("	", "text/tab-separated-values");
  var d3_timer_queueHead, d3_timer_queueTail, d3_timer_interval, d3_timer_timeout, d3_timer_active, d3_timer_frame = d3_window[d3_vendorSymbol(d3_window, "requestAnimationFrame")] || function(callback) {
    setTimeout(callback, 17);
  };
  d3.timer = function(callback, delay, then) {
    var n = arguments.length;
    if (n < 2) delay = 0;
    if (n < 3) then = Date.now();
    var time = then + delay, timer = {
      callback: callback,
      time: time,
      next: null
    };
    if (d3_timer_queueTail) d3_timer_queueTail.next = timer; else d3_timer_queueHead = timer;
    d3_timer_queueTail = timer;
    if (!d3_timer_interval) {
      d3_timer_timeout = clearTimeout(d3_timer_timeout);
      d3_timer_interval = 1;
      d3_timer_frame(d3_timer_step);
    }
  };
  function d3_timer_step() {
    var now = d3_timer_mark(), delay = d3_timer_sweep() - now;
    if (delay > 24) {
      if (isFinite(delay)) {
        clearTimeout(d3_timer_timeout);
        d3_timer_timeout = setTimeout(d3_timer_step, delay);
      }
      d3_timer_interval = 0;
    } else {
      d3_timer_interval = 1;
      d3_timer_frame(d3_timer_step);
    }
  }
  d3.timer.flush = function() {
    d3_timer_mark();
    d3_timer_sweep();
  };
  function d3_timer_replace(callback, delay, then) {
    var n = arguments.length;
    if (n < 2) delay = 0;
    if (n < 3) then = Date.now();
    d3_timer_active.callback = callback;
    d3_timer_active.time = then + delay;
  }
  function d3_timer_mark() {
    var now = Date.now();
    d3_timer_active = d3_timer_queueHead;
    while (d3_timer_active) {
      if (now >= d3_timer_active.time) d3_timer_active.flush = d3_timer_active.callback(now - d3_timer_active.time);
      d3_timer_active = d3_timer_active.next;
    }
    return now;
  }
  function d3_timer_sweep() {
    var t0, t1 = d3_timer_queueHead, time = Infinity;
    while (t1) {
      if (t1.flush) {
        t1 = t0 ? t0.next = t1.next : d3_timer_queueHead = t1.next;
      } else {
        if (t1.time < time) time = t1.time;
        t1 = (t0 = t1).next;
      }
    }
    d3_timer_queueTail = t0;
    return time;
  }
  var d3_format_decimalPoint = ".", d3_format_thousandsSeparator = ",", d3_format_grouping = [ 3, 3 ], d3_format_currencySymbol = "$";
  var d3_formatPrefixes = [ "y", "z", "a", "f", "p", "n", "µ", "m", "", "k", "M", "G", "T", "P", "E", "Z", "Y" ].map(d3_formatPrefix);
  d3.formatPrefix = function(value, precision) {
    var i = 0;
    if (value) {
      if (value < 0) value *= -1;
      if (precision) value = d3.round(value, d3_format_precision(value, precision));
      i = 1 + Math.floor(1e-12 + Math.log(value) / Math.LN10);
      i = Math.max(-24, Math.min(24, Math.floor((i <= 0 ? i + 1 : i - 1) / 3) * 3));
    }
    return d3_formatPrefixes[8 + i / 3];
  };
  function d3_formatPrefix(d, i) {
    var k = Math.pow(10, Math.abs(8 - i) * 3);
    return {
      scale: i > 8 ? function(d) {
        return d / k;
      } : function(d) {
        return d * k;
      },
      symbol: d
    };
  }
  d3.round = function(x, n) {
    return n ? Math.round(x * (n = Math.pow(10, n))) / n : Math.round(x);
  };
  d3.format = function(specifier) {
    var match = d3_format_re.exec(specifier), fill = match[1] || " ", align = match[2] || ">", sign = match[3] || "", symbol = match[4] || "", zfill = match[5], width = +match[6], comma = match[7], precision = match[8], type = match[9], scale = 1, suffix = "", integer = false;
    if (precision) precision = +precision.substring(1);
    if (zfill || fill === "0" && align === "=") {
      zfill = fill = "0";
      align = "=";
      if (comma) width -= Math.floor((width - 1) / 4);
    }
    switch (type) {
     case "n":
      comma = true;
      type = "g";
      break;

     case "%":
      scale = 100;
      suffix = "%";
      type = "f";
      break;

     case "p":
      scale = 100;
      suffix = "%";
      type = "r";
      break;

     case "b":
     case "o":
     case "x":
     case "X":
      if (symbol === "#") symbol = "0" + type.toLowerCase();

     case "c":
     case "d":
      integer = true;
      precision = 0;
      break;

     case "s":
      scale = -1;
      type = "r";
      break;
    }
    if (symbol === "#") symbol = ""; else if (symbol === "$") symbol = d3_format_currencySymbol;
    if (type == "r" && !precision) type = "g";
    if (precision != null) {
      if (type == "g") precision = Math.max(1, Math.min(21, precision)); else if (type == "e" || type == "f") precision = Math.max(0, Math.min(20, precision));
    }
    type = d3_format_types.get(type) || d3_format_typeDefault;
    var zcomma = zfill && comma;
    return function(value) {
      if (integer && value % 1) return "";
      var negative = value < 0 || value === 0 && 1 / value < 0 ? (value = -value, "-") : sign;
      if (scale < 0) {
        var prefix = d3.formatPrefix(value, precision);
        value = prefix.scale(value);
        suffix = prefix.symbol;
      } else {
        value *= scale;
      }
      value = type(value, precision);
      var i = value.lastIndexOf("."), before = i < 0 ? value : value.substring(0, i), after = i < 0 ? "" : d3_format_decimalPoint + value.substring(i + 1);
      if (!zfill && comma) before = d3_format_group(before);
      var length = symbol.length + before.length + after.length + (zcomma ? 0 : negative.length), padding = length < width ? new Array(length = width - length + 1).join(fill) : "";
      if (zcomma) before = d3_format_group(padding + before);
      negative += symbol;
      value = before + after;
      return (align === "<" ? negative + value + padding : align === ">" ? padding + negative + value : align === "^" ? padding.substring(0, length >>= 1) + negative + value + padding.substring(length) : negative + (zcomma ? value : padding + value)) + suffix;
    };
  };
  var d3_format_re = /(?:([^{])?([<>=^]))?([+\- ])?([$#])?(0)?(\d+)?(,)?(\.-?\d+)?([a-z%])?/i;
  var d3_format_types = d3.map({
    b: function(x) {
      return x.toString(2);
    },
    c: function(x) {
      return String.fromCharCode(x);
    },
    o: function(x) {
      return x.toString(8);
    },
    x: function(x) {
      return x.toString(16);
    },
    X: function(x) {
      return x.toString(16).toUpperCase();
    },
    g: function(x, p) {
      return x.toPrecision(p);
    },
    e: function(x, p) {
      return x.toExponential(p);
    },
    f: function(x, p) {
      return x.toFixed(p);
    },
    r: function(x, p) {
      return (x = d3.round(x, d3_format_precision(x, p))).toFixed(Math.max(0, Math.min(20, d3_format_precision(x * (1 + 1e-15), p))));
    }
  });
  function d3_format_precision(x, p) {
    return p - (x ? Math.ceil(Math.log(x) / Math.LN10) : 1);
  }
  function d3_format_typeDefault(x) {
    return x + "";
  }
  var d3_format_group = d3_identity;
  if (d3_format_grouping) {
    var d3_format_groupingLength = d3_format_grouping.length;
    d3_format_group = function(value) {
      var i = value.length, t = [], j = 0, g = d3_format_grouping[0];
      while (i > 0 && g > 0) {
        t.push(value.substring(i -= g, i + g));
        g = d3_format_grouping[j = (j + 1) % d3_format_groupingLength];
      }
      return t.reverse().join(d3_format_thousandsSeparator);
    };
  }
  d3.geo = {};
  function d3_adder() {}
  d3_adder.prototype = {
    s: 0,
    t: 0,
    add: function(y) {
      d3_adderSum(y, this.t, d3_adderTemp);
      d3_adderSum(d3_adderTemp.s, this.s, this);
      if (this.s) this.t += d3_adderTemp.t; else this.s = d3_adderTemp.t;
    },
    reset: function() {
      this.s = this.t = 0;
    },
    valueOf: function() {
      return this.s;
    }
  };
  var d3_adderTemp = new d3_adder();
  function d3_adderSum(a, b, o) {
    var x = o.s = a + b, bv = x - a, av = x - bv;
    o.t = a - av + (b - bv);
  }
  d3.geo.stream = function(object, listener) {
    if (object && d3_geo_streamObjectType.hasOwnProperty(object.type)) {
      d3_geo_streamObjectType[object.type](object, listener);
    } else {
      d3_geo_streamGeometry(object, listener);
    }
  };
  function d3_geo_streamGeometry(geometry, listener) {
    if (geometry && d3_geo_streamGeometryType.hasOwnProperty(geometry.type)) {
      d3_geo_streamGeometryType[geometry.type](geometry, listener);
    }
  }
  var d3_geo_streamObjectType = {
    Feature: function(feature, listener) {
      d3_geo_streamGeometry(feature.geometry, listener);
    },
    FeatureCollection: function(object, listener) {
      var features = object.features, i = -1, n = features.length;
      while (++i < n) d3_geo_streamGeometry(features[i].geometry, listener);
    }
  };
  var d3_geo_streamGeometryType = {
    Sphere: function(object, listener) {
      listener.sphere();
    },
    Point: function(object, listener) {
      var coordinate = object.coordinates;
      listener.point(coordinate[0], coordinate[1]);
    },
    MultiPoint: function(object, listener) {
      var coordinates = object.coordinates, i = -1, n = coordinates.length, coordinate;
      while (++i < n) coordinate = coordinates[i], listener.point(coordinate[0], coordinate[1]);
    },
    LineString: function(object, listener) {
      d3_geo_streamLine(object.coordinates, listener, 0);
    },
    MultiLineString: function(object, listener) {
      var coordinates = object.coordinates, i = -1, n = coordinates.length;
      while (++i < n) d3_geo_streamLine(coordinates[i], listener, 0);
    },
    Polygon: function(object, listener) {
      d3_geo_streamPolygon(object.coordinates, listener);
    },
    MultiPolygon: function(object, listener) {
      var coordinates = object.coordinates, i = -1, n = coordinates.length;
      while (++i < n) d3_geo_streamPolygon(coordinates[i], listener);
    },
    GeometryCollection: function(object, listener) {
      var geometries = object.geometries, i = -1, n = geometries.length;
      while (++i < n) d3_geo_streamGeometry(geometries[i], listener);
    }
  };
  function d3_geo_streamLine(coordinates, listener, closed) {
    var i = -1, n = coordinates.length - closed, coordinate;
    listener.lineStart();
    while (++i < n) coordinate = coordinates[i], listener.point(coordinate[0], coordinate[1]);
    listener.lineEnd();
  }
  function d3_geo_streamPolygon(coordinates, listener) {
    var i = -1, n = coordinates.length;
    listener.polygonStart();
    while (++i < n) d3_geo_streamLine(coordinates[i], listener, 1);
    listener.polygonEnd();
  }
  d3.geo.area = function(object) {
    d3_geo_areaSum = 0;
    d3.geo.stream(object, d3_geo_area);
    return d3_geo_areaSum;
  };
  var d3_geo_areaSum, d3_geo_areaRingSum = new d3_adder();
  var d3_geo_area = {
    sphere: function() {
      d3_geo_areaSum += 4 * π;
    },
    point: d3_noop,
    lineStart: d3_noop,
    lineEnd: d3_noop,
    polygonStart: function() {
      d3_geo_areaRingSum.reset();
      d3_geo_area.lineStart = d3_geo_areaRingStart;
    },
    polygonEnd: function() {
      var area = 2 * d3_geo_areaRingSum;
      d3_geo_areaSum += area < 0 ? 4 * π + area : area;
      d3_geo_area.lineStart = d3_geo_area.lineEnd = d3_geo_area.point = d3_noop;
    }
  };
  function d3_geo_areaRingStart() {
    var λ00, φ00, λ0, cosφ0, sinφ0;
    d3_geo_area.point = function(λ, φ) {
      d3_geo_area.point = nextPoint;
      λ0 = (λ00 = λ) * d3_radians, cosφ0 = Math.cos(φ = (φ00 = φ) * d3_radians / 2 + π / 4), 
      sinφ0 = Math.sin(φ);
    };
    function nextPoint(λ, φ) {
      λ *= d3_radians;
      φ = φ * d3_radians / 2 + π / 4;
      var dλ = λ - λ0, cosφ = Math.cos(φ), sinφ = Math.sin(φ), k = sinφ0 * sinφ, u = cosφ0 * cosφ + k * Math.cos(dλ), v = k * Math.sin(dλ);
      d3_geo_areaRingSum.add(Math.atan2(v, u));
      λ0 = λ, cosφ0 = cosφ, sinφ0 = sinφ;
    }
    d3_geo_area.lineEnd = function() {
      nextPoint(λ00, φ00);
    };
  }
  function d3_geo_cartesian(spherical) {
    var λ = spherical[0], φ = spherical[1], cosφ = Math.cos(φ);
    return [ cosφ * Math.cos(λ), cosφ * Math.sin(λ), Math.sin(φ) ];
  }
  function d3_geo_cartesianDot(a, b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
  }
  function d3_geo_cartesianCross(a, b) {
    return [ a[1] * b[2] - a[2] * b[1], a[2] * b[0] - a[0] * b[2], a[0] * b[1] - a[1] * b[0] ];
  }
  function d3_geo_cartesianAdd(a, b) {
    a[0] += b[0];
    a[1] += b[1];
    a[2] += b[2];
  }
  function d3_geo_cartesianScale(vector, k) {
    return [ vector[0] * k, vector[1] * k, vector[2] * k ];
  }
  function d3_geo_cartesianNormalize(d) {
    var l = Math.sqrt(d[0] * d[0] + d[1] * d[1] + d[2] * d[2]);
    d[0] /= l;
    d[1] /= l;
    d[2] /= l;
  }
  function d3_geo_spherical(cartesian) {
    return [ Math.atan2(cartesian[1], cartesian[0]), d3_asin(cartesian[2]) ];
  }
  function d3_geo_sphericalEqual(a, b) {
    return Math.abs(a[0] - b[0]) < ε && Math.abs(a[1] - b[1]) < ε;
  }
  d3.geo.bounds = function() {
    var λ0, φ0, λ1, φ1, λ_, λ__, φ__, p0, dλSum, ranges, range;
    var bound = {
      point: point,
      lineStart: lineStart,
      lineEnd: lineEnd,
      polygonStart: function() {
        bound.point = ringPoint;
        bound.lineStart = ringStart;
        bound.lineEnd = ringEnd;
        dλSum = 0;
        d3_geo_area.polygonStart();
      },
      polygonEnd: function() {
        d3_geo_area.polygonEnd();
        bound.point = point;
        bound.lineStart = lineStart;
        bound.lineEnd = lineEnd;
        if (d3_geo_areaRingSum < 0) λ0 = -(λ1 = 180), φ0 = -(φ1 = 90); else if (dλSum > ε) φ1 = 90; else if (dλSum < -ε) φ0 = -90;
        range[0] = λ0, range[1] = λ1;
      }
    };
    function point(λ, φ) {
      ranges.push(range = [ λ0 = λ, λ1 = λ ]);
      if (φ < φ0) φ0 = φ;
      if (φ > φ1) φ1 = φ;
    }
    function linePoint(λ, φ) {
      var p = d3_geo_cartesian([ λ * d3_radians, φ * d3_radians ]);
      if (p0) {
        var normal = d3_geo_cartesianCross(p0, p), equatorial = [ normal[1], -normal[0], 0 ], inflection = d3_geo_cartesianCross(equatorial, normal);
        d3_geo_cartesianNormalize(inflection);
        inflection = d3_geo_spherical(inflection);
        var dλ = λ - λ_, s = dλ > 0 ? 1 : -1, λi = inflection[0] * d3_degrees * s, antimeridian = Math.abs(dλ) > 180;
        if (antimeridian ^ (s * λ_ < λi && λi < s * λ)) {
          var φi = inflection[1] * d3_degrees;
          if (φi > φ1) φ1 = φi;
        } else if (λi = (λi + 360) % 360 - 180, antimeridian ^ (s * λ_ < λi && λi < s * λ)) {
          var φi = -inflection[1] * d3_degrees;
          if (φi < φ0) φ0 = φi;
        } else {
          if (φ < φ0) φ0 = φ;
          if (φ > φ1) φ1 = φ;
        }
        if (antimeridian) {
          if (λ < λ_) {
            if (angle(λ0, λ) > angle(λ0, λ1)) λ1 = λ;
          } else {
            if (angle(λ, λ1) > angle(λ0, λ1)) λ0 = λ;
          }
        } else {
          if (λ1 >= λ0) {
            if (λ < λ0) λ0 = λ;
            if (λ > λ1) λ1 = λ;
          } else {
            if (λ > λ_) {
              if (angle(λ0, λ) > angle(λ0, λ1)) λ1 = λ;
            } else {
              if (angle(λ, λ1) > angle(λ0, λ1)) λ0 = λ;
            }
          }
        }
      } else {
        point(λ, φ);
      }
      p0 = p, λ_ = λ;
    }
    function lineStart() {
      bound.point = linePoint;
    }
    function lineEnd() {
      range[0] = λ0, range[1] = λ1;
      bound.point = point;
      p0 = null;
    }
    function ringPoint(λ, φ) {
      if (p0) {
        var dλ = λ - λ_;
        dλSum += Math.abs(dλ) > 180 ? dλ + (dλ > 0 ? 360 : -360) : dλ;
      } else λ__ = λ, φ__ = φ;
      d3_geo_area.point(λ, φ);
      linePoint(λ, φ);
    }
    function ringStart() {
      d3_geo_area.lineStart();
    }
    function ringEnd() {
      ringPoint(λ__, φ__);
      d3_geo_area.lineEnd();
      if (Math.abs(dλSum) > ε) λ0 = -(λ1 = 180);
      range[0] = λ0, range[1] = λ1;
      p0 = null;
    }
    function angle(λ0, λ1) {
      return (λ1 -= λ0) < 0 ? λ1 + 360 : λ1;
    }
    function compareRanges(a, b) {
      return a[0] - b[0];
    }
    function withinRange(x, range) {
      return range[0] <= range[1] ? range[0] <= x && x <= range[1] : x < range[0] || range[1] < x;
    }
    return function(feature) {
      φ1 = λ1 = -(λ0 = φ0 = Infinity);
      ranges = [];
      d3.geo.stream(feature, bound);
      var n = ranges.length;
      if (n) {
        ranges.sort(compareRanges);
        for (var i = 1, a = ranges[0], b, merged = [ a ]; i < n; ++i) {
          b = ranges[i];
          if (withinRange(b[0], a) || withinRange(b[1], a)) {
            if (angle(a[0], b[1]) > angle(a[0], a[1])) a[1] = b[1];
            if (angle(b[0], a[1]) > angle(a[0], a[1])) a[0] = b[0];
          } else {
            merged.push(a = b);
          }
        }
        var best = -Infinity, dλ;
        for (var n = merged.length - 1, i = 0, a = merged[n], b; i <= n; a = b, ++i) {
          b = merged[i];
          if ((dλ = angle(a[1], b[0])) > best) best = dλ, λ0 = b[0], λ1 = a[1];
        }
      }
      ranges = range = null;
      return λ0 === Infinity || φ0 === Infinity ? [ [ NaN, NaN ], [ NaN, NaN ] ] : [ [ λ0, φ0 ], [ λ1, φ1 ] ];
    };
  }();
  d3.geo.centroid = function(object) {
    d3_geo_centroidW0 = d3_geo_centroidW1 = d3_geo_centroidX0 = d3_geo_centroidY0 = d3_geo_centroidZ0 = d3_geo_centroidX1 = d3_geo_centroidY1 = d3_geo_centroidZ1 = d3_geo_centroidX2 = d3_geo_centroidY2 = d3_geo_centroidZ2 = 0;
    d3.geo.stream(object, d3_geo_centroid);
    var x = d3_geo_centroidX2, y = d3_geo_centroidY2, z = d3_geo_centroidZ2, m = x * x + y * y + z * z;
    if (m < ε2) {
      x = d3_geo_centroidX1, y = d3_geo_centroidY1, z = d3_geo_centroidZ1;
      if (d3_geo_centroidW1 < ε) x = d3_geo_centroidX0, y = d3_geo_centroidY0, z = d3_geo_centroidZ0;
      m = x * x + y * y + z * z;
      if (m < ε2) return [ NaN, NaN ];
    }
    return [ Math.atan2(y, x) * d3_degrees, d3_asin(z / Math.sqrt(m)) * d3_degrees ];
  };
  var d3_geo_centroidW0, d3_geo_centroidW1, d3_geo_centroidX0, d3_geo_centroidY0, d3_geo_centroidZ0, d3_geo_centroidX1, d3_geo_centroidY1, d3_geo_centroidZ1, d3_geo_centroidX2, d3_geo_centroidY2, d3_geo_centroidZ2;
  var d3_geo_centroid = {
    sphere: d3_noop,
    point: d3_geo_centroidPoint,
    lineStart: d3_geo_centroidLineStart,
    lineEnd: d3_geo_centroidLineEnd,
    polygonStart: function() {
      d3_geo_centroid.lineStart = d3_geo_centroidRingStart;
    },
    polygonEnd: function() {
      d3_geo_centroid.lineStart = d3_geo_centroidLineStart;
    }
  };
  function d3_geo_centroidPoint(λ, φ) {
    λ *= d3_radians;
    var cosφ = Math.cos(φ *= d3_radians);
    d3_geo_centroidPointXYZ(cosφ * Math.cos(λ), cosφ * Math.sin(λ), Math.sin(φ));
  }
  function d3_geo_centroidPointXYZ(x, y, z) {
    ++d3_geo_centroidW0;
    d3_geo_centroidX0 += (x - d3_geo_centroidX0) / d3_geo_centroidW0;
    d3_geo_centroidY0 += (y - d3_geo_centroidY0) / d3_geo_centroidW0;
    d3_geo_centroidZ0 += (z - d3_geo_centroidZ0) / d3_geo_centroidW0;
  }
  function d3_geo_centroidLineStart() {
    var x0, y0, z0;
    d3_geo_centroid.point = function(λ, φ) {
      λ *= d3_radians;
      var cosφ = Math.cos(φ *= d3_radians);
      x0 = cosφ * Math.cos(λ);
      y0 = cosφ * Math.sin(λ);
      z0 = Math.sin(φ);
      d3_geo_centroid.point = nextPoint;
      d3_geo_centroidPointXYZ(x0, y0, z0);
    };
    function nextPoint(λ, φ) {
      λ *= d3_radians;
      var cosφ = Math.cos(φ *= d3_radians), x = cosφ * Math.cos(λ), y = cosφ * Math.sin(λ), z = Math.sin(φ), w = Math.atan2(Math.sqrt((w = y0 * z - z0 * y) * w + (w = z0 * x - x0 * z) * w + (w = x0 * y - y0 * x) * w), x0 * x + y0 * y + z0 * z);
      d3_geo_centroidW1 += w;
      d3_geo_centroidX1 += w * (x0 + (x0 = x));
      d3_geo_centroidY1 += w * (y0 + (y0 = y));
      d3_geo_centroidZ1 += w * (z0 + (z0 = z));
      d3_geo_centroidPointXYZ(x0, y0, z0);
    }
  }
  function d3_geo_centroidLineEnd() {
    d3_geo_centroid.point = d3_geo_centroidPoint;
  }
  function d3_geo_centroidRingStart() {
    var λ00, φ00, x0, y0, z0;
    d3_geo_centroid.point = function(λ, φ) {
      λ00 = λ, φ00 = φ;
      d3_geo_centroid.point = nextPoint;
      λ *= d3_radians;
      var cosφ = Math.cos(φ *= d3_radians);
      x0 = cosφ * Math.cos(λ);
      y0 = cosφ * Math.sin(λ);
      z0 = Math.sin(φ);
      d3_geo_centroidPointXYZ(x0, y0, z0);
    };
    d3_geo_centroid.lineEnd = function() {
      nextPoint(λ00, φ00);
      d3_geo_centroid.lineEnd = d3_geo_centroidLineEnd;
      d3_geo_centroid.point = d3_geo_centroidPoint;
    };
    function nextPoint(λ, φ) {
      λ *= d3_radians;
      var cosφ = Math.cos(φ *= d3_radians), x = cosφ * Math.cos(λ), y = cosφ * Math.sin(λ), z = Math.sin(φ), cx = y0 * z - z0 * y, cy = z0 * x - x0 * z, cz = x0 * y - y0 * x, m = Math.sqrt(cx * cx + cy * cy + cz * cz), u = x0 * x + y0 * y + z0 * z, v = m && -d3_acos(u) / m, w = Math.atan2(m, u);
      d3_geo_centroidX2 += v * cx;
      d3_geo_centroidY2 += v * cy;
      d3_geo_centroidZ2 += v * cz;
      d3_geo_centroidW1 += w;
      d3_geo_centroidX1 += w * (x0 + (x0 = x));
      d3_geo_centroidY1 += w * (y0 + (y0 = y));
      d3_geo_centroidZ1 += w * (z0 + (z0 = z));
      d3_geo_centroidPointXYZ(x0, y0, z0);
    }
  }
  function d3_true() {
    return true;
  }
  function d3_geo_clipPolygon(segments, compare, inside, interpolate, listener) {
    var subject = [], clip = [];
    segments.forEach(function(segment) {
      if ((n = segment.length - 1) <= 0) return;
      var n, p0 = segment[0], p1 = segment[n];
      if (d3_geo_sphericalEqual(p0, p1)) {
        listener.lineStart();
        for (var i = 0; i < n; ++i) listener.point((p0 = segment[i])[0], p0[1]);
        listener.lineEnd();
        return;
      }
      var a = {
        point: p0,
        points: segment,
        other: null,
        visited: false,
        entry: true,
        subject: true
      }, b = {
        point: p0,
        points: [ p0 ],
        other: a,
        visited: false,
        entry: false,
        subject: false
      };
      a.other = b;
      subject.push(a);
      clip.push(b);
      a = {
        point: p1,
        points: [ p1 ],
        other: null,
        visited: false,
        entry: false,
        subject: true
      };
      b = {
        point: p1,
        points: [ p1 ],
        other: a,
        visited: false,
        entry: true,
        subject: false
      };
      a.other = b;
      subject.push(a);
      clip.push(b);
    });
    clip.sort(compare);
    d3_geo_clipPolygonLinkCircular(subject);
    d3_geo_clipPolygonLinkCircular(clip);
    if (!subject.length) return;
    if (inside) for (var i = 1, e = !inside(clip[0].point), n = clip.length; i < n; ++i) {
      clip[i].entry = e = !e;
    }
    var start = subject[0], current, points, point;
    while (1) {
      current = start;
      while (current.visited) if ((current = current.next) === start) return;
      points = current.points;
      listener.lineStart();
      do {
        current.visited = current.other.visited = true;
        if (current.entry) {
          if (current.subject) {
            for (var i = 0; i < points.length; i++) listener.point((point = points[i])[0], point[1]);
          } else {
            interpolate(current.point, current.next.point, 1, listener);
          }
          current = current.next;
        } else {
          if (current.subject) {
            points = current.prev.points;
            for (var i = points.length; --i >= 0; ) listener.point((point = points[i])[0], point[1]);
          } else {
            interpolate(current.point, current.prev.point, -1, listener);
          }
          current = current.prev;
        }
        current = current.other;
        points = current.points;
      } while (!current.visited);
      listener.lineEnd();
    }
  }
  function d3_geo_clipPolygonLinkCircular(array) {
    if (!(n = array.length)) return;
    var n, i = 0, a = array[0], b;
    while (++i < n) {
      a.next = b = array[i];
      b.prev = a;
      a = b;
    }
    a.next = b = array[0];
    b.prev = a;
  }
  function d3_geo_clip(pointVisible, clipLine, interpolate, polygonContains) {
    return function(listener) {
      var line = clipLine(listener);
      var clip = {
        point: point,
        lineStart: lineStart,
        lineEnd: lineEnd,
        polygonStart: function() {
          clip.point = pointRing;
          clip.lineStart = ringStart;
          clip.lineEnd = ringEnd;
          segments = [];
          polygon = [];
          listener.polygonStart();
        },
        polygonEnd: function() {
          clip.point = point;
          clip.lineStart = lineStart;
          clip.lineEnd = lineEnd;
          segments = d3.merge(segments);
          if (segments.length) {
            d3_geo_clipPolygon(segments, d3_geo_clipSort, null, interpolate, listener);
          } else if (polygonContains(polygon)) {
            listener.lineStart();
            interpolate(null, null, 1, listener);
            listener.lineEnd();
          }
          listener.polygonEnd();
          segments = polygon = null;
        },
        sphere: function() {
          listener.polygonStart();
          listener.lineStart();
          interpolate(null, null, 1, listener);
          listener.lineEnd();
          listener.polygonEnd();
        }
      };
      function point(λ, φ) {
        if (pointVisible(λ, φ)) listener.point(λ, φ);
      }
      function pointLine(λ, φ) {
        line.point(λ, φ);
      }
      function lineStart() {
        clip.point = pointLine;
        line.lineStart();
      }
      function lineEnd() {
        clip.point = point;
        line.lineEnd();
      }
      var segments;
      var buffer = d3_geo_clipBufferListener(), ringListener = clipLine(buffer), polygon, ring;
      function pointRing(λ, φ) {
        ringListener.point(λ, φ);
        ring.push([ λ, φ ]);
      }
      function ringStart() {
        ringListener.lineStart();
        ring = [];
      }
      function ringEnd() {
        pointRing(ring[0][0], ring[0][1]);
        ringListener.lineEnd();
        var clean = ringListener.clean(), ringSegments = buffer.buffer(), segment, n = ringSegments.length;
        ring.pop();
        polygon.push(ring);
        ring = null;
        if (!n) return;
        if (clean & 1) {
          segment = ringSegments[0];
          var n = segment.length - 1, i = -1, point;
          listener.lineStart();
          while (++i < n) listener.point((point = segment[i])[0], point[1]);
          listener.lineEnd();
          return;
        }
        if (n > 1 && clean & 2) ringSegments.push(ringSegments.pop().concat(ringSegments.shift()));
        segments.push(ringSegments.filter(d3_geo_clipSegmentLength1));
      }
      return clip;
    };
  }
  function d3_geo_clipSegmentLength1(segment) {
    return segment.length > 1;
  }
  function d3_geo_clipBufferListener() {
    var lines = [], line;
    return {
      lineStart: function() {
        lines.push(line = []);
      },
      point: function(λ, φ) {
        line.push([ λ, φ ]);
      },
      lineEnd: d3_noop,
      buffer: function() {
        var buffer = lines;
        lines = [];
        line = null;
        return buffer;
      },
      rejoin: function() {
        if (lines.length > 1) lines.push(lines.pop().concat(lines.shift()));
      }
    };
  }
  function d3_geo_clipSort(a, b) {
    return ((a = a.point)[0] < 0 ? a[1] - π / 2 - ε : π / 2 - a[1]) - ((b = b.point)[0] < 0 ? b[1] - π / 2 - ε : π / 2 - b[1]);
  }
  function d3_geo_pointInPolygon(point, polygon) {
    var meridian = point[0], parallel = point[1], meridianNormal = [ Math.sin(meridian), -Math.cos(meridian), 0 ], polarAngle = 0, polar = false, southPole = false, winding = 0;
    d3_geo_areaRingSum.reset();
    for (var i = 0, n = polygon.length; i < n; ++i) {
      var ring = polygon[i], m = ring.length;
      if (!m) continue;
      var point0 = ring[0], λ0 = point0[0], φ0 = point0[1] / 2 + π / 4, sinφ0 = Math.sin(φ0), cosφ0 = Math.cos(φ0), j = 1;
      while (true) {
        if (j === m) j = 0;
        point = ring[j];
        var λ = point[0], φ = point[1] / 2 + π / 4, sinφ = Math.sin(φ), cosφ = Math.cos(φ), dλ = λ - λ0, antimeridian = Math.abs(dλ) > π, k = sinφ0 * sinφ;
        d3_geo_areaRingSum.add(Math.atan2(k * Math.sin(dλ), cosφ0 * cosφ + k * Math.cos(dλ)));
        if (Math.abs(φ) < ε) southPole = true;
        polarAngle += antimeridian ? dλ + (dλ >= 0 ? 2 : -2) * π : dλ;
        if (antimeridian ^ λ0 >= meridian ^ λ >= meridian) {
          var arc = d3_geo_cartesianCross(d3_geo_cartesian(point0), d3_geo_cartesian(point));
          d3_geo_cartesianNormalize(arc);
          var intersection = d3_geo_cartesianCross(meridianNormal, arc);
          d3_geo_cartesianNormalize(intersection);
          var φarc = (antimeridian ^ dλ >= 0 ? -1 : 1) * d3_asin(intersection[2]);
          if (parallel > φarc) {
            winding += antimeridian ^ dλ >= 0 ? 1 : -1;
          }
        }
        if (!j++) break;
        λ0 = λ, sinφ0 = sinφ, cosφ0 = cosφ, point0 = point;
      }
      if (Math.abs(polarAngle) > ε) polar = true;
    }
    return (!southPole && !polar && d3_geo_areaRingSum < 0 || polarAngle < -ε) ^ winding & 1;
  }
  var d3_geo_clipAntimeridian = d3_geo_clip(d3_true, d3_geo_clipAntimeridianLine, d3_geo_clipAntimeridianInterpolate, d3_geo_clipAntimeridianPolygonContains);
  function d3_geo_clipAntimeridianLine(listener) {
    var λ0 = NaN, φ0 = NaN, sλ0 = NaN, clean;
    return {
      lineStart: function() {
        listener.lineStart();
        clean = 1;
      },
      point: function(λ1, φ1) {
        var sλ1 = λ1 > 0 ? π : -π, dλ = Math.abs(λ1 - λ0);
        if (Math.abs(dλ - π) < ε) {
          listener.point(λ0, φ0 = (φ0 + φ1) / 2 > 0 ? π / 2 : -π / 2);
          listener.point(sλ0, φ0);
          listener.lineEnd();
          listener.lineStart();
          listener.point(sλ1, φ0);
          listener.point(λ1, φ0);
          clean = 0;
        } else if (sλ0 !== sλ1 && dλ >= π) {
          if (Math.abs(λ0 - sλ0) < ε) λ0 -= sλ0 * ε;
          if (Math.abs(λ1 - sλ1) < ε) λ1 -= sλ1 * ε;
          φ0 = d3_geo_clipAntimeridianIntersect(λ0, φ0, λ1, φ1);
          listener.point(sλ0, φ0);
          listener.lineEnd();
          listener.lineStart();
          listener.point(sλ1, φ0);
          clean = 0;
        }
        listener.point(λ0 = λ1, φ0 = φ1);
        sλ0 = sλ1;
      },
      lineEnd: function() {
        listener.lineEnd();
        λ0 = φ0 = NaN;
      },
      clean: function() {
        return 2 - clean;
      }
    };
  }
  function d3_geo_clipAntimeridianIntersect(λ0, φ0, λ1, φ1) {
    var cosφ0, cosφ1, sinλ0_λ1 = Math.sin(λ0 - λ1);
    return Math.abs(sinλ0_λ1) > ε ? Math.atan((Math.sin(φ0) * (cosφ1 = Math.cos(φ1)) * Math.sin(λ1) - Math.sin(φ1) * (cosφ0 = Math.cos(φ0)) * Math.sin(λ0)) / (cosφ0 * cosφ1 * sinλ0_λ1)) : (φ0 + φ1) / 2;
  }
  function d3_geo_clipAntimeridianInterpolate(from, to, direction, listener) {
    var φ;
    if (from == null) {
      φ = direction * π / 2;
      listener.point(-π, φ);
      listener.point(0, φ);
      listener.point(π, φ);
      listener.point(π, 0);
      listener.point(π, -φ);
      listener.point(0, -φ);
      listener.point(-π, -φ);
      listener.point(-π, 0);
      listener.point(-π, φ);
    } else if (Math.abs(from[0] - to[0]) > ε) {
      var s = (from[0] < to[0] ? 1 : -1) * π;
      φ = direction * s / 2;
      listener.point(-s, φ);
      listener.point(0, φ);
      listener.point(s, φ);
    } else {
      listener.point(to[0], to[1]);
    }
  }
  var d3_geo_clipAntimeridianPoint = [ -π, 0 ];
  function d3_geo_clipAntimeridianPolygonContains(polygon) {
    return d3_geo_pointInPolygon(d3_geo_clipAntimeridianPoint, polygon);
  }
  function d3_geo_clipCircle(radius) {
    var cr = Math.cos(radius), smallRadius = cr > 0, point = [ radius, 0 ], notHemisphere = Math.abs(cr) > ε, interpolate = d3_geo_circleInterpolate(radius, 6 * d3_radians);
    return d3_geo_clip(visible, clipLine, interpolate, polygonContains);
    function visible(λ, φ) {
      return Math.cos(λ) * Math.cos(φ) > cr;
    }
    function clipLine(listener) {
      var point0, c0, v0, v00, clean;
      return {
        lineStart: function() {
          v00 = v0 = false;
          clean = 1;
        },
        point: function(λ, φ) {
          var point1 = [ λ, φ ], point2, v = visible(λ, φ), c = smallRadius ? v ? 0 : code(λ, φ) : v ? code(λ + (λ < 0 ? π : -π), φ) : 0;
          if (!point0 && (v00 = v0 = v)) listener.lineStart();
          if (v !== v0) {
            point2 = intersect(point0, point1);
            if (d3_geo_sphericalEqual(point0, point2) || d3_geo_sphericalEqual(point1, point2)) {
              point1[0] += ε;
              point1[1] += ε;
              v = visible(point1[0], point1[1]);
            }
          }
          if (v !== v0) {
            clean = 0;
            if (v) {
              listener.lineStart();
              point2 = intersect(point1, point0);
              listener.point(point2[0], point2[1]);
            } else {
              point2 = intersect(point0, point1);
              listener.point(point2[0], point2[1]);
              listener.lineEnd();
            }
            point0 = point2;
          } else if (notHemisphere && point0 && smallRadius ^ v) {
            var t;
            if (!(c & c0) && (t = intersect(point1, point0, true))) {
              clean = 0;
              if (smallRadius) {
                listener.lineStart();
                listener.point(t[0][0], t[0][1]);
                listener.point(t[1][0], t[1][1]);
                listener.lineEnd();
              } else {
                listener.point(t[1][0], t[1][1]);
                listener.lineEnd();
                listener.lineStart();
                listener.point(t[0][0], t[0][1]);
              }
            }
          }
          if (v && (!point0 || !d3_geo_sphericalEqual(point0, point1))) {
            listener.point(point1[0], point1[1]);
          }
          point0 = point1, v0 = v, c0 = c;
        },
        lineEnd: function() {
          if (v0) listener.lineEnd();
          point0 = null;
        },
        clean: function() {
          return clean | (v00 && v0) << 1;
        }
      };
    }
    function intersect(a, b, two) {
      var pa = d3_geo_cartesian(a), pb = d3_geo_cartesian(b);
      var n1 = [ 1, 0, 0 ], n2 = d3_geo_cartesianCross(pa, pb), n2n2 = d3_geo_cartesianDot(n2, n2), n1n2 = n2[0], determinant = n2n2 - n1n2 * n1n2;
      if (!determinant) return !two && a;
      var c1 = cr * n2n2 / determinant, c2 = -cr * n1n2 / determinant, n1xn2 = d3_geo_cartesianCross(n1, n2), A = d3_geo_cartesianScale(n1, c1), B = d3_geo_cartesianScale(n2, c2);
      d3_geo_cartesianAdd(A, B);
      var u = n1xn2, w = d3_geo_cartesianDot(A, u), uu = d3_geo_cartesianDot(u, u), t2 = w * w - uu * (d3_geo_cartesianDot(A, A) - 1);
      if (t2 < 0) return;
      var t = Math.sqrt(t2), q = d3_geo_cartesianScale(u, (-w - t) / uu);
      d3_geo_cartesianAdd(q, A);
      q = d3_geo_spherical(q);
      if (!two) return q;
      var λ0 = a[0], λ1 = b[0], φ0 = a[1], φ1 = b[1], z;
      if (λ1 < λ0) z = λ0, λ0 = λ1, λ1 = z;
      var δλ = λ1 - λ0, polar = Math.abs(δλ - π) < ε, meridian = polar || δλ < ε;
      if (!polar && φ1 < φ0) z = φ0, φ0 = φ1, φ1 = z;
      if (meridian ? polar ? φ0 + φ1 > 0 ^ q[1] < (Math.abs(q[0] - λ0) < ε ? φ0 : φ1) : φ0 <= q[1] && q[1] <= φ1 : δλ > π ^ (λ0 <= q[0] && q[0] <= λ1)) {
        var q1 = d3_geo_cartesianScale(u, (-w + t) / uu);
        d3_geo_cartesianAdd(q1, A);
        return [ q, d3_geo_spherical(q1) ];
      }
    }
    function code(λ, φ) {
      var r = smallRadius ? radius : π - radius, code = 0;
      if (λ < -r) code |= 1; else if (λ > r) code |= 2;
      if (φ < -r) code |= 4; else if (φ > r) code |= 8;
      return code;
    }
    function polygonContains(polygon) {
      return d3_geo_pointInPolygon(point, polygon);
    }
  }
  var d3_geo_clipViewMAX = 1e9;
  function d3_geo_clipView(x0, y0, x1, y1) {
    return function(listener) {
      var listener_ = listener, bufferListener = d3_geo_clipBufferListener(), segments, polygon, ring;
      var clip = {
        point: point,
        lineStart: lineStart,
        lineEnd: lineEnd,
        polygonStart: function() {
          listener = bufferListener;
          segments = [];
          polygon = [];
        },
        polygonEnd: function() {
          listener = listener_;
          if ((segments = d3.merge(segments)).length) {
            listener.polygonStart();
            d3_geo_clipPolygon(segments, compare, inside, interpolate, listener);
            listener.polygonEnd();
          } else if (insidePolygon([ x0, y0 ])) {
            listener.polygonStart(), listener.lineStart();
            interpolate(null, null, 1, listener);
            listener.lineEnd(), listener.polygonEnd();
          }
          segments = polygon = ring = null;
        }
      };
      function inside(point) {
        var a = corner(point, -1), i = insidePolygon([ a === 0 || a === 3 ? x0 : x1, a > 1 ? y1 : y0 ]);
        return i;
      }
      function insidePolygon(p) {
        var wn = 0, n = polygon.length, y = p[1];
        for (var i = 0; i < n; ++i) {
          for (var j = 1, v = polygon[i], m = v.length, a = v[0], b; j < m; ++j) {
            b = v[j];
            if (a[1] <= y) {
              if (b[1] > y && isLeft(a, b, p) > 0) ++wn;
            } else {
              if (b[1] <= y && isLeft(a, b, p) < 0) --wn;
            }
            a = b;
          }
        }
        return wn !== 0;
      }
      function isLeft(a, b, c) {
        return (b[0] - a[0]) * (c[1] - a[1]) - (c[0] - a[0]) * (b[1] - a[1]);
      }
      function interpolate(from, to, direction, listener) {
        var a = 0, a1 = 0;
        if (from == null || (a = corner(from, direction)) !== (a1 = corner(to, direction)) || comparePoints(from, to) < 0 ^ direction > 0) {
          do {
            listener.point(a === 0 || a === 3 ? x0 : x1, a > 1 ? y1 : y0);
          } while ((a = (a + direction + 4) % 4) !== a1);
        } else {
          listener.point(to[0], to[1]);
        }
      }
      function visible(x, y) {
        return x0 <= x && x <= x1 && y0 <= y && y <= y1;
      }
      function point(x, y) {
        if (visible(x, y)) listener.point(x, y);
      }
      var x__, y__, v__, x_, y_, v_, first;
      function lineStart() {
        clip.point = linePoint;
        if (polygon) polygon.push(ring = []);
        first = true;
        v_ = false;
        x_ = y_ = NaN;
      }
      function lineEnd() {
        if (segments) {
          linePoint(x__, y__);
          if (v__ && v_) bufferListener.rejoin();
          segments.push(bufferListener.buffer());
        }
        clip.point = point;
        if (v_) listener.lineEnd();
      }
      function linePoint(x, y) {
        x = Math.max(-d3_geo_clipViewMAX, Math.min(d3_geo_clipViewMAX, x));
        y = Math.max(-d3_geo_clipViewMAX, Math.min(d3_geo_clipViewMAX, y));
        var v = visible(x, y);
        if (polygon) ring.push([ x, y ]);
        if (first) {
          x__ = x, y__ = y, v__ = v;
          first = false;
          if (v) {
            listener.lineStart();
            listener.point(x, y);
          }
        } else {
          if (v && v_) listener.point(x, y); else {
            var a = [ x_, y_ ], b = [ x, y ];
            if (clipLine(a, b)) {
              if (!v_) {
                listener.lineStart();
                listener.point(a[0], a[1]);
              }
              listener.point(b[0], b[1]);
              if (!v) listener.lineEnd();
            } else if (v) {
              listener.lineStart();
              listener.point(x, y);
            }
          }
        }
        x_ = x, y_ = y, v_ = v;
      }
      return clip;
    };
    function corner(p, direction) {
      return Math.abs(p[0] - x0) < ε ? direction > 0 ? 0 : 3 : Math.abs(p[0] - x1) < ε ? direction > 0 ? 2 : 1 : Math.abs(p[1] - y0) < ε ? direction > 0 ? 1 : 0 : direction > 0 ? 3 : 2;
    }
    function compare(a, b) {
      return comparePoints(a.point, b.point);
    }
    function comparePoints(a, b) {
      var ca = corner(a, 1), cb = corner(b, 1);
      return ca !== cb ? ca - cb : ca === 0 ? b[1] - a[1] : ca === 1 ? a[0] - b[0] : ca === 2 ? a[1] - b[1] : b[0] - a[0];
    }
    function clipLine(a, b) {
      var dx = b[0] - a[0], dy = b[1] - a[1], t = [ 0, 1 ];
      if (Math.abs(dx) < ε && Math.abs(dy) < ε) return x0 <= a[0] && a[0] <= x1 && y0 <= a[1] && a[1] <= y1;
      if (d3_geo_clipViewT(x0 - a[0], dx, t) && d3_geo_clipViewT(a[0] - x1, -dx, t) && d3_geo_clipViewT(y0 - a[1], dy, t) && d3_geo_clipViewT(a[1] - y1, -dy, t)) {
        if (t[1] < 1) {
          b[0] = a[0] + t[1] * dx;
          b[1] = a[1] + t[1] * dy;
        }
        if (t[0] > 0) {
          a[0] += t[0] * dx;
          a[1] += t[0] * dy;
        }
        return true;
      }
      return false;
    }
  }
  function d3_geo_clipViewT(num, denominator, t) {
    if (Math.abs(denominator) < ε) return num <= 0;
    var u = num / denominator;
    if (denominator > 0) {
      if (u > t[1]) return false;
      if (u > t[0]) t[0] = u;
    } else {
      if (u < t[0]) return false;
      if (u < t[1]) t[1] = u;
    }
    return true;
  }
  function d3_geo_compose(a, b) {
    function compose(x, y) {
      return x = a(x, y), b(x[0], x[1]);
    }
    if (a.invert && b.invert) compose.invert = function(x, y) {
      return x = b.invert(x, y), x && a.invert(x[0], x[1]);
    };
    return compose;
  }
  function d3_geo_conic(projectAt) {
    var φ0 = 0, φ1 = π / 3, m = d3_geo_projectionMutator(projectAt), p = m(φ0, φ1);
    p.parallels = function(_) {
      if (!arguments.length) return [ φ0 / π * 180, φ1 / π * 180 ];
      return m(φ0 = _[0] * π / 180, φ1 = _[1] * π / 180);
    };
    return p;
  }
  function d3_geo_conicEqualArea(φ0, φ1) {
    var sinφ0 = Math.sin(φ0), n = (sinφ0 + Math.sin(φ1)) / 2, C = 1 + sinφ0 * (2 * n - sinφ0), ρ0 = Math.sqrt(C) / n;
    function forward(λ, φ) {
      var ρ = Math.sqrt(C - 2 * n * Math.sin(φ)) / n;
      return [ ρ * Math.sin(λ *= n), ρ0 - ρ * Math.cos(λ) ];
    }
    forward.invert = function(x, y) {
      var ρ0_y = ρ0 - y;
      return [ Math.atan2(x, ρ0_y) / n, d3_asin((C - (x * x + ρ0_y * ρ0_y) * n * n) / (2 * n)) ];
    };
    return forward;
  }
  (d3.geo.conicEqualArea = function() {
    return d3_geo_conic(d3_geo_conicEqualArea);
  }).raw = d3_geo_conicEqualArea;
  d3.geo.albers = function() {
    return d3.geo.conicEqualArea().rotate([ 96, 0 ]).center([ -.6, 38.7 ]).parallels([ 29.5, 45.5 ]).scale(1070);
  };
  d3.geo.albersUsa = function() {
    var lower48 = d3.geo.albers();
    var alaska = d3.geo.conicEqualArea().rotate([ 154, 0 ]).center([ -2, 58.5 ]).parallels([ 55, 65 ]);
    var hawaii = d3.geo.conicEqualArea().rotate([ 157, 0 ]).center([ -3, 19.9 ]).parallels([ 8, 18 ]);
    var point, pointStream = {
      point: function(x, y) {
        point = [ x, y ];
      }
    }, lower48Point, alaskaPoint, hawaiiPoint;
    function albersUsa(coordinates) {
      var x = coordinates[0], y = coordinates[1];
      point = null;
      (lower48Point(x, y), point) || (alaskaPoint(x, y), point) || hawaiiPoint(x, y);
      return point;
    }
    albersUsa.invert = function(coordinates) {
      var k = lower48.scale(), t = lower48.translate(), x = (coordinates[0] - t[0]) / k, y = (coordinates[1] - t[1]) / k;
      return (y >= .12 && y < .234 && x >= -.425 && x < -.214 ? alaska : y >= .166 && y < .234 && x >= -.214 && x < -.115 ? hawaii : lower48).invert(coordinates);
    };
    albersUsa.stream = function(stream) {
      var lower48Stream = lower48.stream(stream), alaskaStream = alaska.stream(stream), hawaiiStream = hawaii.stream(stream);
      return {
        point: function(x, y) {
          lower48Stream.point(x, y);
          alaskaStream.point(x, y);
          hawaiiStream.point(x, y);
        },
        sphere: function() {
          lower48Stream.sphere();
          alaskaStream.sphere();
          hawaiiStream.sphere();
        },
        lineStart: function() {
          lower48Stream.lineStart();
          alaskaStream.lineStart();
          hawaiiStream.lineStart();
        },
        lineEnd: function() {
          lower48Stream.lineEnd();
          alaskaStream.lineEnd();
          hawaiiStream.lineEnd();
        },
        polygonStart: function() {
          lower48Stream.polygonStart();
          alaskaStream.polygonStart();
          hawaiiStream.polygonStart();
        },
        polygonEnd: function() {
          lower48Stream.polygonEnd();
          alaskaStream.polygonEnd();
          hawaiiStream.polygonEnd();
        }
      };
    };
    albersUsa.precision = function(_) {
      if (!arguments.length) return lower48.precision();
      lower48.precision(_);
      alaska.precision(_);
      hawaii.precision(_);
      return albersUsa;
    };
    albersUsa.scale = function(_) {
      if (!arguments.length) return lower48.scale();
      lower48.scale(_);
      alaska.scale(_ * .35);
      hawaii.scale(_);
      return albersUsa.translate(lower48.translate());
    };
    albersUsa.translate = function(_) {
      if (!arguments.length) return lower48.translate();
      var k = lower48.scale(), x = +_[0], y = +_[1];
      lower48Point = lower48.translate(_).clipExtent([ [ x - .455 * k, y - .238 * k ], [ x + .455 * k, y + .238 * k ] ]).stream(pointStream).point;
      alaskaPoint = alaska.translate([ x - .307 * k, y + .201 * k ]).clipExtent([ [ x - .425 * k + ε, y + .12 * k + ε ], [ x - .214 * k - ε, y + .234 * k - ε ] ]).stream(pointStream).point;
      hawaiiPoint = hawaii.translate([ x - .205 * k, y + .212 * k ]).clipExtent([ [ x - .214 * k + ε, y + .166 * k + ε ], [ x - .115 * k - ε, y + .234 * k - ε ] ]).stream(pointStream).point;
      return albersUsa;
    };
    return albersUsa.scale(1070);
  };
  var d3_geo_pathAreaSum, d3_geo_pathAreaPolygon, d3_geo_pathArea = {
    point: d3_noop,
    lineStart: d3_noop,
    lineEnd: d3_noop,
    polygonStart: function() {
      d3_geo_pathAreaPolygon = 0;
      d3_geo_pathArea.lineStart = d3_geo_pathAreaRingStart;
    },
    polygonEnd: function() {
      d3_geo_pathArea.lineStart = d3_geo_pathArea.lineEnd = d3_geo_pathArea.point = d3_noop;
      d3_geo_pathAreaSum += Math.abs(d3_geo_pathAreaPolygon / 2);
    }
  };
  function d3_geo_pathAreaRingStart() {
    var x00, y00, x0, y0;
    d3_geo_pathArea.point = function(x, y) {
      d3_geo_pathArea.point = nextPoint;
      x00 = x0 = x, y00 = y0 = y;
    };
    function nextPoint(x, y) {
      d3_geo_pathAreaPolygon += y0 * x - x0 * y;
      x0 = x, y0 = y;
    }
    d3_geo_pathArea.lineEnd = function() {
      nextPoint(x00, y00);
    };
  }
  var d3_geo_pathBoundsX0, d3_geo_pathBoundsY0, d3_geo_pathBoundsX1, d3_geo_pathBoundsY1;
  var d3_geo_pathBounds = {
    point: d3_geo_pathBoundsPoint,
    lineStart: d3_noop,
    lineEnd: d3_noop,
    polygonStart: d3_noop,
    polygonEnd: d3_noop
  };
  function d3_geo_pathBoundsPoint(x, y) {
    if (x < d3_geo_pathBoundsX0) d3_geo_pathBoundsX0 = x;
    if (x > d3_geo_pathBoundsX1) d3_geo_pathBoundsX1 = x;
    if (y < d3_geo_pathBoundsY0) d3_geo_pathBoundsY0 = y;
    if (y > d3_geo_pathBoundsY1) d3_geo_pathBoundsY1 = y;
  }
  function d3_geo_pathBuffer() {
    var pointCircle = d3_geo_pathBufferCircle(4.5), buffer = [];
    var stream = {
      point: point,
      lineStart: function() {
        stream.point = pointLineStart;
      },
      lineEnd: lineEnd,
      polygonStart: function() {
        stream.lineEnd = lineEndPolygon;
      },
      polygonEnd: function() {
        stream.lineEnd = lineEnd;
        stream.point = point;
      },
      pointRadius: function(_) {
        pointCircle = d3_geo_pathBufferCircle(_);
        return stream;
      },
      result: function() {
        if (buffer.length) {
          var result = buffer.join("");
          buffer = [];
          return result;
        }
      }
    };
    function point(x, y) {
      buffer.push("M", x, ",", y, pointCircle);
    }
    function pointLineStart(x, y) {
      buffer.push("M", x, ",", y);
      stream.point = pointLine;
    }
    function pointLine(x, y) {
      buffer.push("L", x, ",", y);
    }
    function lineEnd() {
      stream.point = point;
    }
    function lineEndPolygon() {
      buffer.push("Z");
    }
    return stream;
  }
  function d3_geo_pathBufferCircle(radius) {
    return "m0," + radius + "a" + radius + "," + radius + " 0 1,1 0," + -2 * radius + "a" + radius + "," + radius + " 0 1,1 0," + 2 * radius + "z";
  }
  var d3_geo_pathCentroid = {
    point: d3_geo_pathCentroidPoint,
    lineStart: d3_geo_pathCentroidLineStart,
    lineEnd: d3_geo_pathCentroidLineEnd,
    polygonStart: function() {
      d3_geo_pathCentroid.lineStart = d3_geo_pathCentroidRingStart;
    },
    polygonEnd: function() {
      d3_geo_pathCentroid.point = d3_geo_pathCentroidPoint;
      d3_geo_pathCentroid.lineStart = d3_geo_pathCentroidLineStart;
      d3_geo_pathCentroid.lineEnd = d3_geo_pathCentroidLineEnd;
    }
  };
  function d3_geo_pathCentroidPoint(x, y) {
    d3_geo_centroidX0 += x;
    d3_geo_centroidY0 += y;
    ++d3_geo_centroidZ0;
  }
  function d3_geo_pathCentroidLineStart() {
    var x0, y0;
    d3_geo_pathCentroid.point = function(x, y) {
      d3_geo_pathCentroid.point = nextPoint;
      d3_geo_pathCentroidPoint(x0 = x, y0 = y);
    };
    function nextPoint(x, y) {
      var dx = x - x0, dy = y - y0, z = Math.sqrt(dx * dx + dy * dy);
      d3_geo_centroidX1 += z * (x0 + x) / 2;
      d3_geo_centroidY1 += z * (y0 + y) / 2;
      d3_geo_centroidZ1 += z;
      d3_geo_pathCentroidPoint(x0 = x, y0 = y);
    }
  }
  function d3_geo_pathCentroidLineEnd() {
    d3_geo_pathCentroid.point = d3_geo_pathCentroidPoint;
  }
  function d3_geo_pathCentroidRingStart() {
    var x00, y00, x0, y0;
    d3_geo_pathCentroid.point = function(x, y) {
      d3_geo_pathCentroid.point = nextPoint;
      d3_geo_pathCentroidPoint(x00 = x0 = x, y00 = y0 = y);
    };
    function nextPoint(x, y) {
      var dx = x - x0, dy = y - y0, z = Math.sqrt(dx * dx + dy * dy);
      d3_geo_centroidX1 += z * (x0 + x) / 2;
      d3_geo_centroidY1 += z * (y0 + y) / 2;
      d3_geo_centroidZ1 += z;
      z = y0 * x - x0 * y;
      d3_geo_centroidX2 += z * (x0 + x);
      d3_geo_centroidY2 += z * (y0 + y);
      d3_geo_centroidZ2 += z * 3;
      d3_geo_pathCentroidPoint(x0 = x, y0 = y);
    }
    d3_geo_pathCentroid.lineEnd = function() {
      nextPoint(x00, y00);
    };
  }
  function d3_geo_pathContext(context) {
    var pointRadius = 4.5;
    var stream = {
      point: point,
      lineStart: function() {
        stream.point = pointLineStart;
      },
      lineEnd: lineEnd,
      polygonStart: function() {
        stream.lineEnd = lineEndPolygon;
      },
      polygonEnd: function() {
        stream.lineEnd = lineEnd;
        stream.point = point;
      },
      pointRadius: function(_) {
        pointRadius = _;
        return stream;
      },
      result: d3_noop
    };
    function point(x, y) {
      context.moveTo(x, y);
      context.arc(x, y, pointRadius, 0, 2 * π);
    }
    function pointLineStart(x, y) {
      context.moveTo(x, y);
      stream.point = pointLine;
    }
    function pointLine(x, y) {
      context.lineTo(x, y);
    }
    function lineEnd() {
      stream.point = point;
    }
    function lineEndPolygon() {
      context.closePath();
    }
    return stream;
  }
  function d3_geo_resample(project) {
    var δ2 = .5, cosMinDistance = Math.cos(30 * d3_radians), maxDepth = 16;
    function resample(stream) {
      var λ00, φ00, x00, y00, a00, b00, c00, λ0, x0, y0, a0, b0, c0;
      var resample = {
        point: point,
        lineStart: lineStart,
        lineEnd: lineEnd,
        polygonStart: function() {
          stream.polygonStart();
          resample.lineStart = ringStart;
        },
        polygonEnd: function() {
          stream.polygonEnd();
          resample.lineStart = lineStart;
        }
      };
      function point(x, y) {
        x = project(x, y);
        stream.point(x[0], x[1]);
      }
      function lineStart() {
        x0 = NaN;
        resample.point = linePoint;
        stream.lineStart();
      }
      function linePoint(λ, φ) {
        var c = d3_geo_cartesian([ λ, φ ]), p = project(λ, φ);
        resampleLineTo(x0, y0, λ0, a0, b0, c0, x0 = p[0], y0 = p[1], λ0 = λ, a0 = c[0], b0 = c[1], c0 = c[2], maxDepth, stream);
        stream.point(x0, y0);
      }
      function lineEnd() {
        resample.point = point;
        stream.lineEnd();
      }
      function ringStart() {
        lineStart();
        resample.point = ringPoint;
        resample.lineEnd = ringEnd;
      }
      function ringPoint(λ, φ) {
        linePoint(λ00 = λ, φ00 = φ), x00 = x0, y00 = y0, a00 = a0, b00 = b0, c00 = c0;
        resample.point = linePoint;
      }
      function ringEnd() {
        resampleLineTo(x0, y0, λ0, a0, b0, c0, x00, y00, λ00, a00, b00, c00, maxDepth, stream);
        resample.lineEnd = lineEnd;
        lineEnd();
      }
      return resample;
    }
    function resampleLineTo(x0, y0, λ0, a0, b0, c0, x1, y1, λ1, a1, b1, c1, depth, stream) {
      var dx = x1 - x0, dy = y1 - y0, d2 = dx * dx + dy * dy;
      if (d2 > 4 * δ2 && depth--) {
        var a = a0 + a1, b = b0 + b1, c = c0 + c1, m = Math.sqrt(a * a + b * b + c * c), φ2 = Math.asin(c /= m), λ2 = Math.abs(Math.abs(c) - 1) < ε ? (λ0 + λ1) / 2 : Math.atan2(b, a), p = project(λ2, φ2), x2 = p[0], y2 = p[1], dx2 = x2 - x0, dy2 = y2 - y0, dz = dy * dx2 - dx * dy2;
        if (dz * dz / d2 > δ2 || Math.abs((dx * dx2 + dy * dy2) / d2 - .5) > .3 || a0 * a1 + b0 * b1 + c0 * c1 < cosMinDistance) {
          resampleLineTo(x0, y0, λ0, a0, b0, c0, x2, y2, λ2, a /= m, b /= m, c, depth, stream);
          stream.point(x2, y2);
          resampleLineTo(x2, y2, λ2, a, b, c, x1, y1, λ1, a1, b1, c1, depth, stream);
        }
      }
    }
    resample.precision = function(_) {
      if (!arguments.length) return Math.sqrt(δ2);
      maxDepth = (δ2 = _ * _) > 0 && 16;
      return resample;
    };
    return resample;
  }
  d3.geo.path = function() {
    var pointRadius = 4.5, projection, context, projectStream, contextStream, cacheStream;
    function path(object) {
      if (object) {
        if (typeof pointRadius === "function") contextStream.pointRadius(+pointRadius.apply(this, arguments));
        if (!cacheStream || !cacheStream.valid) cacheStream = projectStream(contextStream);
        d3.geo.stream(object, cacheStream);
      }
      return contextStream.result();
    }
    path.area = function(object) {
      d3_geo_pathAreaSum = 0;
      d3.geo.stream(object, projectStream(d3_geo_pathArea));
      return d3_geo_pathAreaSum;
    };
    path.centroid = function(object) {
      d3_geo_centroidX0 = d3_geo_centroidY0 = d3_geo_centroidZ0 = d3_geo_centroidX1 = d3_geo_centroidY1 = d3_geo_centroidZ1 = d3_geo_centroidX2 = d3_geo_centroidY2 = d3_geo_centroidZ2 = 0;
      d3.geo.stream(object, projectStream(d3_geo_pathCentroid));
      return d3_geo_centroidZ2 ? [ d3_geo_centroidX2 / d3_geo_centroidZ2, d3_geo_centroidY2 / d3_geo_centroidZ2 ] : d3_geo_centroidZ1 ? [ d3_geo_centroidX1 / d3_geo_centroidZ1, d3_geo_centroidY1 / d3_geo_centroidZ1 ] : d3_geo_centroidZ0 ? [ d3_geo_centroidX0 / d3_geo_centroidZ0, d3_geo_centroidY0 / d3_geo_centroidZ0 ] : [ NaN, NaN ];
    };
    path.bounds = function(object) {
      d3_geo_pathBoundsX1 = d3_geo_pathBoundsY1 = -(d3_geo_pathBoundsX0 = d3_geo_pathBoundsY0 = Infinity);
      d3.geo.stream(object, projectStream(d3_geo_pathBounds));
      return [ [ d3_geo_pathBoundsX0, d3_geo_pathBoundsY0 ], [ d3_geo_pathBoundsX1, d3_geo_pathBoundsY1 ] ];
    };
    path.projection = function(_) {
      if (!arguments.length) return projection;
      projectStream = (projection = _) ? _.stream || d3_geo_pathProjectStream(_) : d3_identity;
      return reset();
    };
    path.context = function(_) {
      if (!arguments.length) return context;
      contextStream = (context = _) == null ? new d3_geo_pathBuffer() : new d3_geo_pathContext(_);
      if (typeof pointRadius !== "function") contextStream.pointRadius(pointRadius);
      return reset();
    };
    path.pointRadius = function(_) {
      if (!arguments.length) return pointRadius;
      pointRadius = typeof _ === "function" ? _ : (contextStream.pointRadius(+_), +_);
      return path;
    };
    function reset() {
      cacheStream = null;
      return path;
    }
    return path.projection(d3.geo.albersUsa()).context(null);
  };
  function d3_geo_pathProjectStream(project) {
    var resample = d3_geo_resample(function(λ, φ) {
      return project([ λ * d3_degrees, φ * d3_degrees ]);
    });
    return function(stream) {
      stream = resample(stream);
      return {
        point: function(λ, φ) {
          stream.point(λ * d3_radians, φ * d3_radians);
        },
        sphere: function() {
          stream.sphere();
        },
        lineStart: function() {
          stream.lineStart();
        },
        lineEnd: function() {
          stream.lineEnd();
        },
        polygonStart: function() {
          stream.polygonStart();
        },
        polygonEnd: function() {
          stream.polygonEnd();
        }
      };
    };
  }
  d3.geo.projection = d3_geo_projection;
  d3.geo.projectionMutator = d3_geo_projectionMutator;
  function d3_geo_projection(project) {
    return d3_geo_projectionMutator(function() {
      return project;
    })();
  }
  function d3_geo_projectionMutator(projectAt) {
    var project, rotate, projectRotate, projectResample = d3_geo_resample(function(x, y) {
      x = project(x, y);
      return [ x[0] * k + δx, δy - x[1] * k ];
    }), k = 150, x = 480, y = 250, λ = 0, φ = 0, δλ = 0, δφ = 0, δγ = 0, δx, δy, preclip = d3_geo_clipAntimeridian, postclip = d3_identity, clipAngle = null, clipExtent = null, stream;
    function projection(point) {
      point = projectRotate(point[0] * d3_radians, point[1] * d3_radians);
      return [ point[0] * k + δx, δy - point[1] * k ];
    }
    function invert(point) {
      point = projectRotate.invert((point[0] - δx) / k, (δy - point[1]) / k);
      return point && [ point[0] * d3_degrees, point[1] * d3_degrees ];
    }
    projection.stream = function(output) {
      if (stream) stream.valid = false;
      stream = d3_geo_projectionRadiansRotate(rotate, preclip(projectResample(postclip(output))));
      stream.valid = true;
      return stream;
    };
    projection.clipAngle = function(_) {
      if (!arguments.length) return clipAngle;
      preclip = _ == null ? (clipAngle = _, d3_geo_clipAntimeridian) : d3_geo_clipCircle((clipAngle = +_) * d3_radians);
      return invalidate();
    };
    projection.clipExtent = function(_) {
      if (!arguments.length) return clipExtent;
      clipExtent = _;
      postclip = _ == null ? d3_identity : d3_geo_clipView(_[0][0], _[0][1], _[1][0], _[1][1]);
      return invalidate();
    };
    projection.scale = function(_) {
      if (!arguments.length) return k;
      k = +_;
      return reset();
    };
    projection.translate = function(_) {
      if (!arguments.length) return [ x, y ];
      x = +_[0];
      y = +_[1];
      return reset();
    };
    projection.center = function(_) {
      if (!arguments.length) return [ λ * d3_degrees, φ * d3_degrees ];
      λ = _[0] % 360 * d3_radians;
      φ = _[1] % 360 * d3_radians;
      return reset();
    };
    projection.rotate = function(_) {
      if (!arguments.length) return [ δλ * d3_degrees, δφ * d3_degrees, δγ * d3_degrees ];
      δλ = _[0] % 360 * d3_radians;
      δφ = _[1] % 360 * d3_radians;
      δγ = _.length > 2 ? _[2] % 360 * d3_radians : 0;
      return reset();
    };
    d3.rebind(projection, projectResample, "precision");
    function reset() {
      projectRotate = d3_geo_compose(rotate = d3_geo_rotation(δλ, δφ, δγ), project);
      var center = project(λ, φ);
      δx = x - center[0] * k;
      δy = y + center[1] * k;
      return invalidate();
    }
    function invalidate() {
      if (stream) {
        stream.valid = false;
        stream = null;
      }
      return projection;
    }
    return function() {
      project = projectAt.apply(this, arguments);
      projection.invert = project.invert && invert;
      return reset();
    };
  }
  function d3_geo_projectionRadiansRotate(rotate, stream) {
    return {
      point: function(x, y) {
        y = rotate(x * d3_radians, y * d3_radians), x = y[0];
        stream.point(x > π ? x - 2 * π : x < -π ? x + 2 * π : x, y[1]);
      },
      sphere: function() {
        stream.sphere();
      },
      lineStart: function() {
        stream.lineStart();
      },
      lineEnd: function() {
        stream.lineEnd();
      },
      polygonStart: function() {
        stream.polygonStart();
      },
      polygonEnd: function() {
        stream.polygonEnd();
      }
    };
  }
  function d3_geo_equirectangular(λ, φ) {
    return [ λ, φ ];
  }
  (d3.geo.equirectangular = function() {
    return d3_geo_projection(d3_geo_equirectangular);
  }).raw = d3_geo_equirectangular.invert = d3_geo_equirectangular;
  d3.geo.rotation = function(rotate) {
    rotate = d3_geo_rotation(rotate[0] % 360 * d3_radians, rotate[1] * d3_radians, rotate.length > 2 ? rotate[2] * d3_radians : 0);
    function forward(coordinates) {
      coordinates = rotate(coordinates[0] * d3_radians, coordinates[1] * d3_radians);
      return coordinates[0] *= d3_degrees, coordinates[1] *= d3_degrees, coordinates;
    }
    forward.invert = function(coordinates) {
      coordinates = rotate.invert(coordinates[0] * d3_radians, coordinates[1] * d3_radians);
      return coordinates[0] *= d3_degrees, coordinates[1] *= d3_degrees, coordinates;
    };
    return forward;
  };
  function d3_geo_rotation(δλ, δφ, δγ) {
    return δλ ? δφ || δγ ? d3_geo_compose(d3_geo_rotationλ(δλ), d3_geo_rotationφγ(δφ, δγ)) : d3_geo_rotationλ(δλ) : δφ || δγ ? d3_geo_rotationφγ(δφ, δγ) : d3_geo_equirectangular;
  }
  function d3_geo_forwardRotationλ(δλ) {
    return function(λ, φ) {
      return λ += δλ, [ λ > π ? λ - 2 * π : λ < -π ? λ + 2 * π : λ, φ ];
    };
  }
  function d3_geo_rotationλ(δλ) {
    var rotation = d3_geo_forwardRotationλ(δλ);
    rotation.invert = d3_geo_forwardRotationλ(-δλ);
    return rotation;
  }
  function d3_geo_rotationφγ(δφ, δγ) {
    var cosδφ = Math.cos(δφ), sinδφ = Math.sin(δφ), cosδγ = Math.cos(δγ), sinδγ = Math.sin(δγ);
    function rotation(λ, φ) {
      var cosφ = Math.cos(φ), x = Math.cos(λ) * cosφ, y = Math.sin(λ) * cosφ, z = Math.sin(φ), k = z * cosδφ + x * sinδφ;
      return [ Math.atan2(y * cosδγ - k * sinδγ, x * cosδφ - z * sinδφ), d3_asin(k * cosδγ + y * sinδγ) ];
    }
    rotation.invert = function(λ, φ) {
      var cosφ = Math.cos(φ), x = Math.cos(λ) * cosφ, y = Math.sin(λ) * cosφ, z = Math.sin(φ), k = z * cosδγ - y * sinδγ;
      return [ Math.atan2(y * cosδγ + z * sinδγ, x * cosδφ + k * sinδφ), d3_asin(k * cosδφ - x * sinδφ) ];
    };
    return rotation;
  }
  d3.geo.circle = function() {
    var origin = [ 0, 0 ], angle, precision = 6, interpolate;
    function circle() {
      var center = typeof origin === "function" ? origin.apply(this, arguments) : origin, rotate = d3_geo_rotation(-center[0] * d3_radians, -center[1] * d3_radians, 0).invert, ring = [];
      interpolate(null, null, 1, {
        point: function(x, y) {
          ring.push(x = rotate(x, y));
          x[0] *= d3_degrees, x[1] *= d3_degrees;
        }
      });
      return {
        type: "Polygon",
        coordinates: [ ring ]
      };
    }
    circle.origin = function(x) {
      if (!arguments.length) return origin;
      origin = x;
      return circle;
    };
    circle.angle = function(x) {
      if (!arguments.length) return angle;
      interpolate = d3_geo_circleInterpolate((angle = +x) * d3_radians, precision * d3_radians);
      return circle;
    };
    circle.precision = function(_) {
      if (!arguments.length) return precision;
      interpolate = d3_geo_circleInterpolate(angle * d3_radians, (precision = +_) * d3_radians);
      return circle;
    };
    return circle.angle(90);
  };
  function d3_geo_circleInterpolate(radius, precision) {
    var cr = Math.cos(radius), sr = Math.sin(radius);
    return function(from, to, direction, listener) {
      if (from != null) {
        from = d3_geo_circleAngle(cr, from);
        to = d3_geo_circleAngle(cr, to);
        if (direction > 0 ? from < to : from > to) from += direction * 2 * π;
      } else {
        from = radius + direction * 2 * π;
        to = radius;
      }
      var point;
      for (var step = direction * precision, t = from; direction > 0 ? t > to : t < to; t -= step) {
        listener.point((point = d3_geo_spherical([ cr, -sr * Math.cos(t), -sr * Math.sin(t) ]))[0], point[1]);
      }
    };
  }
  function d3_geo_circleAngle(cr, point) {
    var a = d3_geo_cartesian(point);
    a[0] -= cr;
    d3_geo_cartesianNormalize(a);
    var angle = d3_acos(-a[1]);
    return ((-a[2] < 0 ? -angle : angle) + 2 * Math.PI - ε) % (2 * Math.PI);
  }
  d3.geo.distance = function(a, b) {
    var Δλ = (b[0] - a[0]) * d3_radians, φ0 = a[1] * d3_radians, φ1 = b[1] * d3_radians, sinΔλ = Math.sin(Δλ), cosΔλ = Math.cos(Δλ), sinφ0 = Math.sin(φ0), cosφ0 = Math.cos(φ0), sinφ1 = Math.sin(φ1), cosφ1 = Math.cos(φ1), t;
    return Math.atan2(Math.sqrt((t = cosφ1 * sinΔλ) * t + (t = cosφ0 * sinφ1 - sinφ0 * cosφ1 * cosΔλ) * t), sinφ0 * sinφ1 + cosφ0 * cosφ1 * cosΔλ);
  };
  d3.geo.graticule = function() {
    var x1, x0, X1, X0, y1, y0, Y1, Y0, dx = 10, dy = dx, DX = 90, DY = 360, x, y, X, Y, precision = 2.5;
    function graticule() {
      return {
        type: "MultiLineString",
        coordinates: lines()
      };
    }
    function lines() {
      return d3.range(Math.ceil(X0 / DX) * DX, X1, DX).map(X).concat(d3.range(Math.ceil(Y0 / DY) * DY, Y1, DY).map(Y)).concat(d3.range(Math.ceil(x0 / dx) * dx, x1, dx).filter(function(x) {
        return Math.abs(x % DX) > ε;
      }).map(x)).concat(d3.range(Math.ceil(y0 / dy) * dy, y1, dy).filter(function(y) {
        return Math.abs(y % DY) > ε;
      }).map(y));
    }
    graticule.lines = function() {
      return lines().map(function(coordinates) {
        return {
          type: "LineString",
          coordinates: coordinates
        };
      });
    };
    graticule.outline = function() {
      return {
        type: "Polygon",
        coordinates: [ X(X0).concat(Y(Y1).slice(1), X(X1).reverse().slice(1), Y(Y0).reverse().slice(1)) ]
      };
    };
    graticule.extent = function(_) {
      if (!arguments.length) return graticule.minorExtent();
      return graticule.majorExtent(_).minorExtent(_);
    };
    graticule.majorExtent = function(_) {
      if (!arguments.length) return [ [ X0, Y0 ], [ X1, Y1 ] ];
      X0 = +_[0][0], X1 = +_[1][0];
      Y0 = +_[0][1], Y1 = +_[1][1];
      if (X0 > X1) _ = X0, X0 = X1, X1 = _;
      if (Y0 > Y1) _ = Y0, Y0 = Y1, Y1 = _;
      return graticule.precision(precision);
    };
    graticule.minorExtent = function(_) {
      if (!arguments.length) return [ [ x0, y0 ], [ x1, y1 ] ];
      x0 = +_[0][0], x1 = +_[1][0];
      y0 = +_[0][1], y1 = +_[1][1];
      if (x0 > x1) _ = x0, x0 = x1, x1 = _;
      if (y0 > y1) _ = y0, y0 = y1, y1 = _;
      return graticule.precision(precision);
    };
    graticule.step = function(_) {
      if (!arguments.length) return graticule.minorStep();
      return graticule.majorStep(_).minorStep(_);
    };
    graticule.majorStep = function(_) {
      if (!arguments.length) return [ DX, DY ];
      DX = +_[0], DY = +_[1];
      return graticule;
    };
    graticule.minorStep = function(_) {
      if (!arguments.length) return [ dx, dy ];
      dx = +_[0], dy = +_[1];
      return graticule;
    };
    graticule.precision = function(_) {
      if (!arguments.length) return precision;
      precision = +_;
      x = d3_geo_graticuleX(y0, y1, 90);
      y = d3_geo_graticuleY(x0, x1, precision);
      X = d3_geo_graticuleX(Y0, Y1, 90);
      Y = d3_geo_graticuleY(X0, X1, precision);
      return graticule;
    };
    return graticule.majorExtent([ [ -180, -90 + ε ], [ 180, 90 - ε ] ]).minorExtent([ [ -180, -80 - ε ], [ 180, 80 + ε ] ]);
  };
  function d3_geo_graticuleX(y0, y1, dy) {
    var y = d3.range(y0, y1 - ε, dy).concat(y1);
    return function(x) {
      return y.map(function(y) {
        return [ x, y ];
      });
    };
  }
  function d3_geo_graticuleY(x0, x1, dx) {
    var x = d3.range(x0, x1 - ε, dx).concat(x1);
    return function(y) {
      return x.map(function(x) {
        return [ x, y ];
      });
    };
  }
  function d3_source(d) {
    return d.source;
  }
  function d3_target(d) {
    return d.target;
  }
  d3.geo.greatArc = function() {
    var source = d3_source, source_, target = d3_target, target_;
    function greatArc() {
      return {
        type: "LineString",
        coordinates: [ source_ || source.apply(this, arguments), target_ || target.apply(this, arguments) ]
      };
    }
    greatArc.distance = function() {
      return d3.geo.distance(source_ || source.apply(this, arguments), target_ || target.apply(this, arguments));
    };
    greatArc.source = function(_) {
      if (!arguments.length) return source;
      source = _, source_ = typeof _ === "function" ? null : _;
      return greatArc;
    };
    greatArc.target = function(_) {
      if (!arguments.length) return target;
      target = _, target_ = typeof _ === "function" ? null : _;
      return greatArc;
    };
    greatArc.precision = function() {
      return arguments.length ? greatArc : 0;
    };
    return greatArc;
  };
  d3.geo.interpolate = function(source, target) {
    return d3_geo_interpolate(source[0] * d3_radians, source[1] * d3_radians, target[0] * d3_radians, target[1] * d3_radians);
  };
  function d3_geo_interpolate(x0, y0, x1, y1) {
    var cy0 = Math.cos(y0), sy0 = Math.sin(y0), cy1 = Math.cos(y1), sy1 = Math.sin(y1), kx0 = cy0 * Math.cos(x0), ky0 = cy0 * Math.sin(x0), kx1 = cy1 * Math.cos(x1), ky1 = cy1 * Math.sin(x1), d = 2 * Math.asin(Math.sqrt(d3_haversin(y1 - y0) + cy0 * cy1 * d3_haversin(x1 - x0))), k = 1 / Math.sin(d);
    var interpolate = d ? function(t) {
      var B = Math.sin(t *= d) * k, A = Math.sin(d - t) * k, x = A * kx0 + B * kx1, y = A * ky0 + B * ky1, z = A * sy0 + B * sy1;
      return [ Math.atan2(y, x) * d3_degrees, Math.atan2(z, Math.sqrt(x * x + y * y)) * d3_degrees ];
    } : function() {
      return [ x0 * d3_degrees, y0 * d3_degrees ];
    };
    interpolate.distance = d;
    return interpolate;
  }
  d3.geo.length = function(object) {
    d3_geo_lengthSum = 0;
    d3.geo.stream(object, d3_geo_length);
    return d3_geo_lengthSum;
  };
  var d3_geo_lengthSum;
  var d3_geo_length = {
    sphere: d3_noop,
    point: d3_noop,
    lineStart: d3_geo_lengthLineStart,
    lineEnd: d3_noop,
    polygonStart: d3_noop,
    polygonEnd: d3_noop
  };
  function d3_geo_lengthLineStart() {
    var λ0, sinφ0, cosφ0;
    d3_geo_length.point = function(λ, φ) {
      λ0 = λ * d3_radians, sinφ0 = Math.sin(φ *= d3_radians), cosφ0 = Math.cos(φ);
      d3_geo_length.point = nextPoint;
    };
    d3_geo_length.lineEnd = function() {
      d3_geo_length.point = d3_geo_length.lineEnd = d3_noop;
    };
    function nextPoint(λ, φ) {
      var sinφ = Math.sin(φ *= d3_radians), cosφ = Math.cos(φ), t = Math.abs((λ *= d3_radians) - λ0), cosΔλ = Math.cos(t);
      d3_geo_lengthSum += Math.atan2(Math.sqrt((t = cosφ * Math.sin(t)) * t + (t = cosφ0 * sinφ - sinφ0 * cosφ * cosΔλ) * t), sinφ0 * sinφ + cosφ0 * cosφ * cosΔλ);
      λ0 = λ, sinφ0 = sinφ, cosφ0 = cosφ;
    }
  }
  function d3_geo_azimuthal(scale, angle) {
    function azimuthal(λ, φ) {
      var cosλ = Math.cos(λ), cosφ = Math.cos(φ), k = scale(cosλ * cosφ);
      return [ k * cosφ * Math.sin(λ), k * Math.sin(φ) ];
    }
    azimuthal.invert = function(x, y) {
      var ρ = Math.sqrt(x * x + y * y), c = angle(ρ), sinc = Math.sin(c), cosc = Math.cos(c);
      return [ Math.atan2(x * sinc, ρ * cosc), Math.asin(ρ && y * sinc / ρ) ];
    };
    return azimuthal;
  }
  var d3_geo_azimuthalEqualArea = d3_geo_azimuthal(function(cosλcosφ) {
    return Math.sqrt(2 / (1 + cosλcosφ));
  }, function(ρ) {
    return 2 * Math.asin(ρ / 2);
  });
  (d3.geo.azimuthalEqualArea = function() {
    return d3_geo_projection(d3_geo_azimuthalEqualArea);
  }).raw = d3_geo_azimuthalEqualArea;
  var d3_geo_azimuthalEquidistant = d3_geo_azimuthal(function(cosλcosφ) {
    var c = Math.acos(cosλcosφ);
    return c && c / Math.sin(c);
  }, d3_identity);
  (d3.geo.azimuthalEquidistant = function() {
    return d3_geo_projection(d3_geo_azimuthalEquidistant);
  }).raw = d3_geo_azimuthalEquidistant;
  function d3_geo_conicConformal(φ0, φ1) {
    var cosφ0 = Math.cos(φ0), t = function(φ) {
      return Math.tan(π / 4 + φ / 2);
    }, n = φ0 === φ1 ? Math.sin(φ0) : Math.log(cosφ0 / Math.cos(φ1)) / Math.log(t(φ1) / t(φ0)), F = cosφ0 * Math.pow(t(φ0), n) / n;
    if (!n) return d3_geo_mercator;
    function forward(λ, φ) {
      var ρ = Math.abs(Math.abs(φ) - π / 2) < ε ? 0 : F / Math.pow(t(φ), n);
      return [ ρ * Math.sin(n * λ), F - ρ * Math.cos(n * λ) ];
    }
    forward.invert = function(x, y) {
      var ρ0_y = F - y, ρ = d3_sgn(n) * Math.sqrt(x * x + ρ0_y * ρ0_y);
      return [ Math.atan2(x, ρ0_y) / n, 2 * Math.atan(Math.pow(F / ρ, 1 / n)) - π / 2 ];
    };
    return forward;
  }
  (d3.geo.conicConformal = function() {
    return d3_geo_conic(d3_geo_conicConformal);
  }).raw = d3_geo_conicConformal;
  function d3_geo_conicEquidistant(φ0, φ1) {
    var cosφ0 = Math.cos(φ0), n = φ0 === φ1 ? Math.sin(φ0) : (cosφ0 - Math.cos(φ1)) / (φ1 - φ0), G = cosφ0 / n + φ0;
    if (Math.abs(n) < ε) return d3_geo_equirectangular;
    function forward(λ, φ) {
      var ρ = G - φ;
      return [ ρ * Math.sin(n * λ), G - ρ * Math.cos(n * λ) ];
    }
    forward.invert = function(x, y) {
      var ρ0_y = G - y;
      return [ Math.atan2(x, ρ0_y) / n, G - d3_sgn(n) * Math.sqrt(x * x + ρ0_y * ρ0_y) ];
    };
    return forward;
  }
  (d3.geo.conicEquidistant = function() {
    return d3_geo_conic(d3_geo_conicEquidistant);
  }).raw = d3_geo_conicEquidistant;
  var d3_geo_gnomonic = d3_geo_azimuthal(function(cosλcosφ) {
    return 1 / cosλcosφ;
  }, Math.atan);
  (d3.geo.gnomonic = function() {
    return d3_geo_projection(d3_geo_gnomonic);
  }).raw = d3_geo_gnomonic;
  function d3_geo_mercator(λ, φ) {
    return [ λ, Math.log(Math.tan(π / 4 + φ / 2)) ];
  }
  d3_geo_mercator.invert = function(x, y) {
    return [ x, 2 * Math.atan(Math.exp(y)) - π / 2 ];
  };
  function d3_geo_mercatorProjection(project) {
    var m = d3_geo_projection(project), scale = m.scale, translate = m.translate, clipExtent = m.clipExtent, clipAuto;
    m.scale = function() {
      var v = scale.apply(m, arguments);
      return v === m ? clipAuto ? m.clipExtent(null) : m : v;
    };
    m.translate = function() {
      var v = translate.apply(m, arguments);
      return v === m ? clipAuto ? m.clipExtent(null) : m : v;
    };
    m.clipExtent = function(_) {
      var v = clipExtent.apply(m, arguments);
      if (v === m) {
        if (clipAuto = _ == null) {
          var k = π * scale(), t = translate();
          clipExtent([ [ t[0] - k, t[1] - k ], [ t[0] + k, t[1] + k ] ]);
        }
      } else if (clipAuto) {
        v = null;
      }
      return v;
    };
    return m.clipExtent(null);
  }
  (d3.geo.mercator = function() {
    return d3_geo_mercatorProjection(d3_geo_mercator);
  }).raw = d3_geo_mercator;
  var d3_geo_orthographic = d3_geo_azimuthal(function() {
    return 1;
  }, Math.asin);
  (d3.geo.orthographic = function() {
    return d3_geo_projection(d3_geo_orthographic);
  }).raw = d3_geo_orthographic;
  var d3_geo_stereographic = d3_geo_azimuthal(function(cosλcosφ) {
    return 1 / (1 + cosλcosφ);
  }, function(ρ) {
    return 2 * Math.atan(ρ);
  });
  (d3.geo.stereographic = function() {
    return d3_geo_projection(d3_geo_stereographic);
  }).raw = d3_geo_stereographic;
  function d3_geo_transverseMercator(λ, φ) {
    var B = Math.cos(φ) * Math.sin(λ);
    return [ Math.log((1 + B) / (1 - B)) / 2, Math.atan2(Math.tan(φ), Math.cos(λ)) ];
  }
  d3_geo_transverseMercator.invert = function(x, y) {
    return [ Math.atan2(d3_sinh(x), Math.cos(y)), d3_asin(Math.sin(y) / d3_cosh(x)) ];
  };
  (d3.geo.transverseMercator = function() {
    return d3_geo_mercatorProjection(d3_geo_transverseMercator);
  }).raw = d3_geo_transverseMercator;
  d3.geom = {};
  d3.svg = {};
  function d3_svg_line(projection) {
    var x = d3_svg_lineX, y = d3_svg_lineY, defined = d3_true, interpolate = d3_svg_lineLinear, interpolateKey = interpolate.key, tension = .7;
    function line(data) {
      var segments = [], points = [], i = -1, n = data.length, d, fx = d3_functor(x), fy = d3_functor(y);
      function segment() {
        segments.push("M", interpolate(projection(points), tension));
      }
      while (++i < n) {
        if (defined.call(this, d = data[i], i)) {
          points.push([ +fx.call(this, d, i), +fy.call(this, d, i) ]);
        } else if (points.length) {
          segment();
          points = [];
        }
      }
      if (points.length) segment();
      return segments.length ? segments.join("") : null;
    }
    line.x = function(_) {
      if (!arguments.length) return x;
      x = _;
      return line;
    };
    line.y = function(_) {
      if (!arguments.length) return y;
      y = _;
      return line;
    };
    line.defined = function(_) {
      if (!arguments.length) return defined;
      defined = _;
      return line;
    };
    line.interpolate = function(_) {
      if (!arguments.length) return interpolateKey;
      if (typeof _ === "function") interpolateKey = interpolate = _; else interpolateKey = (interpolate = d3_svg_lineInterpolators.get(_) || d3_svg_lineLinear).key;
      return line;
    };
    line.tension = function(_) {
      if (!arguments.length) return tension;
      tension = _;
      return line;
    };
    return line;
  }
  d3.svg.line = function() {
    return d3_svg_line(d3_identity);
  };
  function d3_svg_lineX(d) {
    return d[0];
  }
  function d3_svg_lineY(d) {
    return d[1];
  }
  var d3_svg_lineInterpolators = d3.map({
    linear: d3_svg_lineLinear,
    "linear-closed": d3_svg_lineLinearClosed,
    step: d3_svg_lineStep,
    "step-before": d3_svg_lineStepBefore,
    "step-after": d3_svg_lineStepAfter,
    basis: d3_svg_lineBasis,
    "basis-open": d3_svg_lineBasisOpen,
    "basis-closed": d3_svg_lineBasisClosed,
    bundle: d3_svg_lineBundle,
    cardinal: d3_svg_lineCardinal,
    "cardinal-open": d3_svg_lineCardinalOpen,
    "cardinal-closed": d3_svg_lineCardinalClosed,
    monotone: d3_svg_lineMonotone
  });
  d3_svg_lineInterpolators.forEach(function(key, value) {
    value.key = key;
    value.closed = /-closed$/.test(key);
  });
  function d3_svg_lineLinear(points) {
    return points.join("L");
  }
  function d3_svg_lineLinearClosed(points) {
    return d3_svg_lineLinear(points) + "Z";
  }
  function d3_svg_lineStep(points) {
    var i = 0, n = points.length, p = points[0], path = [ p[0], ",", p[1] ];
    while (++i < n) path.push("H", (p[0] + (p = points[i])[0]) / 2, "V", p[1]);
    if (n > 1) path.push("H", p[0]);
    return path.join("");
  }
  function d3_svg_lineStepBefore(points) {
    var i = 0, n = points.length, p = points[0], path = [ p[0], ",", p[1] ];
    while (++i < n) path.push("V", (p = points[i])[1], "H", p[0]);
    return path.join("");
  }
  function d3_svg_lineStepAfter(points) {
    var i = 0, n = points.length, p = points[0], path = [ p[0], ",", p[1] ];
    while (++i < n) path.push("H", (p = points[i])[0], "V", p[1]);
    return path.join("");
  }
  function d3_svg_lineCardinalOpen(points, tension) {
    return points.length < 4 ? d3_svg_lineLinear(points) : points[1] + d3_svg_lineHermite(points.slice(1, points.length - 1), d3_svg_lineCardinalTangents(points, tension));
  }
  function d3_svg_lineCardinalClosed(points, tension) {
    return points.length < 3 ? d3_svg_lineLinear(points) : points[0] + d3_svg_lineHermite((points.push(points[0]), 
    points), d3_svg_lineCardinalTangents([ points[points.length - 2] ].concat(points, [ points[1] ]), tension));
  }
  function d3_svg_lineCardinal(points, tension) {
    return points.length < 3 ? d3_svg_lineLinear(points) : points[0] + d3_svg_lineHermite(points, d3_svg_lineCardinalTangents(points, tension));
  }
  function d3_svg_lineHermite(points, tangents) {
    if (tangents.length < 1 || points.length != tangents.length && points.length != tangents.length + 2) {
      return d3_svg_lineLinear(points);
    }
    var quad = points.length != tangents.length, path = "", p0 = points[0], p = points[1], t0 = tangents[0], t = t0, pi = 1;
    if (quad) {
      path += "Q" + (p[0] - t0[0] * 2 / 3) + "," + (p[1] - t0[1] * 2 / 3) + "," + p[0] + "," + p[1];
      p0 = points[1];
      pi = 2;
    }
    if (tangents.length > 1) {
      t = tangents[1];
      p = points[pi];
      pi++;
      path += "C" + (p0[0] + t0[0]) + "," + (p0[1] + t0[1]) + "," + (p[0] - t[0]) + "," + (p[1] - t[1]) + "," + p[0] + "," + p[1];
      for (var i = 2; i < tangents.length; i++, pi++) {
        p = points[pi];
        t = tangents[i];
        path += "S" + (p[0] - t[0]) + "," + (p[1] - t[1]) + "," + p[0] + "," + p[1];
      }
    }
    if (quad) {
      var lp = points[pi];
      path += "Q" + (p[0] + t[0] * 2 / 3) + "," + (p[1] + t[1] * 2 / 3) + "," + lp[0] + "," + lp[1];
    }
    return path;
  }
  function d3_svg_lineCardinalTangents(points, tension) {
    var tangents = [], a = (1 - tension) / 2, p0, p1 = points[0], p2 = points[1], i = 1, n = points.length;
    while (++i < n) {
      p0 = p1;
      p1 = p2;
      p2 = points[i];
      tangents.push([ a * (p2[0] - p0[0]), a * (p2[1] - p0[1]) ]);
    }
    return tangents;
  }
  function d3_svg_lineBasis(points) {
    if (points.length < 3) return d3_svg_lineLinear(points);
    var i = 1, n = points.length, pi = points[0], x0 = pi[0], y0 = pi[1], px = [ x0, x0, x0, (pi = points[1])[0] ], py = [ y0, y0, y0, pi[1] ], path = [ x0, ",", y0, "L", d3_svg_lineDot4(d3_svg_lineBasisBezier3, px), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier3, py) ];
    points.push(points[n - 1]);
    while (++i <= n) {
      pi = points[i];
      px.shift();
      px.push(pi[0]);
      py.shift();
      py.push(pi[1]);
      d3_svg_lineBasisBezier(path, px, py);
    }
    points.pop();
    path.push("L", pi);
    return path.join("");
  }
  function d3_svg_lineBasisOpen(points) {
    if (points.length < 4) return d3_svg_lineLinear(points);
    var path = [], i = -1, n = points.length, pi, px = [ 0 ], py = [ 0 ];
    while (++i < 3) {
      pi = points[i];
      px.push(pi[0]);
      py.push(pi[1]);
    }
    path.push(d3_svg_lineDot4(d3_svg_lineBasisBezier3, px) + "," + d3_svg_lineDot4(d3_svg_lineBasisBezier3, py));
    --i;
    while (++i < n) {
      pi = points[i];
      px.shift();
      px.push(pi[0]);
      py.shift();
      py.push(pi[1]);
      d3_svg_lineBasisBezier(path, px, py);
    }
    return path.join("");
  }
  function d3_svg_lineBasisClosed(points) {
    var path, i = -1, n = points.length, m = n + 4, pi, px = [], py = [];
    while (++i < 4) {
      pi = points[i % n];
      px.push(pi[0]);
      py.push(pi[1]);
    }
    path = [ d3_svg_lineDot4(d3_svg_lineBasisBezier3, px), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier3, py) ];
    --i;
    while (++i < m) {
      pi = points[i % n];
      px.shift();
      px.push(pi[0]);
      py.shift();
      py.push(pi[1]);
      d3_svg_lineBasisBezier(path, px, py);
    }
    return path.join("");
  }
  function d3_svg_lineBundle(points, tension) {
    var n = points.length - 1;
    if (n) {
      var x0 = points[0][0], y0 = points[0][1], dx = points[n][0] - x0, dy = points[n][1] - y0, i = -1, p, t;
      while (++i <= n) {
        p = points[i];
        t = i / n;
        p[0] = tension * p[0] + (1 - tension) * (x0 + t * dx);
        p[1] = tension * p[1] + (1 - tension) * (y0 + t * dy);
      }
    }
    return d3_svg_lineBasis(points);
  }
  function d3_svg_lineDot4(a, b) {
    return a[0] * b[0] + a[1] * b[1] + a[2] * b[2] + a[3] * b[3];
  }
  var d3_svg_lineBasisBezier1 = [ 0, 2 / 3, 1 / 3, 0 ], d3_svg_lineBasisBezier2 = [ 0, 1 / 3, 2 / 3, 0 ], d3_svg_lineBasisBezier3 = [ 0, 1 / 6, 2 / 3, 1 / 6 ];
  function d3_svg_lineBasisBezier(path, x, y) {
    path.push("C", d3_svg_lineDot4(d3_svg_lineBasisBezier1, x), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier1, y), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier2, x), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier2, y), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier3, x), ",", d3_svg_lineDot4(d3_svg_lineBasisBezier3, y));
  }
  function d3_svg_lineSlope(p0, p1) {
    return (p1[1] - p0[1]) / (p1[0] - p0[0]);
  }
  function d3_svg_lineFiniteDifferences(points) {
    var i = 0, j = points.length - 1, m = [], p0 = points[0], p1 = points[1], d = m[0] = d3_svg_lineSlope(p0, p1);
    while (++i < j) {
      m[i] = (d + (d = d3_svg_lineSlope(p0 = p1, p1 = points[i + 1]))) / 2;
    }
    m[i] = d;
    return m;
  }
  function d3_svg_lineMonotoneTangents(points) {
    var tangents = [], d, a, b, s, m = d3_svg_lineFiniteDifferences(points), i = -1, j = points.length - 1;
    while (++i < j) {
      d = d3_svg_lineSlope(points[i], points[i + 1]);
      if (Math.abs(d) < 1e-6) {
        m[i] = m[i + 1] = 0;
      } else {
        a = m[i] / d;
        b = m[i + 1] / d;
        s = a * a + b * b;
        if (s > 9) {
          s = d * 3 / Math.sqrt(s);
          m[i] = s * a;
          m[i + 1] = s * b;
        }
      }
    }
    i = -1;
    while (++i <= j) {
      s = (points[Math.min(j, i + 1)][0] - points[Math.max(0, i - 1)][0]) / (6 * (1 + m[i] * m[i]));
      tangents.push([ s || 0, m[i] * s || 0 ]);
    }
    return tangents;
  }
  function d3_svg_lineMonotone(points) {
    return points.length < 3 ? d3_svg_lineLinear(points) : points[0] + d3_svg_lineHermite(points, d3_svg_lineMonotoneTangents(points));
  }
  d3.geom.hull = function(vertices) {
    var x = d3_svg_lineX, y = d3_svg_lineY;
    if (arguments.length) return hull(vertices);
    function hull(data) {
      if (data.length < 3) return [];
      var fx = d3_functor(x), fy = d3_functor(y), n = data.length, vertices, plen = n - 1, points = [], stack = [], d, i, j, h = 0, x1, y1, x2, y2, u, v, a, sp;
      if (fx === d3_svg_lineX && y === d3_svg_lineY) vertices = data; else for (i = 0, 
      vertices = []; i < n; ++i) {
        vertices.push([ +fx.call(this, d = data[i], i), +fy.call(this, d, i) ]);
      }
      for (i = 1; i < n; ++i) {
        if (vertices[i][1] < vertices[h][1] || vertices[i][1] == vertices[h][1] && vertices[i][0] < vertices[h][0]) h = i;
      }
      for (i = 0; i < n; ++i) {
        if (i === h) continue;
        y1 = vertices[i][1] - vertices[h][1];
        x1 = vertices[i][0] - vertices[h][0];
        points.push({
          angle: Math.atan2(y1, x1),
          index: i
        });
      }
      points.sort(function(a, b) {
        return a.angle - b.angle;
      });
      a = points[0].angle;
      v = points[0].index;
      u = 0;
      for (i = 1; i < plen; ++i) {
        j = points[i].index;
        if (a == points[i].angle) {
          x1 = vertices[v][0] - vertices[h][0];
          y1 = vertices[v][1] - vertices[h][1];
          x2 = vertices[j][0] - vertices[h][0];
          y2 = vertices[j][1] - vertices[h][1];
          if (x1 * x1 + y1 * y1 >= x2 * x2 + y2 * y2) {
            points[i].index = -1;
            continue;
          } else {
            points[u].index = -1;
          }
        }
        a = points[i].angle;
        u = i;
        v = j;
      }
      stack.push(h);
      for (i = 0, j = 0; i < 2; ++j) {
        if (points[j].index > -1) {
          stack.push(points[j].index);
          i++;
        }
      }
      sp = stack.length;
      for (;j < plen; ++j) {
        if (points[j].index < 0) continue;
        while (!d3_geom_hullCCW(stack[sp - 2], stack[sp - 1], points[j].index, vertices)) {
          --sp;
        }
        stack[sp++] = points[j].index;
      }
      var poly = [];
      for (i = sp - 1; i >= 0; --i) poly.push(data[stack[i]]);
      return poly;
    }
    hull.x = function(_) {
      return arguments.length ? (x = _, hull) : x;
    };
    hull.y = function(_) {
      return arguments.length ? (y = _, hull) : y;
    };
    return hull;
  };
  function d3_geom_hullCCW(i1, i2, i3, v) {
    var t, a, b, c, d, e, f;
    t = v[i1];
    a = t[0];
    b = t[1];
    t = v[i2];
    c = t[0];
    d = t[1];
    t = v[i3];
    e = t[0];
    f = t[1];
    return (f - b) * (c - a) - (d - b) * (e - a) > 0;
  }
  d3.geom.polygon = function(coordinates) {
    d3_subclass(coordinates, d3_geom_polygonPrototype);
    return coordinates;
  };
  var d3_geom_polygonPrototype = d3.geom.polygon.prototype = [];
  d3_geom_polygonPrototype.area = function() {
    var i = -1, n = this.length, a, b = this[n - 1], area = 0;
    while (++i < n) {
      a = b;
      b = this[i];
      area += a[1] * b[0] - a[0] * b[1];
    }
    return area * .5;
  };
  d3_geom_polygonPrototype.centroid = function(k) {
    var i = -1, n = this.length, x = 0, y = 0, a, b = this[n - 1], c;
    if (!arguments.length) k = -1 / (6 * this.area());
    while (++i < n) {
      a = b;
      b = this[i];
      c = a[0] * b[1] - b[0] * a[1];
      x += (a[0] + b[0]) * c;
      y += (a[1] + b[1]) * c;
    }
    return [ x * k, y * k ];
  };
  d3_geom_polygonPrototype.clip = function(subject) {
    var input, closed = d3_geom_polygonClosed(subject), i = -1, n = this.length - d3_geom_polygonClosed(this), j, m, a = this[n - 1], b, c, d;
    while (++i < n) {
      input = subject.slice();
      subject.length = 0;
      b = this[i];
      c = input[(m = input.length - closed) - 1];
      j = -1;
      while (++j < m) {
        d = input[j];
        if (d3_geom_polygonInside(d, a, b)) {
          if (!d3_geom_polygonInside(c, a, b)) {
            subject.push(d3_geom_polygonIntersect(c, d, a, b));
          }
          subject.push(d);
        } else if (d3_geom_polygonInside(c, a, b)) {
          subject.push(d3_geom_polygonIntersect(c, d, a, b));
        }
        c = d;
      }
      if (closed) subject.push(subject[0]);
      a = b;
    }
    return subject;
  };
  function d3_geom_polygonInside(p, a, b) {
    return (b[0] - a[0]) * (p[1] - a[1]) < (b[1] - a[1]) * (p[0] - a[0]);
  }
  function d3_geom_polygonIntersect(c, d, a, b) {
    var x1 = c[0], x3 = a[0], x21 = d[0] - x1, x43 = b[0] - x3, y1 = c[1], y3 = a[1], y21 = d[1] - y1, y43 = b[1] - y3, ua = (x43 * (y1 - y3) - y43 * (x1 - x3)) / (y43 * x21 - x43 * y21);
    return [ x1 + ua * x21, y1 + ua * y21 ];
  }
  function d3_geom_polygonClosed(coordinates) {
    var a = coordinates[0], b = coordinates[coordinates.length - 1];
    return !(a[0] - b[0] || a[1] - b[1]);
  }
  d3.geom.delaunay = function(vertices) {
    var edges = vertices.map(function() {
      return [];
    }), triangles = [];
    d3_geom_voronoiTessellate(vertices, function(e) {
      edges[e.region.l.index].push(vertices[e.region.r.index]);
    });
    edges.forEach(function(edge, i) {
      var v = vertices[i], cx = v[0], cy = v[1];
      edge.forEach(function(v) {
        v.angle = Math.atan2(v[0] - cx, v[1] - cy);
      });
      edge.sort(function(a, b) {
        return a.angle - b.angle;
      });
      for (var j = 0, m = edge.length - 1; j < m; j++) {
        triangles.push([ v, edge[j], edge[j + 1] ]);
      }
    });
    return triangles;
  };
  d3.geom.voronoi = function(points) {
    var x = d3_svg_lineX, y = d3_svg_lineY, clipPolygon = null;
    if (arguments.length) return voronoi(points);
    function voronoi(data) {
      var points, polygons = data.map(function() {
        return [];
      }), fx = d3_functor(x), fy = d3_functor(y), d, i, n = data.length, Z = 1e6;
      if (fx === d3_svg_lineX && fy === d3_svg_lineY) points = data; else for (points = new Array(n), 
      i = 0; i < n; ++i) {
        points[i] = [ +fx.call(this, d = data[i], i), +fy.call(this, d, i) ];
      }
      d3_geom_voronoiTessellate(points, function(e) {
        var s1, s2, x1, x2, y1, y2;
        if (e.a === 1 && e.b >= 0) {
          s1 = e.ep.r;
          s2 = e.ep.l;
        } else {
          s1 = e.ep.l;
          s2 = e.ep.r;
        }
        if (e.a === 1) {
          y1 = s1 ? s1.y : -Z;
          x1 = e.c - e.b * y1;
          y2 = s2 ? s2.y : Z;
          x2 = e.c - e.b * y2;
        } else {
          x1 = s1 ? s1.x : -Z;
          y1 = e.c - e.a * x1;
          x2 = s2 ? s2.x : Z;
          y2 = e.c - e.a * x2;
        }
        var v1 = [ x1, y1 ], v2 = [ x2, y2 ];
        polygons[e.region.l.index].push(v1, v2);
        polygons[e.region.r.index].push(v1, v2);
      });
      polygons = polygons.map(function(polygon, i) {
        var cx = points[i][0], cy = points[i][1], angle = polygon.map(function(v) {
          return Math.atan2(v[0] - cx, v[1] - cy);
        }), order = d3.range(polygon.length).sort(function(a, b) {
          return angle[a] - angle[b];
        });
        return order.filter(function(d, i) {
          return !i || angle[d] - angle[order[i - 1]] > ε;
        }).map(function(d) {
          return polygon[d];
        });
      });
      polygons.forEach(function(polygon, i) {
        var n = polygon.length;
        if (!n) return polygon.push([ -Z, -Z ], [ -Z, Z ], [ Z, Z ], [ Z, -Z ]);
        if (n > 2) return;
        var p0 = points[i], p1 = polygon[0], p2 = polygon[1], x0 = p0[0], y0 = p0[1], x1 = p1[0], y1 = p1[1], x2 = p2[0], y2 = p2[1], dx = Math.abs(x2 - x1), dy = y2 - y1;
        if (Math.abs(dy) < ε) {
          var y = y0 < y1 ? -Z : Z;
          polygon.push([ -Z, y ], [ Z, y ]);
        } else if (dx < ε) {
          var x = x0 < x1 ? -Z : Z;
          polygon.push([ x, -Z ], [ x, Z ]);
        } else {
          var y = (x2 - x1) * (y1 - y0) < (x1 - x0) * (y2 - y1) ? Z : -Z, z = Math.abs(dy) - dx;
          if (Math.abs(z) < ε) {
            polygon.push([ dy < 0 ? y : -y, y ]);
          } else {
            if (z > 0) y *= -1;
            polygon.push([ -Z, y ], [ Z, y ]);
          }
        }
      });
      if (clipPolygon) for (i = 0; i < n; ++i) clipPolygon.clip(polygons[i]);
      for (i = 0; i < n; ++i) polygons[i].point = data[i];
      return polygons;
    }
    voronoi.x = function(_) {
      return arguments.length ? (x = _, voronoi) : x;
    };
    voronoi.y = function(_) {
      return arguments.length ? (y = _, voronoi) : y;
    };
    voronoi.clipExtent = function(_) {
      if (!arguments.length) return clipPolygon && [ clipPolygon[0], clipPolygon[2] ];
      if (_ == null) clipPolygon = null; else {
        var x1 = +_[0][0], y1 = +_[0][1], x2 = +_[1][0], y2 = +_[1][1];
        clipPolygon = d3.geom.polygon([ [ x1, y1 ], [ x1, y2 ], [ x2, y2 ], [ x2, y1 ] ]);
      }
      return voronoi;
    };
    voronoi.size = function(_) {
      if (!arguments.length) return clipPolygon && clipPolygon[2];
      return voronoi.clipExtent(_ && [ [ 0, 0 ], _ ]);
    };
    voronoi.links = function(data) {
      var points, graph = data.map(function() {
        return [];
      }), links = [], fx = d3_functor(x), fy = d3_functor(y), d, i, n = data.length;
      if (fx === d3_svg_lineX && fy === d3_svg_lineY) points = data; else for (points = new Array(n), 
      i = 0; i < n; ++i) {
        points[i] = [ +fx.call(this, d = data[i], i), +fy.call(this, d, i) ];
      }
      d3_geom_voronoiTessellate(points, function(e) {
        var l = e.region.l.index, r = e.region.r.index;
        if (graph[l][r]) return;
        graph[l][r] = graph[r][l] = true;
        links.push({
          source: data[l],
          target: data[r]
        });
      });
      return links;
    };
    voronoi.triangles = function(data) {
      if (x === d3_svg_lineX && y === d3_svg_lineY) return d3.geom.delaunay(data);
      var points = new Array(n), fx = d3_functor(x), fy = d3_functor(y), d, i = -1, n = data.length;
      while (++i < n) {
        (points[i] = [ +fx.call(this, d = data[i], i), +fy.call(this, d, i) ]).data = d;
      }
      return d3.geom.delaunay(points).map(function(triangle) {
        return triangle.map(function(point) {
          return point.data;
        });
      });
    };
    return voronoi;
  };
  var d3_geom_voronoiOpposite = {
    l: "r",
    r: "l"
  };
  function d3_geom_voronoiTessellate(points, callback) {
    var Sites = {
      list: points.map(function(v, i) {
        return {
          index: i,
          x: v[0],
          y: v[1]
        };
      }).sort(function(a, b) {
        return a.y < b.y ? -1 : a.y > b.y ? 1 : a.x < b.x ? -1 : a.x > b.x ? 1 : 0;
      }),
      bottomSite: null
    };
    var EdgeList = {
      list: [],
      leftEnd: null,
      rightEnd: null,
      init: function() {
        EdgeList.leftEnd = EdgeList.createHalfEdge(null, "l");
        EdgeList.rightEnd = EdgeList.createHalfEdge(null, "l");
        EdgeList.leftEnd.r = EdgeList.rightEnd;
        EdgeList.rightEnd.l = EdgeList.leftEnd;
        EdgeList.list.unshift(EdgeList.leftEnd, EdgeList.rightEnd);
      },
      createHalfEdge: function(edge, side) {
        return {
          edge: edge,
          side: side,
          vertex: null,
          l: null,
          r: null
        };
      },
      insert: function(lb, he) {
        he.l = lb;
        he.r = lb.r;
        lb.r.l = he;
        lb.r = he;
      },
      leftBound: function(p) {
        var he = EdgeList.leftEnd;
        do {
          he = he.r;
        } while (he != EdgeList.rightEnd && Geom.rightOf(he, p));
        he = he.l;
        return he;
      },
      del: function(he) {
        he.l.r = he.r;
        he.r.l = he.l;
        he.edge = null;
      },
      right: function(he) {
        return he.r;
      },
      left: function(he) {
        return he.l;
      },
      leftRegion: function(he) {
        return he.edge == null ? Sites.bottomSite : he.edge.region[he.side];
      },
      rightRegion: function(he) {
        return he.edge == null ? Sites.bottomSite : he.edge.region[d3_geom_voronoiOpposite[he.side]];
      }
    };
    var Geom = {
      bisect: function(s1, s2) {
        var newEdge = {
          region: {
            l: s1,
            r: s2
          },
          ep: {
            l: null,
            r: null
          }
        };
        var dx = s2.x - s1.x, dy = s2.y - s1.y, adx = dx > 0 ? dx : -dx, ady = dy > 0 ? dy : -dy;
        newEdge.c = s1.x * dx + s1.y * dy + (dx * dx + dy * dy) * .5;
        if (adx > ady) {
          newEdge.a = 1;
          newEdge.b = dy / dx;
          newEdge.c /= dx;
        } else {
          newEdge.b = 1;
          newEdge.a = dx / dy;
          newEdge.c /= dy;
        }
        return newEdge;
      },
      intersect: function(el1, el2) {
        var e1 = el1.edge, e2 = el2.edge;
        if (!e1 || !e2 || e1.region.r == e2.region.r) {
          return null;
        }
        var d = e1.a * e2.b - e1.b * e2.a;
        if (Math.abs(d) < 1e-10) {
          return null;
        }
        var xint = (e1.c * e2.b - e2.c * e1.b) / d, yint = (e2.c * e1.a - e1.c * e2.a) / d, e1r = e1.region.r, e2r = e2.region.r, el, e;
        if (e1r.y < e2r.y || e1r.y == e2r.y && e1r.x < e2r.x) {
          el = el1;
          e = e1;
        } else {
          el = el2;
          e = e2;
        }
        var rightOfSite = xint >= e.region.r.x;
        if (rightOfSite && el.side === "l" || !rightOfSite && el.side === "r") {
          return null;
        }
        return {
          x: xint,
          y: yint
        };
      },
      rightOf: function(he, p) {
        var e = he.edge, topsite = e.region.r, rightOfSite = p.x > topsite.x;
        if (rightOfSite && he.side === "l") {
          return 1;
        }
        if (!rightOfSite && he.side === "r") {
          return 0;
        }
        if (e.a === 1) {
          var dyp = p.y - topsite.y, dxp = p.x - topsite.x, fast = 0, above = 0;
          if (!rightOfSite && e.b < 0 || rightOfSite && e.b >= 0) {
            above = fast = dyp >= e.b * dxp;
          } else {
            above = p.x + p.y * e.b > e.c;
            if (e.b < 0) {
              above = !above;
            }
            if (!above) {
              fast = 1;
            }
          }
          if (!fast) {
            var dxs = topsite.x - e.region.l.x;
            above = e.b * (dxp * dxp - dyp * dyp) < dxs * dyp * (1 + 2 * dxp / dxs + e.b * e.b);
            if (e.b < 0) {
              above = !above;
            }
          }
        } else {
          var yl = e.c - e.a * p.x, t1 = p.y - yl, t2 = p.x - topsite.x, t3 = yl - topsite.y;
          above = t1 * t1 > t2 * t2 + t3 * t3;
        }
        return he.side === "l" ? above : !above;
      },
      endPoint: function(edge, side, site) {
        edge.ep[side] = site;
        if (!edge.ep[d3_geom_voronoiOpposite[side]]) return;
        callback(edge);
      },
      distance: function(s, t) {
        var dx = s.x - t.x, dy = s.y - t.y;
        return Math.sqrt(dx * dx + dy * dy);
      }
    };
    var EventQueue = {
      list: [],
      insert: function(he, site, offset) {
        he.vertex = site;
        he.ystar = site.y + offset;
        for (var i = 0, list = EventQueue.list, l = list.length; i < l; i++) {
          var next = list[i];
          if (he.ystar > next.ystar || he.ystar == next.ystar && site.x > next.vertex.x) {
            continue;
          } else {
            break;
          }
        }
        list.splice(i, 0, he);
      },
      del: function(he) {
        for (var i = 0, ls = EventQueue.list, l = ls.length; i < l && ls[i] != he; ++i) {}
        ls.splice(i, 1);
      },
      empty: function() {
        return EventQueue.list.length === 0;
      },
      nextEvent: function(he) {
        for (var i = 0, ls = EventQueue.list, l = ls.length; i < l; ++i) {
          if (ls[i] == he) return ls[i + 1];
        }
        return null;
      },
      min: function() {
        var elem = EventQueue.list[0];
        return {
          x: elem.vertex.x,
          y: elem.ystar
        };
      },
      extractMin: function() {
        return EventQueue.list.shift();
      }
    };
    EdgeList.init();
    Sites.bottomSite = Sites.list.shift();
    var newSite = Sites.list.shift(), newIntStar;
    var lbnd, rbnd, llbnd, rrbnd, bisector;
    var bot, top, temp, p, v;
    var e, pm;
    while (true) {
      if (!EventQueue.empty()) {
        newIntStar = EventQueue.min();
      }
      if (newSite && (EventQueue.empty() || newSite.y < newIntStar.y || newSite.y == newIntStar.y && newSite.x < newIntStar.x)) {
        lbnd = EdgeList.leftBound(newSite);
        rbnd = EdgeList.right(lbnd);
        bot = EdgeList.rightRegion(lbnd);
        e = Geom.bisect(bot, newSite);
        bisector = EdgeList.createHalfEdge(e, "l");
        EdgeList.insert(lbnd, bisector);
        p = Geom.intersect(lbnd, bisector);
        if (p) {
          EventQueue.del(lbnd);
          EventQueue.insert(lbnd, p, Geom.distance(p, newSite));
        }
        lbnd = bisector;
        bisector = EdgeList.createHalfEdge(e, "r");
        EdgeList.insert(lbnd, bisector);
        p = Geom.intersect(bisector, rbnd);
        if (p) {
          EventQueue.insert(bisector, p, Geom.distance(p, newSite));
        }
        newSite = Sites.list.shift();
      } else if (!EventQueue.empty()) {
        lbnd = EventQueue.extractMin();
        llbnd = EdgeList.left(lbnd);
        rbnd = EdgeList.right(lbnd);
        rrbnd = EdgeList.right(rbnd);
        bot = EdgeList.leftRegion(lbnd);
        top = EdgeList.rightRegion(rbnd);
        v = lbnd.vertex;
        Geom.endPoint(lbnd.edge, lbnd.side, v);
        Geom.endPoint(rbnd.edge, rbnd.side, v);
        EdgeList.del(lbnd);
        EventQueue.del(rbnd);
        EdgeList.del(rbnd);
        pm = "l";
        if (bot.y > top.y) {
          temp = bot;
          bot = top;
          top = temp;
          pm = "r";
        }
        e = Geom.bisect(bot, top);
        bisector = EdgeList.createHalfEdge(e, pm);
        EdgeList.insert(llbnd, bisector);
        Geom.endPoint(e, d3_geom_voronoiOpposite[pm], v);
        p = Geom.intersect(llbnd, bisector);
        if (p) {
          EventQueue.del(llbnd);
          EventQueue.insert(llbnd, p, Geom.distance(p, bot));
        }
        p = Geom.intersect(bisector, rrbnd);
        if (p) {
          EventQueue.insert(bisector, p, Geom.distance(p, bot));
        }
      } else {
        break;
      }
    }
    for (lbnd = EdgeList.right(EdgeList.leftEnd); lbnd != EdgeList.rightEnd; lbnd = EdgeList.right(lbnd)) {
      callback(lbnd.edge);
    }
  }
  d3.geom.quadtree = function(points, x1, y1, x2, y2) {
    var x = d3_svg_lineX, y = d3_svg_lineY, compat;
    if (compat = arguments.length) {
      x = d3_geom_quadtreeCompatX;
      y = d3_geom_quadtreeCompatY;
      if (compat === 3) {
        y2 = y1;
        x2 = x1;
        y1 = x1 = 0;
      }
      return quadtree(points);
    }
    function quadtree(data) {
      var d, fx = d3_functor(x), fy = d3_functor(y), xs, ys, i, n, x1_, y1_, x2_, y2_;
      if (x1 != null) {
        x1_ = x1, y1_ = y1, x2_ = x2, y2_ = y2;
      } else {
        x2_ = y2_ = -(x1_ = y1_ = Infinity);
        xs = [], ys = [];
        n = data.length;
        if (compat) for (i = 0; i < n; ++i) {
          d = data[i];
          if (d.x < x1_) x1_ = d.x;
          if (d.y < y1_) y1_ = d.y;
          if (d.x > x2_) x2_ = d.x;
          if (d.y > y2_) y2_ = d.y;
          xs.push(d.x);
          ys.push(d.y);
        } else for (i = 0; i < n; ++i) {
          var x_ = +fx(d = data[i], i), y_ = +fy(d, i);
          if (x_ < x1_) x1_ = x_;
          if (y_ < y1_) y1_ = y_;
          if (x_ > x2_) x2_ = x_;
          if (y_ > y2_) y2_ = y_;
          xs.push(x_);
          ys.push(y_);
        }
      }
      var dx = x2_ - x1_, dy = y2_ - y1_;
      if (dx > dy) y2_ = y1_ + dx; else x2_ = x1_ + dy;
      function insert(n, d, x, y, x1, y1, x2, y2) {
        if (isNaN(x) || isNaN(y)) return;
        if (n.leaf) {
          var nx = n.x, ny = n.y;
          if (nx != null) {
            if (Math.abs(nx - x) + Math.abs(ny - y) < .01) {
              insertChild(n, d, x, y, x1, y1, x2, y2);
            } else {
              var nPoint = n.point;
              n.x = n.y = n.point = null;
              insertChild(n, nPoint, nx, ny, x1, y1, x2, y2);
              insertChild(n, d, x, y, x1, y1, x2, y2);
            }
          } else {
            n.x = x, n.y = y, n.point = d;
          }
        } else {
          insertChild(n, d, x, y, x1, y1, x2, y2);
        }
      }
      function insertChild(n, d, x, y, x1, y1, x2, y2) {
        var sx = (x1 + x2) * .5, sy = (y1 + y2) * .5, right = x >= sx, bottom = y >= sy, i = (bottom << 1) + right;
        n.leaf = false;
        n = n.nodes[i] || (n.nodes[i] = d3_geom_quadtreeNode());
        if (right) x1 = sx; else x2 = sx;
        if (bottom) y1 = sy; else y2 = sy;
        insert(n, d, x, y, x1, y1, x2, y2);
      }
      var root = d3_geom_quadtreeNode();
      root.add = function(d) {
        insert(root, d, +fx(d, ++i), +fy(d, i), x1_, y1_, x2_, y2_);
      };
      root.visit = function(f) {
        d3_geom_quadtreeVisit(f, root, x1_, y1_, x2_, y2_);
      };
      i = -1;
      if (x1 == null) {
        while (++i < n) {
          insert(root, data[i], xs[i], ys[i], x1_, y1_, x2_, y2_);
        }
        --i;
      } else data.forEach(root.add);
      xs = ys = data = d = null;
      return root;
    }
    quadtree.x = function(_) {
      return arguments.length ? (x = _, quadtree) : x;
    };
    quadtree.y = function(_) {
      return arguments.length ? (y = _, quadtree) : y;
    };
    quadtree.extent = function(_) {
      if (!arguments.length) return x1 == null ? null : [ [ x1, y1 ], [ x2, y2 ] ];
      if (_ == null) x1 = y1 = x2 = y2 = null; else x1 = +_[0][0], y1 = +_[0][1], x2 = +_[1][0], 
      y2 = +_[1][1];
      return quadtree;
    };
    quadtree.size = function(_) {
      if (!arguments.length) return x1 == null ? null : [ x2 - x1, y2 - y1 ];
      if (_ == null) x1 = y1 = x2 = y2 = null; else x1 = y1 = 0, x2 = +_[0], y2 = +_[1];
      return quadtree;
    };
    return quadtree;
  };
  function d3_geom_quadtreeCompatX(d) {
    return d.x;
  }
  function d3_geom_quadtreeCompatY(d) {
    return d.y;
  }
  function d3_geom_quadtreeNode() {
    return {
      leaf: true,
      nodes: [],
      point: null,
      x: null,
      y: null
    };
  }
  function d3_geom_quadtreeVisit(f, node, x1, y1, x2, y2) {
    if (!f(node, x1, y1, x2, y2)) {
      var sx = (x1 + x2) * .5, sy = (y1 + y2) * .5, children = node.nodes;
      if (children[0]) d3_geom_quadtreeVisit(f, children[0], x1, y1, sx, sy);
      if (children[1]) d3_geom_quadtreeVisit(f, children[1], sx, y1, x2, sy);
      if (children[2]) d3_geom_quadtreeVisit(f, children[2], x1, sy, sx, y2);
      if (children[3]) d3_geom_quadtreeVisit(f, children[3], sx, sy, x2, y2);
    }
  }
  d3.interpolateRgb = d3_interpolateRgb;
  function d3_interpolateRgb(a, b) {
    a = d3.rgb(a);
    b = d3.rgb(b);
    var ar = a.r, ag = a.g, ab = a.b, br = b.r - ar, bg = b.g - ag, bb = b.b - ab;
    return function(t) {
      return "#" + d3_rgb_hex(Math.round(ar + br * t)) + d3_rgb_hex(Math.round(ag + bg * t)) + d3_rgb_hex(Math.round(ab + bb * t));
    };
  }
  d3.interpolateObject = d3_interpolateObject;
  function d3_interpolateObject(a, b) {
    var i = {}, c = {}, k;
    for (k in a) {
      if (k in b) {
        i[k] = d3_interpolate(a[k], b[k]);
      } else {
        c[k] = a[k];
      }
    }
    for (k in b) {
      if (!(k in a)) {
        c[k] = b[k];
      }
    }
    return function(t) {
      for (k in i) c[k] = i[k](t);
      return c;
    };
  }
  d3.interpolateNumber = d3_interpolateNumber;
  function d3_interpolateNumber(a, b) {
    b -= a = +a;
    return function(t) {
      return a + b * t;
    };
  }
  d3.interpolateString = d3_interpolateString;
  function d3_interpolateString(a, b) {
    var m, i, j, s0 = 0, s1 = 0, s = [], q = [], n, o;
    a = a + "", b = b + "";
    d3_interpolate_number.lastIndex = 0;
    for (i = 0; m = d3_interpolate_number.exec(b); ++i) {
      if (m.index) s.push(b.substring(s0, s1 = m.index));
      q.push({
        i: s.length,
        x: m[0]
      });
      s.push(null);
      s0 = d3_interpolate_number.lastIndex;
    }
    if (s0 < b.length) s.push(b.substring(s0));
    for (i = 0, n = q.length; (m = d3_interpolate_number.exec(a)) && i < n; ++i) {
      o = q[i];
      if (o.x == m[0]) {
        if (o.i) {
          if (s[o.i + 1] == null) {
            s[o.i - 1] += o.x;
            s.splice(o.i, 1);
            for (j = i + 1; j < n; ++j) q[j].i--;
          } else {
            s[o.i - 1] += o.x + s[o.i + 1];
            s.splice(o.i, 2);
            for (j = i + 1; j < n; ++j) q[j].i -= 2;
          }
        } else {
          if (s[o.i + 1] == null) {
            s[o.i] = o.x;
          } else {
            s[o.i] = o.x + s[o.i + 1];
            s.splice(o.i + 1, 1);
            for (j = i + 1; j < n; ++j) q[j].i--;
          }
        }
        q.splice(i, 1);
        n--;
        i--;
      } else {
        o.x = d3_interpolateNumber(parseFloat(m[0]), parseFloat(o.x));
      }
    }
    while (i < n) {
      o = q.pop();
      if (s[o.i + 1] == null) {
        s[o.i] = o.x;
      } else {
        s[o.i] = o.x + s[o.i + 1];
        s.splice(o.i + 1, 1);
      }
      n--;
    }
    if (s.length === 1) {
      return s[0] == null ? (o = q[0].x, function(t) {
        return o(t) + "";
      }) : function() {
        return b;
      };
    }
    return function(t) {
      for (i = 0; i < n; ++i) s[(o = q[i]).i] = o.x(t);
      return s.join("");
    };
  }
  var d3_interpolate_number = /[-+]?(?:\d+\.?\d*|\.?\d+)(?:[eE][-+]?\d+)?/g;
  d3.interpolate = d3_interpolate;
  function d3_interpolate(a, b) {
    var i = d3.interpolators.length, f;
    while (--i >= 0 && !(f = d3.interpolators[i](a, b))) ;
    return f;
  }
  d3.interpolators = [ function(a, b) {
    var t = typeof b;
    return (t === "string" ? d3_rgb_names.has(b) || /^(#|rgb\(|hsl\()/.test(b) ? d3_interpolateRgb : d3_interpolateString : b instanceof d3_Color ? d3_interpolateRgb : t === "object" ? Array.isArray(b) ? d3_interpolateArray : d3_interpolateObject : d3_interpolateNumber)(a, b);
  } ];
  d3.interpolateArray = d3_interpolateArray;
  function d3_interpolateArray(a, b) {
    var x = [], c = [], na = a.length, nb = b.length, n0 = Math.min(a.length, b.length), i;
    for (i = 0; i < n0; ++i) x.push(d3_interpolate(a[i], b[i]));
    for (;i < na; ++i) c[i] = a[i];
    for (;i < nb; ++i) c[i] = b[i];
    return function(t) {
      for (i = 0; i < n0; ++i) c[i] = x[i](t);
      return c;
    };
  }
  var d3_ease_default = function() {
    return d3_identity;
  };
  var d3_ease = d3.map({
    linear: d3_ease_default,
    poly: d3_ease_poly,
    quad: function() {
      return d3_ease_quad;
    },
    cubic: function() {
      return d3_ease_cubic;
    },
    sin: function() {
      return d3_ease_sin;
    },
    exp: function() {
      return d3_ease_exp;
    },
    circle: function() {
      return d3_ease_circle;
    },
    elastic: d3_ease_elastic,
    back: d3_ease_back,
    bounce: function() {
      return d3_ease_bounce;
    }
  });
  var d3_ease_mode = d3.map({
    "in": d3_identity,
    out: d3_ease_reverse,
    "in-out": d3_ease_reflect,
    "out-in": function(f) {
      return d3_ease_reflect(d3_ease_reverse(f));
    }
  });
  d3.ease = function(name) {
    var i = name.indexOf("-"), t = i >= 0 ? name.substring(0, i) : name, m = i >= 0 ? name.substring(i + 1) : "in";
    t = d3_ease.get(t) || d3_ease_default;
    m = d3_ease_mode.get(m) || d3_identity;
    return d3_ease_clamp(m(t.apply(null, Array.prototype.slice.call(arguments, 1))));
  };
  function d3_ease_clamp(f) {
    return function(t) {
      return t <= 0 ? 0 : t >= 1 ? 1 : f(t);
    };
  }
  function d3_ease_reverse(f) {
    return function(t) {
      return 1 - f(1 - t);
    };
  }
  function d3_ease_reflect(f) {
    return function(t) {
      return .5 * (t < .5 ? f(2 * t) : 2 - f(2 - 2 * t));
    };
  }
  function d3_ease_quad(t) {
    return t * t;
  }
  function d3_ease_cubic(t) {
    return t * t * t;
  }
  function d3_ease_cubicInOut(t) {
    if (t <= 0) return 0;
    if (t >= 1) return 1;
    var t2 = t * t, t3 = t2 * t;
    return 4 * (t < .5 ? t3 : 3 * (t - t2) + t3 - .75);
  }
  function d3_ease_poly(e) {
    return function(t) {
      return Math.pow(t, e);
    };
  }
  function d3_ease_sin(t) {
    return 1 - Math.cos(t * π / 2);
  }
  function d3_ease_exp(t) {
    return Math.pow(2, 10 * (t - 1));
  }
  function d3_ease_circle(t) {
    return 1 - Math.sqrt(1 - t * t);
  }
  function d3_ease_elastic(a, p) {
    var s;
    if (arguments.length < 2) p = .45;
    if (arguments.length) s = p / (2 * π) * Math.asin(1 / a); else a = 1, s = p / 4;
    return function(t) {
      return 1 + a * Math.pow(2, 10 * -t) * Math.sin((t - s) * 2 * π / p);
    };
  }
  function d3_ease_back(s) {
    if (!s) s = 1.70158;
    return function(t) {
      return t * t * ((s + 1) * t - s);
    };
  }
  function d3_ease_bounce(t) {
    return t < 1 / 2.75 ? 7.5625 * t * t : t < 2 / 2.75 ? 7.5625 * (t -= 1.5 / 2.75) * t + .75 : t < 2.5 / 2.75 ? 7.5625 * (t -= 2.25 / 2.75) * t + .9375 : 7.5625 * (t -= 2.625 / 2.75) * t + .984375;
  }
  d3.interpolateHcl = d3_interpolateHcl;
  function d3_interpolateHcl(a, b) {
    a = d3.hcl(a);
    b = d3.hcl(b);
    var ah = a.h, ac = a.c, al = a.l, bh = b.h - ah, bc = b.c - ac, bl = b.l - al;
    if (isNaN(bc)) bc = 0, ac = isNaN(ac) ? b.c : ac;
    if (isNaN(bh)) bh = 0, ah = isNaN(ah) ? b.h : ah; else if (bh > 180) bh -= 360; else if (bh < -180) bh += 360;
    return function(t) {
      return d3_hcl_lab(ah + bh * t, ac + bc * t, al + bl * t) + "";
    };
  }
  d3.interpolateHsl = d3_interpolateHsl;
  function d3_interpolateHsl(a, b) {
    a = d3.hsl(a);
    b = d3.hsl(b);
    var ah = a.h, as = a.s, al = a.l, bh = b.h - ah, bs = b.s - as, bl = b.l - al;
    if (isNaN(bs)) bs = 0, as = isNaN(as) ? b.s : as;
    if (isNaN(bh)) bh = 0, ah = isNaN(ah) ? b.h : ah; else if (bh > 180) bh -= 360; else if (bh < -180) bh += 360;
    return function(t) {
      return d3_hsl_rgb(ah + bh * t, as + bs * t, al + bl * t) + "";
    };
  }
  d3.interpolateLab = d3_interpolateLab;
  function d3_interpolateLab(a, b) {
    a = d3.lab(a);
    b = d3.lab(b);
    var al = a.l, aa = a.a, ab = a.b, bl = b.l - al, ba = b.a - aa, bb = b.b - ab;
    return function(t) {
      return d3_lab_rgb(al + bl * t, aa + ba * t, ab + bb * t) + "";
    };
  }
  d3.interpolateRound = d3_interpolateRound;
  function d3_interpolateRound(a, b) {
    b -= a;
    return function(t) {
      return Math.round(a + b * t);
    };
  }
  d3.transform = function(string) {
    var g = d3_document.createElementNS(d3.ns.prefix.svg, "g");
    return (d3.transform = function(string) {
      if (string != null) {
        g.setAttribute("transform", string);
        var t = g.transform.baseVal.consolidate();
      }
      return new d3_transform(t ? t.matrix : d3_transformIdentity);
    })(string);
  };
  function d3_transform(m) {
    var r0 = [ m.a, m.b ], r1 = [ m.c, m.d ], kx = d3_transformNormalize(r0), kz = d3_transformDot(r0, r1), ky = d3_transformNormalize(d3_transformCombine(r1, r0, -kz)) || 0;
    if (r0[0] * r1[1] < r1[0] * r0[1]) {
      r0[0] *= -1;
      r0[1] *= -1;
      kx *= -1;
      kz *= -1;
    }
    this.rotate = (kx ? Math.atan2(r0[1], r0[0]) : Math.atan2(-r1[0], r1[1])) * d3_degrees;
    this.translate = [ m.e, m.f ];
    this.scale = [ kx, ky ];
    this.skew = ky ? Math.atan2(kz, ky) * d3_degrees : 0;
  }
  d3_transform.prototype.toString = function() {
    return "translate(" + this.translate + ")rotate(" + this.rotate + ")skewX(" + this.skew + ")scale(" + this.scale + ")";
  };
  function d3_transformDot(a, b) {
    return a[0] * b[0] + a[1] * b[1];
  }
  function d3_transformNormalize(a) {
    var k = Math.sqrt(d3_transformDot(a, a));
    if (k) {
      a[0] /= k;
      a[1] /= k;
    }
    return k;
  }
  function d3_transformCombine(a, b, k) {
    a[0] += k * b[0];
    a[1] += k * b[1];
    return a;
  }
  var d3_transformIdentity = {
    a: 1,
    b: 0,
    c: 0,
    d: 1,
    e: 0,
    f: 0
  };
  d3.interpolateTransform = d3_interpolateTransform;
  function d3_interpolateTransform(a, b) {
    var s = [], q = [], n, A = d3.transform(a), B = d3.transform(b), ta = A.translate, tb = B.translate, ra = A.rotate, rb = B.rotate, wa = A.skew, wb = B.skew, ka = A.scale, kb = B.scale;
    if (ta[0] != tb[0] || ta[1] != tb[1]) {
      s.push("translate(", null, ",", null, ")");
      q.push({
        i: 1,
        x: d3_interpolateNumber(ta[0], tb[0])
      }, {
        i: 3,
        x: d3_interpolateNumber(ta[1], tb[1])
      });
    } else if (tb[0] || tb[1]) {
      s.push("translate(" + tb + ")");
    } else {
      s.push("");
    }
    if (ra != rb) {
      if (ra - rb > 180) rb += 360; else if (rb - ra > 180) ra += 360;
      q.push({
        i: s.push(s.pop() + "rotate(", null, ")") - 2,
        x: d3_interpolateNumber(ra, rb)
      });
    } else if (rb) {
      s.push(s.pop() + "rotate(" + rb + ")");
    }
    if (wa != wb) {
      q.push({
        i: s.push(s.pop() + "skewX(", null, ")") - 2,
        x: d3_interpolateNumber(wa, wb)
      });
    } else if (wb) {
      s.push(s.pop() + "skewX(" + wb + ")");
    }
    if (ka[0] != kb[0] || ka[1] != kb[1]) {
      n = s.push(s.pop() + "scale(", null, ",", null, ")");
      q.push({
        i: n - 4,
        x: d3_interpolateNumber(ka[0], kb[0])
      }, {
        i: n - 2,
        x: d3_interpolateNumber(ka[1], kb[1])
      });
    } else if (kb[0] != 1 || kb[1] != 1) {
      s.push(s.pop() + "scale(" + kb + ")");
    }
    n = q.length;
    return function(t) {
      var i = -1, o;
      while (++i < n) s[(o = q[i]).i] = o.x(t);
      return s.join("");
    };
  }
  function d3_uninterpolateNumber(a, b) {
    b = b - (a = +a) ? 1 / (b - a) : 0;
    return function(x) {
      return (x - a) * b;
    };
  }
  function d3_uninterpolateClamp(a, b) {
    b = b - (a = +a) ? 1 / (b - a) : 0;
    return function(x) {
      return Math.max(0, Math.min(1, (x - a) * b));
    };
  }
  d3.layout = {};
  d3.layout.bundle = function() {
    return function(links) {
      var paths = [], i = -1, n = links.length;
      while (++i < n) paths.push(d3_layout_bundlePath(links[i]));
      return paths;
    };
  };
  function d3_layout_bundlePath(link) {
    var start = link.source, end = link.target, lca = d3_layout_bundleLeastCommonAncestor(start, end), points = [ start ];
    while (start !== lca) {
      start = start.parent;
      points.push(start);
    }
    var k = points.length;
    while (end !== lca) {
      points.splice(k, 0, end);
      end = end.parent;
    }
    return points;
  }
  function d3_layout_bundleAncestors(node) {
    var ancestors = [], parent = node.parent;
    while (parent != null) {
      ancestors.push(node);
      node = parent;
      parent = parent.parent;
    }
    ancestors.push(node);
    return ancestors;
  }
  function d3_layout_bundleLeastCommonAncestor(a, b) {
    if (a === b) return a;
    var aNodes = d3_layout_bundleAncestors(a), bNodes = d3_layout_bundleAncestors(b), aNode = aNodes.pop(), bNode = bNodes.pop(), sharedNode = null;
    while (aNode === bNode) {
      sharedNode = aNode;
      aNode = aNodes.pop();
      bNode = bNodes.pop();
    }
    return sharedNode;
  }
  d3.layout.chord = function() {
    var chord = {}, chords, groups, matrix, n, padding = 0, sortGroups, sortSubgroups, sortChords;
    function relayout() {
      var subgroups = {}, groupSums = [], groupIndex = d3.range(n), subgroupIndex = [], k, x, x0, i, j;
      chords = [];
      groups = [];
      k = 0, i = -1;
      while (++i < n) {
        x = 0, j = -1;
        while (++j < n) {
          x += matrix[i][j];
        }
        groupSums.push(x);
        subgroupIndex.push(d3.range(n));
        k += x;
      }
      if (sortGroups) {
        groupIndex.sort(function(a, b) {
          return sortGroups(groupSums[a], groupSums[b]);
        });
      }
      if (sortSubgroups) {
        subgroupIndex.forEach(function(d, i) {
          d.sort(function(a, b) {
            return sortSubgroups(matrix[i][a], matrix[i][b]);
          });
        });
      }
      k = (2 * π - padding * n) / k;
      x = 0, i = -1;
      while (++i < n) {
        x0 = x, j = -1;
        while (++j < n) {
          var di = groupIndex[i], dj = subgroupIndex[di][j], v = matrix[di][dj], a0 = x, a1 = x += v * k;
          subgroups[di + "-" + dj] = {
            index: di,
            subindex: dj,
            startAngle: a0,
            endAngle: a1,
            value: v
          };
        }
        groups[di] = {
          index: di,
          startAngle: x0,
          endAngle: x,
          value: (x - x0) / k
        };
        x += padding;
      }
      i = -1;
      while (++i < n) {
        j = i - 1;
        while (++j < n) {
          var source = subgroups[i + "-" + j], target = subgroups[j + "-" + i];
          if (source.value || target.value) {
            chords.push(source.value < target.value ? {
              source: target,
              target: source
            } : {
              source: source,
              target: target
            });
          }
        }
      }
      if (sortChords) resort();
    }
    function resort() {
      chords.sort(function(a, b) {
        return sortChords((a.source.value + a.target.value) / 2, (b.source.value + b.target.value) / 2);
      });
    }
    chord.matrix = function(x) {
      if (!arguments.length) return matrix;
      n = (matrix = x) && matrix.length;
      chords = groups = null;
      return chord;
    };
    chord.padding = function(x) {
      if (!arguments.length) return padding;
      padding = x;
      chords = groups = null;
      return chord;
    };
    chord.sortGroups = function(x) {
      if (!arguments.length) return sortGroups;
      sortGroups = x;
      chords = groups = null;
      return chord;
    };
    chord.sortSubgroups = function(x) {
      if (!arguments.length) return sortSubgroups;
      sortSubgroups = x;
      chords = null;
      return chord;
    };
    chord.sortChords = function(x) {
      if (!arguments.length) return sortChords;
      sortChords = x;
      if (chords) resort();
      return chord;
    };
    chord.chords = function() {
      if (!chords) relayout();
      return chords;
    };
    chord.groups = function() {
      if (!groups) relayout();
      return groups;
    };
    return chord;
  };
  d3.layout.force = function() {
    var force = {}, event = d3.dispatch("start", "tick", "end"), size = [ 1, 1 ], drag, alpha, friction = .9, linkDistance = d3_layout_forceLinkDistance, linkStrength = d3_layout_forceLinkStrength, charge = -30, gravity = .1, theta = .8, nodes = [], links = [], distances, strengths, charges;
    function repulse(node) {
      return function(quad, x1, _, x2) {
        if (quad.point !== node) {
          var dx = quad.cx - node.x, dy = quad.cy - node.y, dn = 1 / Math.sqrt(dx * dx + dy * dy);
          if ((x2 - x1) * dn < theta) {
            var k = quad.charge * dn * dn;
            node.px -= dx * k;
            node.py -= dy * k;
            return true;
          }
          if (quad.point && isFinite(dn)) {
            var k = quad.pointCharge * dn * dn;
            node.px -= dx * k;
            node.py -= dy * k;
          }
        }
        return !quad.charge;
      };
    }
    force.tick = function() {
      if ((alpha *= .99) < .005) {
        event.end({
          type: "end",
          alpha: alpha = 0
        });
        return true;
      }
      var n = nodes.length, m = links.length, q, i, o, s, t, l, k, x, y;
      for (i = 0; i < m; ++i) {
        o = links[i];
        s = o.source;
        t = o.target;
        x = t.x - s.x;
        y = t.y - s.y;
        if (l = x * x + y * y) {
          l = alpha * strengths[i] * ((l = Math.sqrt(l)) - distances[i]) / l;
          x *= l;
          y *= l;
          t.x -= x * (k = s.weight / (t.weight + s.weight));
          t.y -= y * k;
          s.x += x * (k = 1 - k);
          s.y += y * k;
        }
      }
      if (k = alpha * gravity) {
        x = size[0] / 2;
        y = size[1] / 2;
        i = -1;
        if (k) while (++i < n) {
          o = nodes[i];
          o.x += (x - o.x) * k;
          o.y += (y - o.y) * k;
        }
      }
      if (charge) {
        d3_layout_forceAccumulate(q = d3.geom.quadtree(nodes), alpha, charges);
        i = -1;
        while (++i < n) {
          if (!(o = nodes[i]).fixed) {
            q.visit(repulse(o));
          }
        }
      }
      i = -1;
      while (++i < n) {
        o = nodes[i];
        if (o.fixed) {
          o.x = o.px;
          o.y = o.py;
        } else {
          o.x -= (o.px - (o.px = o.x)) * friction;
          o.y -= (o.py - (o.py = o.y)) * friction;
        }
      }
      event.tick({
        type: "tick",
        alpha: alpha
      });
    };
    force.nodes = function(x) {
      if (!arguments.length) return nodes;
      nodes = x;
      return force;
    };
    force.links = function(x) {
      if (!arguments.length) return links;
      links = x;
      return force;
    };
    force.size = function(x) {
      if (!arguments.length) return size;
      size = x;
      return force;
    };
    force.linkDistance = function(x) {
      if (!arguments.length) return linkDistance;
      linkDistance = typeof x === "function" ? x : +x;
      return force;
    };
    force.distance = force.linkDistance;
    force.linkStrength = function(x) {
      if (!arguments.length) return linkStrength;
      linkStrength = typeof x === "function" ? x : +x;
      return force;
    };
    force.friction = function(x) {
      if (!arguments.length) return friction;
      friction = +x;
      return force;
    };
    force.charge = function(x) {
      if (!arguments.length) return charge;
      charge = typeof x === "function" ? x : +x;
      return force;
    };
    force.gravity = function(x) {
      if (!arguments.length) return gravity;
      gravity = +x;
      return force;
    };
    force.theta = function(x) {
      if (!arguments.length) return theta;
      theta = +x;
      return force;
    };
    force.alpha = function(x) {
      if (!arguments.length) return alpha;
      x = +x;
      if (alpha) {
        if (x > 0) alpha = x; else alpha = 0;
      } else if (x > 0) {
        event.start({
          type: "start",
          alpha: alpha = x
        });
        d3.timer(force.tick);
      }
      return force;
    };
    force.start = function() {
      var i, j, n = nodes.length, m = links.length, w = size[0], h = size[1], neighbors, o;
      for (i = 0; i < n; ++i) {
        (o = nodes[i]).index = i;
        o.weight = 0;
      }
      for (i = 0; i < m; ++i) {
        o = links[i];
        if (typeof o.source == "number") o.source = nodes[o.source];
        if (typeof o.target == "number") o.target = nodes[o.target];
        ++o.source.weight;
        ++o.target.weight;
      }
      for (i = 0; i < n; ++i) {
        o = nodes[i];
        if (isNaN(o.x)) o.x = position("x", w);
        if (isNaN(o.y)) o.y = position("y", h);
        if (isNaN(o.px)) o.px = o.x;
        if (isNaN(o.py)) o.py = o.y;
      }
      distances = [];
      if (typeof linkDistance === "function") for (i = 0; i < m; ++i) distances[i] = +linkDistance.call(this, links[i], i); else for (i = 0; i < m; ++i) distances[i] = linkDistance;
      strengths = [];
      if (typeof linkStrength === "function") for (i = 0; i < m; ++i) strengths[i] = +linkStrength.call(this, links[i], i); else for (i = 0; i < m; ++i) strengths[i] = linkStrength;
      charges = [];
      if (typeof charge === "function") for (i = 0; i < n; ++i) charges[i] = +charge.call(this, nodes[i], i); else for (i = 0; i < n; ++i) charges[i] = charge;
      function position(dimension, size) {
        var neighbors = neighbor(i), j = -1, m = neighbors.length, x;
        while (++j < m) if (!isNaN(x = neighbors[j][dimension])) return x;
        return Math.random() * size;
      }
      function neighbor() {
        if (!neighbors) {
          neighbors = [];
          for (j = 0; j < n; ++j) {
            neighbors[j] = [];
          }
          for (j = 0; j < m; ++j) {
            var o = links[j];
            neighbors[o.source.index].push(o.target);
            neighbors[o.target.index].push(o.source);
          }
        }
        return neighbors[i];
      }
      return force.resume();
    };
    force.resume = function() {
      return force.alpha(.1);
    };
    force.stop = function() {
      return force.alpha(0);
    };
    force.drag = function() {
      if (!drag) drag = d3.behavior.drag().origin(d3_identity).on("dragstart.force", d3_layout_forceDragstart).on("drag.force", dragmove).on("dragend.force", d3_layout_forceDragend);
      if (!arguments.length) return drag;
      this.on("mouseover.force", d3_layout_forceMouseover).on("mouseout.force", d3_layout_forceMouseout).call(drag);
    };
    function dragmove(d) {
      d.px = d3.event.x, d.py = d3.event.y;
      force.resume();
    }
    return d3.rebind(force, event, "on");
  };
  function d3_layout_forceDragstart(d) {
    d.fixed |= 2;
  }
  function d3_layout_forceDragend(d) {
    d.fixed &= ~6;
  }
  function d3_layout_forceMouseover(d) {
    d.fixed |= 4;
    d.px = d.x, d.py = d.y;
  }
  function d3_layout_forceMouseout(d) {
    d.fixed &= ~4;
  }
  function d3_layout_forceAccumulate(quad, alpha, charges) {
    var cx = 0, cy = 0;
    quad.charge = 0;
    if (!quad.leaf) {
      var nodes = quad.nodes, n = nodes.length, i = -1, c;
      while (++i < n) {
        c = nodes[i];
        if (c == null) continue;
        d3_layout_forceAccumulate(c, alpha, charges);
        quad.charge += c.charge;
        cx += c.charge * c.cx;
        cy += c.charge * c.cy;
      }
    }
    if (quad.point) {
      if (!quad.leaf) {
        quad.point.x += Math.random() - .5;
        quad.point.y += Math.random() - .5;
      }
      var k = alpha * charges[quad.point.index];
      quad.charge += quad.pointCharge = k;
      cx += k * quad.point.x;
      cy += k * quad.point.y;
    }
    quad.cx = cx / quad.charge;
    quad.cy = cy / quad.charge;
  }
  var d3_layout_forceLinkDistance = 20, d3_layout_forceLinkStrength = 1;
  d3.layout.hierarchy = function() {
    var sort = d3_layout_hierarchySort, children = d3_layout_hierarchyChildren, value = d3_layout_hierarchyValue;
    function recurse(node, depth, nodes) {
      var childs = children.call(hierarchy, node, depth);
      node.depth = depth;
      nodes.push(node);
      if (childs && (n = childs.length)) {
        var i = -1, n, c = node.children = [], v = 0, j = depth + 1, d;
        while (++i < n) {
          d = recurse(childs[i], j, nodes);
          d.parent = node;
          c.push(d);
          v += d.value;
        }
        if (sort) c.sort(sort);
        if (value) node.value = v;
      } else if (value) {
        node.value = +value.call(hierarchy, node, depth) || 0;
      }
      return node;
    }
    function revalue(node, depth) {
      var children = node.children, v = 0;
      if (children && (n = children.length)) {
        var i = -1, n, j = depth + 1;
        while (++i < n) v += revalue(children[i], j);
      } else if (value) {
        v = +value.call(hierarchy, node, depth) || 0;
      }
      if (value) node.value = v;
      return v;
    }
    function hierarchy(d) {
      var nodes = [];
      recurse(d, 0, nodes);
      return nodes;
    }
    hierarchy.sort = function(x) {
      if (!arguments.length) return sort;
      sort = x;
      return hierarchy;
    };
    hierarchy.children = function(x) {
      if (!arguments.length) return children;
      children = x;
      return hierarchy;
    };
    hierarchy.value = function(x) {
      if (!arguments.length) return value;
      value = x;
      return hierarchy;
    };
    hierarchy.revalue = function(root) {
      revalue(root, 0);
      return root;
    };
    return hierarchy;
  };
  function d3_layout_hierarchyRebind(object, hierarchy) {
    d3.rebind(object, hierarchy, "sort", "children", "value");
    object.nodes = object;
    object.links = d3_layout_hierarchyLinks;
    return object;
  }
  function d3_layout_hierarchyChildren(d) {
    return d.children;
  }
  function d3_layout_hierarchyValue(d) {
    return d.value;
  }
  function d3_layout_hierarchySort(a, b) {
    return b.value - a.value;
  }
  function d3_layout_hierarchyLinks(nodes) {
    return d3.merge(nodes.map(function(parent) {
      return (parent.children || []).map(function(child) {
        return {
          source: parent,
          target: child
        };
      });
    }));
  }
  d3.layout.partition = function() {
    var hierarchy = d3.layout.hierarchy(), size = [ 1, 1 ];
    function position(node, x, dx, dy) {
      var children = node.children;
      node.x = x;
      node.y = node.depth * dy;
      node.dx = dx;
      node.dy = dy;
      if (children && (n = children.length)) {
        var i = -1, n, c, d;
        dx = node.value ? dx / node.value : 0;
        while (++i < n) {
          position(c = children[i], x, d = c.value * dx, dy);
          x += d;
        }
      }
    }
    function depth(node) {
      var children = node.children, d = 0;
      if (children && (n = children.length)) {
        var i = -1, n;
        while (++i < n) d = Math.max(d, depth(children[i]));
      }
      return 1 + d;
    }
    function partition(d, i) {
      var nodes = hierarchy.call(this, d, i);
      position(nodes[0], 0, size[0], size[1] / depth(nodes[0]));
      return nodes;
    }
    partition.size = function(x) {
      if (!arguments.length) return size;
      size = x;
      return partition;
    };
    return d3_layout_hierarchyRebind(partition, hierarchy);
  };
  d3.layout.pie = function() {
    var value = Number, sort = d3_layout_pieSortByValue, startAngle = 0, endAngle = 2 * π;
    function pie(data) {
      var values = data.map(function(d, i) {
        return +value.call(pie, d, i);
      });
      var a = +(typeof startAngle === "function" ? startAngle.apply(this, arguments) : startAngle);
      var k = ((typeof endAngle === "function" ? endAngle.apply(this, arguments) : endAngle) - a) / d3.sum(values);
      var index = d3.range(data.length);
      if (sort != null) index.sort(sort === d3_layout_pieSortByValue ? function(i, j) {
        return values[j] - values[i];
      } : function(i, j) {
        return sort(data[i], data[j]);
      });
      var arcs = [];
      index.forEach(function(i) {
        var d;
        arcs[i] = {
          data: data[i],
          value: d = values[i],
          startAngle: a,
          endAngle: a += d * k
        };
      });
      return arcs;
    }
    pie.value = function(x) {
      if (!arguments.length) return value;
      value = x;
      return pie;
    };
    pie.sort = function(x) {
      if (!arguments.length) return sort;
      sort = x;
      return pie;
    };
    pie.startAngle = function(x) {
      if (!arguments.length) return startAngle;
      startAngle = x;
      return pie;
    };
    pie.endAngle = function(x) {
      if (!arguments.length) return endAngle;
      endAngle = x;
      return pie;
    };
    return pie;
  };
  var d3_layout_pieSortByValue = {};
  d3.layout.stack = function() {
    var values = d3_identity, order = d3_layout_stackOrderDefault, offset = d3_layout_stackOffsetZero, out = d3_layout_stackOut, x = d3_layout_stackX, y = d3_layout_stackY;
    function stack(data, index) {
      var series = data.map(function(d, i) {
        return values.call(stack, d, i);
      });
      var points = series.map(function(d) {
        return d.map(function(v, i) {
          return [ x.call(stack, v, i), y.call(stack, v, i) ];
        });
      });
      var orders = order.call(stack, points, index);
      series = d3.permute(series, orders);
      points = d3.permute(points, orders);
      var offsets = offset.call(stack, points, index);
      var n = series.length, m = series[0].length, i, j, o;
      for (j = 0; j < m; ++j) {
        out.call(stack, series[0][j], o = offsets[j], points[0][j][1]);
        for (i = 1; i < n; ++i) {
          out.call(stack, series[i][j], o += points[i - 1][j][1], points[i][j][1]);
        }
      }
      return data;
    }
    stack.values = function(x) {
      if (!arguments.length) return values;
      values = x;
      return stack;
    };
    stack.order = function(x) {
      if (!arguments.length) return order;
      order = typeof x === "function" ? x : d3_layout_stackOrders.get(x) || d3_layout_stackOrderDefault;
      return stack;
    };
    stack.offset = function(x) {
      if (!arguments.length) return offset;
      offset = typeof x === "function" ? x : d3_layout_stackOffsets.get(x) || d3_layout_stackOffsetZero;
      return stack;
    };
    stack.x = function(z) {
      if (!arguments.length) return x;
      x = z;
      return stack;
    };
    stack.y = function(z) {
      if (!arguments.length) return y;
      y = z;
      return stack;
    };
    stack.out = function(z) {
      if (!arguments.length) return out;
      out = z;
      return stack;
    };
    return stack;
  };
  function d3_layout_stackX(d) {
    return d.x;
  }
  function d3_layout_stackY(d) {
    return d.y;
  }
  function d3_layout_stackOut(d, y0, y) {
    d.y0 = y0;
    d.y = y;
  }
  var d3_layout_stackOrders = d3.map({
    "inside-out": function(data) {
      var n = data.length, i, j, max = data.map(d3_layout_stackMaxIndex), sums = data.map(d3_layout_stackReduceSum), index = d3.range(n).sort(function(a, b) {
        return max[a] - max[b];
      }), top = 0, bottom = 0, tops = [], bottoms = [];
      for (i = 0; i < n; ++i) {
        j = index[i];
        if (top < bottom) {
          top += sums[j];
          tops.push(j);
        } else {
          bottom += sums[j];
          bottoms.push(j);
        }
      }
      return bottoms.reverse().concat(tops);
    },
    reverse: function(data) {
      return d3.range(data.length).reverse();
    },
    "default": d3_layout_stackOrderDefault
  });
  var d3_layout_stackOffsets = d3.map({
    silhouette: function(data) {
      var n = data.length, m = data[0].length, sums = [], max = 0, i, j, o, y0 = [];
      for (j = 0; j < m; ++j) {
        for (i = 0, o = 0; i < n; i++) o += data[i][j][1];
        if (o > max) max = o;
        sums.push(o);
      }
      for (j = 0; j < m; ++j) {
        y0[j] = (max - sums[j]) / 2;
      }
      return y0;
    },
    wiggle: function(data) {
      var n = data.length, x = data[0], m = x.length, i, j, k, s1, s2, s3, dx, o, o0, y0 = [];
      y0[0] = o = o0 = 0;
      for (j = 1; j < m; ++j) {
        for (i = 0, s1 = 0; i < n; ++i) s1 += data[i][j][1];
        for (i = 0, s2 = 0, dx = x[j][0] - x[j - 1][0]; i < n; ++i) {
          for (k = 0, s3 = (data[i][j][1] - data[i][j - 1][1]) / (2 * dx); k < i; ++k) {
            s3 += (data[k][j][1] - data[k][j - 1][1]) / dx;
          }
          s2 += s3 * data[i][j][1];
        }
        y0[j] = o -= s1 ? s2 / s1 * dx : 0;
        if (o < o0) o0 = o;
      }
      for (j = 0; j < m; ++j) y0[j] -= o0;
      return y0;
    },
    expand: function(data) {
      var n = data.length, m = data[0].length, k = 1 / n, i, j, o, y0 = [];
      for (j = 0; j < m; ++j) {
        for (i = 0, o = 0; i < n; i++) o += data[i][j][1];
        if (o) for (i = 0; i < n; i++) data[i][j][1] /= o; else for (i = 0; i < n; i++) data[i][j][1] = k;
      }
      for (j = 0; j < m; ++j) y0[j] = 0;
      return y0;
    },
    zero: d3_layout_stackOffsetZero
  });
  function d3_layout_stackOrderDefault(data) {
    return d3.range(data.length);
  }
  function d3_layout_stackOffsetZero(data) {
    var j = -1, m = data[0].length, y0 = [];
    while (++j < m) y0[j] = 0;
    return y0;
  }
  function d3_layout_stackMaxIndex(array) {
    var i = 1, j = 0, v = array[0][1], k, n = array.length;
    for (;i < n; ++i) {
      if ((k = array[i][1]) > v) {
        j = i;
        v = k;
      }
    }
    return j;
  }
  function d3_layout_stackReduceSum(d) {
    return d.reduce(d3_layout_stackSum, 0);
  }
  function d3_layout_stackSum(p, d) {
    return p + d[1];
  }
  d3.layout.histogram = function() {
    var frequency = true, valuer = Number, ranger = d3_layout_histogramRange, binner = d3_layout_histogramBinSturges;
    function histogram(data, i) {
      var bins = [], values = data.map(valuer, this), range = ranger.call(this, values, i), thresholds = binner.call(this, range, values, i), bin, i = -1, n = values.length, m = thresholds.length - 1, k = frequency ? 1 : 1 / n, x;
      while (++i < m) {
        bin = bins[i] = [];
        bin.dx = thresholds[i + 1] - (bin.x = thresholds[i]);
        bin.y = 0;
      }
      if (m > 0) {
        i = -1;
        while (++i < n) {
          x = values[i];
          if (x >= range[0] && x <= range[1]) {
            bin = bins[d3.bisect(thresholds, x, 1, m) - 1];
            bin.y += k;
            bin.push(data[i]);
          }
        }
      }
      return bins;
    }
    histogram.value = function(x) {
      if (!arguments.length) return valuer;
      valuer = x;
      return histogram;
    };
    histogram.range = function(x) {
      if (!arguments.length) return ranger;
      ranger = d3_functor(x);
      return histogram;
    };
    histogram.bins = function(x) {
      if (!arguments.length) return binner;
      binner = typeof x === "number" ? function(range) {
        return d3_layout_histogramBinFixed(range, x);
      } : d3_functor(x);
      return histogram;
    };
    histogram.frequency = function(x) {
      if (!arguments.length) return frequency;
      frequency = !!x;
      return histogram;
    };
    return histogram;
  };
  function d3_layout_histogramBinSturges(range, values) {
    return d3_layout_histogramBinFixed(range, Math.ceil(Math.log(values.length) / Math.LN2 + 1));
  }
  function d3_layout_histogramBinFixed(range, n) {
    var x = -1, b = +range[0], m = (range[1] - b) / n, f = [];
    while (++x <= n) f[x] = m * x + b;
    return f;
  }
  function d3_layout_histogramRange(values) {
    return [ d3.min(values), d3.max(values) ];
  }
  d3.layout.tree = function() {
    var hierarchy = d3.layout.hierarchy().sort(null).value(null), separation = d3_layout_treeSeparation, size = [ 1, 1 ], nodeSize = false;
    function tree(d, i) {
      var nodes = hierarchy.call(this, d, i), root = nodes[0];
      function firstWalk(node, previousSibling) {
        var children = node.children, layout = node._tree;
        if (children && (n = children.length)) {
          var n, firstChild = children[0], previousChild, ancestor = firstChild, child, i = -1;
          while (++i < n) {
            child = children[i];
            firstWalk(child, previousChild);
            ancestor = apportion(child, previousChild, ancestor);
            previousChild = child;
          }
          d3_layout_treeShift(node);
          var midpoint = .5 * (firstChild._tree.prelim + child._tree.prelim);
          if (previousSibling) {
            layout.prelim = previousSibling._tree.prelim + separation(node, previousSibling);
            layout.mod = layout.prelim - midpoint;
          } else {
            layout.prelim = midpoint;
          }
        } else {
          if (previousSibling) {
            layout.prelim = previousSibling._tree.prelim + separation(node, previousSibling);
          }
        }
      }
      function secondWalk(node, x) {
        node.x = node._tree.prelim + x;
        var children = node.children;
        if (children && (n = children.length)) {
          var i = -1, n;
          x += node._tree.mod;
          while (++i < n) {
            secondWalk(children[i], x);
          }
        }
      }
      function apportion(node, previousSibling, ancestor) {
        if (previousSibling) {
          var vip = node, vop = node, vim = previousSibling, vom = node.parent.children[0], sip = vip._tree.mod, sop = vop._tree.mod, sim = vim._tree.mod, som = vom._tree.mod, shift;
          while (vim = d3_layout_treeRight(vim), vip = d3_layout_treeLeft(vip), vim && vip) {
            vom = d3_layout_treeLeft(vom);
            vop = d3_layout_treeRight(vop);
            vop._tree.ancestor = node;
            shift = vim._tree.prelim + sim - vip._tree.prelim - sip + separation(vim, vip);
            if (shift > 0) {
              d3_layout_treeMove(d3_layout_treeAncestor(vim, node, ancestor), node, shift);
              sip += shift;
              sop += shift;
            }
            sim += vim._tree.mod;
            sip += vip._tree.mod;
            som += vom._tree.mod;
            sop += vop._tree.mod;
          }
          if (vim && !d3_layout_treeRight(vop)) {
            vop._tree.thread = vim;
            vop._tree.mod += sim - sop;
          }
          if (vip && !d3_layout_treeLeft(vom)) {
            vom._tree.thread = vip;
            vom._tree.mod += sip - som;
            ancestor = node;
          }
        }
        return ancestor;
      }
      d3_layout_treeVisitAfter(root, function(node, previousSibling) {
        node._tree = {
          ancestor: node,
          prelim: 0,
          mod: 0,
          change: 0,
          shift: 0,
          number: previousSibling ? previousSibling._tree.number + 1 : 0
        };
      });
      firstWalk(root);
      secondWalk(root, -root._tree.prelim);
      var left = d3_layout_treeSearch(root, d3_layout_treeLeftmost), right = d3_layout_treeSearch(root, d3_layout_treeRightmost), deep = d3_layout_treeSearch(root, d3_layout_treeDeepest), x0 = left.x - separation(left, right) / 2, x1 = right.x + separation(right, left) / 2, y1 = deep.depth || 1;
      d3_layout_treeVisitAfter(root, nodeSize ? function(node) {
        node.x *= size[0];
        node.y = node.depth * size[1];
        delete node._tree;
      } : function(node) {
        node.x = (node.x - x0) / (x1 - x0) * size[0];
        node.y = node.depth / y1 * size[1];
        delete node._tree;
      });
      return nodes;
    }
    tree.separation = function(x) {
      if (!arguments.length) return separation;
      separation = x;
      return tree;
    };
    tree.size = function(x) {
      if (!arguments.length) return nodeSize ? null : size;
      nodeSize = (size = x) == null;
      return tree;
    };
    tree.nodeSize = function(x) {
      if (!arguments.length) return nodeSize ? size : null;
      nodeSize = (size = x) != null;
      return tree;
    };
    return d3_layout_hierarchyRebind(tree, hierarchy);
  };
  function d3_layout_treeSeparation(a, b) {
    return a.parent == b.parent ? 1 : 2;
  }
  function d3_layout_treeLeft(node) {
    var children = node.children;
    return children && children.length ? children[0] : node._tree.thread;
  }
  function d3_layout_treeRight(node) {
    var children = node.children, n;
    return children && (n = children.length) ? children[n - 1] : node._tree.thread;
  }
  function d3_layout_treeSearch(node, compare) {
    var children = node.children;
    if (children && (n = children.length)) {
      var child, n, i = -1;
      while (++i < n) {
        if (compare(child = d3_layout_treeSearch(children[i], compare), node) > 0) {
          node = child;
        }
      }
    }
    return node;
  }
  function d3_layout_treeRightmost(a, b) {
    return a.x - b.x;
  }
  function d3_layout_treeLeftmost(a, b) {
    return b.x - a.x;
  }
  function d3_layout_treeDeepest(a, b) {
    return a.depth - b.depth;
  }
  function d3_layout_treeVisitAfter(node, callback) {
    function visit(node, previousSibling) {
      var children = node.children;
      if (children && (n = children.length)) {
        var child, previousChild = null, i = -1, n;
        while (++i < n) {
          child = children[i];
          visit(child, previousChild);
          previousChild = child;
        }
      }
      callback(node, previousSibling);
    }
    visit(node, null);
  }
  function d3_layout_treeShift(node) {
    var shift = 0, change = 0, children = node.children, i = children.length, child;
    while (--i >= 0) {
      child = children[i]._tree;
      child.prelim += shift;
      child.mod += shift;
      shift += child.shift + (change += child.change);
    }
  }
  function d3_layout_treeMove(ancestor, node, shift) {
    ancestor = ancestor._tree;
    node = node._tree;
    var change = shift / (node.number - ancestor.number);
    ancestor.change += change;
    node.change -= change;
    node.shift += shift;
    node.prelim += shift;
    node.mod += shift;
  }
  function d3_layout_treeAncestor(vim, node, ancestor) {
    return vim._tree.ancestor.parent == node.parent ? vim._tree.ancestor : ancestor;
  }
  d3.layout.pack = function() {
    var hierarchy = d3.layout.hierarchy().sort(d3_layout_packSort), padding = 0, size = [ 1, 1 ], radius;
    function pack(d, i) {
      var nodes = hierarchy.call(this, d, i), root = nodes[0], w = size[0], h = size[1], r = radius == null ? Math.sqrt : typeof radius === "function" ? radius : function() {
        return radius;
      };
      root.x = root.y = 0;
      d3_layout_treeVisitAfter(root, function(d) {
        d.r = +r(d.value);
      });
      d3_layout_treeVisitAfter(root, d3_layout_packSiblings);
      if (padding) {
        var dr = padding * (radius ? 1 : Math.max(2 * root.r / w, 2 * root.r / h)) / 2;
        d3_layout_treeVisitAfter(root, function(d) {
          d.r += dr;
        });
        d3_layout_treeVisitAfter(root, d3_layout_packSiblings);
        d3_layout_treeVisitAfter(root, function(d) {
          d.r -= dr;
        });
      }
      d3_layout_packTransform(root, w / 2, h / 2, radius ? 1 : 1 / Math.max(2 * root.r / w, 2 * root.r / h));
      return nodes;
    }
    pack.size = function(_) {
      if (!arguments.length) return size;
      size = _;
      return pack;
    };
    pack.radius = function(_) {
      if (!arguments.length) return radius;
      radius = _ == null || typeof _ === "function" ? _ : +_;
      return pack;
    };
    pack.padding = function(_) {
      if (!arguments.length) return padding;
      padding = +_;
      return pack;
    };
    return d3_layout_hierarchyRebind(pack, hierarchy);
  };
  function d3_layout_packSort(a, b) {
    return a.value - b.value;
  }
  function d3_layout_packInsert(a, b) {
    var c = a._pack_next;
    a._pack_next = b;
    b._pack_prev = a;
    b._pack_next = c;
    c._pack_prev = b;
  }
  function d3_layout_packSplice(a, b) {
    a._pack_next = b;
    b._pack_prev = a;
  }
  function d3_layout_packIntersects(a, b) {
    var dx = b.x - a.x, dy = b.y - a.y, dr = a.r + b.r;
    return .999 * dr * dr > dx * dx + dy * dy;
  }
  function d3_layout_packSiblings(node) {
    if (!(nodes = node.children) || !(n = nodes.length)) return;
    var nodes, xMin = Infinity, xMax = -Infinity, yMin = Infinity, yMax = -Infinity, a, b, c, i, j, k, n;
    function bound(node) {
      xMin = Math.min(node.x - node.r, xMin);
      xMax = Math.max(node.x + node.r, xMax);
      yMin = Math.min(node.y - node.r, yMin);
      yMax = Math.max(node.y + node.r, yMax);
    }
    nodes.forEach(d3_layout_packLink);
    a = nodes[0];
    a.x = -a.r;
    a.y = 0;
    bound(a);
    if (n > 1) {
      b = nodes[1];
      b.x = b.r;
      b.y = 0;
      bound(b);
      if (n > 2) {
        c = nodes[2];
        d3_layout_packPlace(a, b, c);
        bound(c);
        d3_layout_packInsert(a, c);
        a._pack_prev = c;
        d3_layout_packInsert(c, b);
        b = a._pack_next;
        for (i = 3; i < n; i++) {
          d3_layout_packPlace(a, b, c = nodes[i]);
          var isect = 0, s1 = 1, s2 = 1;
          for (j = b._pack_next; j !== b; j = j._pack_next, s1++) {
            if (d3_layout_packIntersects(j, c)) {
              isect = 1;
              break;
            }
          }
          if (isect == 1) {
            for (k = a._pack_prev; k !== j._pack_prev; k = k._pack_prev, s2++) {
              if (d3_layout_packIntersects(k, c)) {
                break;
              }
            }
          }
          if (isect) {
            if (s1 < s2 || s1 == s2 && b.r < a.r) d3_layout_packSplice(a, b = j); else d3_layout_packSplice(a = k, b);
            i--;
          } else {
            d3_layout_packInsert(a, c);
            b = c;
            bound(c);
          }
        }
      }
    }
    var cx = (xMin + xMax) / 2, cy = (yMin + yMax) / 2, cr = 0;
    for (i = 0; i < n; i++) {
      c = nodes[i];
      c.x -= cx;
      c.y -= cy;
      cr = Math.max(cr, c.r + Math.sqrt(c.x * c.x + c.y * c.y));
    }
    node.r = cr;
    nodes.forEach(d3_layout_packUnlink);
  }
  function d3_layout_packLink(node) {
    node._pack_next = node._pack_prev = node;
  }
  function d3_layout_packUnlink(node) {
    delete node._pack_next;
    delete node._pack_prev;
  }
  function d3_layout_packTransform(node, x, y, k) {
    var children = node.children;
    node.x = x += k * node.x;
    node.y = y += k * node.y;
    node.r *= k;
    if (children) {
      var i = -1, n = children.length;
      while (++i < n) d3_layout_packTransform(children[i], x, y, k);
    }
  }
  function d3_layout_packPlace(a, b, c) {
    var db = a.r + c.r, dx = b.x - a.x, dy = b.y - a.y;
    if (db && (dx || dy)) {
      var da = b.r + c.r, dc = dx * dx + dy * dy;
      da *= da;
      db *= db;
      var x = .5 + (db - da) / (2 * dc), y = Math.sqrt(Math.max(0, 2 * da * (db + dc) - (db -= dc) * db - da * da)) / (2 * dc);
      c.x = a.x + x * dx + y * dy;
      c.y = a.y + x * dy - y * dx;
    } else {
      c.x = a.x + db;
      c.y = a.y;
    }
  }
  d3.layout.cluster = function() {
    var hierarchy = d3.layout.hierarchy().sort(null).value(null), separation = d3_layout_treeSeparation, size = [ 1, 1 ], nodeSize = false;
    function cluster(d, i) {
      var nodes = hierarchy.call(this, d, i), root = nodes[0], previousNode, x = 0;
      d3_layout_treeVisitAfter(root, function(node) {
        var children = node.children;
        if (children && children.length) {
          node.x = d3_layout_clusterX(children);
          node.y = d3_layout_clusterY(children);
        } else {
          node.x = previousNode ? x += separation(node, previousNode) : 0;
          node.y = 0;
          previousNode = node;
        }
      });
      var left = d3_layout_clusterLeft(root), right = d3_layout_clusterRight(root), x0 = left.x - separation(left, right) / 2, x1 = right.x + separation(right, left) / 2;
      d3_layout_treeVisitAfter(root, nodeSize ? function(node) {
        node.x = (node.x - root.x) * size[0];
        node.y = (root.y - node.y) * size[1];
      } : function(node) {
        node.x = (node.x - x0) / (x1 - x0) * size[0];
        node.y = (1 - (root.y ? node.y / root.y : 1)) * size[1];
      });
      return nodes;
    }
    cluster.separation = function(x) {
      if (!arguments.length) return separation;
      separation = x;
      return cluster;
    };
    cluster.size = function(x) {
      if (!arguments.length) return nodeSize ? null : size;
      nodeSize = (size = x) == null;
      return cluster;
    };
    cluster.nodeSize = function(x) {
      if (!arguments.length) return nodeSize ? size : null;
      nodeSize = (size = x) != null;
      return cluster;
    };
    return d3_layout_hierarchyRebind(cluster, hierarchy);
  };
  function d3_layout_clusterY(children) {
    return 1 + d3.max(children, function(child) {
      return child.y;
    });
  }
  function d3_layout_clusterX(children) {
    return children.reduce(function(x, child) {
      return x + child.x;
    }, 0) / children.length;
  }
  function d3_layout_clusterLeft(node) {
    var children = node.children;
    return children && children.length ? d3_layout_clusterLeft(children[0]) : node;
  }
  function d3_layout_clusterRight(node) {
    var children = node.children, n;
    return children && (n = children.length) ? d3_layout_clusterRight(children[n - 1]) : node;
  }
  d3.layout.treemap = function() {
    var hierarchy = d3.layout.hierarchy(), round = Math.round, size = [ 1, 1 ], padding = null, pad = d3_layout_treemapPadNull, sticky = false, stickies, mode = "squarify", ratio = .5 * (1 + Math.sqrt(5));
    function scale(children, k) {
      var i = -1, n = children.length, child, area;
      while (++i < n) {
        area = (child = children[i]).value * (k < 0 ? 0 : k);
        child.area = isNaN(area) || area <= 0 ? 0 : area;
      }
    }
    function squarify(node) {
      var children = node.children;
      if (children && children.length) {
        var rect = pad(node), row = [], remaining = children.slice(), child, best = Infinity, score, u = mode === "slice" ? rect.dx : mode === "dice" ? rect.dy : mode === "slice-dice" ? node.depth & 1 ? rect.dy : rect.dx : Math.min(rect.dx, rect.dy), n;
        scale(remaining, rect.dx * rect.dy / node.value);
        row.area = 0;
        while ((n = remaining.length) > 0) {
          row.push(child = remaining[n - 1]);
          row.area += child.area;
          if (mode !== "squarify" || (score = worst(row, u)) <= best) {
            remaining.pop();
            best = score;
          } else {
            row.area -= row.pop().area;
            position(row, u, rect, false);
            u = Math.min(rect.dx, rect.dy);
            row.length = row.area = 0;
            best = Infinity;
          }
        }
        if (row.length) {
          position(row, u, rect, true);
          row.length = row.area = 0;
        }
        children.forEach(squarify);
      }
    }
    function stickify(node) {
      var children = node.children;
      if (children && children.length) {
        var rect = pad(node), remaining = children.slice(), child, row = [];
        scale(remaining, rect.dx * rect.dy / node.value);
        row.area = 0;
        while (child = remaining.pop()) {
          row.push(child);
          row.area += child.area;
          if (child.z != null) {
            position(row, child.z ? rect.dx : rect.dy, rect, !remaining.length);
            row.length = row.area = 0;
          }
        }
        children.forEach(stickify);
      }
    }
    function worst(row, u) {
      var s = row.area, r, rmax = 0, rmin = Infinity, i = -1, n = row.length;
      while (++i < n) {
        if (!(r = row[i].area)) continue;
        if (r < rmin) rmin = r;
        if (r > rmax) rmax = r;
      }
      s *= s;
      u *= u;
      return s ? Math.max(u * rmax * ratio / s, s / (u * rmin * ratio)) : Infinity;
    }
    function position(row, u, rect, flush) {
      var i = -1, n = row.length, x = rect.x, y = rect.y, v = u ? round(row.area / u) : 0, o;
      if (u == rect.dx) {
        if (flush || v > rect.dy) v = rect.dy;
        while (++i < n) {
          o = row[i];
          o.x = x;
          o.y = y;
          o.dy = v;
          x += o.dx = Math.min(rect.x + rect.dx - x, v ? round(o.area / v) : 0);
        }
        o.z = true;
        o.dx += rect.x + rect.dx - x;
        rect.y += v;
        rect.dy -= v;
      } else {
        if (flush || v > rect.dx) v = rect.dx;
        while (++i < n) {
          o = row[i];
          o.x = x;
          o.y = y;
          o.dx = v;
          y += o.dy = Math.min(rect.y + rect.dy - y, v ? round(o.area / v) : 0);
        }
        o.z = false;
        o.dy += rect.y + rect.dy - y;
        rect.x += v;
        rect.dx -= v;
      }
    }
    function treemap(d) {
      var nodes = stickies || hierarchy(d), root = nodes[0];
      root.x = 0;
      root.y = 0;
      root.dx = size[0];
      root.dy = size[1];
      if (stickies) hierarchy.revalue(root);
      scale([ root ], root.dx * root.dy / root.value);
      (stickies ? stickify : squarify)(root);
      if (sticky) stickies = nodes;
      return nodes;
    }
    treemap.size = function(x) {
      if (!arguments.length) return size;
      size = x;
      return treemap;
    };
    treemap.padding = function(x) {
      if (!arguments.length) return padding;
      function padFunction(node) {
        var p = x.call(treemap, node, node.depth);
        return p == null ? d3_layout_treemapPadNull(node) : d3_layout_treemapPad(node, typeof p === "number" ? [ p, p, p, p ] : p);
      }
      function padConstant(node) {
        return d3_layout_treemapPad(node, x);
      }
      var type;
      pad = (padding = x) == null ? d3_layout_treemapPadNull : (type = typeof x) === "function" ? padFunction : type === "number" ? (x = [ x, x, x, x ], 
      padConstant) : padConstant;
      return treemap;
    };
    treemap.round = function(x) {
      if (!arguments.length) return round != Number;
      round = x ? Math.round : Number;
      return treemap;
    };
    treemap.sticky = function(x) {
      if (!arguments.length) return sticky;
      sticky = x;
      stickies = null;
      return treemap;
    };
    treemap.ratio = function(x) {
      if (!arguments.length) return ratio;
      ratio = x;
      return treemap;
    };
    treemap.mode = function(x) {
      if (!arguments.length) return mode;
      mode = x + "";
      return treemap;
    };
    return d3_layout_hierarchyRebind(treemap, hierarchy);
  };
  function d3_layout_treemapPadNull(node) {
    return {
      x: node.x,
      y: node.y,
      dx: node.dx,
      dy: node.dy
    };
  }
  function d3_layout_treemapPad(node, padding) {
    var x = node.x + padding[3], y = node.y + padding[0], dx = node.dx - padding[1] - padding[3], dy = node.dy - padding[0] - padding[2];
    if (dx < 0) {
      x += dx / 2;
      dx = 0;
    }
    if (dy < 0) {
      y += dy / 2;
      dy = 0;
    }
    return {
      x: x,
      y: y,
      dx: dx,
      dy: dy
    };
  }
  d3.random = {
    normal: function(µ, σ) {
      var n = arguments.length;
      if (n < 2) σ = 1;
      if (n < 1) µ = 0;
      return function() {
        var x, y, r;
        do {
          x = Math.random() * 2 - 1;
          y = Math.random() * 2 - 1;
          r = x * x + y * y;
        } while (!r || r > 1);
        return µ + σ * x * Math.sqrt(-2 * Math.log(r) / r);
      };
    },
    logNormal: function() {
      var random = d3.random.normal.apply(d3, arguments);
      return function() {
        return Math.exp(random());
      };
    },
    irwinHall: function(m) {
      return function() {
        for (var s = 0, j = 0; j < m; j++) s += Math.random();
        return s / m;
      };
    }
  };
  d3.scale = {};
  function d3_scaleExtent(domain) {
    var start = domain[0], stop = domain[domain.length - 1];
    return start < stop ? [ start, stop ] : [ stop, start ];
  }
  function d3_scaleRange(scale) {
    return scale.rangeExtent ? scale.rangeExtent() : d3_scaleExtent(scale.range());
  }
  function d3_scale_bilinear(domain, range, uninterpolate, interpolate) {
    var u = uninterpolate(domain[0], domain[1]), i = interpolate(range[0], range[1]);
    return function(x) {
      return i(u(x));
    };
  }
  function d3_scale_nice(domain, nice) {
    var i0 = 0, i1 = domain.length - 1, x0 = domain[i0], x1 = domain[i1], dx;
    if (x1 < x0) {
      dx = i0, i0 = i1, i1 = dx;
      dx = x0, x0 = x1, x1 = dx;
    }
    domain[i0] = nice.floor(x0);
    domain[i1] = nice.ceil(x1);
    return domain;
  }
  function d3_scale_niceStep(step) {
    return step ? {
      floor: function(x) {
        return Math.floor(x / step) * step;
      },
      ceil: function(x) {
        return Math.ceil(x / step) * step;
      }
    } : d3_scale_niceIdentity;
  }
  var d3_scale_niceIdentity = {
    floor: d3_identity,
    ceil: d3_identity
  };
  function d3_scale_polylinear(domain, range, uninterpolate, interpolate) {
    var u = [], i = [], j = 0, k = Math.min(domain.length, range.length) - 1;
    if (domain[k] < domain[0]) {
      domain = domain.slice().reverse();
      range = range.slice().reverse();
    }
    while (++j <= k) {
      u.push(uninterpolate(domain[j - 1], domain[j]));
      i.push(interpolate(range[j - 1], range[j]));
    }
    return function(x) {
      var j = d3.bisect(domain, x, 1, k) - 1;
      return i[j](u[j](x));
    };
  }
  d3.scale.linear = function() {
    return d3_scale_linear([ 0, 1 ], [ 0, 1 ], d3_interpolate, false);
  };
  function d3_scale_linear(domain, range, interpolate, clamp) {
    var output, input;
    function rescale() {
      var linear = Math.min(domain.length, range.length) > 2 ? d3_scale_polylinear : d3_scale_bilinear, uninterpolate = clamp ? d3_uninterpolateClamp : d3_uninterpolateNumber;
      output = linear(domain, range, uninterpolate, interpolate);
      input = linear(range, domain, uninterpolate, d3_interpolate);
      return scale;
    }
    function scale(x) {
      return output(x);
    }
    scale.invert = function(y) {
      return input(y);
    };
    scale.domain = function(x) {
      if (!arguments.length) return domain;
      domain = x.map(Number);
      return rescale();
    };
    scale.range = function(x) {
      if (!arguments.length) return range;
      range = x;
      return rescale();
    };
    scale.rangeRound = function(x) {
      return scale.range(x).interpolate(d3_interpolateRound);
    };
    scale.clamp = function(x) {
      if (!arguments.length) return clamp;
      clamp = x;
      return rescale();
    };
    scale.interpolate = function(x) {
      if (!arguments.length) return interpolate;
      interpolate = x;
      return rescale();
    };
    scale.ticks = function(m) {
      return d3_scale_linearTicks(domain, m);
    };
    scale.tickFormat = function(m, format) {
      return d3_scale_linearTickFormat(domain, m, format);
    };
    scale.nice = function(m) {
      d3_scale_linearNice(domain, m);
      return rescale();
    };
    scale.copy = function() {
      return d3_scale_linear(domain, range, interpolate, clamp);
    };
    return rescale();
  }
  function d3_scale_linearRebind(scale, linear) {
    return d3.rebind(scale, linear, "range", "rangeRound", "interpolate", "clamp");
  }
  function d3_scale_linearNice(domain, m) {
    return d3_scale_nice(domain, d3_scale_niceStep(m ? d3_scale_linearTickRange(domain, m)[2] : d3_scale_linearNiceStep(domain)));
  }
  function d3_scale_linearNiceStep(domain) {
    var extent = d3_scaleExtent(domain), span = extent[1] - extent[0];
    return Math.pow(10, Math.round(Math.log(span) / Math.LN10) - 1);
  }
  function d3_scale_linearTickRange(domain, m) {
    var extent = d3_scaleExtent(domain), span = extent[1] - extent[0], step = Math.pow(10, Math.floor(Math.log(span / m) / Math.LN10)), err = m / span * step;
    if (err <= .15) step *= 10; else if (err <= .35) step *= 5; else if (err <= .75) step *= 2;
    extent[0] = Math.ceil(extent[0] / step) * step;
    extent[1] = Math.floor(extent[1] / step) * step + step * .5;
    extent[2] = step;
    return extent;
  }
  function d3_scale_linearTicks(domain, m) {
    return d3.range.apply(d3, d3_scale_linearTickRange(domain, m));
  }
  function d3_scale_linearTickFormat(domain, m, format) {
    var precision = -Math.floor(Math.log(d3_scale_linearTickRange(domain, m)[2]) / Math.LN10 + .01);
    return d3.format(format ? format.replace(d3_format_re, function(a, b, c, d, e, f, g, h, i, j) {
      return [ b, c, d, e, f, g, h, i || "." + (precision - (j === "%") * 2), j ].join("");
    }) : ",." + precision + "f");
  }
  d3.scale.log = function() {
    return d3_scale_log(d3.scale.linear().domain([ 0, 1 ]), 10, true, [ 1, 10 ]);
  };
  function d3_scale_log(linear, base, positive, domain) {
    function log(x) {
      return (positive ? Math.log(x < 0 ? 0 : x) : -Math.log(x > 0 ? 0 : -x)) / Math.log(base);
    }
    function pow(x) {
      return positive ? Math.pow(base, x) : -Math.pow(base, -x);
    }
    function scale(x) {
      return linear(log(x));
    }
    scale.invert = function(x) {
      return pow(linear.invert(x));
    };
    scale.domain = function(x) {
      if (!arguments.length) return domain;
      positive = x[0] >= 0;
      linear.domain((domain = x.map(Number)).map(log));
      return scale;
    };
    scale.base = function(_) {
      if (!arguments.length) return base;
      base = +_;
      linear.domain(domain.map(log));
      return scale;
    };
    scale.nice = function() {
      var niced = d3_scale_nice(domain.map(log), positive ? Math : d3_scale_logNiceNegative);
      linear.domain(niced);
      domain = niced.map(pow);
      return scale;
    };
    scale.ticks = function() {
      var extent = d3_scaleExtent(domain), ticks = [];
      if (extent.every(isFinite)) {
        var u = extent[0], v = extent[1], i = Math.floor(log(u)), j = Math.ceil(log(v)), n = base % 1 ? 2 : base;
        if (positive) {
          for (;i < j; i++) for (var k = 1; k < n; k++) ticks.push(pow(i) * k);
          ticks.push(pow(i));
        } else {
          ticks.push(pow(i));
          for (;i++ < j; ) for (var k = n - 1; k > 0; k--) ticks.push(pow(i) * k);
        }
        for (i = 0; ticks[i] < u; i++) {}
        for (j = ticks.length; ticks[j - 1] > v; j--) {}
        ticks = ticks.slice(i, j);
      }
      return ticks;
    };
    scale.tickFormat = function(n, format) {
      if (!arguments.length) return d3_scale_logFormat;
      if (arguments.length < 2) format = d3_scale_logFormat; else if (typeof format !== "function") format = d3.format(format);
      var k = Math.max(.1, n / scale.ticks().length), f = positive ? (e = 1e-12, Math.ceil) : (e = -1e-12, 
      Math.floor), e;
      return function(d) {
        return d / pow(f(log(d) + e)) <= k ? format(d) : "";
      };
    };
    scale.copy = function() {
      return d3_scale_log(linear.copy(), base, positive, domain);
    };
    return d3_scale_linearRebind(scale, linear);
  }
  var d3_scale_logFormat = d3.format(".0e"), d3_scale_logNiceNegative = {
    floor: function(x) {
      return -Math.ceil(-x);
    },
    ceil: function(x) {
      return -Math.floor(-x);
    }
  };
  d3.scale.pow = function() {
    return d3_scale_pow(d3.scale.linear(), 1, [ 0, 1 ]);
  };
  function d3_scale_pow(linear, exponent, domain) {
    var powp = d3_scale_powPow(exponent), powb = d3_scale_powPow(1 / exponent);
    function scale(x) {
      return linear(powp(x));
    }
    scale.invert = function(x) {
      return powb(linear.invert(x));
    };
    scale.domain = function(x) {
      if (!arguments.length) return domain;
      linear.domain((domain = x.map(Number)).map(powp));
      return scale;
    };
    scale.ticks = function(m) {
      return d3_scale_linearTicks(domain, m);
    };
    scale.tickFormat = function(m, format) {
      return d3_scale_linearTickFormat(domain, m, format);
    };
    scale.nice = function(m) {
      return scale.domain(d3_scale_linearNice(domain, m));
    };
    scale.exponent = function(x) {
      if (!arguments.length) return exponent;
      powp = d3_scale_powPow(exponent = x);
      powb = d3_scale_powPow(1 / exponent);
      linear.domain(domain.map(powp));
      return scale;
    };
    scale.copy = function() {
      return d3_scale_pow(linear.copy(), exponent, domain);
    };
    return d3_scale_linearRebind(scale, linear);
  }
  function d3_scale_powPow(e) {
    return function(x) {
      return x < 0 ? -Math.pow(-x, e) : Math.pow(x, e);
    };
  }
  d3.scale.sqrt = function() {
    return d3.scale.pow().exponent(.5);
  };
  d3.scale.ordinal = function() {
    return d3_scale_ordinal([], {
      t: "range",
      a: [ [] ]
    });
  };
  function d3_scale_ordinal(domain, ranger) {
    var index, range, rangeBand;
    function scale(x) {
      return range[((index.get(x) || index.set(x, domain.push(x))) - 1) % range.length];
    }
    function steps(start, step) {
      return d3.range(domain.length).map(function(i) {
        return start + step * i;
      });
    }
    scale.domain = function(x) {
      if (!arguments.length) return domain;
      domain = [];
      index = new d3_Map();
      var i = -1, n = x.length, xi;
      while (++i < n) if (!index.has(xi = x[i])) index.set(xi, domain.push(xi));
      return scale[ranger.t].apply(scale, ranger.a);
    };
    scale.range = function(x) {
      if (!arguments.length) return range;
      range = x;
      rangeBand = 0;
      ranger = {
        t: "range",
        a: arguments
      };
      return scale;
    };
    scale.rangePoints = function(x, padding) {
      if (arguments.length < 2) padding = 0;
      var start = x[0], stop = x[1], step = (stop - start) / (Math.max(1, domain.length - 1) + padding);
      range = steps(domain.length < 2 ? (start + stop) / 2 : start + step * padding / 2, step);
      rangeBand = 0;
      ranger = {
        t: "rangePoints",
        a: arguments
      };
      return scale;
    };
    scale.rangeBands = function(x, padding, outerPadding) {
      if (arguments.length < 2) padding = 0;
      if (arguments.length < 3) outerPadding = padding;
      var reverse = x[1] < x[0], start = x[reverse - 0], stop = x[1 - reverse], step = (stop - start) / (domain.length - padding + 2 * outerPadding);
      range = steps(start + step * outerPadding, step);
      if (reverse) range.reverse();
      rangeBand = step * (1 - padding);
      ranger = {
        t: "rangeBands",
        a: arguments
      };
      return scale;
    };
    scale.rangeRoundBands = function(x, padding, outerPadding) {
      if (arguments.length < 2) padding = 0;
      if (arguments.length < 3) outerPadding = padding;
      var reverse = x[1] < x[0], start = x[reverse - 0], stop = x[1 - reverse], step = Math.floor((stop - start) / (domain.length - padding + 2 * outerPadding)), error = stop - start - (domain.length - padding) * step;
      range = steps(start + Math.round(error / 2), step);
      if (reverse) range.reverse();
      rangeBand = Math.round(step * (1 - padding));
      ranger = {
        t: "rangeRoundBands",
        a: arguments
      };
      return scale;
    };
    scale.rangeBand = function() {
      return rangeBand;
    };
    scale.rangeExtent = function() {
      return d3_scaleExtent(ranger.a[0]);
    };
    scale.copy = function() {
      return d3_scale_ordinal(domain, ranger);
    };
    return scale.domain(domain);
  }
  d3.scale.category10 = function() {
    return d3.scale.ordinal().range(d3_category10);
  };
  d3.scale.category20 = function() {
    return d3.scale.ordinal().range(d3_category20);
  };
  d3.scale.category20b = function() {
    return d3.scale.ordinal().range(d3_category20b);
  };
  d3.scale.category20c = function() {
    return d3.scale.ordinal().range(d3_category20c);
  };
  var d3_category10 = [ 2062260, 16744206, 2924588, 14034728, 9725885, 9197131, 14907330, 8355711, 12369186, 1556175 ].map(d3_rgbString);
  var d3_category20 = [ 2062260, 11454440, 16744206, 16759672, 2924588, 10018698, 14034728, 16750742, 9725885, 12955861, 9197131, 12885140, 14907330, 16234194, 8355711, 13092807, 12369186, 14408589, 1556175, 10410725 ].map(d3_rgbString);
  var d3_category20b = [ 3750777, 5395619, 7040719, 10264286, 6519097, 9216594, 11915115, 13556636, 9202993, 12426809, 15186514, 15190932, 8666169, 11356490, 14049643, 15177372, 8077683, 10834324, 13528509, 14589654 ].map(d3_rgbString);
  var d3_category20c = [ 3244733, 7057110, 10406625, 13032431, 15095053, 16616764, 16625259, 16634018, 3253076, 7652470, 10607003, 13101504, 7695281, 10394312, 12369372, 14342891, 6513507, 9868950, 12434877, 14277081 ].map(d3_rgbString);
  d3.scale.quantile = function() {
    return d3_scale_quantile([], []);
  };
  function d3_scale_quantile(domain, range) {
    var thresholds;
    function rescale() {
      var k = 0, q = range.length;
      thresholds = [];
      while (++k < q) thresholds[k - 1] = d3.quantile(domain, k / q);
      return scale;
    }
    function scale(x) {
      if (!isNaN(x = +x)) return range[d3.bisect(thresholds, x)];
    }
    scale.domain = function(x) {
      if (!arguments.length) return domain;
      domain = x.filter(function(d) {
        return !isNaN(d);
      }).sort(d3.ascending);
      return rescale();
    };
    scale.range = function(x) {
      if (!arguments.length) return range;
      range = x;
      return rescale();
    };
    scale.quantiles = function() {
      return thresholds;
    };
    scale.invertExtent = function(y) {
      y = range.indexOf(y);
      return y < 0 ? [ NaN, NaN ] : [ y > 0 ? thresholds[y - 1] : domain[0], y < thresholds.length ? thresholds[y] : domain[domain.length - 1] ];
    };
    scale.copy = function() {
      return d3_scale_quantile(domain, range);
    };
    return rescale();
  }
  d3.scale.quantize = function() {
    return d3_scale_quantize(0, 1, [ 0, 1 ]);
  };
  function d3_scale_quantize(x0, x1, range) {
    var kx, i;
    function scale(x) {
      return range[Math.max(0, Math.min(i, Math.floor(kx * (x - x0))))];
    }
    function rescale() {
      kx = range.length / (x1 - x0);
      i = range.length - 1;
      return scale;
    }
    scale.domain = function(x) {
      if (!arguments.length) return [ x0, x1 ];
      x0 = +x[0];
      x1 = +x[x.length - 1];
      return rescale();
    };
    scale.range = function(x) {
      if (!arguments.length) return range;
      range = x;
      return rescale();
    };
    scale.invertExtent = function(y) {
      y = range.indexOf(y);
      y = y < 0 ? NaN : y / kx + x0;
      return [ y, y + 1 / kx ];
    };
    scale.copy = function() {
      return d3_scale_quantize(x0, x1, range);
    };
    return rescale();
  }
  d3.scale.threshold = function() {
    return d3_scale_threshold([ .5 ], [ 0, 1 ]);
  };
  function d3_scale_threshold(domain, range) {
    function scale(x) {
      if (x <= x) return range[d3.bisect(domain, x)];
    }
    scale.domain = function(_) {
      if (!arguments.length) return domain;
      domain = _;
      return scale;
    };
    scale.range = function(_) {
      if (!arguments.length) return range;
      range = _;
      return scale;
    };
    scale.invertExtent = function(y) {
      y = range.indexOf(y);
      return [ domain[y - 1], domain[y] ];
    };
    scale.copy = function() {
      return d3_scale_threshold(domain, range);
    };
    return scale;
  }
  d3.scale.identity = function() {
    return d3_scale_identity([ 0, 1 ]);
  };
  function d3_scale_identity(domain) {
    function identity(x) {
      return +x;
    }
    identity.invert = identity;
    identity.domain = identity.range = function(x) {
      if (!arguments.length) return domain;
      domain = x.map(identity);
      return identity;
    };
    identity.ticks = function(m) {
      return d3_scale_linearTicks(domain, m);
    };
    identity.tickFormat = function(m, format) {
      return d3_scale_linearTickFormat(domain, m, format);
    };
    identity.copy = function() {
      return d3_scale_identity(domain);
    };
    return identity;
  }
  d3.svg.arc = function() {
    var innerRadius = d3_svg_arcInnerRadius, outerRadius = d3_svg_arcOuterRadius, startAngle = d3_svg_arcStartAngle, endAngle = d3_svg_arcEndAngle;
    function arc() {
      var r0 = innerRadius.apply(this, arguments), r1 = outerRadius.apply(this, arguments), a0 = startAngle.apply(this, arguments) + d3_svg_arcOffset, a1 = endAngle.apply(this, arguments) + d3_svg_arcOffset, da = (a1 < a0 && (da = a0, 
      a0 = a1, a1 = da), a1 - a0), df = da < π ? "0" : "1", c0 = Math.cos(a0), s0 = Math.sin(a0), c1 = Math.cos(a1), s1 = Math.sin(a1);
      return da >= d3_svg_arcMax ? r0 ? "M0," + r1 + "A" + r1 + "," + r1 + " 0 1,1 0," + -r1 + "A" + r1 + "," + r1 + " 0 1,1 0," + r1 + "M0," + r0 + "A" + r0 + "," + r0 + " 0 1,0 0," + -r0 + "A" + r0 + "," + r0 + " 0 1,0 0," + r0 + "Z" : "M0," + r1 + "A" + r1 + "," + r1 + " 0 1,1 0," + -r1 + "A" + r1 + "," + r1 + " 0 1,1 0," + r1 + "Z" : r0 ? "M" + r1 * c0 + "," + r1 * s0 + "A" + r1 + "," + r1 + " 0 " + df + ",1 " + r1 * c1 + "," + r1 * s1 + "L" + r0 * c1 + "," + r0 * s1 + "A" + r0 + "," + r0 + " 0 " + df + ",0 " + r0 * c0 + "," + r0 * s0 + "Z" : "M" + r1 * c0 + "," + r1 * s0 + "A" + r1 + "," + r1 + " 0 " + df + ",1 " + r1 * c1 + "," + r1 * s1 + "L0,0" + "Z";
    }
    arc.innerRadius = function(v) {
      if (!arguments.length) return innerRadius;
      innerRadius = d3_functor(v);
      return arc;
    };
    arc.outerRadius = function(v) {
      if (!arguments.length) return outerRadius;
      outerRadius = d3_functor(v);
      return arc;
    };
    arc.startAngle = function(v) {
      if (!arguments.length) return startAngle;
      startAngle = d3_functor(v);
      return arc;
    };
    arc.endAngle = function(v) {
      if (!arguments.length) return endAngle;
      endAngle = d3_functor(v);
      return arc;
    };
    arc.centroid = function() {
      var r = (innerRadius.apply(this, arguments) + outerRadius.apply(this, arguments)) / 2, a = (startAngle.apply(this, arguments) + endAngle.apply(this, arguments)) / 2 + d3_svg_arcOffset;
      return [ Math.cos(a) * r, Math.sin(a) * r ];
    };
    return arc;
  };
  var d3_svg_arcOffset = -π / 2, d3_svg_arcMax = 2 * π - 1e-6;
  function d3_svg_arcInnerRadius(d) {
    return d.innerRadius;
  }
  function d3_svg_arcOuterRadius(d) {
    return d.outerRadius;
  }
  function d3_svg_arcStartAngle(d) {
    return d.startAngle;
  }
  function d3_svg_arcEndAngle(d) {
    return d.endAngle;
  }
  d3.svg.line.radial = function() {
    var line = d3_svg_line(d3_svg_lineRadial);
    line.radius = line.x, delete line.x;
    line.angle = line.y, delete line.y;
    return line;
  };
  function d3_svg_lineRadial(points) {
    var point, i = -1, n = points.length, r, a;
    while (++i < n) {
      point = points[i];
      r = point[0];
      a = point[1] + d3_svg_arcOffset;
      point[0] = r * Math.cos(a);
      point[1] = r * Math.sin(a);
    }
    return points;
  }
  function d3_svg_area(projection) {
    var x0 = d3_svg_lineX, x1 = d3_svg_lineX, y0 = 0, y1 = d3_svg_lineY, defined = d3_true, interpolate = d3_svg_lineLinear, interpolateKey = interpolate.key, interpolateReverse = interpolate, L = "L", tension = .7;
    function area(data) {
      var segments = [], points0 = [], points1 = [], i = -1, n = data.length, d, fx0 = d3_functor(x0), fy0 = d3_functor(y0), fx1 = x0 === x1 ? function() {
        return x;
      } : d3_functor(x1), fy1 = y0 === y1 ? function() {
        return y;
      } : d3_functor(y1), x, y;
      function segment() {
        segments.push("M", interpolate(projection(points1), tension), L, interpolateReverse(projection(points0.reverse()), tension), "Z");
      }
      while (++i < n) {
        if (defined.call(this, d = data[i], i)) {
          points0.push([ x = +fx0.call(this, d, i), y = +fy0.call(this, d, i) ]);
          points1.push([ +fx1.call(this, d, i), +fy1.call(this, d, i) ]);
        } else if (points0.length) {
          segment();
          points0 = [];
          points1 = [];
        }
      }
      if (points0.length) segment();
      return segments.length ? segments.join("") : null;
    }
    area.x = function(_) {
      if (!arguments.length) return x1;
      x0 = x1 = _;
      return area;
    };
    area.x0 = function(_) {
      if (!arguments.length) return x0;
      x0 = _;
      return area;
    };
    area.x1 = function(_) {
      if (!arguments.length) return x1;
      x1 = _;
      return area;
    };
    area.y = function(_) {
      if (!arguments.length) return y1;
      y0 = y1 = _;
      return area;
    };
    area.y0 = function(_) {
      if (!arguments.length) return y0;
      y0 = _;
      return area;
    };
    area.y1 = function(_) {
      if (!arguments.length) return y1;
      y1 = _;
      return area;
    };
    area.defined = function(_) {
      if (!arguments.length) return defined;
      defined = _;
      return area;
    };
    area.interpolate = function(_) {
      if (!arguments.length) return interpolateKey;
      if (typeof _ === "function") interpolateKey = interpolate = _; else interpolateKey = (interpolate = d3_svg_lineInterpolators.get(_) || d3_svg_lineLinear).key;
      interpolateReverse = interpolate.reverse || interpolate;
      L = interpolate.closed ? "M" : "L";
      return area;
    };
    area.tension = function(_) {
      if (!arguments.length) return tension;
      tension = _;
      return area;
    };
    return area;
  }
  d3_svg_lineStepBefore.reverse = d3_svg_lineStepAfter;
  d3_svg_lineStepAfter.reverse = d3_svg_lineStepBefore;
  d3.svg.area = function() {
    return d3_svg_area(d3_identity);
  };
  d3.svg.area.radial = function() {
    var area = d3_svg_area(d3_svg_lineRadial);
    area.radius = area.x, delete area.x;
    area.innerRadius = area.x0, delete area.x0;
    area.outerRadius = area.x1, delete area.x1;
    area.angle = area.y, delete area.y;
    area.startAngle = area.y0, delete area.y0;
    area.endAngle = area.y1, delete area.y1;
    return area;
  };
  d3.svg.chord = function() {
    var source = d3_source, target = d3_target, radius = d3_svg_chordRadius, startAngle = d3_svg_arcStartAngle, endAngle = d3_svg_arcEndAngle;
    function chord(d, i) {
      var s = subgroup(this, source, d, i), t = subgroup(this, target, d, i);
      return "M" + s.p0 + arc(s.r, s.p1, s.a1 - s.a0) + (equals(s, t) ? curve(s.r, s.p1, s.r, s.p0) : curve(s.r, s.p1, t.r, t.p0) + arc(t.r, t.p1, t.a1 - t.a0) + curve(t.r, t.p1, s.r, s.p0)) + "Z";
    }
    function subgroup(self, f, d, i) {
      var subgroup = f.call(self, d, i), r = radius.call(self, subgroup, i), a0 = startAngle.call(self, subgroup, i) + d3_svg_arcOffset, a1 = endAngle.call(self, subgroup, i) + d3_svg_arcOffset;
      return {
        r: r,
        a0: a0,
        a1: a1,
        p0: [ r * Math.cos(a0), r * Math.sin(a0) ],
        p1: [ r * Math.cos(a1), r * Math.sin(a1) ]
      };
    }
    function equals(a, b) {
      return a.a0 == b.a0 && a.a1 == b.a1;
    }
    function arc(r, p, a) {
      return "A" + r + "," + r + " 0 " + +(a > π) + ",1 " + p;
    }
    function curve(r0, p0, r1, p1) {
      return "Q 0,0 " + p1;
    }
    chord.radius = function(v) {
      if (!arguments.length) return radius;
      radius = d3_functor(v);
      return chord;
    };
    chord.source = function(v) {
      if (!arguments.length) return source;
      source = d3_functor(v);
      return chord;
    };
    chord.target = function(v) {
      if (!arguments.length) return target;
      target = d3_functor(v);
      return chord;
    };
    chord.startAngle = function(v) {
      if (!arguments.length) return startAngle;
      startAngle = d3_functor(v);
      return chord;
    };
    chord.endAngle = function(v) {
      if (!arguments.length) return endAngle;
      endAngle = d3_functor(v);
      return chord;
    };
    return chord;
  };
  function d3_svg_chordRadius(d) {
    return d.radius;
  }
  d3.svg.diagonal = function() {
    var source = d3_source, target = d3_target, projection = d3_svg_diagonalProjection;
    function diagonal(d, i) {
      var p0 = source.call(this, d, i), p3 = target.call(this, d, i), m = (p0.y + p3.y) / 2, p = [ p0, {
        x: p0.x,
        y: m
      }, {
        x: p3.x,
        y: m
      }, p3 ];
      p = p.map(projection);
      return "M" + p[0] + "C" + p[1] + " " + p[2] + " " + p[3];
    }
    diagonal.source = function(x) {
      if (!arguments.length) return source;
      source = d3_functor(x);
      return diagonal;
    };
    diagonal.target = function(x) {
      if (!arguments.length) return target;
      target = d3_functor(x);
      return diagonal;
    };
    diagonal.projection = function(x) {
      if (!arguments.length) return projection;
      projection = x;
      return diagonal;
    };
    return diagonal;
  };
  function d3_svg_diagonalProjection(d) {
    return [ d.x, d.y ];
  }
  d3.svg.diagonal.radial = function() {
    var diagonal = d3.svg.diagonal(), projection = d3_svg_diagonalProjection, projection_ = diagonal.projection;
    diagonal.projection = function(x) {
      return arguments.length ? projection_(d3_svg_diagonalRadialProjection(projection = x)) : projection;
    };
    return diagonal;
  };
  function d3_svg_diagonalRadialProjection(projection) {
    return function() {
      var d = projection.apply(this, arguments), r = d[0], a = d[1] + d3_svg_arcOffset;
      return [ r * Math.cos(a), r * Math.sin(a) ];
    };
  }
  d3.svg.symbol = function() {
    var type = d3_svg_symbolType, size = d3_svg_symbolSize;
    function symbol(d, i) {
      return (d3_svg_symbols.get(type.call(this, d, i)) || d3_svg_symbolCircle)(size.call(this, d, i));
    }
    symbol.type = function(x) {
      if (!arguments.length) return type;
      type = d3_functor(x);
      return symbol;
    };
    symbol.size = function(x) {
      if (!arguments.length) return size;
      size = d3_functor(x);
      return symbol;
    };
    return symbol;
  };
  function d3_svg_symbolSize() {
    return 64;
  }
  function d3_svg_symbolType() {
    return "circle";
  }
  function d3_svg_symbolCircle(size) {
    var r = Math.sqrt(size / π);
    return "M0," + r + "A" + r + "," + r + " 0 1,1 0," + -r + "A" + r + "," + r + " 0 1,1 0," + r + "Z";
  }
  var d3_svg_symbols = d3.map({
    circle: d3_svg_symbolCircle,
    cross: function(size) {
      var r = Math.sqrt(size / 5) / 2;
      return "M" + -3 * r + "," + -r + "H" + -r + "V" + -3 * r + "H" + r + "V" + -r + "H" + 3 * r + "V" + r + "H" + r + "V" + 3 * r + "H" + -r + "V" + r + "H" + -3 * r + "Z";
    },
    diamond: function(size) {
      var ry = Math.sqrt(size / (2 * d3_svg_symbolTan30)), rx = ry * d3_svg_symbolTan30;
      return "M0," + -ry + "L" + rx + ",0" + " 0," + ry + " " + -rx + ",0" + "Z";
    },
    square: function(size) {
      var r = Math.sqrt(size) / 2;
      return "M" + -r + "," + -r + "L" + r + "," + -r + " " + r + "," + r + " " + -r + "," + r + "Z";
    },
    "triangle-down": function(size) {
      var rx = Math.sqrt(size / d3_svg_symbolSqrt3), ry = rx * d3_svg_symbolSqrt3 / 2;
      return "M0," + ry + "L" + rx + "," + -ry + " " + -rx + "," + -ry + "Z";
    },
    "triangle-up": function(size) {
      var rx = Math.sqrt(size / d3_svg_symbolSqrt3), ry = rx * d3_svg_symbolSqrt3 / 2;
      return "M0," + -ry + "L" + rx + "," + ry + " " + -rx + "," + ry + "Z";
    }
  });
  d3.svg.symbolTypes = d3_svg_symbols.keys();
  var d3_svg_symbolSqrt3 = Math.sqrt(3), d3_svg_symbolTan30 = Math.tan(30 * d3_radians);
  function d3_transition(groups, id) {
    d3_subclass(groups, d3_transitionPrototype);
    groups.id = id;
    return groups;
  }
  var d3_transitionPrototype = [], d3_transitionId = 0, d3_transitionInheritId, d3_transitionInherit;
  d3_transitionPrototype.call = d3_selectionPrototype.call;
  d3_transitionPrototype.empty = d3_selectionPrototype.empty;
  d3_transitionPrototype.node = d3_selectionPrototype.node;
  d3_transitionPrototype.size = d3_selectionPrototype.size;
  d3.transition = function(selection) {
    return arguments.length ? d3_transitionInheritId ? selection.transition() : selection : d3_selectionRoot.transition();
  };
  d3.transition.prototype = d3_transitionPrototype;
  d3_transitionPrototype.select = function(selector) {
    var id = this.id, subgroups = [], subgroup, subnode, node;
    selector = d3_selection_selector(selector);
    for (var j = -1, m = this.length; ++j < m; ) {
      subgroups.push(subgroup = []);
      for (var group = this[j], i = -1, n = group.length; ++i < n; ) {
        if ((node = group[i]) && (subnode = selector.call(node, node.__data__, i, j))) {
          if ("__data__" in node) subnode.__data__ = node.__data__;
          d3_transitionNode(subnode, i, id, node.__transition__[id]);
          subgroup.push(subnode);
        } else {
          subgroup.push(null);
        }
      }
    }
    return d3_transition(subgroups, id);
  };
  d3_transitionPrototype.selectAll = function(selector) {
    var id = this.id, subgroups = [], subgroup, subnodes, node, subnode, transition;
    selector = d3_selection_selectorAll(selector);
    for (var j = -1, m = this.length; ++j < m; ) {
      for (var group = this[j], i = -1, n = group.length; ++i < n; ) {
        if (node = group[i]) {
          transition = node.__transition__[id];
          subnodes = selector.call(node, node.__data__, i, j);
          subgroups.push(subgroup = []);
          for (var k = -1, o = subnodes.length; ++k < o; ) {
            if (subnode = subnodes[k]) d3_transitionNode(subnode, k, id, transition);
            subgroup.push(subnode);
          }
        }
      }
    }
    return d3_transition(subgroups, id);
  };
  d3_transitionPrototype.filter = function(filter) {
    var subgroups = [], subgroup, group, node;
    if (typeof filter !== "function") filter = d3_selection_filter(filter);
    for (var j = 0, m = this.length; j < m; j++) {
      subgroups.push(subgroup = []);
      for (var group = this[j], i = 0, n = group.length; i < n; i++) {
        if ((node = group[i]) && filter.call(node, node.__data__, i)) {
          subgroup.push(node);
        }
      }
    }
    return d3_transition(subgroups, this.id);
  };
  d3_transitionPrototype.tween = function(name, tween) {
    var id = this.id;
    if (arguments.length < 2) return this.node().__transition__[id].tween.get(name);
    return d3_selection_each(this, tween == null ? function(node) {
      node.__transition__[id].tween.remove(name);
    } : function(node) {
      node.__transition__[id].tween.set(name, tween);
    });
  };
  function d3_transition_tween(groups, name, value, tween) {
    var id = groups.id;
    return d3_selection_each(groups, typeof value === "function" ? function(node, i, j) {
      node.__transition__[id].tween.set(name, tween(value.call(node, node.__data__, i, j)));
    } : (value = tween(value), function(node) {
      node.__transition__[id].tween.set(name, value);
    }));
  }
  d3_transitionPrototype.attr = function(nameNS, value) {
    if (arguments.length < 2) {
      for (value in nameNS) this.attr(value, nameNS[value]);
      return this;
    }
    var interpolate = nameNS == "transform" ? d3_interpolateTransform : d3_interpolate, name = d3.ns.qualify(nameNS);
    function attrNull() {
      this.removeAttribute(name);
    }
    function attrNullNS() {
      this.removeAttributeNS(name.space, name.local);
    }
    function attrTween(b) {
      return b == null ? attrNull : (b += "", function() {
        var a = this.getAttribute(name), i;
        return a !== b && (i = interpolate(a, b), function(t) {
          this.setAttribute(name, i(t));
        });
      });
    }
    function attrTweenNS(b) {
      return b == null ? attrNullNS : (b += "", function() {
        var a = this.getAttributeNS(name.space, name.local), i;
        return a !== b && (i = interpolate(a, b), function(t) {
          this.setAttributeNS(name.space, name.local, i(t));
        });
      });
    }
    return d3_transition_tween(this, "attr." + nameNS, value, name.local ? attrTweenNS : attrTween);
  };
  d3_transitionPrototype.attrTween = function(nameNS, tween) {
    var name = d3.ns.qualify(nameNS);
    function attrTween(d, i) {
      var f = tween.call(this, d, i, this.getAttribute(name));
      return f && function(t) {
        this.setAttribute(name, f(t));
      };
    }
    function attrTweenNS(d, i) {
      var f = tween.call(this, d, i, this.getAttributeNS(name.space, name.local));
      return f && function(t) {
        this.setAttributeNS(name.space, name.local, f(t));
      };
    }
    return this.tween("attr." + nameNS, name.local ? attrTweenNS : attrTween);
  };
  d3_transitionPrototype.style = function(name, value, priority) {
    var n = arguments.length;
    if (n < 3) {
      if (typeof name !== "string") {
        if (n < 2) value = "";
        for (priority in name) this.style(priority, name[priority], value);
        return this;
      }
      priority = "";
    }
    function styleNull() {
      this.style.removeProperty(name);
    }
    function styleString(b) {
      return b == null ? styleNull : (b += "", function() {
        var a = d3_window.getComputedStyle(this, null).getPropertyValue(name), i;
        return a !== b && (i = d3_interpolate(a, b), function(t) {
          this.style.setProperty(name, i(t), priority);
        });
      });
    }
    return d3_transition_tween(this, "style." + name, value, styleString);
  };
  d3_transitionPrototype.styleTween = function(name, tween, priority) {
    if (arguments.length < 3) priority = "";
    function styleTween(d, i) {
      var f = tween.call(this, d, i, d3_window.getComputedStyle(this, null).getPropertyValue(name));
      return f && function(t) {
        this.style.setProperty(name, f(t), priority);
      };
    }
    return this.tween("style." + name, styleTween);
  };
  d3_transitionPrototype.text = function(value) {
    return d3_transition_tween(this, "text", value, d3_transition_text);
  };
  function d3_transition_text(b) {
    if (b == null) b = "";
    return function() {
      this.textContent = b;
    };
  }
  d3_transitionPrototype.remove = function() {
    return this.each("end.transition", function() {
      var p;
      if (!this.__transition__ && (p = this.parentNode)) p.removeChild(this);
    });
  };
  d3_transitionPrototype.ease = function(value) {
    var id = this.id;
    if (arguments.length < 1) return this.node().__transition__[id].ease;
    if (typeof value !== "function") value = d3.ease.apply(d3, arguments);
    return d3_selection_each(this, function(node) {
      node.__transition__[id].ease = value;
    });
  };
  d3_transitionPrototype.delay = function(value) {
    var id = this.id;
    return d3_selection_each(this, typeof value === "function" ? function(node, i, j) {
      node.__transition__[id].delay = value.call(node, node.__data__, i, j) | 0;
    } : (value |= 0, function(node) {
      node.__transition__[id].delay = value;
    }));
  };
  d3_transitionPrototype.duration = function(value) {
    var id = this.id;
    return d3_selection_each(this, typeof value === "function" ? function(node, i, j) {
      node.__transition__[id].duration = Math.max(1, value.call(node, node.__data__, i, j) | 0);
    } : (value = Math.max(1, value | 0), function(node) {
      node.__transition__[id].duration = value;
    }));
  };
  d3_transitionPrototype.each = function(type, listener) {
    var id = this.id;
    if (arguments.length < 2) {
      var inherit = d3_transitionInherit, inheritId = d3_transitionInheritId;
      d3_transitionInheritId = id;
      d3_selection_each(this, function(node, i, j) {
        d3_transitionInherit = node.__transition__[id];
        type.call(node, node.__data__, i, j);
      });
      d3_transitionInherit = inherit;
      d3_transitionInheritId = inheritId;
    } else {
      d3_selection_each(this, function(node) {
        var transition = node.__transition__[id];
        (transition.event || (transition.event = d3.dispatch("start", "end"))).on(type, listener);
      });
    }
    return this;
  };
  d3_transitionPrototype.transition = function() {
    var id0 = this.id, id1 = ++d3_transitionId, subgroups = [], subgroup, group, node, transition;
    for (var j = 0, m = this.length; j < m; j++) {
      subgroups.push(subgroup = []);
      for (var group = this[j], i = 0, n = group.length; i < n; i++) {
        if (node = group[i]) {
          transition = Object.create(node.__transition__[id0]);
          transition.delay += transition.duration;
          d3_transitionNode(node, i, id1, transition);
        }
        subgroup.push(node);
      }
    }
    return d3_transition(subgroups, id1);
  };
  function d3_transitionNode(node, i, id, inherit) {
    var lock = node.__transition__ || (node.__transition__ = {
      active: 0,
      count: 0
    }), transition = lock[id];
    if (!transition) {
      var time = inherit.time;
      transition = lock[id] = {
        tween: new d3_Map(),
        time: time,
        ease: inherit.ease,
        delay: inherit.delay,
        duration: inherit.duration
      };
      ++lock.count;
      d3.timer(function(elapsed) {
        var d = node.__data__, ease = transition.ease, delay = transition.delay, duration = transition.duration, tweened = [];
        if (delay <= elapsed) return start(elapsed);
        d3_timer_replace(start, delay, time);
        function start(elapsed) {
          if (lock.active > id) return stop();
          lock.active = id;
          transition.event && transition.event.start.call(node, d, i);
          transition.tween.forEach(function(key, value) {
            if (value = value.call(node, d, i)) {
              tweened.push(value);
            }
          });
          if (tick(elapsed)) return 1;
          d3_timer_replace(tick, 0, time);
        }
        function tick(elapsed) {
          if (lock.active !== id) return stop();
          var t = (elapsed - delay) / duration, e = ease(t), n = tweened.length;
          while (n > 0) {
            tweened[--n].call(node, e);
          }
          if (t >= 1) {
            stop();
            transition.event && transition.event.end.call(node, d, i);
            return 1;
          }
        }
        function stop() {
          if (--lock.count) delete lock[id]; else delete node.__transition__;
          return 1;
        }
      }, 0, time);
    }
  }
  d3.svg.axis = function() {
    var scale = d3.scale.linear(), orient = d3_svg_axisDefaultOrient, tickMajorSize = 6, tickMinorSize = 6, tickEndSize = 6, tickPadding = 3, tickArguments_ = [ 10 ], tickValues = null, tickFormat_, tickSubdivide = 0;
    function axis(g) {
      g.each(function() {
        var g = d3.select(this);
        var ticks = tickValues == null ? scale.ticks ? scale.ticks.apply(scale, tickArguments_) : scale.domain() : tickValues, tickFormat = tickFormat_ == null ? scale.tickFormat ? scale.tickFormat.apply(scale, tickArguments_) : String : tickFormat_;
        var subticks = d3_svg_axisSubdivide(scale, ticks, tickSubdivide), subtick = g.selectAll(".tick.minor").data(subticks, String), subtickEnter = subtick.enter().insert("line", ".tick").attr("class", "tick minor").style("opacity", 1e-6), subtickExit = d3.transition(subtick.exit()).style("opacity", 1e-6).remove(), subtickUpdate = d3.transition(subtick).style("opacity", 1);
        var tick = g.selectAll(".tick.major").data(ticks, String), tickEnter = tick.enter().insert("g", ".domain").attr("class", "tick major").style("opacity", 1e-6), tickExit = d3.transition(tick.exit()).style("opacity", 1e-6).remove(), tickUpdate = d3.transition(tick).style("opacity", 1), tickTransform;
        var range = d3_scaleRange(scale), path = g.selectAll(".domain").data([ 0 ]), pathUpdate = (path.enter().append("path").attr("class", "domain"), 
        d3.transition(path));
        var scale1 = scale.copy(), scale0 = this.__chart__ || scale1;
        this.__chart__ = scale1;
        tickEnter.append("line");
        tickEnter.append("text");
        var lineEnter = tickEnter.select("line"), lineUpdate = tickUpdate.select("line"), text = tick.select("text").text(tickFormat), textEnter = tickEnter.select("text"), textUpdate = tickUpdate.select("text");
        switch (orient) {
         case "bottom":
          {
            tickTransform = d3_svg_axisX;
            subtickEnter.attr("y2", tickMinorSize);
            subtickUpdate.attr("x2", 0).attr("y2", tickMinorSize);
            lineEnter.attr("y2", tickMajorSize);
            textEnter.attr("y", Math.max(tickMajorSize, 0) + tickPadding);
            lineUpdate.attr("x2", 0).attr("y2", tickMajorSize);
            textUpdate.attr("x", 0).attr("y", Math.max(tickMajorSize, 0) + tickPadding);
            text.attr("dy", ".71em").style("text-anchor", "middle");
            pathUpdate.attr("d", "M" + range[0] + "," + tickEndSize + "V0H" + range[1] + "V" + tickEndSize);
            break;
          }

         case "top":
          {
            tickTransform = d3_svg_axisX;
            subtickEnter.attr("y2", -tickMinorSize);
            subtickUpdate.attr("x2", 0).attr("y2", -tickMinorSize);
            lineEnter.attr("y2", -tickMajorSize);
            textEnter.attr("y", -(Math.max(tickMajorSize, 0) + tickPadding));
            lineUpdate.attr("x2", 0).attr("y2", -tickMajorSize);
            textUpdate.attr("x", 0).attr("y", -(Math.max(tickMajorSize, 0) + tickPadding));
            text.attr("dy", "0em").style("text-anchor", "middle");
            pathUpdate.attr("d", "M" + range[0] + "," + -tickEndSize + "V0H" + range[1] + "V" + -tickEndSize);
            break;
          }

         case "left":
          {
            tickTransform = d3_svg_axisY;
            subtickEnter.attr("x2", -tickMinorSize);
            subtickUpdate.attr("x2", -tickMinorSize).attr("y2", 0);
            lineEnter.attr("x2", -tickMajorSize);
            textEnter.attr("x", -(Math.max(tickMajorSize, 0) + tickPadding));
            lineUpdate.attr("x2", -tickMajorSize).attr("y2", 0);
            textUpdate.attr("x", -(Math.max(tickMajorSize, 0) + tickPadding)).attr("y", 0);
            text.attr("dy", ".32em").style("text-anchor", "end");
            pathUpdate.attr("d", "M" + -tickEndSize + "," + range[0] + "H0V" + range[1] + "H" + -tickEndSize);
            break;
          }

         case "right":
          {
            tickTransform = d3_svg_axisY;
            subtickEnter.attr("x2", tickMinorSize);
            subtickUpdate.attr("x2", tickMinorSize).attr("y2", 0);
            lineEnter.attr("x2", tickMajorSize);
            textEnter.attr("x", Math.max(tickMajorSize, 0) + tickPadding);
            lineUpdate.attr("x2", tickMajorSize).attr("y2", 0);
            textUpdate.attr("x", Math.max(tickMajorSize, 0) + tickPadding).attr("y", 0);
            text.attr("dy", ".32em").style("text-anchor", "start");
            pathUpdate.attr("d", "M" + tickEndSize + "," + range[0] + "H0V" + range[1] + "H" + tickEndSize);
            break;
          }
        }
        if (scale.rangeBand) {
          var dx = scale1.rangeBand() / 2, x = function(d) {
            return scale1(d) + dx;
          };
          tickEnter.call(tickTransform, x);
          tickUpdate.call(tickTransform, x);
        } else {
          tickEnter.call(tickTransform, scale0);
          tickUpdate.call(tickTransform, scale1);
          tickExit.call(tickTransform, scale1);
          subtickEnter.call(tickTransform, scale0);
          subtickUpdate.call(tickTransform, scale1);
          subtickExit.call(tickTransform, scale1);
        }
      });
    }
    axis.scale = function(x) {
      if (!arguments.length) return scale;
      scale = x;
      return axis;
    };
    axis.orient = function(x) {
      if (!arguments.length) return orient;
      orient = x in d3_svg_axisOrients ? x + "" : d3_svg_axisDefaultOrient;
      return axis;
    };
    axis.ticks = function() {
      if (!arguments.length) return tickArguments_;
      tickArguments_ = arguments;
      return axis;
    };
    axis.tickValues = function(x) {
      if (!arguments.length) return tickValues;
      tickValues = x;
      return axis;
    };
    axis.tickFormat = function(x) {
      if (!arguments.length) return tickFormat_;
      tickFormat_ = x;
      return axis;
    };
    axis.tickSize = function(x, y) {
      if (!arguments.length) return tickMajorSize;
      var n = arguments.length - 1;
      tickMajorSize = +x;
      tickMinorSize = n > 1 ? +y : tickMajorSize;
      tickEndSize = n > 0 ? +arguments[n] : tickMajorSize;
      return axis;
    };
    axis.tickPadding = function(x) {
      if (!arguments.length) return tickPadding;
      tickPadding = +x;
      return axis;
    };
    axis.tickSubdivide = function(x) {
      if (!arguments.length) return tickSubdivide;
      tickSubdivide = +x;
      return axis;
    };
    return axis;
  };
  var d3_svg_axisDefaultOrient = "bottom", d3_svg_axisOrients = {
    top: 1,
    right: 1,
    bottom: 1,
    left: 1
  };
  function d3_svg_axisX(selection, x) {
    selection.attr("transform", function(d) {
      return "translate(" + x(d) + ",0)";
    });
  }
  function d3_svg_axisY(selection, y) {
    selection.attr("transform", function(d) {
      return "translate(0," + y(d) + ")";
    });
  }
  function d3_svg_axisSubdivide(scale, ticks, m) {
    subticks = [];
    if (m && ticks.length > 1) {
      var extent = d3_scaleExtent(scale.domain()), subticks, i = -1, n = ticks.length, d = (ticks[1] - ticks[0]) / ++m, j, v;
      while (++i < n) {
        for (j = m; --j > 0; ) {
          if ((v = +ticks[i] - j * d) >= extent[0]) {
            subticks.push(v);
          }
        }
      }
      for (--i, j = 0; ++j < m && (v = +ticks[i] + j * d) < extent[1]; ) {
        subticks.push(v);
      }
    }
    return subticks;
  }
  d3.svg.brush = function() {
    var event = d3_eventDispatch(brush, "brushstart", "brush", "brushend"), x = null, y = null, resizes = d3_svg_brushResizes[0], extent = [ [ 0, 0 ], [ 0, 0 ] ], clamp = [ true, true ], extentDomain;
    function brush(g) {
      g.each(function() {
        var g = d3.select(this), bg = g.selectAll(".background").data([ 0 ]), fg = g.selectAll(".extent").data([ 0 ]), tz = g.selectAll(".resize").data(resizes, String), e;
        g.style("pointer-events", "all").on("mousedown.brush", brushstart).on("touchstart.brush", brushstart);
        bg.enter().append("rect").attr("class", "background").style("visibility", "hidden").style("cursor", "crosshair");
        fg.enter().append("rect").attr("class", "extent").style("cursor", "move");
        tz.enter().append("g").attr("class", function(d) {
          return "resize " + d;
        }).style("cursor", function(d) {
          return d3_svg_brushCursor[d];
        }).append("rect").attr("x", function(d) {
          return /[ew]$/.test(d) ? -3 : null;
        }).attr("y", function(d) {
          return /^[ns]/.test(d) ? -3 : null;
        }).attr("width", 6).attr("height", 6).style("visibility", "hidden");
        tz.style("display", brush.empty() ? "none" : null);
        tz.exit().remove();
        if (x) {
          e = d3_scaleRange(x);
          bg.attr("x", e[0]).attr("width", e[1] - e[0]);
          redrawX(g);
        }
        if (y) {
          e = d3_scaleRange(y);
          bg.attr("y", e[0]).attr("height", e[1] - e[0]);
          redrawY(g);
        }
        redraw(g);
      });
    }
    function redraw(g) {
      g.selectAll(".resize").attr("transform", function(d) {
        return "translate(" + extent[+/e$/.test(d)][0] + "," + extent[+/^s/.test(d)][1] + ")";
      });
    }
    function redrawX(g) {
      g.select(".extent").attr("x", extent[0][0]);
      g.selectAll(".extent,.n>rect,.s>rect").attr("width", extent[1][0] - extent[0][0]);
    }
    function redrawY(g) {
      g.select(".extent").attr("y", extent[0][1]);
      g.selectAll(".extent,.e>rect,.w>rect").attr("height", extent[1][1] - extent[0][1]);
    }
    function brushstart() {
      var target = this, eventTarget = d3.select(d3.event.target), event_ = event.of(target, arguments), g = d3.select(target), resizing = eventTarget.datum(), resizingX = !/^(n|s)$/.test(resizing) && x, resizingY = !/^(e|w)$/.test(resizing) && y, dragging = eventTarget.classed("extent"), dragRestore = d3_event_dragSuppress(), center, origin = mouse(), offset;
      var w = d3.select(d3_window).on("keydown.brush", keydown).on("keyup.brush", keyup);
      if (d3.event.changedTouches) {
        w.on("touchmove.brush", brushmove).on("touchend.brush", brushend);
      } else {
        w.on("mousemove.brush", brushmove).on("mouseup.brush", brushend);
      }
      if (dragging) {
        origin[0] = extent[0][0] - origin[0];
        origin[1] = extent[0][1] - origin[1];
      } else if (resizing) {
        var ex = +/w$/.test(resizing), ey = +/^n/.test(resizing);
        offset = [ extent[1 - ex][0] - origin[0], extent[1 - ey][1] - origin[1] ];
        origin[0] = extent[ex][0];
        origin[1] = extent[ey][1];
      } else if (d3.event.altKey) center = origin.slice();
      g.style("pointer-events", "none").selectAll(".resize").style("display", null);
      d3.select("body").style("cursor", eventTarget.style("cursor"));
      event_({
        type: "brushstart"
      });
      brushmove();
      function mouse() {
        var touches = d3.event.changedTouches;
        return touches ? d3.touches(target, touches)[0] : d3.mouse(target);
      }
      function keydown() {
        if (d3.event.keyCode == 32) {
          if (!dragging) {
            center = null;
            origin[0] -= extent[1][0];
            origin[1] -= extent[1][1];
            dragging = 2;
          }
          d3_eventPreventDefault();
        }
      }
      function keyup() {
        if (d3.event.keyCode == 32 && dragging == 2) {
          origin[0] += extent[1][0];
          origin[1] += extent[1][1];
          dragging = 0;
          d3_eventPreventDefault();
        }
      }
      function brushmove() {
        var point = mouse(), moved = false;
        if (offset) {
          point[0] += offset[0];
          point[1] += offset[1];
        }
        if (!dragging) {
          if (d3.event.altKey) {
            if (!center) center = [ (extent[0][0] + extent[1][0]) / 2, (extent[0][1] + extent[1][1]) / 2 ];
            origin[0] = extent[+(point[0] < center[0])][0];
            origin[1] = extent[+(point[1] < center[1])][1];
          } else center = null;
        }
        if (resizingX && move1(point, x, 0)) {
          redrawX(g);
          moved = true;
        }
        if (resizingY && move1(point, y, 1)) {
          redrawY(g);
          moved = true;
        }
        if (moved) {
          redraw(g);
          event_({
            type: "brush",
            mode: dragging ? "move" : "resize"
          });
        }
      }
      function move1(point, scale, i) {
        var range = d3_scaleRange(scale), r0 = range[0], r1 = range[1], position = origin[i], size = extent[1][i] - extent[0][i], min, max;
        if (dragging) {
          r0 -= position;
          r1 -= size + position;
        }
        min = clamp[i] ? Math.max(r0, Math.min(r1, point[i])) : point[i];
        if (dragging) {
          max = (min += position) + size;
        } else {
          if (center) position = Math.max(r0, Math.min(r1, 2 * center[i] - min));
          if (position < min) {
            max = min;
            min = position;
          } else {
            max = position;
          }
        }
        if (extent[0][i] !== min || extent[1][i] !== max) {
          extentDomain = null;
          extent[0][i] = min;
          extent[1][i] = max;
          return true;
        }
      }
      function brushend() {
        brushmove();
        g.style("pointer-events", "all").selectAll(".resize").style("display", brush.empty() ? "none" : null);
        d3.select("body").style("cursor", null);
        w.on("mousemove.brush", null).on("mouseup.brush", null).on("touchmove.brush", null).on("touchend.brush", null).on("keydown.brush", null).on("keyup.brush", null);
        dragRestore();
        event_({
          type: "brushend"
        });
      }
    }
    brush.x = function(z) {
      if (!arguments.length) return x;
      x = z;
      resizes = d3_svg_brushResizes[!x << 1 | !y];
      return brush;
    };
    brush.y = function(z) {
      if (!arguments.length) return y;
      y = z;
      resizes = d3_svg_brushResizes[!x << 1 | !y];
      return brush;
    };
    brush.clamp = function(z) {
      if (!arguments.length) return x && y ? clamp : x || y ? clamp[+!x] : null;
      if (x && y) clamp = [ !!z[0], !!z[1] ]; else if (x || y) clamp[+!x] = !!z;
      return brush;
    };
    brush.extent = function(z) {
      var x0, x1, y0, y1, t;
      if (!arguments.length) {
        z = extentDomain || extent;
        if (x) {
          x0 = z[0][0], x1 = z[1][0];
          if (!extentDomain) {
            x0 = extent[0][0], x1 = extent[1][0];
            if (x.invert) x0 = x.invert(x0), x1 = x.invert(x1);
            if (x1 < x0) t = x0, x0 = x1, x1 = t;
          }
        }
        if (y) {
          y0 = z[0][1], y1 = z[1][1];
          if (!extentDomain) {
            y0 = extent[0][1], y1 = extent[1][1];
            if (y.invert) y0 = y.invert(y0), y1 = y.invert(y1);
            if (y1 < y0) t = y0, y0 = y1, y1 = t;
          }
        }
        return x && y ? [ [ x0, y0 ], [ x1, y1 ] ] : x ? [ x0, x1 ] : y && [ y0, y1 ];
      }
      extentDomain = [ [ 0, 0 ], [ 0, 0 ] ];
      if (x) {
        x0 = z[0], x1 = z[1];
        if (y) x0 = x0[0], x1 = x1[0];
        extentDomain[0][0] = x0, extentDomain[1][0] = x1;
        if (x.invert) x0 = x(x0), x1 = x(x1);
        if (x1 < x0) t = x0, x0 = x1, x1 = t;
        extent[0][0] = x0 | 0, extent[1][0] = x1 | 0;
      }
      if (y) {
        y0 = z[0], y1 = z[1];
        if (x) y0 = y0[1], y1 = y1[1];
        extentDomain[0][1] = y0, extentDomain[1][1] = y1;
        if (y.invert) y0 = y(y0), y1 = y(y1);
        if (y1 < y0) t = y0, y0 = y1, y1 = t;
        extent[0][1] = y0 | 0, extent[1][1] = y1 | 0;
      }
      return brush;
    };
    brush.clear = function() {
      extentDomain = null;
      extent[0][0] = extent[0][1] = extent[1][0] = extent[1][1] = 0;
      return brush;
    };
    brush.empty = function() {
      return x && extent[0][0] === extent[1][0] || y && extent[0][1] === extent[1][1];
    };
    return d3.rebind(brush, event, "on");
  };
  var d3_svg_brushCursor = {
    n: "ns-resize",
    e: "ew-resize",
    s: "ns-resize",
    w: "ew-resize",
    nw: "nwse-resize",
    ne: "nesw-resize",
    se: "nwse-resize",
    sw: "nesw-resize"
  };
  var d3_svg_brushResizes = [ [ "n", "e", "s", "w", "nw", "ne", "se", "sw" ], [ "e", "w" ], [ "n", "s" ], [] ];
  d3.time = {};
  var d3_time = Date, d3_time_daySymbols = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ];
  function d3_time_utc() {
    this._ = new Date(arguments.length > 1 ? Date.UTC.apply(this, arguments) : arguments[0]);
  }
  d3_time_utc.prototype = {
    getDate: function() {
      return this._.getUTCDate();
    },
    getDay: function() {
      return this._.getUTCDay();
    },
    getFullYear: function() {
      return this._.getUTCFullYear();
    },
    getHours: function() {
      return this._.getUTCHours();
    },
    getMilliseconds: function() {
      return this._.getUTCMilliseconds();
    },
    getMinutes: function() {
      return this._.getUTCMinutes();
    },
    getMonth: function() {
      return this._.getUTCMonth();
    },
    getSeconds: function() {
      return this._.getUTCSeconds();
    },
    getTime: function() {
      return this._.getTime();
    },
    getTimezoneOffset: function() {
      return 0;
    },
    valueOf: function() {
      return this._.valueOf();
    },
    setDate: function() {
      d3_time_prototype.setUTCDate.apply(this._, arguments);
    },
    setDay: function() {
      d3_time_prototype.setUTCDay.apply(this._, arguments);
    },
    setFullYear: function() {
      d3_time_prototype.setUTCFullYear.apply(this._, arguments);
    },
    setHours: function() {
      d3_time_prototype.setUTCHours.apply(this._, arguments);
    },
    setMilliseconds: function() {
      d3_time_prototype.setUTCMilliseconds.apply(this._, arguments);
    },
    setMinutes: function() {
      d3_time_prototype.setUTCMinutes.apply(this._, arguments);
    },
    setMonth: function() {
      d3_time_prototype.setUTCMonth.apply(this._, arguments);
    },
    setSeconds: function() {
      d3_time_prototype.setUTCSeconds.apply(this._, arguments);
    },
    setTime: function() {
      d3_time_prototype.setTime.apply(this._, arguments);
    }
  };
  var d3_time_prototype = Date.prototype;
  var d3_time_formatDateTime = "%a %b %e %X %Y", d3_time_formatDate = "%m/%d/%Y", d3_time_formatTime = "%H:%M:%S";
  var d3_time_days = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" ], d3_time_dayAbbreviations = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ], d3_time_months = [ "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December" ], d3_time_monthAbbreviations = [ "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" ];
  function d3_time_interval(local, step, number) {
    function round(date) {
      var d0 = local(date), d1 = offset(d0, 1);
      return date - d0 < d1 - date ? d0 : d1;
    }
    function ceil(date) {
      step(date = local(new d3_time(date - 1)), 1);
      return date;
    }
    function offset(date, k) {
      step(date = new d3_time(+date), k);
      return date;
    }
    function range(t0, t1, dt) {
      var time = ceil(t0), times = [];
      if (dt > 1) {
        while (time < t1) {
          if (!(number(time) % dt)) times.push(new Date(+time));
          step(time, 1);
        }
      } else {
        while (time < t1) times.push(new Date(+time)), step(time, 1);
      }
      return times;
    }
    function range_utc(t0, t1, dt) {
      try {
        d3_time = d3_time_utc;
        var utc = new d3_time_utc();
        utc._ = t0;
        return range(utc, t1, dt);
      } finally {
        d3_time = Date;
      }
    }
    local.floor = local;
    local.round = round;
    local.ceil = ceil;
    local.offset = offset;
    local.range = range;
    var utc = local.utc = d3_time_interval_utc(local);
    utc.floor = utc;
    utc.round = d3_time_interval_utc(round);
    utc.ceil = d3_time_interval_utc(ceil);
    utc.offset = d3_time_interval_utc(offset);
    utc.range = range_utc;
    return local;
  }
  function d3_time_interval_utc(method) {
    return function(date, k) {
      try {
        d3_time = d3_time_utc;
        var utc = new d3_time_utc();
        utc._ = date;
        return method(utc, k)._;
      } finally {
        d3_time = Date;
      }
    };
  }
  d3.time.year = d3_time_interval(function(date) {
    date = d3.time.day(date);
    date.setMonth(0, 1);
    return date;
  }, function(date, offset) {
    date.setFullYear(date.getFullYear() + offset);
  }, function(date) {
    return date.getFullYear();
  });
  d3.time.years = d3.time.year.range;
  d3.time.years.utc = d3.time.year.utc.range;
  d3.time.day = d3_time_interval(function(date) {
    var day = new d3_time(2e3, 0);
    day.setFullYear(date.getFullYear(), date.getMonth(), date.getDate());
    return day;
  }, function(date, offset) {
    date.setDate(date.getDate() + offset);
  }, function(date) {
    return date.getDate() - 1;
  });
  d3.time.days = d3.time.day.range;
  d3.time.days.utc = d3.time.day.utc.range;
  d3.time.dayOfYear = function(date) {
    var year = d3.time.year(date);
    return Math.floor((date - year - (date.getTimezoneOffset() - year.getTimezoneOffset()) * 6e4) / 864e5);
  };
  d3_time_daySymbols.forEach(function(day, i) {
    day = day.toLowerCase();
    i = 7 - i;
    var interval = d3.time[day] = d3_time_interval(function(date) {
      (date = d3.time.day(date)).setDate(date.getDate() - (date.getDay() + i) % 7);
      return date;
    }, function(date, offset) {
      date.setDate(date.getDate() + Math.floor(offset) * 7);
    }, function(date) {
      var day = d3.time.year(date).getDay();
      return Math.floor((d3.time.dayOfYear(date) + (day + i) % 7) / 7) - (day !== i);
    });
    d3.time[day + "s"] = interval.range;
    d3.time[day + "s"].utc = interval.utc.range;
    d3.time[day + "OfYear"] = function(date) {
      var day = d3.time.year(date).getDay();
      return Math.floor((d3.time.dayOfYear(date) + (day + i) % 7) / 7);
    };
  });
  d3.time.week = d3.time.sunday;
  d3.time.weeks = d3.time.sunday.range;
  d3.time.weeks.utc = d3.time.sunday.utc.range;
  d3.time.weekOfYear = d3.time.sundayOfYear;
  d3.time.format = function(template) {
    var n = template.length;
    function format(date) {
      var string = [], i = -1, j = 0, c, p, f;
      while (++i < n) {
        if (template.charCodeAt(i) === 37) {
          string.push(template.substring(j, i));
          if ((p = d3_time_formatPads[c = template.charAt(++i)]) != null) c = template.charAt(++i);
          if (f = d3_time_formats[c]) c = f(date, p == null ? c === "e" ? " " : "0" : p);
          string.push(c);
          j = i + 1;
        }
      }
      string.push(template.substring(j, i));
      return string.join("");
    }
    format.parse = function(string) {
      var d = {
        y: 1900,
        m: 0,
        d: 1,
        H: 0,
        M: 0,
        S: 0,
        L: 0
      }, i = d3_time_parse(d, template, string, 0);
      if (i != string.length) return null;
      if ("p" in d) d.H = d.H % 12 + d.p * 12;
      var date = new d3_time();
      if ("j" in d) date.setFullYear(d.y, 0, d.j); else if ("w" in d && ("W" in d || "U" in d)) {
        date.setFullYear(d.y, 0, 1);
        date.setFullYear(d.y, 0, "W" in d ? (d.w + 6) % 7 + d.W * 7 - (date.getDay() + 5) % 7 : d.w + d.U * 7 - (date.getDay() + 6) % 7);
      } else date.setFullYear(d.y, d.m, d.d);
      date.setHours(d.H, d.M, d.S, d.L);
      return date;
    };
    format.toString = function() {
      return template;
    };
    return format;
  };
  function d3_time_parse(date, template, string, j) {
    var c, p, i = 0, n = template.length, m = string.length;
    while (i < n) {
      if (j >= m) return -1;
      c = template.charCodeAt(i++);
      if (c === 37) {
        p = d3_time_parsers[template.charAt(i++)];
        if (!p || (j = p(date, string, j)) < 0) return -1;
      } else if (c != string.charCodeAt(j++)) {
        return -1;
      }
    }
    return j;
  }
  function d3_time_formatRe(names) {
    return new RegExp("^(?:" + names.map(d3.requote).join("|") + ")", "i");
  }
  function d3_time_formatLookup(names) {
    var map = new d3_Map(), i = -1, n = names.length;
    while (++i < n) map.set(names[i].toLowerCase(), i);
    return map;
  }
  function d3_time_formatPad(value, fill, width) {
    var sign = value < 0 ? "-" : "", string = (sign ? -value : value) + "", length = string.length;
    return sign + (length < width ? new Array(width - length + 1).join(fill) + string : string);
  }
  var d3_time_dayRe = d3_time_formatRe(d3_time_days), d3_time_dayLookup = d3_time_formatLookup(d3_time_days), d3_time_dayAbbrevRe = d3_time_formatRe(d3_time_dayAbbreviations), d3_time_dayAbbrevLookup = d3_time_formatLookup(d3_time_dayAbbreviations), d3_time_monthRe = d3_time_formatRe(d3_time_months), d3_time_monthLookup = d3_time_formatLookup(d3_time_months), d3_time_monthAbbrevRe = d3_time_formatRe(d3_time_monthAbbreviations), d3_time_monthAbbrevLookup = d3_time_formatLookup(d3_time_monthAbbreviations), d3_time_percentRe = /^%/;
  var d3_time_formatPads = {
    "-": "",
    _: " ",
    "0": "0"
  };
  var d3_time_formats = {
    a: function(d) {
      return d3_time_dayAbbreviations[d.getDay()];
    },
    A: function(d) {
      return d3_time_days[d.getDay()];
    },
    b: function(d) {
      return d3_time_monthAbbreviations[d.getMonth()];
    },
    B: function(d) {
      return d3_time_months[d.getMonth()];
    },
    c: d3.time.format(d3_time_formatDateTime),
    d: function(d, p) {
      return d3_time_formatPad(d.getDate(), p, 2);
    },
    e: function(d, p) {
      return d3_time_formatPad(d.getDate(), p, 2);
    },
    H: function(d, p) {
      return d3_time_formatPad(d.getHours(), p, 2);
    },
    I: function(d, p) {
      return d3_time_formatPad(d.getHours() % 12 || 12, p, 2);
    },
    j: function(d, p) {
      return d3_time_formatPad(1 + d3.time.dayOfYear(d), p, 3);
    },
    L: function(d, p) {
      return d3_time_formatPad(d.getMilliseconds(), p, 3);
    },
    m: function(d, p) {
      return d3_time_formatPad(d.getMonth() + 1, p, 2);
    },
    M: function(d, p) {
      return d3_time_formatPad(d.getMinutes(), p, 2);
    },
    p: function(d) {
      return d.getHours() >= 12 ? "PM" : "AM";
    },
    S: function(d, p) {
      return d3_time_formatPad(d.getSeconds(), p, 2);
    },
    U: function(d, p) {
      return d3_time_formatPad(d3.time.sundayOfYear(d), p, 2);
    },
    w: function(d) {
      return d.getDay();
    },
    W: function(d, p) {
      return d3_time_formatPad(d3.time.mondayOfYear(d), p, 2);
    },
    x: d3.time.format(d3_time_formatDate),
    X: d3.time.format(d3_time_formatTime),
    y: function(d, p) {
      return d3_time_formatPad(d.getFullYear() % 100, p, 2);
    },
    Y: function(d, p) {
      return d3_time_formatPad(d.getFullYear() % 1e4, p, 4);
    },
    Z: d3_time_zone,
    "%": function() {
      return "%";
    }
  };
  var d3_time_parsers = {
    a: d3_time_parseWeekdayAbbrev,
    A: d3_time_parseWeekday,
    b: d3_time_parseMonthAbbrev,
    B: d3_time_parseMonth,
    c: d3_time_parseLocaleFull,
    d: d3_time_parseDay,
    e: d3_time_parseDay,
    H: d3_time_parseHour24,
    I: d3_time_parseHour24,
    j: d3_time_parseDayOfYear,
    L: d3_time_parseMilliseconds,
    m: d3_time_parseMonthNumber,
    M: d3_time_parseMinutes,
    p: d3_time_parseAmPm,
    S: d3_time_parseSeconds,
    U: d3_time_parseWeekNumberSunday,
    w: d3_time_parseWeekdayNumber,
    W: d3_time_parseWeekNumberMonday,
    x: d3_time_parseLocaleDate,
    X: d3_time_parseLocaleTime,
    y: d3_time_parseYear,
    Y: d3_time_parseFullYear,
    "%": d3_time_parseLiteralPercent
  };
  function d3_time_parseWeekdayAbbrev(date, string, i) {
    d3_time_dayAbbrevRe.lastIndex = 0;
    var n = d3_time_dayAbbrevRe.exec(string.substring(i));
    return n ? (date.w = d3_time_dayAbbrevLookup.get(n[0].toLowerCase()), i + n[0].length) : -1;
  }
  function d3_time_parseWeekday(date, string, i) {
    d3_time_dayRe.lastIndex = 0;
    var n = d3_time_dayRe.exec(string.substring(i));
    return n ? (date.w = d3_time_dayLookup.get(n[0].toLowerCase()), i + n[0].length) : -1;
  }
  function d3_time_parseWeekdayNumber(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 1));
    return n ? (date.w = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseWeekNumberSunday(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i));
    return n ? (date.U = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseWeekNumberMonday(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i));
    return n ? (date.W = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseMonthAbbrev(date, string, i) {
    d3_time_monthAbbrevRe.lastIndex = 0;
    var n = d3_time_monthAbbrevRe.exec(string.substring(i));
    return n ? (date.m = d3_time_monthAbbrevLookup.get(n[0].toLowerCase()), i + n[0].length) : -1;
  }
  function d3_time_parseMonth(date, string, i) {
    d3_time_monthRe.lastIndex = 0;
    var n = d3_time_monthRe.exec(string.substring(i));
    return n ? (date.m = d3_time_monthLookup.get(n[0].toLowerCase()), i + n[0].length) : -1;
  }
  function d3_time_parseLocaleFull(date, string, i) {
    return d3_time_parse(date, d3_time_formats.c.toString(), string, i);
  }
  function d3_time_parseLocaleDate(date, string, i) {
    return d3_time_parse(date, d3_time_formats.x.toString(), string, i);
  }
  function d3_time_parseLocaleTime(date, string, i) {
    return d3_time_parse(date, d3_time_formats.X.toString(), string, i);
  }
  function d3_time_parseFullYear(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 4));
    return n ? (date.y = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseYear(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.y = d3_time_expandYear(+n[0]), i + n[0].length) : -1;
  }
  function d3_time_expandYear(d) {
    return d + (d > 68 ? 1900 : 2e3);
  }
  function d3_time_parseMonthNumber(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.m = n[0] - 1, i + n[0].length) : -1;
  }
  function d3_time_parseDay(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.d = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseDayOfYear(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 3));
    return n ? (date.j = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseHour24(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.H = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseMinutes(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.M = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseSeconds(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 2));
    return n ? (date.S = +n[0], i + n[0].length) : -1;
  }
  function d3_time_parseMilliseconds(date, string, i) {
    d3_time_numberRe.lastIndex = 0;
    var n = d3_time_numberRe.exec(string.substring(i, i + 3));
    return n ? (date.L = +n[0], i + n[0].length) : -1;
  }
  var d3_time_numberRe = /^\s*\d+/;
  function d3_time_parseAmPm(date, string, i) {
    var n = d3_time_amPmLookup.get(string.substring(i, i += 2).toLowerCase());
    return n == null ? -1 : (date.p = n, i);
  }
  var d3_time_amPmLookup = d3.map({
    am: 0,
    pm: 1
  });
  function d3_time_zone(d) {
    var z = d.getTimezoneOffset(), zs = z > 0 ? "-" : "+", zh = ~~(Math.abs(z) / 60), zm = Math.abs(z) % 60;
    return zs + d3_time_formatPad(zh, "0", 2) + d3_time_formatPad(zm, "0", 2);
  }
  function d3_time_parseLiteralPercent(date, string, i) {
    d3_time_percentRe.lastIndex = 0;
    var n = d3_time_percentRe.exec(string.substring(i, i + 1));
    return n ? i + n[0].length : -1;
  }
  d3.time.format.utc = function(template) {
    var local = d3.time.format(template);
    function format(date) {
      try {
        d3_time = d3_time_utc;
        var utc = new d3_time();
        utc._ = date;
        return local(utc);
      } finally {
        d3_time = Date;
      }
    }
    format.parse = function(string) {
      try {
        d3_time = d3_time_utc;
        var date = local.parse(string);
        return date && date._;
      } finally {
        d3_time = Date;
      }
    };
    format.toString = local.toString;
    return format;
  };
  var d3_time_formatIso = d3.time.format.utc("%Y-%m-%dT%H:%M:%S.%LZ");
  d3.time.format.iso = Date.prototype.toISOString && +new Date("2000-01-01T00:00:00.000Z") ? d3_time_formatIsoNative : d3_time_formatIso;
  function d3_time_formatIsoNative(date) {
    return date.toISOString();
  }
  d3_time_formatIsoNative.parse = function(string) {
    var date = new Date(string);
    return isNaN(date) ? null : date;
  };
  d3_time_formatIsoNative.toString = d3_time_formatIso.toString;
  d3.time.second = d3_time_interval(function(date) {
    return new d3_time(Math.floor(date / 1e3) * 1e3);
  }, function(date, offset) {
    date.setTime(date.getTime() + Math.floor(offset) * 1e3);
  }, function(date) {
    return date.getSeconds();
  });
  d3.time.seconds = d3.time.second.range;
  d3.time.seconds.utc = d3.time.second.utc.range;
  d3.time.minute = d3_time_interval(function(date) {
    return new d3_time(Math.floor(date / 6e4) * 6e4);
  }, function(date, offset) {
    date.setTime(date.getTime() + Math.floor(offset) * 6e4);
  }, function(date) {
    return date.getMinutes();
  });
  d3.time.minutes = d3.time.minute.range;
  d3.time.minutes.utc = d3.time.minute.utc.range;
  d3.time.hour = d3_time_interval(function(date) {
    var timezone = date.getTimezoneOffset() / 60;
    return new d3_time((Math.floor(date / 36e5 - timezone) + timezone) * 36e5);
  }, function(date, offset) {
    date.setTime(date.getTime() + Math.floor(offset) * 36e5);
  }, function(date) {
    return date.getHours();
  });
  d3.time.hours = d3.time.hour.range;
  d3.time.hours.utc = d3.time.hour.utc.range;
  d3.time.month = d3_time_interval(function(date) {
    date = d3.time.day(date);
    date.setDate(1);
    return date;
  }, function(date, offset) {
    date.setMonth(date.getMonth() + offset);
  }, function(date) {
    return date.getMonth();
  });
  d3.time.months = d3.time.month.range;
  d3.time.months.utc = d3.time.month.utc.range;
  function d3_time_scale(linear, methods, format) {
    function scale(x) {
      return linear(x);
    }
    scale.invert = function(x) {
      return d3_time_scaleDate(linear.invert(x));
    };
    scale.domain = function(x) {
      if (!arguments.length) return linear.domain().map(d3_time_scaleDate);
      linear.domain(x);
      return scale;
    };
    scale.nice = function(m) {
      return scale.domain(d3_scale_nice(scale.domain(), m));
    };
    scale.ticks = function(m, k) {
      var extent = d3_scaleExtent(scale.domain());
      if (typeof m !== "function") {
        var span = extent[1] - extent[0], target = span / m, i = d3.bisect(d3_time_scaleSteps, target);
        if (i == d3_time_scaleSteps.length) return methods.year(extent, m);
        if (!i) return linear.ticks(m).map(d3_time_scaleDate);
        if (target / d3_time_scaleSteps[i - 1] < d3_time_scaleSteps[i] / target) --i;
        m = methods[i];
        k = m[1];
        m = m[0].range;
      }
      return m(extent[0], new Date(+extent[1] + 1), k);
    };
    scale.tickFormat = function() {
      return format;
    };
    scale.copy = function() {
      return d3_time_scale(linear.copy(), methods, format);
    };
    return d3_scale_linearRebind(scale, linear);
  }
  function d3_time_scaleDate(t) {
    return new Date(t);
  }
  function d3_time_scaleFormat(formats) {
    return function(date) {
      var i = formats.length - 1, f = formats[i];
      while (!f[1](date)) f = formats[--i];
      return f[0](date);
    };
  }
  function d3_time_scaleSetYear(y) {
    var d = new Date(y, 0, 1);
    d.setFullYear(y);
    return d;
  }
  function d3_time_scaleGetYear(d) {
    var y = d.getFullYear(), d0 = d3_time_scaleSetYear(y), d1 = d3_time_scaleSetYear(y + 1);
    return y + (d - d0) / (d1 - d0);
  }
  var d3_time_scaleSteps = [ 1e3, 5e3, 15e3, 3e4, 6e4, 3e5, 9e5, 18e5, 36e5, 108e5, 216e5, 432e5, 864e5, 1728e5, 6048e5, 2592e6, 7776e6, 31536e6 ];
  var d3_time_scaleLocalMethods = [ [ d3.time.second, 1 ], [ d3.time.second, 5 ], [ d3.time.second, 15 ], [ d3.time.second, 30 ], [ d3.time.minute, 1 ], [ d3.time.minute, 5 ], [ d3.time.minute, 15 ], [ d3.time.minute, 30 ], [ d3.time.hour, 1 ], [ d3.time.hour, 3 ], [ d3.time.hour, 6 ], [ d3.time.hour, 12 ], [ d3.time.day, 1 ], [ d3.time.day, 2 ], [ d3.time.week, 1 ], [ d3.time.month, 1 ], [ d3.time.month, 3 ], [ d3.time.year, 1 ] ];
  var d3_time_scaleLocalFormats = [ [ d3.time.format("%Y"), d3_true ], [ d3.time.format("%B"), function(d) {
    return d.getMonth();
  } ], [ d3.time.format("%b %d"), function(d) {
    return d.getDate() != 1;
  } ], [ d3.time.format("%a %d"), function(d) {
    return d.getDay() && d.getDate() != 1;
  } ], [ d3.time.format("%I %p"), function(d) {
    return d.getHours();
  } ], [ d3.time.format("%I:%M"), function(d) {
    return d.getMinutes();
  } ], [ d3.time.format(":%S"), function(d) {
    return d.getSeconds();
  } ], [ d3.time.format(".%L"), function(d) {
    return d.getMilliseconds();
  } ] ];
  var d3_time_scaleLinear = d3.scale.linear(), d3_time_scaleLocalFormat = d3_time_scaleFormat(d3_time_scaleLocalFormats);
  d3_time_scaleLocalMethods.year = function(extent, m) {
    return d3_time_scaleLinear.domain(extent.map(d3_time_scaleGetYear)).ticks(m).map(d3_time_scaleSetYear);
  };
  d3.time.scale = function() {
    return d3_time_scale(d3.scale.linear(), d3_time_scaleLocalMethods, d3_time_scaleLocalFormat);
  };
  var d3_time_scaleUTCMethods = d3_time_scaleLocalMethods.map(function(m) {
    return [ m[0].utc, m[1] ];
  });
  var d3_time_scaleUTCFormats = [ [ d3.time.format.utc("%Y"), d3_true ], [ d3.time.format.utc("%B"), function(d) {
    return d.getUTCMonth();
  } ], [ d3.time.format.utc("%b %d"), function(d) {
    return d.getUTCDate() != 1;
  } ], [ d3.time.format.utc("%a %d"), function(d) {
    return d.getUTCDay() && d.getUTCDate() != 1;
  } ], [ d3.time.format.utc("%I %p"), function(d) {
    return d.getUTCHours();
  } ], [ d3.time.format.utc("%I:%M"), function(d) {
    return d.getUTCMinutes();
  } ], [ d3.time.format.utc(":%S"), function(d) {
    return d.getUTCSeconds();
  } ], [ d3.time.format.utc(".%L"), function(d) {
    return d.getUTCMilliseconds();
  } ] ];
  var d3_time_scaleUTCFormat = d3_time_scaleFormat(d3_time_scaleUTCFormats);
  function d3_time_scaleUTCSetYear(y) {
    var d = new Date(Date.UTC(y, 0, 1));
    d.setUTCFullYear(y);
    return d;
  }
  function d3_time_scaleUTCGetYear(d) {
    var y = d.getUTCFullYear(), d0 = d3_time_scaleUTCSetYear(y), d1 = d3_time_scaleUTCSetYear(y + 1);
    return y + (d - d0) / (d1 - d0);
  }
  d3_time_scaleUTCMethods.year = function(extent, m) {
    return d3_time_scaleLinear.domain(extent.map(d3_time_scaleUTCGetYear)).ticks(m).map(d3_time_scaleUTCSetYear);
  };
  d3.time.scale.utc = function() {
    return d3_time_scale(d3.scale.linear(), d3_time_scaleUTCMethods, d3_time_scaleUTCFormat);
  };
  d3.text = d3_xhrType(function(request) {
    return request.responseText;
  });
  d3.json = function(url, callback) {
    return d3_xhr(url, "application/json", d3_json, callback);
  };
  function d3_json(request) {
    return JSON.parse(request.responseText);
  }
  d3.html = function(url, callback) {
    return d3_xhr(url, "text/html", d3_html, callback);
  };
  function d3_html(request) {
    var range = d3_document.createRange();
    range.selectNode(d3_document.body);
    return range.createContextualFragment(request.responseText);
  }
  d3.xml = d3_xhrType(function(request) {
    return request.responseXML;
  });
  return d3;
}();
</script>

<script>
LDAvis = function(to_select, json_file) {

    // This section sets up the logic for event handling
    var current_clicked = {
        what: "nothing",
        element: undefined
    },
    current_hover = {
        what: "nothing",
        element: undefined
    },
    old_winning_state = {
        what: "nothing",
        element: undefined
    },
    vis_state = {
        lambda: 1,
        topic: 0,
        term: ""
    };

    // Set up a few 'global' variables to hold the data:
    var K, // number of topics 
    R, // number of terms to display in bar chart
    mdsData, // (x,y) locations and topic proportions
    mdsData3, // topic proportions for all terms in the viz
    lamData, // all terms that are among the top-R most relevant for all topics, lambda values
    lambda = {
        old: 1,
        current: 1
    },
    color1 = "#1f77b4", // baseline color for default topic circles and overall term frequencies
    color2 = "#d62728"; // 'highlight' color for selected topics and term-topic frequencies

    // Set the duration of each half of the transition:
    var duration = 750;

    // Set global margins used for everything
    var margin = {
        top: 30,
        right: 30,
        bottom: 70,
        left: 30
    },
    mdswidth = 530,
    mdsheight = 530,
    barwidth = 530,
    barheight = 530,
    termwidth = 90, // width to add between two panels to display terms
    mdsarea = mdsheight * mdswidth;
    // controls how big the maximum circle can be
    // doesn't depend on data, only on mds width and height:
    var rMax = 60;  

    // proportion of area of MDS plot to which the sum of default topic circle areas is set
    var circle_prop = 0.25;
    var word_prop = 0.25;

    // opacity of topic circles:
    var base_opacity = 0.2,
    highlight_opacity = 0.6;

    // topic/lambda selection names are specific to *this* vis
    var topic_select = to_select + "-topic";
    var lambda_select = to_select + "-lambda";

    // get rid of the # in the to_select (useful) for setting ID values
    var parts = to_select.split("#");
    var visID = parts[parts.length - 1];
    var topicID = visID + "-topic";
    var lambdaID = visID + "-lambda";
    var termID = visID + "-term";
    var topicDown = topicID + "-down";
    var topicUp = topicID + "-up";
    var topicClear = topicID + "-clear";

    //////////////////////////////////////////////////////////////////////////////

    // sort array according to a specified object key name 
    // Note that default is decreasing sort, set decreasing = -1 for increasing
    // adpated from http://stackoverflow.com/questions/16648076/sort-array-on-key-value
    function fancysort(key_name, decreasing) {
        decreasing = (typeof decreasing === "undefined") ? 1 : decreasing;
        return function(a, b) {
            if (a[key_name] < b[key_name])
                return 1 * decreasing;
            if (a[key_name] > b[key_name])
                return -1 * decreasing;
            return 0;
        };
    }


    // The actual read-in of the data and main code:
    data = JSON.parse("{\"mdsDat\":{\"x\":[206.5758,216.4491,466.2391,-121.964,-406.9431,430.8889,-197.6722,-425.7278,-7.9979,200.2859,-323.4347,-157.2192,642.4397,-396.6874,251.5574,-164.7052,-86.3055,374.1906,-234.1392,172.8853,-681.7168,25.9232,-484.6752,24.7754,59.6204,649.5235,481.4588,419.7671,-627.9748,-700.5634,-286.8159,730.7466,-31.7198,232.7056,149.8829,-399.6532],\"y\":[-158.9592,49.1063,208.2602,-718.5358,248.2164,-572.9122,-29.2813,-173.8864,373.7123,492.4604,-372.8042,169.221,-35.8226,-637.5397,753.1226,-221.8084,-459.1921,-317.2524,414.2184,-722.4871,230.0744,-32.1936,482.3359,-243.382,173.9863,-333.6369,487.1488,-55.0224,-398.6444,-73.1921,736.6963,226.0365,626.6383,284.2636,-441.1238,42.1788],\"topics\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36],\"Freq\":[5.9498,5.5873,5.5278,4.9469,4.3634,4.2054,4.193,3.87,3.4148,3.2792,3.2573,3.0629,3.026,2.7901,2.717,2.6343,2.5217,2.4184,2.3245,2.3204,2.203,2.1106,1.8997,1.8868,1.8732,1.8322,1.7773,1.7602,1.7468,1.6908,1.6029,1.5884,1.5186,1.4239,1.3714,1.3041],\"cluster\":[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1]},\"tinfo\":{\"Term\":[\"film\",\"star\",\"final\",\"half\",\"develop\",\"product\",\"releas\",\"share\",\"offic\",\"perform\",\"british\",\"state\",\"control\",\"name\",\"produc\",\"general\",\"find\",\"X2005\",\"great\",\"lost\",\"system\",\"busi\",\"success\",\"role\",\"spokesman\",\"realli\",\"miss\",\"without\",\"took\",\"lot\",\"straw\",\"jack\",\"blunkett\",\"foreign\",\"secretari\",\"drink\",\"korea\",\"detain\",\"justifi\",\"legisl\",\"terrorist\",\"opt\",\"constitut\",\"david\",\"agricultur\",\"liberti\",\"recommend\",\"recruit\",\"sheffield\",\"resign\",\"conduct\",\"summit\",\"apologis\",\"status\",\"china\",\"citizen\",\"formal\",\"affair\",\"prosecut\",\"suspect\",\"dvds\",\"cinema\",\"hollywood\",\"dvd\",\"disc\",\"studio\",\"documentari\",\"sequel\",\"pirat\",\"movi\",\"festiv\",\"comedi\",\"anim\",\"episod\",\"film\",\"screen\",\"adapt\",\"ticket\",\"scorses\",\"gamer\",\"motion\",\"oscar\",\"drama\",\"pictur\",\"theatr\",\"format\",\"ray\",\"viewer\",\"actor\",\"techniqu\",\"itun\",\"ipod\",\"album\",\"appl\",\"portabl\",\"song\",\"gadget\",\"music\",\"purchas\",\"digit\",\"concert\",\"copyright\",\"download\",\"rapper\",\"piraci\",\"rap\",\"storag\",\"creativ\",\"store\",\"compil\",\"broadband\",\"devic\",\"tune\",\"upgrad\",\"model\",\"format\",\"wireless\",\"stone\",\"incorpor\",\"label\",\"milburn\",\"alan\",\"brown\",\"gordon\",\"chancellor\",\"backbench\",\"suspicion\",\"alli\",\"welfar\",\"manifesto\",\"treasuri\",\"poverti\",\"X1bn\",\"stabil\",\"prioriti\",\"none\",\"articl\",\"dismiss\",\"poster\",\"pension\",\"ordin\",\"letwin\",\"journalist\",\"strategi\",\"pledg\",\"asid\",\"diseas\",\"mortgag\",\"parliamentari\",\"theme\",\"oliv\",\"constitu\",\"letwin\",\"shadow\",\"conserv\",\"parti\",\"tax\",\"tori\",\"seat\",\"labour\",\"candid\",\"elect\",\"offens\",\"vote\",\"council\",\"assembl\",\"X1997\",\"chancellor\",\"poster\",\"school\",\"voter\",\"howard\",\"spend\",\"equival\",\"pledg\",\"mps\",\"oblig\",\"pension\",\"choic\",\"prime\",\"gdp\",\"economist\",\"export\",\"currenc\",\"domest\",\"deficit\",\"slowdown\",\"outlook\",\"monetari\",\"recoveri\",\"fiscal\",\"index\",\"expans\",\"forecast\",\"slide\",\"gross\",\"yen\",\"grew\",\"growth\",\"slow\",\"economi\",\"X7bn\",\"econom\",\"sector\",\"weak\",\"commerc\",\"adjust\",\"euro\",\"bank\",\"oil\",\"hodgson\",\"charli\",\"robinson\",\"rugbi\",\"prop\",\"rbs\",\"kick\",\"england\",\"refere\",\"coach\",\"andi\",\"steven\",\"newcastl\",\"penalti\",\"ireland\",\"dublin\",\"captain\",\"ball\",\"jason\",\"irish\",\"matt\",\"wale\",\"flanker\",\"franc\",\"zealand\",\"scotland\",\"injuri\",\"squad\",\"club\",\"skipper\",\"poster\",\"liam\",\"suspicion\",\"fox\",\"agenda\",\"down\",\"offens\",\"brief\",\"spring\",\"backbench\",\"milburn\",\"weapon\",\"welfar\",\"letwin\",\"whatev\",\"manifesto\",\"iraq\",\"commission\",\"intent\",\"campaign\",\"undermin\",\"trick\",\"amid\",\"pledg\",\"seat\",\"journalist\",\"unemploy\",\"oliv\",\"ordin\",\"mortgag\",\"elector\",\"manifesto\",\"invit\",\"elect\",\"poll\",\"seat\",\"voter\",\"reform\",\"forthcom\",\"prime\",\"polit\",\"constitu\",\"assembl\",\"suspicion\",\"candid\",\"constitut\",\"brief\",\"societi\",\"pledg\",\"general\",\"paper\",\"spring\",\"blair\",\"iraq\",\"gordon\",\"engag\",\"ordin\",\"poverti\",\"regist\",\"unemploy\",\"backbench\",\"toni\",\"iraq\",\"blair\",\"parliamentari\",\"intervent\",\"telegraph\",\"manifesto\",\"suspicion\",\"down\",\"poster\",\"milburn\",\"compromis\",\"attorney\",\"cabinet\",\"brief\",\"prime\",\"alli\",\"trust\",\"lay\",\"peac\",\"journalist\",\"circumst\",\"undermin\",\"chancellor\",\"necessari\",\"poverti\",\"agenda\",\"wake\",\"sensibl\",\"kennedi\",\"charl\",\"leader\",\"liam\",\"judgement\",\"argument\",\"rural\",\"terrorist\",\"southern\",\"scrap\",\"howard\",\"seat\",\"fox\",\"fee\",\"muslim\",\"terror\",\"proport\",\"westminst\",\"dem\",\"truth\",\"scrutini\",\"lib\",\"liberti\",\"understood\",\"resist\",\"X800\",\"unfair\",\"incom\",\"clark\",\"scare\",\"handset\",\"phone\",\"mobil\",\"telecom\",\"lab\",\"subscrib\",\"upgrad\",\"text\",\"wireless\",\"sophist\",\"faster\",\"portabl\",\"via\",\"handheld\",\"camera\",\"visual\",\"laboratori\",\"tend\",\"hardwar\",\"stream\",\"confus\",\"partnership\",\"infrastructur\",\"network\",\"trend\",\"devic\",\"speed\",\"function.\",\"send\",\"gadget\",\"dem\",\"lib\",\"tori\",\"advic\",\"kennedi\",\"pension\",\"letwin\",\"commission\",\"rural\",\"audit\",\"inquiri\",\"telephon\",\"wast\",\"scrap\",\"unfair\",\"sum\",\"conserv\",\"payment\",\"sack\",\"westminst\",\"fee\",\"democrat\",\"liber\",\"effici\",\"oliv\",\"insur\",\"council\",\"incom\",\"stick\",\"object\",\"scorses\",\"aviat\",\"oscar\",\"martin\",\"nomine\",\"babi\",\"dollar\",\"academi\",\"nomin\",\"categori\",\"hugh\",\"actor\",\"actress\",\"closer\",\"ceremoni\",\"owen\",\"hollywood\",\"globe\",\"award\",\"jami\",\"ray\",\"clive\",\"comedi\",\"drama\",\"star\",\"film\",\"cinema\",\"carrier\",\"christian\",\"los\",\"ferguson\",\"alex\",\"arsenal\",\"everton\",\"manchest\",\"milan\",\"striker\",\"chelsea\",\"footbal\",\"leagu\",\"unit\",\"yard\",\"boston\",\"boss\",\"van\",\"incid\",\"barcelona\",\"cole\",\"merg\",\"sharehold\",\"leg\",\"motor\",\"gari\",\"sir\",\"water\",\"pitch\",\"punish\",\"takeov\",\"midfield\",\"gas\",\"seed\",\"semi\",\"eighth\",\"wimbledon\",\"seventh\",\"fault\",\"barcelona\",\"tenni\",\"carlo\",\"ankl\",\"qualifi\",\"jose\",\"tommi\",\"tournament\",\"broke\",\"indoor\",\"trophi\",\"argentina\",\"clinch\",\"seal\",\"australian\",\"milan\",\"champion\",\"tie\",\"round\",\"final\",\"sixth\",\"fifth\",\"medal\",\"storm\",\"athen\",\"sprinter\",\"athlet\",\"olymp\",\"medal\",\"X200m\",\"indoor\",\"X100m\",\"gold\",\"X800m\",\"fake\",\"X400m\",\"garden\",\"silver\",\"drug\",\"sydney\",\"suspens\",\"feder\",\"ban\",\"champion\",\"sport\",\"birmingham\",\"storm\",\"submit\",\"usa\",\"X2000\",\"crash\",\"kelli\",\"holder\",\"suspend\",\"penc\",\"takeov\",\"sharehold\",\"acquisit\",\"stock\",\"merger\",\"profit\",\"investor\",\"deutsch\",\"exchang\",\"X5bn\",\"index\",\"stake\",\"equiti\",\"reuter\",\"motor\",\"ongo\",\"airlin\",\"share\",\"divis\",\"X2bn\",\"X4bn\",\"retail\",\"settlement\",\"telecom\",\"X7bn\",\"adjust\",\"bid\",\"retain\",\"soar\",\"reduct\",\"democrat\",\"liberti\",\"liber\",\"terrorist\",\"attitud\",\"telegraph\",\"circumst\",\"foundat\",\"detain\",\"muslim\",\"blunkett\",\"tag\",\"sum\",\"scrutini\",\"chamber\",\"intervent\",\"elector\",\"terror\",\"anger\",\"asylum\",\"kennedi\",\"constitut\",\"dem\",\"lib\",\"implement\",\"abandon\",\"legisl\",\"argument\",\"hole\",\"nomine\",\"nomin\",\"categori\",\"academi\",\"ceremoni\",\"globe\",\"scorses\",\"oscar\",\"award\",\"aviat\",\"translat\",\"actress\",\"prize\",\"actor\",\"drama\",\"diari\",\"babi\",\"ray\",\"theatr\",\"femal\",\"album\",\"comedi\",\"fame\",\"hotel\",\"art\",\"hugh\",\"beauti\",\"honour\",\"closer\",\"singer\",\"ibm\",\"comput\",\"log\",\"virus\",\"processor\",\"pcs\",\"window\",\"lab\",\"upgrad\",\"softwar\",\"com\",\"instal\",\"hardwar\",\"collabor\",\"chip\",\"server\",\"infect\",\"web\",\"click\",\"handheld\",\"program\",\"tool\",\"malici\",\"devic\",\"innov\",\"calcul\",\"googl\",\"updat\",\"techniqu\",\"user\",\"scrum\",\"cole\",\"italian\",\"murphi\",\"penalti\",\"yard\",\"skipper\",\"flanker\",\"henri\",\"convert\",\"winger\",\"corner\",\"slot\",\"refere\",\"score\",\"half\",\"hodgson\",\"seal\",\"midfield\",\"charli\",\"ball\",\"brian\",\"wing\",\"kick\",\"striker\",\"prop\",\"motor\",\"recal\",\"stadium\",\"phil\",\"suspect\",\"detain\",\"arrest\",\"terrorist\",\"trial\",\"terror\",\"law\",\"polic\",\"liberti\",\"opt\",\"anti\",\"attorney\",\"clark\",\"affair\",\"recruit\",\"human\",\"lord\",\"investig\",\"muslim\",\"act\",\"crimin\",\"bay\",\"link\",\"convent\",\"without\",\"order\",\"tag\",\"lawyer\",\"citizen\",\"legisl\",\"actress\",\"drama\",\"odd\",\"bruce\",\"rapper\",\"marri\",\"comedi\",\"globe\",\"beauti\",\"singer\",\"theatr\",\"actor\",\"ross\",\"festiv\",\"translat\",\"oscar\",\"nomine\",\"episod\",\"femal\",\"scorses\",\"mother\",\"rap\",\"garden\",\"concert\",\"aviat\",\"lee\",\"dress\",\"los\",\"girl\",\"fame\",\"immigr\",\"asylum\",\"oblig\",\"polici\",\"document\",\"human\",\"criticis\",\"argu\",\"applic\",\"famili\",\"abus\",\"automat\",\"european\",\"oversea\",\"flight\",\"tori\",\"forthcom\",\"propos\",\"crime\",\"appli\",\"border\",\"care\",\"opinion\",\"react\",\"council\",\"publish\",\"parti\",\"impos\",\"whose\",\"control\",\"las\",\"vega\",\"electron\",\"consum\",\"microsoft\",\"function.\",\"gadget\",\"xbox\",\"connect\",\"largest\",\"pcs\",\"storag\",\"januari\",\"qualiti\",\"content\",\"transfer\",\"copi\",\"video\",\"partnership\",\"artist\",\"definit\",\"consol\",\"store\",\"devic\",\"super\",\"expert\",\"data\",\"metr\",\"vice\",\"push\",\"playstat\",\"soni\",\"xbox\",\"gamer\",\"consol\",\"disc\",\"graphic\",\"handheld\",\"video\",\"microsoft\",\"processor\",\"gadget\",\"consortium\",\"shop\",\"capabl\",\"releas\",\"wireless\",\"sold\",\"japan\",\"portabl\",\"dvds\",\"electron\",\"definit\",\"speed\",\"ibm\",\"develop\",\"buy\",\"entertain\",\"laboratori\",\"store\",\"malici\",\"virus\",\"program\",\"infect\",\"attach\",\"updat\",\"web\",\"softwar\",\"vulner\",\"pcs\",\"user\",\"window\",\"instal\",\"googl\",\"advert\",\"log\",\"code\",\"tool\",\"net\",\"acquisit\",\"compromis\",\"exploit\",\"site\",\"brazilian\",\"mail\",\"comput\",\"microsoft\",\"machin\",\"legitim\",\"spread\",\"dublin\",\"sullivan\",\"ireland\",\"irish\",\"prop\",\"hodgson\",\"charli\",\"brian\",\"skipper\",\"robinson\",\"murphi\",\"refere\",\"rbs\",\"northern\",\"matt\",\"newcastl\",\"pack\",\"flanker\",\"rugbi\",\"encount\",\"recal\",\"ankl\",\"squad\",\"wing\",\"knee\",\"scrum\",\"winger\",\"championship\",\"andi\",\"italian\",\"welsh\",\"wale\",\"cardiff\",\"scrum\",\"skipper\",\"assembl\",\"millennium\",\"glori\",\"italian\",\"pari\",\"cooper\",\"depth\",\"tournament\",\"flanker\",\"rugbi\",\"morgan\",\"lion\",\"jone\",\"england\",\"pack\",\"knee\",\"thoma\",\"squad\",\"rob\",\"itali\",\"slam\",\"seal\",\"prop\",\"rbs\",\"zealand\",\"san\",\"francisco\",\"sprinter\",\"comput\",\"distribut\",\"graphic\",\"playstat\",\"consortium\",\"lawsuit\",\"version\",\"enhanc\",\"california\",\"athlet\",\"sever\",\"server\",\"american\",\"feder\",\"user\",\"drug\",\"solid\",\"founder\",\"laboratori\",\"agenc\",\"window\",\"ban\",\"jose\",\"file\",\"manufactur\",\"microsoft\",\"appl\",\"gas\",\"oil\",\"bankruptci\",\"auction\",\"asset\",\"russian\",\"own\",\"russia\",\"energi\",\"deutsch\",\"fraud\",\"merg\",\"halt\",\"output\",\"ownership\",\"bought\",\"export\",\"ministri\",\"bank\",\"trillion\",\"disput\",\"X5bn\",\"resourc\",\"suppli\",\"soar\",\"reuter\",\"indian\",\"X4bn\",\"expans\",\"economist\",\"flanker\",\"rbs\",\"coach\",\"knee\",\"injur\",\"scrum\",\"rugbi\",\"sullivan\",\"recov\",\"prop\",\"recal\",\"scot\",\"henri\",\"squad\",\"matt\",\"zealand\",\"injuri\",\"skipper\",\"pari\",\"lion\",\"glori\",\"tournament\",\"ankl\",\"refere\",\"barcelona\",\"midfield\",\"slam\",\"suspens\",\"captain\",\"championship\",\"slam\",\"grand\",\"fault\",\"wimbledon\",\"tenni\",\"glori\",\"australian\",\"sullivan\",\"clinch\",\"tournament\",\"championship\",\"birmingham\",\"seed\",\"skipper\",\"knee\",\"error\",\"champion\",\"round\",\"seventh\",\"carlo\",\"victori\",\"broke\",\"match\",\"beaten\",\"cup\",\"injuri\",\"comfort\",\"winger\",\"titl\",\"indoor\",\"potter\",\"harri\",\"worth\",\"surg\",\"gross\",\"climb\",\"mari\",\"prison\",\"san\",\"xbox\",\"led\",\"girl\",\"fierc\",\"sold\",\"fastest\",\"X7bn\",\"drama\",\"adult\",\"cinema\",\"ring\",\"theft\",\"barrier\",\"gamer\",\"ticket\",\"sequel\",\"playstat\",\"broke\",\"pull\",\"popular\",\"copi\",\"angel\",\"los\",\"rap\",\"rapper\",\"X1993\",\"hip\",\"york\",\"genr\",\"chart\",\"wrote\",\"proceed\",\"singer\",\"fame\",\"detect\",\"california\",\"star\",\"sequel\",\"musician\",\"actor\",\"ray\",\"pursu\",\"usa\",\"girl\",\"rock\",\"documentari\",\"lee\",\"dead\",\"award\",\"weather\",\"scorses\",\"box\",\"trust\",\"gordon\",\"fli\",\"abus\",\"toni\",\"parti\",\"vote\",\"custom\",\"euro\",\"bankruptci\",\"secretari\",\"nomin\",\"academi\",\"elect\",\"las\",\"franc\",\"X2006\",\"state\",\"franc\",\"terror\",\"prime\",\"insist\",\"trust\",\"propos\",\"mps\",\"democrat\",\"local\",\"beat\",\"intellig\",\"research\",\"goal\",\"robinson\",\"hous\",\"star\",\"suggest\",\"deni\",\"technolog\",\"devic\",\"digit\",\"agenc\",\"final\",\"oscar\",\"liber\",\"match\",\"labour\",\"pledg\",\"liber\",\"labour\",\"winner\",\"rugbi\",\"threat\",\"labour\",\"spokesman\",\"imag\",\"demand\",\"titl\",\"william\",\"captain\",\"wing\",\"robinson\",\"biggest\",\"song\",\"user\",\"onlin\",\"elect\",\"labour\",\"blair\",\"campaign\",\"tori\",\"parti\",\"angel\",\"bodi\",\"coach\",\"foreign\",\"britain\",\"lock\",\"court\",\"product\",\"film\",\"actress\",\"shadow\",\"cabinet\",\"polit\",\"constitu\",\"labour\",\"present\",\"park\",\"secur\",\"hollywood\",\"democrat\",\"digit\",\"generat\",\"coach\",\"sell\",\"price\",\"itali\",\"coach\",\"previous\",\"comedi\",\"human\",\"band\",\"brown\",\"labour\",\"polici\",\"chancellor\",\"conserv\",\"technolog\",\"championship\",\"analyst\",\"network\",\"itali\",\"case\",\"charg\",\"ceremoni\",\"limit\",\"bill\",\"sell\",\"scotland\",\"statement\",\"unit\",\"giant\",\"wale\",\"franc\",\"movi\",\"nomin\",\"thursday\",\"blair\",\"democrat\",\"output\",\"side\",\"brown\",\"poll\",\"blair\",\"messag\",\"spokesman\",\"impos\",\"star\",\"captain\",\"leader\",\"grow\",\"side\",\"juli\",\"name\",\"actress\",\"artist\",\"parti\",\"polici\",\"cup\",\"poll\",\"elect\",\"law\",\"opposit\",\"digit\",\"elect\",\"voter\",\"tax\",\"movi\",\"match\",\"trial\",\"execut\",\"andi\",\"injuri\",\"internet\",\"angel\",\"secretari\",\"industri\",\"itali\",\"ireland\",\"parliament\",\"star\",\"campaign\",\"economi\",\"democrat\",\"gordon\",\"conserv\",\"elect\",\"test\",\"spokesman\",\"channel\",\"secur\",\"franc\",\"soni\",\"scotland\",\"behind\",\"X2003\",\"star\",\"singl\",\"toni\",\"tori\",\"toni\",\"howard\",\"chancellor\",\"street\",\"parti\",\"labour\",\"toni\",\"oper\",\"download\",\"financi\",\"shadow\",\"film\",\"custom\",\"music\",\"england\",\"annual\",\"william\",\"rose\",\"film\",\"concern\",\"technolog\",\"term\",\"health\",\"parti\",\"howard\",\"februari\",\"cup\",\"defeat\",\"rule\",\"power\",\"anti\",\"scotland\",\"anti\",\"john\",\"find\",\"general\",\"half\",\"conserv\",\"tori\",\"leader\",\"michael\",\"toni\",\"club\",\"labour\",\"parliamentari\",\"internet\",\"night\",\"campaign\",\"technolog\",\"presid\",\"team\",\"defeat\",\"produc\",\"approv\",\"microsoft\",\"britain\",\"parti\",\"blair\",\"tori\",\"brown\",\"vote\",\"leader\",\"august\",\"angel\",\"connect\",\"consid\",\"attack\",\"analyst\",\"victori\",\"coach\",\"analyst\",\"victori\",\"season\",\"ever\",\"clark\",\"tax\",\"elect\",\"school\",\"polit\",\"user\",\"blair\",\"name\",\"didn\",\"cup\",\"race\",\"conserv\",\"technolog\",\"wale\",\"london\",\"econom\",\"wale\",\"actor\",\"case\",\"decis\",\"campaign\",\"rise\",\"miss\",\"conserv\",\"liber\",\"voter\",\"prime\",\"websit\",\"charl\",\"valu\",\"parti\",\"elect\",\"oper\",\"cup\",\"award\",\"inform\",\"team\",\"side\",\"growth\",\"ireland\",\"england\",\"man\",\"law\",\"general\",\"india\",\"toni\",\"tori\",\"season\",\"invest\",\"charl\",\"offic\",\"michael\",\"product\",\"launch\",\"team\",\"match\",\"oper\",\"music\",\"propos\",\"project\",\"consum\",\"inflat\",\"prime\",\"general\",\"prime\",\"fourth\",\"final\",\"hollywood\",\"film\",\"general\",\"associ\",\"season\",\"match\",\"rise\",\"side\",\"scotland\",\"known\",\"britain\",\"britain\",\"council\",\"let\",\"tori\",\"prize\",\"media\",\"X2005\",\"download\",\"share\",\"titl\",\"perform\",\"offici\",\"produc\",\"leader\",\"mps\",\"campaign\",\"net\",\"role\",\"data\",\"decis\",\"film\",\"europ\",\"injuri\",\"charg\",\"appeal\",\"half\",\"team\",\"origin\",\"ceremoni\",\"offic\",\"job\",\"respons\",\"maker\",\"file\",\"cut\",\"rose\",\"defeat\",\"voter\",\"campaign\",\"victori\",\"championship\",\"miss\",\"busi\",\"price\",\"secretari\",\"develop\",\"court\",\"lost\",\"hand\",\"financ\",\"saturday\",\"andi\",\"sport\",\"love\",\"british\",\"statement\",\"leader\",\"rate\",\"team\",\"gordon\",\"suggest\",\"polit\",\"iraq\",\"goal\",\"voter\",\"general\",\"dollar\",\"version\",\"digit\",\"releas\",\"decemb\",\"cup\",\"lost\",\"video\",\"meet\",\"spend\",\"line\",\"howard\",\"secretari\",\"campaign\",\"side\",\"control\",\"half\",\"half\",\"race\",\"figur\",\"releas\",\"mobil\",\"econom\",\"leader\",\"tax\",\"premiership\",\"own\",\"polici\",\"net\",\"ireland\",\"love\",\"system\",\"cup\",\"test\",\"forc\",\"match\",\"realli\",\"direct\",\"secur\",\"watch\",\"polit\",\"brown\",\"war\",\"research\",\"polit\",\"side\",\"trade\",\"blair\",\"polit\",\"leader\",\"attack\",\"movi\",\"websit\",\"industri\",\"award\",\"releas\",\"general\",\"insist\",\"liber\",\"leader\",\"insist\",\"chanc\",\"titl\",\"oper\",\"machin\",\"match\",\"england\",\"system\",\"defeat\",\"music\",\"titl\",\"england\",\"anoth\",\"question\",\"popular\",\"debt\",\"goal\",\"polit\",\"speak\",\"pay\",\"didn\",\"britain\",\"spokesman\",\"held\",\"box\",\"spokesman\",\"award\",\"victori\",\"tax\",\"local\",\"analyst\",\"growth\",\"liber\",\"warn\",\"great\",\"economi\",\"took\",\"ask\",\"video\",\"busi\",\"budget\",\"product\",\"budget\",\"britain\",\"vote\",\"perform\",\"team\",\"biggest\",\"law\",\"toni\",\"access\",\"franc\",\"winner\",\"europ\",\"although\",\"cup\",\"test\",\"ireland\",\"develop\",\"cut\",\"econom\",\"general\",\"differ\",\"law\",\"british\",\"name\",\"digit\",\"miss\",\"cut\",\"lot\",\"confid\",\"replac\",\"half\",\"across\",\"websit\",\"spend\",\"democrat\",\"meet\",\"launch\",\"michael\",\"man\",\"debut\",\"music\",\"protect\",\"kick\",\"success\",\"buy\",\"season\",\"london\",\"receiv\",\"liber\",\"industri\",\"version\",\"figur\",\"lost\",\"winner\",\"prime\",\"british\",\"possibl\",\"tax\",\"futur\",\"internet\",\"injuri\",\"mike\",\"action\",\"futur\",\"tax\",\"X2003\",\"realli\",\"deal\",\"man\",\"releas\",\"britain\",\"bring\",\"break.\",\"serv\",\"team\",\"london\",\"rival\",\"system\",\"media\",\"product\",\"court\",\"life\",\"success\",\"michael\",\"X2005\",\"analyst\",\"industri\",\"winner\",\"event\",\"rise\",\"campaign\",\"golden\",\"minut\",\"role\",\"creat\",\"mean\",\"form\",\"championship\",\"system\",\"posit\",\"strong\",\"februari\",\"product\",\"deliv\",\"state\",\"chanc\",\"cut\",\"return\",\"past\",\"titl\",\"american\",\"suggest\",\"london\",\"busi\",\"differ\",\"fli\",\"concern\",\"offic\",\"miss\",\"common\",\"phone\",\"money\",\"strong\",\"speak\",\"michael\",\"role\",\"career\",\"control\",\"websit\",\"technolog\",\"due\",\"busi\",\"offic\",\"join\",\"european\",\"video\",\"share\",\"deal\",\"mark\",\"term\",\"stand\",\"liber\",\"secretari\",\"reach\",\"american\",\"british\",\"decis\",\"propos\",\"present\",\"team\",\"alway\",\"offic\",\"minut\",\"big\",\"big\",\"british\",\"network\",\"state\",\"clear\",\"chairman\",\"general\",\"find\",\"came\",\"michael\",\"receiv\",\"power\",\"replac\",\"saturday\",\"present\",\"industri\",\"centr\",\"appear\",\"big\",\"technolog\",\"find\",\"launch\",\"secretari\",\"clear\",\"cost\",\"don\",\"quarter\",\"presid\",\"oper\",\"line\",\"decid\",\"saturday\",\"develop\",\"deal\",\"line\",\"industri\",\"sport\",\"join\",\"abl\",\"person\",\"held\",\"success\",\"victori\",\"british\",\"perform\",\"perform\",\"got\",\"sunday\",\"went\",\"suggest\",\"offic\",\"fall\",\"spokesman\",\"attack\",\"mark\",\"product\",\"around\",\"line\",\"cost\",\"movi\",\"turn\",\"sport\",\"final\",\"announc\",\"import\",\"warn\",\"polici\",\"secretari\",\"suggest\",\"far\",\"mean\",\"perform\",\"X2005\",\"side\",\"sunday\",\"polici\",\"britain\",\"power\",\"access\",\"receiv\",\"andi\",\"vote\",\"anoth\",\"product\",\"mark\",\"X2003\",\"great\",\"parti\",\"got\",\"life\",\"clear\",\"deal\",\"music\",\"everi\",\"david\",\"name\",\"final\",\"came\",\"live\",\"music\",\"differ\",\"cost\",\"anoth\",\"democrat\",\"head\",\"great\",\"cost\",\"great\",\"respons\",\"abl\",\"great\",\"lost\",\"tax\",\"deni\",\"X2005\",\"form\",\"announc\",\"messag\",\"full\",\"return\",\"role\",\"don\",\"role\",\"analyst\",\"britain\",\"account\",\"secretari\",\"don\",\"produc\",\"british\",\"centr\",\"whether\",\"chanc\",\"launch\",\"receiv\",\"clear\",\"ask\",\"spokesman\",\"ask\",\"chanc\",\"perform\",\"releas\",\"produc\",\"unit\",\"find\",\"wale\",\"away\",\"success\",\"return\",\"general\",\"websit\",\"busi\",\"meet\",\"lost\",\"minut\",\"injuri\",\"bank\",\"chanc\",\"mean\",\"attack\",\"case\",\"despit\",\"develop\",\"job\",\"michael\",\"britain\",\"great\",\"came\",\"offic\",\"state\",\"develop\",\"sport\",\"suggest\",\"cost\",\"european\",\"minut\",\"ask\",\"british\",\"suggest\",\"london\",\"hand\",\"charg\",\"X2005\",\"among\",\"big\",\"return\",\"anoth\",\"seen\",\"came\",\"mean\",\"ask\",\"term\",\"warn\",\"fail\",\"power\",\"meet\",\"sunday\",\"film\",\"thing\",\"person\",\"around\",\"took\",\"rule\",\"return\",\"huge\",\"appear\",\"centr\",\"half\",\"around\",\"elect\",\"final\",\"almost\",\"got\",\"left\",\"produc\",\"control\",\"despit\",\"announc\",\"littl\",\"offic\",\"came\",\"term\",\"develop\",\"offic\",\"cut\",\"abl\",\"success\",\"network\",\"share\",\"industri\",\"clear\",\"economi\",\"meet\",\"earli\",\"case\",\"cost\",\"result\",\"better\",\"far\",\"chanc\",\"came\",\"meet\",\"came\",\"talk\",\"seen\",\"mean\",\"lost\",\"mean\",\"british\",\"figur\",\"creat\",\"big\",\"cut\",\"buy\",\"don\",\"power\",\"europ\",\"lot\",\"seen\",\"despit\",\"british\",\"realli\",\"abl\",\"differ\",\"star\",\"develop\",\"state\",\"announc\",\"perform\",\"releas\",\"launch\",\"talk\",\"person\",\"industri\",\"final\",\"without\",\"futur\",\"europ\",\"previous\",\"suggest\",\"polici\",\"offic\",\"clear\",\"secur\",\"turn\",\"name\",\"turn\",\"spokesman\",\"person\",\"person\",\"find\",\"took\",\"clear\",\"releas\",\"got\",\"develop\",\"got\",\"took\",\"life\",\"find\",\"around\",\"control\",\"oper\",\"turn\",\"took\",\"hard\",\"talk\",\"music\",\"came\",\"control\",\"european\",\"martin\",\"without\",\"far\",\"product\",\"live\",\"london\",\"close\",\"past\",\"pay\",\"great\",\"despit\",\"took\",\"cut\",\"don\",\"better\",\"live\",\"februari\",\"film\",\"despit\",\"hard\",\"anoth\",\"control\",\"decis\",\"clear\",\"provid\",\"hold\",\"industri\",\"appear\",\"person\",\"took\",\"polit\",\"industri\",\"without\",\"live\",\"improv\",\"lot\",\"thing\",\"man\",\"side\",\"clear\",\"although\",\"man\",\"announc\",\"announc\",\"given\",\"team\",\"previous\",\"around\",\"decis\",\"final\",\"came\",\"meet\",\"lot\",\"decid\",\"big\",\"differ\",\"releas\",\"econom\",\"warn\",\"releas\",\"result\",\"money\",\"took\",\"futur\",\"busi\",\"anoth\",\"away\",\"labour\",\"provid\",\"thing\",\"earlier\",\"find\",\"big\",\"anoth\",\"british\",\"X2005\",\"michael\",\"power\",\"clear\",\"figur\",\"big\",\"away\",\"februari\",\"cost\",\"latest\",\"close\",\"technolog\",\"big\",\"michael\",\"realli\",\"X2003\",\"better\",\"concern\",\"despit\",\"decis\",\"lot\",\"direct\",\"mean\",\"thing\",\"turn\",\"system\",\"offic\",\"ask\",\"got\",\"went\",\"don\",\"took\",\"creat\",\"person\",\"although\",\"appear\",\"control\",\"X2005\",\"thing\",\"despit\",\"thing\",\"biggest\",\"britain\",\"develop\",\"control\",\"level\",\"came\",\"money\",\"elect\",\"power\",\"X2003\",\"decis\",\"concern\",\"big\",\"seen\",\"interest\",\"find\",\"result\",\"cut\",\"final\",\"great\",\"given\",\"creat\",\"came\",\"european\",\"toni\",\"lot\",\"later\",\"mean\",\"ask\",\"produc\",\"took\",\"success\",\"posit\",\"success\",\"rule\",\"don\",\"leader\",\"took\",\"money\",\"term\",\"secur\",\"system\",\"improv\",\"clear\",\"took\",\"hand\",\"better\",\"far\",\"michael\",\"offic\",\"suggest\",\"half\",\"success\",\"talk\",\"better\",\"music\",\"differ\",\"result\",\"term\",\"secur\",\"don\",\"line\",\"film\",\"don\",\"great\",\"secur\",\"better\",\"clear\",\"perform\",\"perform\",\"person\",\"suggest\",\"realli\",\"provid\",\"without\",\"power\",\"cut\",\"return\",\"close\",\"live\",\"import\",\"receiv\",\"despit\",\"meet\",\"turn\",\"perform\",\"anoth\",\"offic\",\"lot\",\"star\",\"busi\",\"don\",\"announc\",\"person\",\"success\",\"product\",\"cost\",\"develop\",\"person\",\"mean\",\"share\",\"big\",\"programm\",\"deal\",\"seen\",\"came\",\"life\",\"X2003\",\"live\",\"power\",\"offic\",\"live\",\"line\",\"develop\",\"general\",\"money\",\"don\",\"turn\",\"given\",\"london\",\"mean\",\"X2003\",\"turn\",\"took\",\"keep\",\"realli\",\"anoth\",\"money\",\"latest\",\"line\",\"big\",\"don\",\"offic\",\"blair\",\"lost\",\"live\",\"came\",\"return\",\"don\",\"interest\",\"money\",\"appear\",\"cut\",\"decis\",\"decis\",\"rule\",\"return\",\"turn\",\"great\",\"keep\",\"return\",\"offic\",\"live\",\"realli\",\"thing\",\"turn\",\"talk\",\"around\",\"decis\",\"offic\",\"offic\",\"don\",\"don\",\"lot\",\"got\",\"abl\",\"share\",\"appear\",\"big\",\"later\",\"mean\",\"industri\",\"thing\",\"oper\",\"decis\",\"X2003\",\"power\",\"michael\",\"interest\",\"britain\",\"programm\",\"announc\",\"despit\"],\"logprob\":[30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,-6.8272,-6.3559,-6.9436,-5.2519,-4.9335,-8.3828,-8.5136,-7.4604,-7.508,-7.2659,-7.7251,-8.0007,-7.3125,-5.2116,-8.1771,-7.6634,-8.0347,-8.1748,-8.4459,-7.2556,-7.7277,-8.2259,-8.0154,-7.6455,-7.3848,-7.7057,-7.8465,-6.5697,-8.0797,-7.21,-7.1114,-6.2628,-5.8462,-6.7196,-7.5634,-5.9838,-7.0412,-7.5352,-7.5306,-5.212,-6.8212,-6.4254,-7.2828,-7.6902,-4.1157,-5.8947,-7.2191,-7.2236,-7.1474,-7.3944,-7.4257,-6.1375,-6.8549,-5.8759,-7.2023,-7.0507,-7.2785,-7.3961,-5.9657,-8.3427,-6.9068,-6.6991,-6.2849,-6.5155,-6.6758,-5.7989,-6.8568,-4.5194,-7.0008,-5.0408,-7.5548,-7.6102,-5.8228,-7.8231,-7.5581,-7.8623,-7.2477,-7.3923,-6.6225,-7.8893,-6.959,-6.0401,-7.7332,-7.9751,-6.1975,-6.9154,-7.3316,-7.9457,-8.0209,-7.0688,-6.5116,-5.7103,-5.1356,-5.3228,-5.3274,-7.1015,-7.3958,-6.9225,-7.6321,-6.8487,-6.9108,-7.1043,-7.9888,-7.127,-7.8145,-7.8395,-7.9423,-7.0577,-7.507,-6.7606,-7.8553,-7.3698,-7.0338,-7.1444,-6.357,-7.6809,-8.2001,-7.9423,-7.0182,-7.5932,-6.6785,-6.9041,-6.9743,-6.0396,-5.2771,-4.4331,-5.4064,-5.0346,-6.8298,-4.6661,-7.396,-4.6794,-8.1981,-5.6321,-6.1301,-8.1267,-7.0079,-5.8122,-7.6873,-6.2603,-6.1209,-5.8594,-5.4592,-8.3243,-6.5244,-6.2323,-8.4213,-6.965,-6.0913,-5.4051,-6.8268,-6.2336,-6.1888,-7.1689,-6.0484,-6.8066,-7.5563,-7.2383,-6.9555,-6.6063,-6.7917,-7.3776,-7.5575,-5.8418,-7.7611,-7.1122,-7.5575,-7.0222,-4.8896,-6.6464,-4.7407,-7.8904,-4.6479,-6.2609,-6.8685,-7.7586,-8.1896,-6.4789,-5.5785,-6.3319,-6.6595,-6.7046,-5.9675,-5.8648,-7.2414,-7.1629,-5.7044,-4.2123,-6.9749,-5.0014,-5.8325,-7.0223,-7.2385,-6.593,-5.2618,-6.894,-6.3637,-6.3637,-6.8762,-6.3858,-6.964,-5.4564,-7.2161,-5.0523,-7.0704,-5.5775,-5.6411,-6.4379,-5.6519,-7.9346,-6.9265,-7.353,-7.5788,-7.1256,-7.4362,-6.8691,-8.0251,-7.8474,-7.2519,-7.3637,-7.0173,-7.7532,-7.7937,-7.332,-7.6407,-7.0035,-6.4115,-7.8244,-7.0964,-4.8637,-8.0896,-8.1008,-6.9837,-6.3629,-6.8274,-7.0534,-7.3012,-7.1808,-7.8981,-7.9645,-6.5763,-6.5763,-8.0315,-4.4923,-5.806,-6.7029,-5.9105,-6.3661,-7.7802,-5.1979,-5.1953,-7.3384,-8.0315,-7.7262,-7.3659,-7.4059,-7.9625,-6.9487,-6.4036,-4.7267,-7.2124,-7.4085,-5.1892,-6.5291,-5.8007,-7.4476,-7.9625,-7.3421,-8.1857,-7.3954,-6.7205,-4.7313,-6.0928,-4.7857,-6.7007,-7.736,-7.5415,-6.8075,-7.497,-6.7509,-7.3367,-6.9068,-8.4353,-8.5393,-6.3888,-7.7863,-5.0622,-7.0677,-6.4762,-7.7058,-7.8599,-6.9135,-7.8461,-7.9934,-5.5848,-8.0381,-7.1461,-7.4708,-8.1384,-8.2048,-6.0426,-5.5031,-4.6558,-7.3985,-8.2194,-7.25,-8.1324,-7.8447,-7.8447,-7.4393,-5.6816,-6.7958,-7.25,-7.1686,-7.9783,-6.9489,-8.3147,-7.3592,-6.3646,-7.6729,-8.0524,-6.3646,-7.727,-8.0524,-8.0524,-8.4201,-7.8447,-6.6734,-7.1086,-7.8447,-6.1716,-4.8322,-5.0126,-7.311,-7.9241,-7.1932,-7.5446,-6.3459,-6.9568,-7.5987,-6.9022,-6.7764,-6.1662,-7.4933,-6.7495,-8.0041,-7.85,-7.0384,-7.781,-7.6558,-7.5987,-7.6535,-7.6418,-5.3191,-7.1026,-6.0045,-6.2964,-7.1121,-6.2778,-7.0932,-5.5572,-5.5503,-4.7292,-7.4962,-6.3819,-6.4977,-7.1068,-7.5963,-7.9758,-7.9758,-7.2449,-7.3627,-6.9572,-7.3219,-7.6504,-7.7682,-5.2783,-7.545,-7.545,-7.2449,-7.075,-5.3861,-5.3945,-7.4053,-7.075,-8.1429,-5.9645,-6.5518,-7.7076,-8.5949,-6.1845,-5.7159,-5.325,-5.0649,-6.1793,-6.2012,-5.5157,-6.1781,-5.4262,-6.0604,-6.5116,-5.3662,-5.9325,-6.6417,-6.0131,-6.7844,-5.9389,-6.8613,-4.6299,-6.5851,-6.8913,-6.7029,-6.3121,-6.5966,-4.1362,-4.0115,-6.6034,-8.4871,-7.7828,-6.5019,-6.2748,-6.0522,-6.3956,-7.3426,-5.5741,-7.6611,-6.994,-6.8453,-5.5232,-6.1188,-4.212,-7.3309,-8.1311,-5.6616,-7.2113,-7.3546,-8.3542,-8.1311,-7.5928,-7.5046,-7.4023,-8.3542,-7.5194,-5.6088,-8.0358,-7.2977,-7.7256,-7.9488,-7.8191,-7.7946,-6.1139,-6.0522,-7.1598,-7.4222,-6.984,-8.1154,-7.853,-7.2399,-7.6454,-7.5847,-6.8838,-7.1048,-7.3734,-6.7004,-7.1598,-7.3269,-7.6454,-7.5276,-7.7789,-7.4222,-6.291,-8.1154,-5.3783,-6.766,-5.8883,-4.0517,-7.2825,-6.794,-7.4735,-7.6454,-5.8724,-6.1873,-5.1828,-4.959,-6.3397,-6.2181,-6.608,-6.472,-6.0279,-6.8121,-7.3324,-7.1542,-7.1188,-6.8436,-5.7097,-6.9569,-7.7379,-5.6487,-5.7249,-5.0936,-4.8768,-7.2093,-7.3788,-7.812,-7.3324,-5.914,-7.3741,-6.3398,-7.3741,-6.626,-6.7098,-6.6398,-6.5583,-7.7199,-5.8785,-7.292,-5.5259,-6.144,-7.5742,-6.2729,-6.478,-7.4311,-6.5091,-7.47,-7.4634,-8.0961,-8.3474,-8.042,-4.2157,-6.8665,-7.4029,-7.1724,-7.1651,-7.9526,-7.7284,-8.0597,-8.3239,-6.0488,-8.2139,-8.0657,-7.6496,-5.0597,-7.2929,-5.0901,-7.516,-7.8037,-7.4554,-7.6496,-7.9861,-7.3983,-7.7237,-7.2441,-7.8037,-7.6496,-7.8037,-7.9861,-7.8037,-6.8547,-6.7333,-7.9861,-7.3442,-6.482,-7.1976,-6.1778,-6.1615,-8.2092,-7.8037,-7.2929,-7.1976,-7.516,-5.7802,-5.072,-5.8339,-6.0356,-5.7214,-6.5573,-6.4849,-5.464,-4.3863,-6.0987,-7.4129,-5.8142,-5.8573,-5.3931,-6.3408,-6.8788,-6.396,-6.8121,-6.7496,-7.4129,-6.5787,-6.2268,-7.5381,-7.3017,-6.5633,-6.7804,-7.3558,-6.4354,-6.8726,-6.3724,-6.5839,-4.5991,-7.6825,-6.7479,-7.2027,-6.3833,-6.3173,-7.9702,-7.5126,-5.4579,-7.4195,-7.0223,-7.4819,-7.7446,-7.1229,-7.0614,-7.5772,-6.3102,-7.5813,-7.4159,-6.107,-6.9397,-7.6596,-5.8485,-6.9222,-7.4018,-7.7695,-7.3949,-7.9702,-5.2709,-6.472,-7.6206,-7.3685,-7.3523,-6.4809,-7.5336,-7.7006,-7.0801,-7.6634,-7.5795,-7.8829,-7.2128,-7.6206,-7.0904,-5.962,-4.2951,-7.2411,-7.7006,-7.6634,-7.2952,-6.4371,-6.9666,-6.9327,-5.9318,-7.7006,-7.6206,-8.3938,-7.8428,-7.2081,-7.3104,-5.817,-6.4848,-6.2739,-7.1239,-5.7394,-6.3378,-4.824,-5.7282,-7.2147,-7.6524,-5.373,-8.2766,-6.6764,-6.1176,-7.8276,-5.9542,-5.7315,-6.4367,-7.6704,-5.1192,-6.8852,-7.8437,-5.9483,-7.4116,-4.7535,-5.4128,-7.7657,-6.9768,-7.3603,-7.1919,-5.4781,-6.1408,-7.4138,-7.3448,-7.4879,-7.4879,-6.0275,-6.7206,-7.1084,-6.0705,-6.6517,-5.398,-7.4879,-6.5265,-7.5679,-5.712,-6.4153,-7.4138,-7.4138,-6.7948,-7.2196,-7.7503,-7.7503,-7.4879,-6.364,-7.4138,-7.5679,-6.3152,-7.7503,-7.5679,-5.6188,-6.5351,-7.5582,-5.0962,-7.0169,-6.0937,-6.4559,-5.6354,-7.0967,-5.6306,-6.9479,-7.6337,-4.9675,-7.7261,-8.3668,-4.9967,-7.7369,-5.4988,-6.569,-7.1637,-8.069,-6.2328,-6.9975,-8.0998,-6.0294,-6.0547,-4.4855,-7.3835,-6.3851,-4.9652,-6.2498,-6.2498,-5.7935,-5.0336,-5.8774,-6.8964,-6.9272,-7.4116,-6.0491,-6.1755,-6.7404,-7.2149,-4.9364,-6.1025,-5.9287,-6.9452,-6.3325,-5.3358,-7.6944,-6.3882,-6.1163,-6.7294,-6.6863,-6.0889,-7.6203,-6.2296,-5.9419,-8.1957,-6.6519,-6.0038,-6.2596,-5.3433,-6.7098,-6.4785,-6.0095,-7.2404,-6.9945,-7.3835,-5.0887,-6.0014,-7.4636,-6.9392,-8.0026,-7.0531,-6.2276,-4.7455,-7.2284,-5.7714,-6.2134,-6.9665,-7.7512,-6.3544,-6.1096,-6.3574,-7.869,-4.4263,-5.4165,-6.1726,-8.0026,-6.6939,-6.1956,-5.8714,-5.0545,-6.7355,-7.2252,-6.6853,-5.8043,-5.072,-6.6042,-6.1237,-4.7122,-6.0666,-6.7179,-7.3226,-7.2023,-7.7361,-6.4771,-6.7075,-4.8843,-8.1415,-7.7361,-6.794,-5.9831,-7.9874,-6.1228,-5.0521,-5.9622,-6.2008,-7.5354,-6.3571,-6.0754,-7.0115,-4.8069,-5.9092,-7.2346,-6.9627,-7.0115,-6.7664,-7.7046,-6.3239,-7.5223,-7.0805,-7.4423,-6.5913,-6.968,-7.3524,-6.9751,-7.2346,-6.2651,-7.3682,-7.81,-8.2155,-6.4227,-6.9609,-7.7046,-7.2992,-8.0613,-6.1932,-6.0798,-7.7816,-6.0191,-4.808,-6.6179,-7.0259,-7.6678,-7.2623,-7.5724,-7.6678,-7.4974,-6.8957,-7.7731,-7.8909,-7.102,-7.1978,-6.2655,-7.1081,-7.4054,-6.2141,-4.5139,-7.0487,-7.7731,-6.5644,-6.5204,-8.1786,-6.3527,-6.9675,-7.8909,-7.7731,-7.6678,-7.2411,-5.5843,-6.2508,-7.5078,-5.1466,-6.3912,-7.2688,-7.3255,-8.07,-7.731,-5.6458,-7.6822,-7.6822,-6.7569,-5.0773,-7.4125,-5.321,-6.3396,-5.4544,-6.5735,-7.5697,-7.3466,-8.07,-6.4467,-6.881,-6.4993,-7.9158,-6.2393,-6.9624,-6.4381,-7.1397,-6.1515,-4.9798,-6.5659,-6.8469,-6.0871,-6.2942,-5.6678,-6.687,-6.1992,-7.609,-7.1301,-7.2195,-7.4672,-6.7495,-7.0265,-6.1807,-6.5312,-7.7856,-5.4627,-7.9191,-7.6186,-6.774,-7.1631,-6.8739,-7.9191,-7.6478,-7.3726,-7.2067,-7.8999,-6.8923,-6.1325,-6.7347,-4.4805,-6.9969,-6.6358,-6.7347,-5.7897,-7.1622,-6.4251,-7.2312,-7.4336,-7.1535,-7.4566,-6.0607,-6.676,-6.7461,-5.2995,-7.5676,-6.7031,-7.037,-7.5676,-6.8615,-7.9243,-6.8942,-8.2608,-7.4374,-6.5972,-8.0785,-6.2664,-5.9123,-5.5963,-5.1023,-7.8551,-7.3161,-6.9678,-7.3161,-6.1857,-7.3161,-7.8551,-6.9548,-5.92,-7.4984,-7.4031,-7.7215,-7.4984,-7.6038,-5.506,-6.0421,-7.7215,-8.1916,-5.247,-7.4984,-4.742,-6.942,-5.6804,-5.5952,-7.4984,-8.0092,-5.1106,-7.7215,-6.1996,-5.3523,-6.3876,-7.8628,-7.3906,-7.6057,-7.6057,-6.7471,-6.7137,-7.5165,-5.6456,-7.9068,-8.3397,-5.829,-7.6259,-8.1856,-6.7471,-7.2983,-6.7137,-6.9639,-7.9342,-8.0314,-7.3799,-7.2227,-7.8289,-7.5412,-7.8124,-6.8557,-5.7329,-6.5898,-5.1066,-5.1918,-7.3665,-7.3665,-7.1842,-7.2712,-5.9891,-7.4719,-6.2895,-7.0301,-7.8774,-6.2703,-7.5897,-7.8774,-7.5897,-4.1195,-7.5897,-7.8774,-5.6977,-7.0301,-7.8774,-7.7232,-7.8774,-6.6614,-7.1842,-7.5897,-6.8965,-4.854,-7.8774,-7.0301,-6.0812,-6.6319,-5.9166,-5.8728,-7.0964,-5.2012,-4.6064,-5.6762,-6.1695,-6.5961,-7.7456,-5.0012,-5.7137,-6.4975,-4.6577,-7.4636,-5.1645,-6.4648,-4.345,-5.0964,-7.0511,-5.2635,-5.8128,-6.6546,-5.6839,-6.0108,-5.5664,-5.8679,-5.1928,-7.3983,-5.3386,-5.9911,-6.56,-5.1929,-4.1109,-4.9519,-5.4738,-4.7536,-6.1254,-5.4026,-6.212,-4.3454,-6.0054,-5.7027,-4.8819,-4.8055,-6.318,-5.6102,-4.6449,-5.483,-6.3412,-6.4802,-4.7011,-4.9322,-6.4695,-5.1546,-5.2968,-5.9142,-6.651,-7.1122,-6.3236,-5.1185,-6.0897,-5.5495,-5.8921,-4.7288,-4.7666,-5.3443,-5.0313,-5.2197,-4.5168,-6.456,-5.9056,-5.3007,-5.3931,-4.8574,-6.8458,-5.3199,-4.5649,-4.3614,-6.2891,-6.3075,-6.5873,-5.4343,-7.3782,-4.7313,-5.2743,-7.1263,-4.692,-6.0762,-5.5253,-5.3133,-5.7436,-5.3572,-5.7464,-5.2358,-6.0501,-5.2654,-4.9033,-6.4561,-6.4436,-6.5116,-5.7737,-4.8396,-5.642,-5.8321,-5.5844,-4.7706,-5.8698,-5.1109,-5.3634,-6.3021,-5.073,-5.2097,-6.1817,-5.7301,-5.4636,-5.6337,-5.8187,-5.6512,-4.6931,-5.8096,-5.3461,-4.9679,-5.5359,-5.9321,-6.2664,-5.2512,-5.7059,-7.0988,-4.5473,-5.7204,-5.9566,-5.3347,-5.7699,-4.9528,-7.2441,-4.3026,-6.5432,-4.9155,-5.5331,-4.6596,-6.6267,-4.7791,-6.5164,-6.5288,-4.6848,-5.7214,-5.8189,-6.0586,-4.7666,-5.6242,-6.3696,-5.3243,-4.7392,-5.9849,-5.4921,-5.4018,-4.8645,-5.7076,-5.0516,-6.0965,-5.7727,-6.0132,-6.3152,-5.3553,-4.6987,-6.358,-5.6549,-6.6768,-4.6621,-5.0574,-5.6242,-5.6653,-5.7831,-5.5026,-4.9268,-4.9684,-4.7855,-6.7431,-4.4092,-5.4032,-6.4359,-5.4768,-5.4526,-4.7574,-4.5998,-5.7963,-5.2755,-5.2604,-5.362,-5.8814,-5.8545,-6.2017,-4.7066,-4.9613,-5.3551,-4.8586,-6.0464,-5.7818,-6.1615,-4.2422,-6.1381,-4.8888,-4.7714,-6.1419,-5.8512,-6.4191,-4.3725,-5.367,-4.9712,-5.1956,-6.4608,-4.8178,-5.7854,-5.2933,-6.0774,-5.9612,-4.9251,-4.759,-5.2983,-5.7959,-5.6438,-5.2284,-4.8796,-4.9936,-4.594,-5.6159,-5.3555,-5.0234,-5.1877,-5.2371,-5.9888,-4.8342,-6.9213,-5.8065,-6.0611,-5.0187,-4.9183,-5.1211,-4.6074,-6.0687,-4.9149,-7.423,-6.4153,-5.0971,-4.8417,-5.3978,-5.3579,-5.694,-5.675,-5.0281,-6.4373,-6.3668,-6.1846,-5.8183,-5.4854,-5.2254,-5.59,-5.5485,-5.104,-5.3086,-5.8159,-5.2512,-7.1917,-5.6555,-4.9829,-6.3033,-5.5149,-5.6328,-5.2906,-4.8384,-6.1347,-5.7939,-5.5713,-5.5365,-4.8491,-5.702,-4.9156,-5.4769,-5.6824,-6.0312,-5.6348,-5.2441,-5.2137,-5.053,-5.3214,-5.6823,-5.7585,-6.0751,-5.5328,-5.2746,-6.0282,-5.8825,-4.7697,-4.8988,-4.8427,-5.9396,-5.0155,-5.3316,-5.0221,-4.8812,-5.2669,-5.3584,-4.5703,-5.2209,-5.8088,-5.0061,-7.1713,-5.4333,-5.2979,-5.8623,-5.7232,-6.0401,-4.6304,-5.0624,-4.9267,-4.9674,-4.9863,-5.1968,-5.1083,-5.0378,-5.9353,-6.1023,-5.7738,-6.6738,-5.548,-4.976,-5.4315,-5.7924,-4.4303,-6.1857,-4.4312,-4.8864,-5.6307,-5.7837,-5.2707,-5.002,-4.5548,-5.7977,-5.711,-5.3141,-5.2231,-6.2789,-5.4258,-5.3311,-6.2156,-5.3249,-4.7567,-5.8979,-5.014,-5.5869,-4.8381,-5.9385,-5.2617,-5.1634,-6.2633,-5.1703,-5.6413,-4.8404,-5.9349,-5.0095,-4.5268,-5.1034,-5.9205,-5.3879,-5.982,-4.5755,-4.9933,-5.9213,-6.4274,-5.176,-5.8065,-5.7361,-6.3359,-6.3331,-5.2835,-6.275,-6.0581,-6.197,-5.3619,-5.4949,-6.1221,-5.1686,-4.9217,-5.6091,-5.5368,-4.7643,-5.4635,-4.9338,-5.1692,-5.9891,-5.4498,-5.9274,-5.6687,-6.1376,-5.2847,-6.2062,-5.2232,-5.5136,-4.9517,-5.9964,-5.3361,-5.4733,-6.6243,-6.3508,-6.1298,-5.0946,-6.0409,-5.8107,-5.4262,-5.3209,-5.5514,-5.7333,-4.8972,-5.7675,-5.285,-5.6224,-4.7981,-5.8997,-5.5427,-5.2563,-4.9992,-4.8893,-4.9189,-4.9983,-5.9412,-5.0827,-5.344,-6.1252,-5.6715,-5.3129,-5.8425,-7.0013,-6.617,-5.7542,-5.5605,-5.7788,-5.9632,-4.8095,-6.0263,-5.6095,-5.0387,-5.0186,-4.9518,-5.4493,-5.4563,-6.201,-5.5464,-5.9082,-6.034,-5.7647,-5.5149,-5.1975,-5.6045,-5.475,-5.546,-5.2544,-5.3638,-5.5288,-5.2931,-4.9294,-5.3803,-5.3086,-5.2382,-5.9496,-5.8608,-5.3166,-5.8409,-5.4065,-5.2465,-5.1753,-6.4377,-5.3837,-5.1086,-5.1995,-6.208,-5.2486,-5.6415,-4.9934,-4.8612,-5.8011,-5.9717,-6.4519,-6.0547,-5.6525,-6.2633,-5.8193,-5.9465,-5.2798,-5.3463,-5.2646,-6.1376,-5.5033,-5.5761,-5.6223,-5.787,-6.224,-5.4712,-5.5833,-5.5921,-5.013,-5.0957,-5.2773,-4.9364,-5.5833,-5.8839,-5.2083,-6.1144,-5.1512,-5.7541,-5.2652,-5.9865,-4.9207,-5.4199,-5.4067,-5.7542,-5.5296,-5.7413,-5.6269,-5.7704,-5.2168,-5.1889,-6.135,-5.293,-5.7048,-5.5081,-5.3958,-5.6863,-5.3398,-5.1408,-5.6989,-4.8313,-5.0759,-5.5279,-5.6623,-5.1774,-4.9915,-5.8422,-5.3395,-4.9745,-5.6079,-5.7092,-5.3341,-5.909,-5.337,-5.2913,-5.3215,-5.5388,-6.11,-5.1577,-5.6125,-6.2105,-5.0987,-5.5581,-5.5733,-5.1985,-5.3664,-5.9555,-5.3999,-6.1109,-5.093,-5.0082,-5.7676,-5.6589,-4.8654,-5.231,-5.5594,-5.077,-5.7941,-6.0897,-6.3868,-5.3355,-5.225,-5.2853,-4.9639,-5.2061,-5.6172,-5.6121,-5.6391,-5.4809,-5.8579,-5.6649,-6.36,-4.8919,-5.1813,-5.9938,-5.1171,-5.424,-5.2643,-5.3663,-5.2925,-5.2361,-5.3495,-5.0479,-5.4661,-5.2327,-5.7926,-5.3638,-5.4219,-5.4613,-6.2148,-5.7381,-5.1435,-5.1565,-4.8904,-5.5208,-6.4294,-5.2111,-5.2309,-5.2521,-5.6165,-5.5119,-6.1225,-5.094,-5.2207,-5.3641,-5.3812,-5.5854,-5.5806,-5.3533,-5.5206,-5.0883,-5.105,-5.156,-6.2033,-5.1438,-4.9997,-5.3965,-6.0547,-6.0796,-5.3671,-5.4164,-6.2753,-5.5693,-5.1401,-5.9937,-5.0529,-5.2618,-5.0705,-5.473,-4.9734,-5.0165,-5.6432,-5.6911,-6.0415,-5.3471,-5.5485,-5.4169,-5.5088,-5.9023,-5.7936,-5.8075,-5.4163,-5.657,-4.724,-4.7807,-5.9563,-5.5725,-5.3948,-5.4371,-4.8396,-5.8148,-5.0091,-5.0347,-5.0976,-5.7908,-5.5968,-5.3353,-6.1094,-5.2742,-5.1509,-5.2946,-5.5177,-5.3038,-5.1276,-5.7777,-5.9574,-5.6445,-5.0101,-5.2584,-5.2492,-5.2798,-5.5878,-5.4859,-5.4697,-5.7361,-5.5337,-5.2015,-5.3588,-5.757,-5.4533,-5.0902,-5.2009,-5.6215,-5.9905,-5.1687,-5.0473,-4.9144,-5.3712,-5.7242,-6.0674,-5.3211,-5.3483,-5.3456,-5.1179,-5.9177,-5.0083,-5.1785,-5.0458,-5.222,-5.5313,-5.3677,-5.5403,-5.2431,-5.7975,-5.4387,-5.914,-5.2375,-5.3917,-5.2011,-5.3292,-5.2347,-5.5978,-5.2721,-5.9836,-4.9517,-5.1936,-5.7083,-5.7172,-5.5707,-5.6689,-5.6358,-5.3036,-5.1632,-5.1386,-5.065,-5.1664,-5.4308,-5.9941,-5.5994,-5.4253,-5.9142,-5.342,-6.221,-5.9654,-5.2985,-5.2054,-5.618,-5.3493,-5.1238,-5.4031,-5.1308,-5.4474,-5.3553,-5.4207,-5.3476,-5.4448,-5.3763,-5.324,-5.2528,-5.2473,-5.1741,-5.6212,-5.4476,-5.2571,-5.0976,-5.8176,-5.7629,-4.9003,-5.3733,-5.3478,-5.4725,-5.2224,-5.2847,-5.0586,-5.5616,-5.9747,-5.3026,-5.6051,-5.0847,-5.7696,-5.6206,-5.0448,-5.3266,-5.5162,-5.577,-5.7371,-5.3876,-5.9625,-5.7302,-5.3782,-5.3483,-5.5161,-5.6807,-5.3152,-5.5098,-5.3576,-5.6799,-5.5311,-5.5537,-5.6622,-5.477,-5.4962,-4.9149,-5.5459,-5.4023,-5.4119,-5.1376,-5.9577,-5.5085,-5.1854,-5.269,-5.5148,-5.7413,-5.3166,-5.5382,-5.3761,-5.7715,-6.0255,-6.1206,-5.5785,-5.0411,-5.3837,-5.4238,-5.0649,-5.5278,-5.8445,-5.5062,-5.385,-5.5495,-5.253,-5.4698,-5.2499,-5.1303,-5.6234,-5.6629,-5.494,-5.4211,-5.6124,-5.7475,-5.608,-5.4436,-5.2841,-5.7007,-5.2305,-5.4404,-5.5439,-5.0084,-5.3984,-5.0555,-5.3523,-5.1771,-5.484,-5.6492,-5.495,-5.5015,-5.1162,-5.5923,-5.3988,-5.6603,-5.0779,-5.1584,-5.267,-5.4901,-5.3146,-5.0463,-5.2061,-5.4204,-5.2455,-5.7417,-5.2871,-5.28,-5.5463,-5.2315,-5.6972,-5.5939,-5.645,-5.4256,-5.3843,-5.4498,-5.151,-5.4319,-5.4299,-5.2842,-5.5666,-5.3922,-5.1218,-5.6542,-5.454,-5.4372,-5.6654,-5.2062,-5.3492,-5.6915,-5.8638,-5.4132,-5.6637,-5.2133,-5.1718,-5.2967,-5.4571,-5.2937,-5.2878,-5.1344,-5.4098,-5.1641,-5.7854,-5.6578,-5.3005,-5.5135,-5.1732,-5.2164,-5.2282,-5.3417,-5.3275,-5.5306,-5.976,-5.5162,-5.7082,-5.5778,-5.4777,-5.6081,-5.3931,-5.3834,-5.2111,-5.2888,-5.2951,-5.1727,-5.2796,-5.3346,-5.6409,-5.583,-5.7448,-5.8456,-5.6689,-5.0408,-5.4192,-5.4803,-5.6092,-5.5951,-5.7348,-5.5342,-5.7587,-6.0066,-5.3582,-5.582,-5.6649,-5.1507,-5.6881,-5.4672,-5.5218,-5.7381,-5.746,-5.4618,-5.2121,-5.6412,-5.5918,-5.5277,-5.1764,-5.1975,-5.2323,-5.6958,-5.462,-5.2123,-5.3224,-5.3132,-5.3137,-5.6197,-5.6963,-5.6836,-5.5481,-5.229,-5.6505,-5.1596,-5.9366,-5.5158,-5.3062,-5.6118,-5.4966,-5.5768,-5.6163,-5.7097,-5.5218,-5.2174,-5.3087,-5.2319,-5.5036,-5.2363,-5.4647,-5.2809,-5.7424,-5.0748,-5.5826,-5.4093,-5.6119,-5.634,-5.2823,-5.6108,-5.5973,-5.7118,-5.5048,-5.597,-5.3002,-5.4669,-5.3797,-5.3329,-5.7531,-5.5723,-5.6949,-5.3358,-5.7328,-5.4769,-5.5187,-5.1064,-5.5989,-5.7037,-5.5958,-5.5233,-5.3609,-5.5937,-5.5626,-5.2047,-5.5136,-5.594,-5.1769,-5.7897,-5.6673,-5.3292,-5.4957,-5.2911,-5.4768,-5.4485,-5.7327,-5.4997,-5.6651,-5.6953,-5.287,-5.2792,-5.3608,-5.5954,-5.3912,-5.6281,-5.7734,-5.5231,-5.6078,-5.5231,-5.204,-5.5387,-5.3542,-5.6493,-5.6178,-5.6254,-5.6174,-5.7359,-5.4289,-5.6862,-5.8303,-5.3034,-5.5604,-5.4678,-5.4096,-5.2707,-5.7013,-5.6816,-5.5315,-5.3561,-5.5818,-5.4124,-5.6354,-5.195,-5.7942,-5.342,-5.2575,-5.312,-5.6899,-5.46,-5.8212,-5.5353,-5.6163,-5.6732,-5.4552,-5.581,-5.2388,-5.486,-5.3712,-5.3319,-5.3224,-5.5889,-5.3624,-5.4887,-5.563,-5.176,-5.6909,-5.3573,-5.3653,-5.5013,-5.6658,-5.4776,-5.5451,-5.7107,-5.6195,-5.7225,-5.4449,-5.4419,-5.3421,-5.7056,-5.4264,-5.8105,-5.6587,-5.5592,-5.2427,-5.791,-5.6474,-5.3985,-5.43,-5.3204,-5.5451,-5.6535,-5.6034,-5.3856,-5.3646,-5.4494,-5.2717,-5.2945,-5.3905,-5.437,-5.699,-5.6487,-5.6914,-5.8324,-5.8027,-5.5671,-5.8625,-5.3439,-5.6715,-5.4753,-5.6478,-5.3926,-5.6664,-5.7478,-5.5593,-5.7329,-5.2624,-5.7837,-5.5547,-5.7629,-5.3,-5.4254,-5.6101,-5.5752,-5.5242,-5.6466,-5.6407,-5.5578,-5.4152,-5.7601,-5.7695,-5.3814,-5.6465,-5.3619,-5.6769,-5.7215,-5.598,-5.6365,-5.4708,-5.8226,-5.7402,-5.3371,-5.8185,-5.5462,-5.6054,-5.8256,-5.5877,-5.7273,-5.6661,-5.7399,-5.5954,-5.3453,-5.4018,-5.4214,-5.5826,-5.6072,-5.7837,-5.7204,-5.5898,-5.5396,-5.7038,-5.7048,-5.6145,-5.5998,-5.6297,-5.4142,-5.7108,-5.7519,-5.7696,-5.5428,-5.6289,-5.7748,-5.4027,-5.3289,-5.4757,-5.7944,-5.7483,-5.4978,-5.6,-5.5973,-5.4418,-5.7903,-5.8411,-5.6076,-5.6718,-5.3806,-5.6872,-5.7378,-5.6882,-5.3563,-5.4921,-5.3839,-5.506,-5.4447,-5.6845,-5.6811,-5.5995,-5.4563,-5.7112,-5.4388,-5.7222,-5.8251,-5.8501,-5.4437,-5.5457,-5.7172,-5.7028,-5.4042,-5.3813,-5.4206,-5.4152,-5.6876,-5.6339,-5.5439,-5.7116,-5.376,-5.7048,-5.7325,-5.8491,-5.3825,-5.77,-5.5962,-5.725,-5.6077,-5.6475,-5.8828,-5.6462,-5.8802,-5.9178,-5.7621,-5.6096,-5.7372,-5.7232,-5.9037,-5.712,-5.8546,-5.4053,-5.7687,-5.6539,-5.7776,-5.6093,-5.5032,-5.8605,-5.4077,-5.3653,-5.4084,-5.4566],\"loglift\":[30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1,1.8697,1.8231,1.6546,1.4445,1.4083,1.3131,1.3071,1.3031,1.294,1.2847,1.2637,1.1834,1.1569,1.1553,1.1389,1.118,1.1097,1.0956,1.0874,1.0865,1.0789,1.0646,1.0415,1.0358,1.023,1.0204,1.019,1.0108,1.0049,1.0018,2.207,1.9383,1.8963,1.8667,1.8122,1.7143,1.7092,1.6983,1.6209,1.6155,1.578,1.5458,1.5418,1.5288,1.5234,1.4577,1.4493,1.4313,1.4262,1.4218,1.3988,1.3937,1.3842,1.3761,1.3643,1.3632,1.3545,1.354,1.3399,1.3237,2.1315,2.1227,2.0391,1.9701,1.8588,1.8055,1.7839,1.7085,1.7025,1.6921,1.68,1.6744,1.6723,1.6607,1.6544,1.6429,1.633,1.624,1.5741,1.5682,1.5667,1.5583,1.5502,1.5099,1.5063,1.4985,1.4911,1.4889,1.4884,1.4814,1.6726,1.5337,1.5064,1.4814,1.4416,1.4321,1.4168,1.3758,1.3067,1.2795,1.2298,1.2183,1.1927,1.1762,1.1748,1.1686,1.1602,1.1577,1.1322,1.109,1.1062,1.0951,1.0946,1.0855,1.0853,1.083,1.0815,1.0812,1.0806,1.0799,1.5711,1.5256,1.4906,1.2162,1.2066,1.14,1.1196,1.1156,1.0752,1.0711,1.0451,1.0364,1.0174,1.0173,0.998,0.9924,0.9671,0.9568,0.9519,0.9483,0.9441,0.9408,0.9376,0.9263,0.9178,0.9162,0.9078,0.9046,0.8933,0.8906,2.5839,2.3264,2.248,2.202,2.1962,2.1617,2.1604,2.1544,2.0904,2.0735,2.0647,2.0592,2.0206,1.9676,1.9481,1.9454,1.8524,1.8495,1.8436,1.8387,1.8356,1.8109,1.8105,1.7917,1.7738,1.7724,1.7634,1.7165,1.7138,1.6983,2.2585,2.2418,2.1636,2.0269,2.0089,1.9788,1.8608,1.859,1.8169,1.8138,1.7859,1.7752,1.7557,1.743,1.7422,1.7365,1.7357,1.7222,1.7209,1.7012,1.6812,1.6455,1.6452,1.6451,1.641,1.6299,1.6228,1.5973,1.595,1.5907,1.7127,1.2566,1.2338,1.2276,1.2041,1.1967,1.1904,1.1743,1.1725,1.1699,1.1668,1.146,1.1451,1.1329,1.1269,1.1247,1.1218,1.1195,1.1062,1.0973,1.0938,1.0884,1.0863,1.0793,1.0776,1.075,1.0713,1.0689,1.0633,1.059,1.5881,1.5519,1.2769,1.2234,1.2032,1.2021,1.1546,1.1397,1.1065,1.0979,1.0957,1.0913,1.0875,1.0864,1.0752,1.0635,1.0592,1.039,1.0387,1.0244,1.023,1.0159,1.0114,1.0042,1.0035,1,0.9989,0.9805,0.9805,0.9771,1.8131,1.4431,1.4406,1.4149,1.3981,1.3809,1.336,1.3207,1.3156,1.3149,1.3025,1.2773,1.2746,1.2506,1.2383,1.2354,1.2336,1.2306,1.2276,1.2262,1.2161,1.2149,1.2027,1.19,1.1842,1.1765,1.1765,1.1695,1.1649,1.1619,1.721,1.535,1.2479,1.2111,1.2061,1.2002,1.1674,1.1441,1.1341,1.1208,1.1186,1.1093,1.1032,1.1006,1.1006,1.0938,1.0882,1.083,1.0819,1.0749,1.0659,1.0646,1.0545,1.0453,1.0422,1.0422,1.0404,1.037,1.0353,1.0301,2.8202,2.3444,2.343,2.085,2.0257,1.9727,1.9403,1.9375,1.8659,1.8359,1.82,1.7581,1.7553,1.7505,1.7482,1.6672,1.6554,1.6545,1.6205,1.6129,1.6122,1.6086,1.6018,1.6015,1.5972,1.5939,1.591,1.5704,1.5578,1.5474,1.8894,1.8789,1.421,1.3949,1.3818,1.372,1.3581,1.3476,1.324,1.3112,1.2644,1.2566,1.2532,1.2382,1.2347,1.2153,1.2054,1.2003,1.1977,1.1973,1.1942,1.1805,1.1788,1.1776,1.1746,1.1688,1.1636,1.1586,1.1567,1.1489,2.3891,2.3858,2.2062,2.1532,2.0515,2.0351,2.0338,2.0126,1.981,1.9744,1.9636,1.9395,1.8717,1.8672,1.8241,1.8075,1.8037,1.7909,1.7769,1.7721,1.7417,1.7116,1.6591,1.6425,1.6321,1.6276,1.5978,1.5779,1.5673,1.5355,3.0146,2.7723,2.683,2.6711,2.5823,2.3853,2.3389,2.3107,2.2266,2.1055,2.0474,2.0281,2.0182,2.0001,1.9571,1.8699,1.7989,1.708,1.7079,1.6642,1.66,1.6497,1.6279,1.6233,1.5921,1.5865,1.5654,1.5034,1.498,1.4559,3.1041,2.7725,2.6168,2.5129,2.4642,2.3666,2.3001,2.2828,2.2678,2.2443,2.2233,2.2127,2.2121,2.0829,2.0398,2.0184,1.9939,1.9643,1.9596,1.9503,1.9411,1.931,1.8988,1.8981,1.8855,1.8742,1.7778,1.7771,1.773,1.762,3.2347,3.229,3.1218,3.1051,2.9067,2.7941,2.7373,2.5472,2.5435,2.5333,2.4432,2.3968,2.3844,2.3645,2.3552,2.2742,2.1937,2.1936,2.1872,2.1835,2.1412,2.1079,2.0285,2.0146,1.9785,1.9755,1.9627,1.9521,1.939,1.9378,3.2164,2.8124,2.6105,2.4339,2.4062,2.3535,2.2104,2.2022,2.1809,2.1561,2.1025,2.0057,1.9529,1.9268,1.9137,1.9078,1.8882,1.8427,1.8242,1.7353,1.7314,1.7262,1.7131,1.6997,1.6676,1.6415,1.6291,1.6158,1.6096,1.6074,1.6191,1.5069,1.4885,1.4832,1.4728,1.4307,1.422,1.3992,1.3762,1.3653,1.3552,1.354,1.3373,1.3339,1.3145,1.3139,1.3131,1.3097,1.3095,1.2927,1.2859,1.2817,1.2718,1.2687,1.2677,1.2624,1.26,1.2577,1.2527,1.2524,2.4505,2.3351,2.2009,2.1551,2.1158,2.095,2.0887,2.0673,2.0206,2.0031,2.0021,1.9899,1.9233,1.9125,1.8983,1.8472,1.8403,1.8208,1.817,1.7946,1.7453,1.7445,1.7311,1.7281,1.7087,1.6947,1.6814,1.6377,1.6363,1.6192,2.8091,2.2939,2.132,2.1263,2.0407,2.0284,1.9848,1.9795,1.9723,1.9557,1.9533,1.9216,1.9197,1.909,1.884,1.8802,1.8669,1.8431,1.8292,1.8279,1.8277,1.8049,1.757,1.7499,1.742,1.7308,1.7101,1.7047,1.6962,1.6844,2.4173,2.2185,1.9476,1.894,1.8552,1.8254,1.8247,1.7813,1.7686,1.7678,1.7654,1.7463,1.716,1.7015,1.694,1.6829,1.6769,1.6719,1.6536,1.6512,1.6488,1.642,1.6406,1.6334,1.6323,1.6298,1.6101,1.59,1.589,1.5798,2.3948,2.2787,1.9563,1.8649,1.8096,1.7049,1.6749,1.6296,1.5667,1.5317,1.5211,1.5133,1.4675,1.4629,1.4429,1.4335,1.4267,1.4103,1.4084,1.4,1.3956,1.3955,1.3866,1.3851,1.3837,1.3773,1.3753,1.3702,1.3658,1.3586,2.326,2.0983,2.059,2.054,1.9958,1.9533,1.9437,1.9316,1.9288,1.9211,1.915,1.9077,1.879,1.8727,1.8471,1.8192,1.8155,1.8051,1.7938,1.7789,1.7648,1.7549,1.753,1.7468,1.7378,1.735,1.7231,1.7222,1.7052,1.7012,2.1557,2.095,1.7709,1.4808,1.44,1.294,1.287,1.2716,1.2676,1.2127,1.2071,1.1807,1.1735,1.1707,1.1642,1.1534,1.1499,1.1486,1.1369,1.1264,1.111,1.1044,1.1037,1.1025,1.0987,1.0888,1.0876,1.0825,1.0701,1.0602,2.7131,2.7131,2.1261,1.9596,1.9248,1.7861,1.7134,1.7033,1.696,1.6921,1.6713,1.6658,1.6546,1.6398,1.6398,1.6239,1.6172,1.5945,1.5676,1.562,1.5466,1.5408,1.5102,1.5095,1.5053,1.5007,1.4975,1.4907,1.4904,1.4858,2.6809,2.4332,2.4051,2.3378,2.2606,2.1352,1.9127,1.8603,1.8416,1.8008,1.7799,1.7014,1.6807,1.64,1.6365,1.6281,1.5944,1.5941,1.5935,1.5681,1.5672,1.5652,1.5533,1.53,1.524,1.5221,1.5109,1.5074,1.5029,1.5027,3.2211,3.0029,2.8803,2.7086,2.5949,2.4143,2.349,2.3416,2.2948,2.2879,2.2431,2.2354,2.2261,2.1571,2.1419,2.0785,2.05,2.0372,2.0205,2.0122,1.9738,1.9729,1.9656,1.9067,1.8422,1.8409,1.84,1.8244,1.8152,1.8109,2.5551,2.2056,2.1971,2.1778,2.0157,1.9553,1.9349,1.8423,1.8206,1.8072,1.724,1.7114,1.6994,1.6906,1.6772,1.6417,1.6298,1.6267,1.6265,1.6248,1.6228,1.6136,1.6126,1.6124,1.5954,1.5901,1.5871,1.5468,1.5386,1.5345,2.7457,2.2939,2.0247,1.8634,1.8575,1.8568,1.8307,1.8226,1.8187,1.7602,1.6986,1.6895,1.6812,1.6636,1.6261,1.5802,1.5733,1.5669,1.5574,1.5562,1.5269,1.52,1.5149,1.496,1.4934,1.4872,1.4816,1.4772,1.4739,1.4703,2.7302,2.7258,1.9084,1.7464,1.7206,1.6384,1.6149,1.6133,1.6018,1.5968,1.5952,1.559,1.5476,1.5459,1.529,1.5141,1.5027,1.5009,1.4914,1.4495,1.4377,1.4355,1.4238,1.4211,1.4128,1.4017,1.4012,1.3861,1.3641,1.3459,3.0991,3.0503,2.7848,2.7375,2.5774,2.4931,2.4172,2.3106,2.2533,2.1461,2.1427,2.0812,2.0551,2.0336,1.9942,1.9372,1.9056,1.893,1.8296,1.8282,1.825,1.8065,1.7956,1.7723,1.754,1.7293,1.7132,1.6919,1.6783,1.6677,2.7288,2.4069,2.3347,2.3032,2.2015,2.1546,2.1019,2.055,2.0223,2.0192,1.9992,1.9846,1.9754,1.9746,1.9692,1.9652,1.9643,1.9577,1.9528,1.9417,1.9227,1.9218,1.9047,1.8976,1.8923,1.8797,1.8576,1.8532,1.8331,1.8277,2.8584,2.6751,2.6268,2.619,2.5549,2.1743,2.0464,1.901,1.8834,1.8285,1.82,1.8187,1.8149,1.8037,1.8016,1.7991,1.7711,1.7317,1.7266,1.7216,1.7181,1.7013,1.6978,1.6972,1.6867,1.6687,1.6576,1.6392,1.6345,1.6238,2.8522,2.8321,1.7028,1.681,1.667,1.6635,1.639,1.6034,1.6008,1.5984,1.5511,1.5487,1.5378,1.5365,1.5184,1.5157,1.4921,1.4886,1.4874,1.4829,1.4537,1.4363,1.4363,1.4321,1.4046,1.3993,1.3873,1.3853,1.3663,1.3599,2.8579,2.8456,2.1387,2.1172,1.91,1.9026,1.8043,1.7909,1.7818,1.7422,1.7319,1.7214,1.6795,1.6533,1.6515,1.6488,1.6438,1.631,1.608,1.6029,1.5978,1.5877,1.5781,1.5718,1.5662,1.5592,1.5581,1.5529,1.5459,1.5436,1.301,1.072,0.8876,1.5874,1.0587,0.9731,0.9667,0.9733,1.5441,1.5993,1.6051,1.3406,1.6935,1.6931,1.058,1.4993,1.5329,1.3422,1.6475,1.6009,0.9916,1.0322,0.8793,1.0493,0.9635,1.1376,1.0002,1.1186,1.735,1.2482,1.6504,1.565,1.5711,1.3218,1.6574,1.0471,1.0551,1.4559,1.473,1.3303,1.6585,1.5805,1.5258,0.8706,1.5579,0.9317,1.1242,0.9631,1.0923,1.6004,1.5504,1.3432,1.0361,1.0396,1.4724,1.4447,1.4484,1.4282,1.4485,1.4611,1.8075,1.3284,1.5147,1.4058,1.4133,0.9869,0.9706,0.8564,0.9297,0.9305,1.0563,1.5085,1.8914,1.5146,1.3033,1.0343,1.4472,1.3182,1.5919,1.2778,1.515,0.9483,1.0397,0.8567,1.0516,1.0058,1.4547,1.4252,1.2595,1.6664,1.0413,1.4196,1.4546,1.458,1.3325,1.6115,1.7959,1.5498,1.2731,1.5151,0.9441,1.4238,0.8683,0.8976,0.935,0.9369,0.8993,1.4388,1.8702,1.4436,1.5572,1.544,1.2598,1.2671,1.6555,1.0422,1.416,1.4452,1.3887,1.3058,1.5663,1.6235,1.7559,1.7294,1.2916,1.475,0.9238,0.9494,0.8608,1.6844,1.4758,0.9217,1.0526,0.8659,1.4733,1.0191,1.2218,1.4657,1.5563,0.9882,1.4146,1.3635,1.3595,1.3863,1.2877,1.4214,0.8883,0.8556,1.5482,0.9506,0.9491,0.8747,0.9253,1.4086,0.9766,1.0802,1.0338,1.4257,1.5753,1.8415,1.3815,1.5219,1.4911,1.3057,1.6493,0.9865,1.3448,1.488,1.3491,0.9168,1.1062,0.9035,0.952,0.9013,1.0211,0.9811,0.789,1.7452,1.1863,1.6745,1.5422,1.2941,1.3405,1.7306,1.2558,1.1851,1.1685,1.3385,0.8988,0.8897,0.8124,0.9188,0.9145,1.0389,0.8665,0.7759,0.8193,1.3355,1.4487,1.4043,1.0943,1.3969,1.5755,1.3391,1.3,1.3096,1.4912,1.3369,1.2666,0.7384,1.2382,0.8573,0.951,0.7554,1.0148,1.4006,1.2897,1.6215,1.1696,1.1487,1.5958,1.4115,1.2503,1.1989,1.1551,0.7575,1.3841,0.8678,0.7947,0.8803,0.7744,0.9372,1.2582,0.903,1.1775,1.5124,1.5838,0.9422,1.2912,1.4805,1.5823,1.514,1.2768,0.9877,1.3869,0.7947,0.7314,0.8029,0.7923,0.948,0.9744,0.8756,1.89,1.5977,1.5604,1.2629,0.9901,1.3291,1.3751,1.2668,1.4505,1.6565,1.2491,1.1627,0.9522,0.8704,0.7328,0.9053,0.7762,1.3225,0.9101,1.327,1.2692,1.5731,1.756,0.9472,1.3604,1.3999,1.1276,0.9816,1.4195,1.2745,0.6979,0.6286,0.7472,1.325,1.4236,0.8014,0.8149,0.9899,0.7629,1.2301,1.0099,1.3614,0.8034,0.8169,1.3514,1.4274,1.3913,1.538,1.1677,1.1419,1.4663,1.6456,1.501,1.1256,0.6902,0.745,1.6751,0.7411,0.8523,1.2026,1.3047,0.998,1.0573,0.8997,1.2301,1.2476,1.2034,1.2429,1.0858,1.1901,0.7121,1.1409,1.2194,1.5786,0.7477,0.7751,0.8642,1.5667,1.4957,1.5569,1.208,0.8647,1.3615,1.2812,1.1691,1.376,1.4683,1.4097,1.2695,0.5776,0.6686,0.8492,1.2195,0.8191,1.5649,1.274,1.1916,1.5972,1.0259,1.1583,1.0898,0.6943,0.9301,0.7402,0.8851,0.7906,1.2636,1.2491,1.5045,0.8632,1.1123,1.2375,1.3434,1.089,1.2175,1.4025,1.1965,1.301,1.4098,0.5117,0.6609,0.6364,1.1697,1.3073,0.7095,1.4809,1.5246,0.8681,0.5991,1.4703,1.6179,1.5764,1.068,1.2382,0.805,1.1841,1.1745,1.1066,1.0173,1.5627,1.5872,1.691,1.3494,1.2624,0.5132,0.7508,0.6805,1.2882,1.238,0.8078,0.6628,0.8177,0.909,1.2053,0.9353,0.6565,1.5086,1.4318,1.3067,1.0526,1.4512,1.6338,1.1431,1.1628,0.6835,0.7745,1.1507,0.9005,0.7991,0.7047,1.024,1.1361,1.0591,0.9797,1.3861,0.9562,1.0295,1.2304,0.787,0.5908,0.6835,1.3781,1.4681,0.8227,1.3443,1.2252,1.4368,1.2516,1.3407,1.104,1.2915,1.4211,1.0908,1.1218,0.4952,1.072,0.7446,0.7339,0.9151,1.2244,0.7762,0.8256,1.1635,0.7257,0.7451,0.6493,1.1117,1.2987,1.2117,1.1141,1.0265,1.0649,0.513,0.7425,0.7125,0.5871,0.8512,0.8734,1.4987,1.0188,1.5875,1.056,0.9627,0.8616,1.3747,0.9793,1.1037,1.0779,1.0286,0.5865,1.1276,1.5042,1.5014,0.6386,0.7877,0.8581,1.4575,0.6119,0.6256,1.0781,1.2446,0.4685,0.8307,1.3428,0.7389,0.7625,1.0834,1.1499,0.9812,1.2702,0.8542,1.299,0.8662,0.4875,1.0463,0.7814,0.878,1.0055,1.2383,0.6265,0.6629,1.0073,0.7698,1.0402,0.7448,0.6448,1.3163,1.0704,1.313,1.1241,1.1097,1.2321,1.4205,1.2992,0.4402,0.5972,0.7722,0.4113,0.9088,0.8001,0.9666,1.0896,1.205,1.0827,0.8156,1.0143,1.1151,1.4172,1.0035,1.0811,0.7955,1.0628,0.6576,0.6314,0.9237,0.6405,0.8078,1.4258,1.0702,1.4632,1.3548,0.8319,1.3692,1.4917,0.8447,0.9111,0.6178,0.6436,1.1316,0.9459,1.0321,1.3159,0.6369,0.9326,1.0516,0.9665,1.0253,1.5248,1.1741,1.3031,0.9282,0.8773,1.2406,0.9786,0.8365,0.4544,0.7345,0.7344,0.4109,0.9152,1.2612,1.5668,1.2978,0.8619,1.2336,0.944,1.1749,0.8925,1.2718,0.927,0.6944,0.6125,0.9004,1.0885,0.8108,1.2909,1.4877,0.9561,0.4996,1.525,1.0385,0.946,1.0391,0.9196,0.9915,1.3106,0.85,0.8595,1.2041,1.0774,0.6449,0.8361,0.8984,1.0593,0.6289,0.6135,0.7186,1.1646,1.4818,0.4783,0.9549,0.8847,0.8935,1.2569,0.9616,0.688,1.3485,0.651,1.097,0.5983,1.0398,0.7757,0.3928,0.9494,1.3335,0.9725,1.2429,1.1389,0.9612,1.0162,0.6712,1.0605,0.4499,0.8887,0.6928,0.5232,1.1559,0.5441,0.7616,0.7797,0.5343,1.0508,1.1781,1.074,1.092,0.6911,1.1565,0.7949,1.1504,0.8481,0.9618,0.7059,0.6804,0.7003,1.1298,0.3956,0.5569,0.6631,0.4769,0.8838,0.4577,0.4443,0.9738,0.7801,0.979,1.0797,1.0845,1.0333,1.2627,0.8228,0.4352,0.6217,0.5488,0.7453,0.6057,0.3586,0.7853,0.4088,1.1921,1.1482,1.1039,0.7479,0.8336,1.0465,0.7796,1.0244,1.0344,0.6722,1.2938,0.6364,0.8496,0.5799,0.9971,0.8127,1.0474,0.7897,0.7495,0.8822,0.7318,0.9697,0.8613,0.4586,0.4445,1.1709,0.5332,0.5615,1.3352,0.765,0.751,0.6196,0.7521,1.2297,0.5654,1.0344,0.9742,0.7221,0.4207,0.566,1.0063,0.6729,0.3631,0.7461,0.6467,0.7894,0.8833,0.8567,1.0703,0.5828,0.2924,0.4824,1.1433,0.9355,1.3974,0.6841,0.5913,0.9514,0.9547,0.5932,0.8261,0.1701,0.823,0.7721,0.537,0.651,0.8803,0.7744,0.9906,0.8415,0.6731,0.5051,0.6785,0.6066,0.602,0.7297,0.7922,0.749,0.6556,1.0496,0.6135,0.6021,0.8999,0.9483,0.6653,0.9818,0.9643,0.5541,0.6458,0.9073,0.831,1.4736,0.7478,0.9499,0.763,0.2515,0.5125,0.8174,0.5041,1.2579,0.6116,0.3895,0.8434,0.2818,0.8404,0.9039,0.7701,0.8574,0.5976,0.3612,0.517,0.3096,0.5938,0.7837,1.0131,0.8276,0.7894,0.8474,0.8972,1.1443,0.6278,0.7451,0.7257,0.2364,0.7634,0.6731,0.4303,0.6642,1.0051,1.2384,1.1716,0.7014,0.7689,1.0917,0.909,0.8971,0.4206,0.6229,0.4558,0.5068,0.4004,0.4993,0.2178,0.7426,0.818,1.3946,0.3361,0.4928,0.7199,1.1642,0.3233,0.1899,0.5554,0.7591,0.4858,1.2464,0.508,0.9397,0.7066,0.5963,0.8343,0.763,0.5752,0.326,0.4216,0.5579,0.7817,1.1281,0.3154,0.5697,0.8408,0.5612,0.6926,0.6613,0.462,0.4879,1.0484,0.7886,1.0581,0.8265,0.7793,0.691,0.672,0.1694,0.6945,0.9244,0.3599,0.8298,0.7661,0.6411,0.5122,0.7646,1.1036,0.2578,0.4681,0.4863,0.5562,0.5658,0.3388,0.7168,0.4934,1.2552,0.8336,0.6943,0.2008,0.7125,0.5553,0.8282,1.1195,0.815,0.8127,0.5478,0.756,0.9921,0.618,0.5587,0.5882,0.3139,0.4576,0.5095,0.5268,0.6367,0.5815,0.8107,0.8539,0.3875,0.4624,0.9514,0.2514,0.1995,0.7631,0.5281,0.5072,0.5688,0.4145,0.8314,0.8819,0.7544,0.5956,0.6687,0.6578,0.2748,0.345,0.6287,0.3694,0.4304,0.8875,0.6243,0.4457,0.528,0.5072,0.6061,0.6422,0.2403,0.5703,0.3295,0.3103,0.2865,0.6868,0.4774,0.3704,0.45,0.1902,0.1823,0.573,0.5905,0.2511,0.7817,0.4261,0.7719,0.7563,0.5702,0.5237,0.5727,0.7398,0.703,0.881,0.5238,0.1828,0.5157,0.4157,0.6797,0.5233,0.3749,0.9814,1.2816,0.6214,0.7434,0.545,0.356,0.4664,0.6326,0.5943,1.1557,0.7325,0.6533,0.5706,0.4894,0.5314,0.5403,0.5718,0.9515,0.5643,0.3794,0.8027,0.2779,0.3914,0.5903,0.2815,0.7576,0.5488,0.5387,0.4751,0.628,0.3356,0.9114,0.7106,0.3841,0.2803,0.7816,0.67,0.1182,0.8696,0.5044,0.7859,0.6997,0.6429,0.3199,0.3923,0.6428,0.596,0.6138,0.7473,0.3591,0.332,0.5755,0.1787,0.3386,1.1259,0.2194,0.7585,0.8967,1.01,0.5505,0.8739,0.4442,0.2702,0.5155,0.8231,0.6289,0.2944,0.7452,0.1091,0.5816,0.3279,0.5947,0.5117,0.511,0.3511,0.4437,0.2991,0.3442,0.2823,0.2748,0.3029,0.2862,0.4501,0.8635,0.6834,1.0189,0.7811,0.7998,0.4443,0.2607,0.361,0.4109,0.6488,0.5236,0.5495,0.2372,0.8108,0.777,0.4679,0.5935,0.5256,0.3712,0.2277,0.2496,0.4185,0.6127,0.0944,0.3473,0.6145,0.6894,0.8126,0.7008,0.6935,0.626,0.2621,0.5995,0.3623,0.8839,0.7157,0.2574,0.6681,1.0022,0.251,0.2996,0.2382,0.3626,0.2318,0.2532,0.3829,0.2702,0.6734,0.6758,0.3291,0.6829,0.1825,0.2673,0.3907,0.761,0.4045,0.1049,0.7425,0.7444,0.6854,0.7466,0.1565,0.4673,0.8061,0.4379,0.4812,0.8187,0.6361,0.7042,0.3307,0.2047,0.1538,0.2741,0.2205,0.1488,0.494,0.614,0.5484,0.131,0.7112,0.3571,0.6571,0.2956,-0.0601,0.4396,0.2452,0.6681,0.3156,0.4502,0.4649,0.7495,0.6839,0.4428,0.3763,0.2434,0.3022,-0.0016,0.2098,0.5347,0.1914,0.2354,0.5109,0.2815,0.5661,0.2513,0.2774,0.4446,0.7184,0.6664,0.0851,0.2528,0.6576,0.4304,0.3064,0.5237,0.4519,0.3742,0.2412,0.1714,0.1881,0.2944,0.3424,0.604,0.3469,0.4071,0.1605,0.132,0.2079,0.3408,0.6171,0.283,0.2435,0.3137,0.2101,0.4102,0.3008,0.418,0.3197,0.3457,0.2095,0.5906,0.1677,0.4499,0.5788,0.2119,0.0582,0.2005,0.4505,0.1511,0.3681,0.3258,0.0473,0.1625,0.4356,0.1382,0.5619,0.1504,0.0647,0.6242,0.6863,0.3977,0.5815,1.0733,0.5041,0.0305,0.0865,0.0881,0.7444,0.3291,0.4138,0.0301,0.1696,-0.0824,0.5742,0.4198,0.3549,0.2902,0.4685,0.4913,0.6741,0.5795,0.1499,0.316,0.7684,0.2831,0.3116,0.1479,0.3101,0.0019,0.455,0.3293,0.3559,0.1476,0.08,0.0402,-0.1151,0.1214,0.1256,0.036,0.4086,0.4303,0.3349,-0.0081,0.388,0.098,0.1889,0.4457,0.4254,0.2188,0.1649,0.2984,0.4589,0.1574,0.484,0.7635,0.5073,0.5054],\"Freq\":[684,601,514,488,502,408,328,458,652,513,584,481,465,404,394,612,461,502,501,458,449,482,511,436,491,457,226,416,581,474,12.4209,19.8986,11.0561,60.0195,82.5189,2.6215,2.3002,6.5938,6.2871,8.01,5.0604,3.8413,7.6453,62.4866,3.2202,5.3824,3.7131,3.2275,2.4612,8.0922,5.0472,3.0669,3.7854,5.4799,7.112,5.1597,4.482,16.0689,3.5496,8.4701,8.7781,20.5095,31.1076,12.9891,5.5861,27.1105,9.4165,5.7457,5.7723,58.6578,11.7344,17.431,7.3956,4.9211,175.5552,29.6355,7.8819,7.8471,8.4678,6.6146,6.4107,23.2477,11.3452,30.199,8.0156,9.3278,7.4276,6.6037,27.604,2.5625,10.657,13.1164,19.8476,15.7601,13.426,32.2699,11.2035,116.0041,9.7006,68.8689,5.5744,5.2739,31.5054,4.2628,5.5562,4.0989,7.5783,6.5582,14.161,3.9896,10.1151,25.3534,4.6636,3.6616,21.6609,10.566,6.9681,3.771,3.4977,9.063,14.1598,31.5516,56.055,46.4853,46.2736,7.8494,5.8486,9.3885,4.6173,10.1068,9.4985,7.8274,3.2321,7.6516,3.8478,3.7525,3.386,8.2012,5.233,11.0376,3.6939,6.0025,8.3991,7.5196,16.5271,4.3974,2.6165,3.386,8.531,4.8005,10.5689,8.4343,7.8625,20.0224,42.9205,99.8207,37.7163,54.699,9.0851,79.0713,5.1576,78.0303,2.3125,30.0937,18.2906,2.4838,7.6028,25.1339,3.8541,16.0571,18.4584,23.9749,35.7745,2.0384,12.3297,16.5138,1.85,7.936,19.0136,37.7623,8.7823,15.8942,16.6223,6.2382,19.1278,8.9615,4.2343,5.82,7.7218,10.9492,9.0959,5.0632,4.2293,23.519,3.4502,6.6016,4.2293,7.224,60.9441,10.5186,70.7311,3.032,77.6041,15.466,8.4238,3.4589,2.2478,12.4366,30.6035,14.4069,10.3514,9.8947,20.6787,22.9168,5.7846,6.2573,26.9016,119.6156,7.5512,54.3367,23.6681,7.2019,5.8018,11.0628,41.8798,8.1878,13.9143,13.9151,8.3348,13.61,7.6337,34.4732,5.9328,51.6431,6.8638,30.543,28.6614,12.9196,28.3517,2.8923,7.3152,4.7752,3.81,5.9944,4.3942,7.747,2.4384,2.9126,5.2832,4.7244,6.6802,3.2004,3.0734,4.8768,3.5814,6.7734,12.2429,2.9803,6.1722,57.5567,2.286,2.2606,6.9088,12.8525,8.0772,6.4432,5.0292,5.6727,2.7686,2.5908,9.1619,9.1619,2.1378,73.6268,19.7928,8.0719,17.8288,11.3049,2.7486,36.358,36.4527,4.2755,2.1378,2.9013,4.1597,3.9965,2.2905,6.3133,10.889,58.2409,4.8495,3.9859,36.6739,9.6042,19.8981,3.8332,2.2905,4.2598,1.8324,4.0386,7.6165,55.6759,14.2683,52.7234,7.7689,2.7589,3.3513,6.9818,3.5036,7.388,4.1129,6.3217,1.371,1.2356,10.6124,2.6235,39.9882,5.3824,9.7238,2.8435,2.4373,6.2794,2.4711,2.1326,23.7128,2.0395,4.9761,3.5967,1.8449,1.7264,14.902,25.5605,59.6411,3.8407,1.6899,4.4552,1.8435,2.4581,2.4581,3.6871,21.3807,7.0171,4.4552,4.8331,2.1508,6.0206,1.5363,3.9943,10.7997,2.9189,1.9972,10.7997,2.7653,1.9972,1.9972,1.3827,2.4581,7.9306,5.132,2.4581,12.3173,47.0099,39.251,3.9415,2.135,4.4342,3.1204,10.3465,5.6167,2.9561,5.932,6.7269,12.383,3.2846,6.9108,1.9708,2.2992,5.1765,2.4635,2.7919,2.9561,2.7985,2.8313,28.8891,4.8546,14.5574,10.872,4.8087,11.0757,4.9006,22.4946,22.6486,51.4809,3.2355,9.8606,8.7821,4.7762,2.9274,2.0029,2.0029,4.16,3.6977,5.5466,3.8518,2.7733,2.4652,29.73,3.0814,3.0814,4.16,4.9303,26.6901,26.4679,3.5437,4.9303,1.6948,14.9687,8.3199,2.6192,1.0785,11.0756,17.696,26.161,33.9313,11.1339,10.8924,21.62,11.1476,23.6434,12.5393,7.9861,25.1053,14.251,7.0118,13.147,6.0791,14.1594,5.6294,52.4239,7.4198,5.4629,6.5954,9.7488,7.3348,85.8892,97.2933,7.2857,1.1076,2.2401,8.0636,9.8545,12.3114,8.7332,3.3875,19.8593,2.4636,4.8005,5.5704,20.8948,11.518,77.5367,3.4276,1.5398,18.1945,3.8628,3.3473,1.2318,1.5398,2.6377,2.8811,3.1912,1.2318,2.8385,19.1818,1.6937,3.5432,2.3096,1.8477,2.1036,2.1557,11.2228,11.9365,3.9432,3.0332,4.7015,1.5166,1.9716,3.6398,2.4266,2.5782,5.1966,4.1662,3.1849,6.2431,3.9432,3.3365,2.4266,2.7299,2.1232,3.0332,9.4007,1.5166,23.4191,5.8463,14.0627,88.2438,3.4882,5.6853,2.8815,2.4266,13.678,9.983,27.2594,34.095,8.5713,9.68,6.5545,7.5092,11.7077,5.3444,3.1764,3.7959,3.9327,5.1788,16.0933,4.6242,2.1176,17.1064,15.8518,29.8025,37.0157,3.5927,3.0324,1.9664,3.1764,13.1195,3.0468,8.571,3.0468,6.4378,5.6774,6.0892,6.6062,2.0677,13.0371,3.1717,18.5481,9.9969,2.3919,8.7878,7.1581,2.7599,6.9391,2.6547,2.6723,1.4194,1.1039,1.4982,68.7601,4.8539,2.8387,3.5747,3.601,1.6384,2.0502,1.4719,1.1302,10.9957,1.2617,1.4632,2.1321,28.4178,3.0459,27.5653,2.4367,1.8275,2.589,2.1321,1.5229,2.7413,1.9798,3.1982,1.8275,2.1321,1.8275,1.5229,1.8275,4.7211,5.3303,1.5229,2.8936,6.8532,3.3505,9.29,9.4422,1.2184,1.8275,3.0459,3.3505,2.4367,13.8006,28.0193,13.0795,10.6905,14.637,6.3451,6.821,18.9343,55.6266,10.0368,2.6967,13.3391,12.7767,20.3242,7.8785,4.6002,7.4555,4.9174,5.2347,2.6967,6.2105,8.8302,2.3794,3.0139,6.3066,5.0761,2.8553,7.1671,4.629,7.6333,5.8656,42.6889,1.9552,4.9786,3.1591,7.1691,7.6579,1.4664,2.3173,18.0858,2.5436,3.7837,2.3897,1.8375,3.4216,3.6389,2.1725,7.7122,2.1634,2.5526,9.4502,4.1096,2.0005,12.2382,4.182,2.5889,1.7923,2.607,1.4664,21.8048,6.2853,1.9929,2.5643,2.6061,6.2296,2.1741,1.8396,3.4214,1.9093,2.0765,1.533,2.9963,1.9929,3.3865,10.4662,55.425,2.9127,1.8396,1.9093,2.7594,6.5083,3.8325,3.9649,10.7868,1.8396,1.9929,0.9198,1.5957,3.0103,2.7176,10.8906,5.5849,6.896,2.9476,11.7687,6.4692,29.3959,11.9017,2.6916,1.7375,16.9773,0.9308,4.6111,8.0633,1.4583,9.4943,11.862,5.8604,1.7065,21.883,3.7424,1.435,9.5504,2.2107,31.5432,16.3151,1.5514,3.4146,2.327,2.7537,15.1791,7.8243,2.1908,2.3473,2.0343,2.0343,8.7632,4.3816,2.9732,8.3941,4.6946,16.4458,2.0343,5.3205,1.8778,12.014,5.9465,2.1908,2.1908,4.0686,2.6603,1.5649,1.5649,2.0343,6.2594,2.1908,1.8778,6.5724,1.5649,1.8778,13.0931,5.2372,1.8827,22.0802,3.2348,8.1434,5.6685,12.8774,2.9866,12.939,3.4658,1.7457,25.113,1.5917,0.8386,24.3891,1.5746,14.7618,5.0627,2.7932,1.1296,7.0857,3.2981,1.0954,8.6842,8.4669,40.6655,2.2421,6.0844,25.1712,6.8138,6.8138,10.7538,22.9909,9.8886,3.5692,3.461,2.1322,8.328,7.3392,4.1717,2.5957,25.3394,7.8954,9.3941,3.3992,6.2731,16.996,1.6069,5.9331,7.7872,4.2181,4.4035,8.0036,1.7305,6.9529,9.2705,0.9734,4.558,8.7143,6.5452,16.3629,4.1725,5.2584,8.4046,2.4544,3.1387,2.1272,21.1082,8.473,1.9636,3.3172,1.1454,2.9602,6.7579,29.7508,2.4842,10.6642,6.8546,3.228,1.4727,5.9531,7.6043,5.9353,1.309,40.9371,15.2086,7.1402,1.1454,4.2395,6.9103,9.5571,21.6323,4.0274,2.468,4.2349,10.2196,21.2558,4.5926,7.4254,30.4621,7.8617,4.099,2.2391,2.5252,1.4808,5.2149,4.1419,25.6446,0.9872,1.4808,3.7985,8.5467,1.1517,7.4325,21.6837,8.7273,6.8745,1.8098,5.8802,7.7336,3.0328,27.4974,9.1321,2.4262,3.1844,3.0328,3.8752,1.5164,6.0319,1.8197,2.8306,1.9713,4.6166,3.1676,2.1567,3.1451,2.4262,6.397,2.123,1.3648,0.9098,5.4647,3.1901,1.5164,2.2746,1.0615,6.8743,7.6999,1.4041,7.9193,26.5863,4.3513,2.8936,1.5229,2.2844,1.6752,1.5229,1.8058,3.2961,1.3707,1.2184,2.6815,2.4367,6.1897,2.6652,1.9798,6.516,35.6777,2.8283,1.3707,4.5906,4.7973,0.9138,5.673,3.0677,1.2184,1.3707,1.5229,2.3334,11.5964,5.9549,1.6941,17.9646,5.1752,2.1516,2.033,0.9657,1.3553,10.9053,1.4231,1.4231,3.5898,19.2538,1.8636,15.0894,5.4487,13.2052,4.3125,1.5925,1.9906,0.9657,4.8956,3.171,4.6447,1.1266,6.0238,2.9231,4.9378,2.448,6.5171,21.0323,4.3062,3.2513,6.9506,5.65,10.5705,3.8149,6.2136,1.5173,2.4493,2.2398,1.7485,3.5837,2.7166,6.3292,4.4579,1.2716,12.9777,1.1127,1.5028,3.497,2.3698,3.1646,1.1127,1.4595,1.9219,2.2687,1.1343,3.1068,6.3498,3.4773,33.1292,2.6753,3.8388,3.4773,8.9462,2.2678,4.7393,2.1166,1.7288,2.2875,1.6893,6.823,3.6876,3.4378,14.6058,1.5118,3.589,2.5701,1.5118,3.0631,1.0583,2.9645,0.7559,1.7222,3.99,0.9071,5.5544,7.9142,10.1789,16.6821,1.0635,1.8231,2.5827,1.8231,5.6459,1.8231,1.0635,2.6165,7.3645,1.5192,1.6712,1.2154,1.5192,1.3673,11.1411,6.5179,1.2154,0.7596,14.4341,1.5192,23.9187,2.6502,9.3581,10.19,1.5192,0.9115,16.5431,1.2154,5.3622,12.5118,4.4435,1.0164,1.6297,1.3143,1.3143,3.1017,3.2068,1.4369,9.3313,0.9726,0.6308,7.7679,1.288,0.736,3.1017,1.7874,3.2068,2.4971,0.9463,0.8587,1.6472,1.9276,1.0514,1.4019,1.0689,2.7825,8.5515,3.6299,15.2123,13.9705,1.5876,1.5876,1.9051,1.7463,6.2941,1.4288,4.6612,2.2226,0.9525,4.7515,1.27,0.9525,1.27,40.8235,1.27,0.9525,8.4238,2.2226,0.9525,1.1113,0.9525,3.2134,1.9051,1.27,2.5401,19.5853,0.9525,2.2226,24.5926,12.5547,22.6426,22.733,6.1722,36.2368,65.6871,22.5361,12.3422,6.3608,2.0151,24.6219,11.9933,5.477,34.232,1.9636,19.2309,4.8077,39.6842,16.7803,9.9287,49.3246,25.1204,9.6013,22.3624,15.487,23.991,16.4857,28.1909,2.7413,20.378,10.1666,5.7557,20.3268,59.571,25.5084,15.1366,30.4228,7.4853,13.908,6.1342,35.5584,6.1925,28.0444,61.2349,53.8287,11.391,22.9646,56.0093,18.5764,7.1633,5.6108,32.7789,26.015,5.4696,19.7605,17.1424,8.795,4.2099,2.6543,5.2455,15.8075,5.6921,41.4085,29.3969,84.1927,81.0757,40.1308,42.9503,33.9345,63.6644,8.4428,13.2311,20.2775,16.6397,28.0346,3.4647,15.1072,31.8499,33.7053,4.663,20.8849,13.1264,36.6756,4.6567,55.6712,27.5211,4.2055,33.5458,8.3469,14.3767,17.3822,10.9647,15.859,9.8618,16.2819,6.8953,14.171,19.6039,3.9456,18.2282,15.8216,26.1203,58.9606,23.3207,19.2821,23.5626,49.9967,13.7134,28.0893,19.878,7.449,22.9178,19.9887,7.5113,11.7136,14.9564,12.2395,9.6765,10.8462,28.018,9.1731,13.9419,20.3495,10.414,6.6633,21.7609,49.9343,27.9548,6.6913,85.565,21.562,16.3502,30.2464,18.4052,41.1681,3.1982,60.4833,5.8533,26.4531,13.9521,31.8613,3.4985,21.1074,15.9147,15.5518,87.9841,27.5239,23.9924,17.4245,53.7399,22.6436,10.7457,28.7386,50.9712,14.6665,24.0057,24.2277,39.1471,16.1281,29.8066,9.1492,12.6473,8.9502,6.5724,17.0398,32.1378,5.8297,11.3985,14.436,101.6559,60.6151,34.3881,22.7836,19.4476,25.7439,45.4838,33.7772,30.5499,4.2842,41.2395,14.6606,4.9485,12.2328,11.3177,22.683,26.5557,32.353,48.7381,49.4773,39.428,20.8027,21.37,12.7958,57.068,43.9392,29.6379,45.7835,13.9596,14.3601,9.4422,64.245,9.1605,26.5755,28.4915,6.6399,7.8889,4.3058,31.6958,53.4918,73.8302,52.7892,10.2834,50.7219,17.905,27.005,12.0054,13.0735,26.57,31.3709,16.9506,10.2273,10.9273,14.1628,20.0732,56.986,81.6662,27.1274,31.0556,41.5705,35.0387,30.9788,13.1176,35.606,4.4165,12.7632,8.4739,23.8585,25.0293,18.2625,29.181,6.3463,18.4267,6.845,17.4212,58.2591,58.8364,33.7399,35.1115,21.2586,19.9939,38.1811,7.7745,7.6766,8.7442,10.8762,14.962,18.4098,12.5656,12.6789,18.5763,14.4743,7.8706,13.8436,8.6262,33.3297,51.0872,12.0368,25.2604,21.111,29.3656,42.557,11.3364,15.4544,18.4832,17.6408,33.247,13.574,26.8248,15.0887,9.339,6.346,40.9235,60.4871,45.7281,51.7572,39.4576,22.3992,20.7564,14.5222,24.8104,30.2029,14.0443,12.9845,37.9788,33.3783,33.4592,10.7032,24.1077,16.3957,21.4634,24.7106,15.7849,13.771,30.2845,14.2692,34.3901,63.8066,6.2233,32.563,31.5917,14.8858,15.2275,10.6606,35.6765,22.8401,25.5866,23.8304,22.9815,18.618,18.6668,16.2969,30.3032,24.0802,33.0887,10.2348,29.0324,40.2217,25.5057,15.4782,57.8495,9.2004,43.2463,27.2336,12.6543,10.0208,16.7385,20.5709,30.7592,8.3223,8.3125,56.3982,35.4521,11.7659,25.9647,21.6627,7.2604,17.1814,29.4176,9.3065,20.5125,9.8958,19.8974,30.2056,55.8144,54.517,14.1987,35.8907,20.9325,42.4725,11.2244,24.081,37.0219,20.8002,9.0296,14.1141,7.7917,30.1269,18.6038,6.7358,4.0607,64.7539,34.4698,36.9834,19.0634,18.9136,42.6452,15.2495,18.8877,15.1724,29.436,20.8421,11.1307,27.648,33.9402,17.0674,17.6346,36.1897,15.5082,24.2203,17.5637,7.6664,12.5681,7.7959,9.4684,5.7052,58.0802,23.1123,45.2971,32.6549,57.107,18.5421,31.6653,26.5087,8.3292,9.133,9.7468,27.4424,10.6342,12.7089,15.0613,15.0916,11.8756,9.4655,20.4785,8.2611,48.2771,34.4523,66.5874,17.3065,22.8229,30.3914,27.4129,26.5601,24.5832,21.9793,7.2096,16.3845,12.617,23.2843,32.8022,36.7298,18.2034,4.7657,6.2294,14.189,16.3217,12.5706,9.3449,27.6371,8.1226,11.3077,19.831,19.3429,19.3906,10.7983,48.9245,21.818,37.1725,20.2524,15.1315,18.5024,23.4661,28.9409,17.1462,18.7601,17.4741,23.3909,17.1348,14.4292,17.7376,24.7526,12.1664,12.4297,39.5784,19.4311,21.2345,32.2878,18.3559,23.4811,25.5772,26.337,6.7889,18.6608,24.5699,19.9135,6.7733,16.2235,10.952,18.6013,21.2295,34.6555,27.1488,12.7776,18.9513,26.1537,11.9505,17.3066,13.268,22.8027,21.3369,18.9206,5.7052,46.6765,40.7552,29.2044,20.1719,12.4299,24.8134,17.5142,13.4474,22.5485,19.9402,15.6207,18.0362,43.0902,29.6376,58.2472,21.0647,46.9157,25.6734,32.6412,15.7621,39.1949,23.1688,20.8961,14.1896,17.763,13.6232,14.6332,11.332,19.1436,19.6844,7.0528,14.7011,9.1326,46.4511,43.2142,28.5079,30.0932,34.5286,19.5221,42.8608,27.9116,16.8637,14.1245,20.3584,23.9797,9.4519,14.0339,18.955,9.2147,35.6761,39.0751,20.2355,30.3796,29.7033,28.4727,20.5724,8.0694,19.701,12.3804,6.7564,18.8462,11.7963,11.1082,14.5921,12.3366,29.6961,48.6075,23.6189,49.7295,53.9686,16.8052,15.6087,34.4521,19.5678,13.8941,21.3551,10.3249,7.3792,5.4826,14.873,16.6109,15.4957,19.1587,14.482,41.6509,39.3164,38.2667,26.1342,14.9517,17.5831,8.774,36.4597,26.1793,11.6177,25.43,15.0941,15.9705,14.2911,12.6318,56.6488,39.9222,52.0207,34.2436,31.496,15.4753,22.7444,20.5807,19.018,8.936,13.0932,21.2112,20.3333,25.7374,13.4659,5.2542,16.8428,16.5129,16.019,9.1365,43.4597,20.894,49.6776,43.6384,27.2847,24.0825,19.6347,19.13,22.9859,17.9226,27.5669,25.7404,24.4589,8.2225,21.3507,24.3172,13.2561,26.8933,24.3705,39.2245,35.9884,14.0294,28.4228,26.1746,9.0644,21.8772,17.5814,21.288,12.9616,21.168,17.506,8.8955,38.6852,25.5892,50.699,37.095,35.8644,26.6412,17.9763,19.2445,18.8519,22.5453,17.7219,43.129,40.7504,11.5928,16.9863,18.4556,15.3582,27.0792,9.7148,20.6123,17.1906,16.1417,7.6747,42.5089,40.4922,16.5609,32.3492,31.1362,26.2618,17.9746,22.2236,25.1649,12.5846,10.515,12.8525,20.4045,15.2191,13.1908,54.81,40.2827,44.6023,44.85,30.7494,24.7903,32.495,24.6284,16.0366,15.111,20.8724,18.5422,11.7855,8.1487,17.5722,19.6605,21.4673,49.4891,26.3754,17.2721,28.8301,27.7183,25.6275,26.7635,10.9401,24.4494,20.4822,22.7128,18.1561,9.9487,11.717,37.3996,44.4032,24.5844,27.4435,16.9478,25.8066,21.2116,23.381,19.7061,19.2237,12.6857,16.7145,8.2056,20.6814,14.6647,38.0255,31.3365,30.8425,21.8008,22.3831,29.3403,33.7614,26.2143,22.2802,15.6456,35.3699,18.5844,27.5799,27.8121,15.9322,25.7192,10.0824,11.4883,20.3213,18.7831,12.2183,15.4731,16.3268,51.5988,47.741,25.4102,27.5264,20.607,21.2716,18.3247,16.9216,17.7095,17.6039,17.1355,14.2193,38.9583,45.8511,42.2008,49.3553,18.7875,16.4414,36.1547,21.6058,19.3433,15.1554,19.0355,17.0528,18.5857,31.1225,18.9485,29.37,18.6671,21.8475,10.5813,11.7965,18.8428,12.2091,46.08,40.7198,34.3255,38.4301,20.8429,21.3514,29.1544,25.5577,18.0038,13.8667,17.9878,13.6146,14.5481,36.7366,37.7447,24.4607,21.8003,24.3721,20.8131,35.6334,16.5616,16.3749,16.1019,19.9068,8.6996,13.1954,15.3512,13.5995,46.1442,34.1819,39.766,20.5845,23.4696,15.8056,12.2604,10.2334,15.3579,22.8209,15.564,13.6154,18.4684,42.7732,27.5896,25.6514,26.7211,20.3524,26.5451,18.8565,16.202,18.0938,10.5651,39.793,43.7736,35.8196,29.4958,23.7826,23.0133,25.2004,27.2545,17.4965,25.9886,20.204,17.4799,23.578,15.2193,18.6429,12.5118,14.1772,44.688,33.5412,34.517,33.0501,29.1357,16.6836,15.2133,11.7131,19.2418,15.7714,12.9583,43.9445,24.9592,31.2459,20.0603,15.1491,17.8701,10.4508,13.3554,12.7904,44.7112,43.1707,19.7933,19.4695,17.9365,19.6741,19.4668,17.4683,19.8319,13.3834,47.1719,41.0724,24.1475,26.8532,32.0544,15.6814,18.1569,15.814,11.7425,16.7712,11.9355,25.1532,18.6818,22.6162,17.6045,26.4399,20.0243,16.9789,14.3521,15.5076,14.7778,16.1553,36.2263,46.1801,22.8983,22.9553,21.1699,16.3892,20.7314,19.5797,18.3592,16.2318,16.3375,12.908,27.0323,38.3113,20.8198,22.3049,21.2027,17.0849,20.3244,16.6879,19.2518,17.2793,15.4854,15.5472,13.4556,12.1108,40.6769,40.4746,34.0608,21.5598,18.0619,31.4179,18.7993,16.9437,11.9318,12.1009,34.4049,31.9889,23.5188,15.448,27.4474,19.702,15.5144,17.7286,36.4387,35.4906,33.6037,24.0079,20.048,25.0482,29.2893,15.8873,16.6621,16.1593,19.9316,16.1751,14.6484,35.773,18.9716,18.6537,16.5477,15.0706,12.3669,41.5483,35.7555,22.3691,22.977,28.7958,18.3986,27.8989,11.8029,17.0688,18.1497,13.2806,14.9009,13.7531,12.2397,10.7911,12.2322,15.8561,13.5712,14.1127,32.9815,42.9638,24.9758,27.3413,14.3331,22.0638,12.2536,12.2715,39.3232,38.0536,41.0293,24.06,21.8725,15.4027,18.176,13.4785,16.9187,14.2119,14.1009,12.7571,36.3601,40.4741,27.2402,38.8926,24.1346,22.4747,20.3507,29.4225,15.7074,12.1144,35.3815,33.5534,25.2392,18.8797,17.1564,19.3754,13.5634,12.1144,16.5122,22.7988,18.0921,23.5455,14.9156,17.2406,14.1799,13.1631,20.4528,21.9685,16.1387,15.0507,18.2447,17.9848,15.925,12.0971,12.4961,41.1991,33.1031,33.5607,29.7176,16.9446,18.8084,13.2266,11.8756,37.8784,34.6092,23.7097,22.951,14.4509,18.6185,13.7901,10.6735,17.0293,13.0427,14.3078,13.8103,14.096,38.2928,36.676,32.0743,38.1113,21.947,23.9711,18.6769,26.9273,11.0662,16.226,15.2334,13.5264,35.9858,34.4527,18.5949,20.0169,18.4589,15.3863,19.1006,15.9914,18.7265,14.0501,14.3503,14.7912,12.8923,35.6266,37.8718,24.3832,20.6195,27.4436,15.7269,17.2468,16.5015,13.7308,37.2587,33.852,22.7673,15.4192,23.8516,20.6617,19.2985,14.683,14.6406,35.4225,35.5244,22.3303,18.248,19.5438,25.6735,14.2286,14.336,16.5506,15.8144,14.3036,9.8124,37.3186,30.9698,14.0168,37.7876,23.1009,24.9402,17.1811,14.077,10.9328,38.3799,37.9014,35.9316,21.8474,18.9434,22.5449,13.2474,17.4791,12.51,14.2012,11.4797,12.4792,22.7573,20.012,22.7196,16.9428,25.1719,14.3338,16.4178,11.4176,17.614,11.6306,29.649,19.2328,13.4201,11.4943,37.7991,32.4145,35.9231,14.6755,12.6876,16.6017,11.495,13.7233,36.8474,20.6825,18.8004,15.1272,33.9824,22.0624,16.8193,23.3597,13.8431,17.4392,15.6063,10.7237,12.5945,37.3114,37.2467,16.8244,18.8485,14.5939,12.3638,35.7014,22.1972,18.6274,14.3338,14.6776,12.5682,9.8662,35.8705,35.4519,30.6282,31.082,29.0758,35.9602,21.7686,20.0629,16.3315,17.4981,15.2425,12.6214,16.2508,16.6009,10.5172,19.1003,16.683,13.8848,29.9514,21.6087,23.2764,12.4272,10.5584,12.3471,11.2079,14.2173,22.2902,16.8598,17.1785,16.1517,13.9649,14.1697,12.4274,11.4078,36.1786,22.4255,16.5339,15.4036,10.7745,13.2911,37.499,12.0022,10.4647,15.5987,9.8066,35.3935,21.9449,16.4564,13.4588,12.134,12.1997,17.1881,15.9757,13.2597,10.7706,14.2817,35.8354,34.4848,11.7168,13.443,19.7044,21.8971,14.6094,15.57,33.5972,20.7733,15.7796,11.3582,9.7789,33.4763,21.6058,16.357,10.6463,20.3425,21.7432,13.3525,15.3797,33.2582,33.3841,19.555,21.6115,21.8915,13.2736,16.3979,16.5015,13.8274,13.0571],\"Total\":[684,601,514,488,502,408,328,458,652,513,584,481,465,404,394,612,461,502,501,458,449,482,511,436,491,457,226,416,581,474,32.1848,54.0221,35.5242,237.9226,339.1931,11.8509,10.4614,30.1091,28.972,37.2548,24.0362,19.7715,40.4055,330.792,17.3295,29.5751,20.5736,18.1359,13.944,45.8867,28.8401,17.7773,22.4533,32.6914,42.9741,31.2575,27.1918,98.2912,21.8395,52.2792,17.2859,52.8385,83.5795,35.9475,16.3255,87.385,30.5075,18.819,20.4275,208.6944,43.3443,66.4962,28.3249,19.0951,684.8828,123.4639,33.1135,33.566,36.4058,28.563,28.3266,103.2505,50.8683,136.5018,36.6614,42.7131,34.3093,30.5173,129.3757,12.2069,22.8763,28.4054,46.73,39.7545,37.8574,95.969,34.0472,380.1473,31.9793,229.4013,18.7955,17.8806,107.045,14.6531,19.22,14.3418,26.7814,23.3862,53.0789,15.0421,38.1933,96.543,17.9022,14.6352,86.884,42.7131,28.3778,15.3914,14.2833,37.2693,53.7432,137.6054,251.2164,213.6129,221.2653,37.8932,28.6677,47.9476,25.2688,56.8359,56.1352,46.7927,19.8231,47.7089,24.0262,23.5758,21.4529,52.0917,34.0955,73.6042,24.703,40.5876,56.8245,51.3406,112.8613,30.0974,17.9343,23.216,58.5314,32.9567,50.3353,42.0413,40.5876,135.9856,294.3145,731.6242,282.1449,410.8308,71.0469,620.9109,41.566,634.3764,19.1602,249.3673,154.5144,21.1007,66.2417,221.2653,34.0955,142.5565,164.5671,214.4706,321.0272,18.4999,112.8613,151.4054,17.1042,73.6042,178.3473,355.1719,15.7622,36.9039,41.7418,16.4034,50.5918,24.5346,11.6075,16.0495,22.7018,32.7388,27.4386,15.3574,13.3329,78.1791,11.6941,22.437,15.7759,27.0223,229.333,39.775,268.2921,11.7886,301.8381,61.2957,33.9903,13.9768,9.1649,53.1411,131.1196,62.6919,25.7996,25.0776,56.6707,72.0061,18.505,20.6294,99.794,444.5456,29.2685,211.2636,94.6294,29.1044,23.9086,46.1682,174.9304,34.3933,58.4937,59.2927,35.562,59.2255,33.8911,158.6046,27.303,237.7098,31.722,142.7331,134.8948,62.3737,137.197,14.0566,34.0955,35.1211,28.6677,45.3827,34.0584,60.4925,19.1602,23.2577,42.2653,37.8932,53.7432,26.2901,25.2688,40.5876,29.9886,56.8359,103.0307,25.1399,52.7587,496.4149,19.7848,19.671,60.2453,112.8613,71.0469,56.8245,44.5162,50.3353,24.703,23.216,54.8184,56.8359,17.4594,634.3764,174.0279,71.0469,164.5671,105.9112,26.619,355.1719,356.8571,42.0413,21.1007,28.6677,41.566,40.4055,23.2577,65.4111,112.8613,612.3117,51.0548,42.2653,390.6068,103.0307,213.6129,41.2959,24.703,46.7927,20.1297,44.5162,37.8932,401.0297,103.0307,390.6068,58.5314,21.1479,26.8672,56.8359,28.6677,60.4925,34.0955,53.7432,11.6867,10.7891,93.8129,23.2577,355.1719,47.9476,86.8825,25.4426,22.0293,56.8245,22.6361,19.7848,221.2653,19.1782,46.7927,34.0584,17.55,16.4732,81.8365,169.0635,525.6742,35.1211,15.5313,41.1864,17.6117,24.0362,24.2772,36.9032,214.4706,71.0469,45.3827,49.3588,21.9659,61.9068,15.8861,41.5206,112.377,30.5875,21.118,114.3348,29.5751,21.556,21.6244,14.971,26.6617,86.316,55.9479,26.9383,23.966,147.1927,123.0757,15.9967,9.1946,20.1348,14.6352,48.6674,28.3778,15.3917,31.3801,37.8574,69.8832,18.6261,39.2791,12.1463,14.3384,32.3124,15.9084,18.1684,19.2502,18.2894,18.6289,190.1376,32.0903,96.543,72.3123,32.6496,76.1565,34.0472,112.377,114.3348,410.8308,26.5012,81.8365,73.6042,40.5876,25.1399,17.6117,17.8376,38.8229,34.7823,52.3497,36.9032,26.6617,24.1651,294.3145,30.6626,30.7431,41.5206,49.3588,270.9022,269.0956,36.0728,50.3353,17.4048,154.5144,86.316,27.2232,11.2984,36.4058,58.3605,103.2505,141.2055,51.296,51.0139,101.3838,53.3957,116.8861,62.4007,40.1742,129.3757,78.5915,38.8402,76.0332,35.7448,83.5795,33.655,317.8374,45.2031,34.3093,42.6859,66.4962,50.8683,601.8783,684.8828,52.8385,8.1939,16.748,62.2393,17.7957,28.3283,21.9725,8.6249,55.2558,8.3475,17.0375,20.3368,82.9726,51.6259,368.334,16.5996,7.5314,90.6229,20.0845,18.9901,7.5026,10.2705,17.5962,20.0775,22.3319,8.7101,20.5124,139.2485,12.6863,26.6881,17.7676,15.1225,17.31,18.501,19.1126,28.3213,10.9326,9.3303,15.1843,5.4002,7.5026,14.0935,9.5369,10.3746,21.3539,17.302,13.2343,29.5209,19.4666,16.8279,12.5425,14.5334,11.3576,16.3767,51.2264,8.3475,133.1277,33.2568,81.0122,514.0896,22.3786,36.5004,18.5768,15.8165,21.3548,15.6761,47.6479,60.5966,18.5768,23.4816,16.8279,23.3169,36.4876,16.8263,10.9438,13.6984,14.3695,19.3026,60.55,18.8648,9.363,75.6449,70.5466,133.1277,172.4899,17.3093,15.8165,10.3996,17.4166,72.1556,16.9718,48.2547,17.3792,36.7684,9.4136,15.1225,20.0775,7.4979,48.6028,12.4636,84.1064,45.7014,11.1707,42.0716,36.1558,15.3574,40.7036,15.9838,16.3018,8.7101,6.9086,9.8128,458.7422,35.3946,20.7804,26.3051,26.8473,12.3801,15.9967,11.7886,9.1649,90.3551,10.4327,12.1249,18.1694,270.9022,29.5751,269.0956,24.0362,18.8008,26.8672,22.6361,16.5451,30.1091,21.9659,35.5242,20.6419,24.1651,21.118,17.6098,21.1479,54.8184,61.9068,17.987,34.4088,81.8365,40.4055,112.377,114.3348,14.8321,22.3014,37.2548,41.1864,29.9609,51.296,116.8861,62.4007,53.3957,76.0332,33.655,36.4058,103.2505,317.8374,58.3605,15.6949,78.5915,80.4625,129.3757,50.8683,31.2598,51.0139,34.3093,36.6614,19.3136,46.73,66.4962,18.1603,23.0706,49.2233,40.1742,22.9007,60.052,38.8402,65.1525,16.0436,195.4672,10.5257,26.9539,18.6332,42.8066,47.7649,9.1946,14.6352,116.1394,16.372,25.1385,15.9084,12.3635,23.6048,25.1988,15.2455,55.424,15.7654,18.6261,68.9668,30.6836,15.669,96.543,33.2533,20.8156,14.7129,21.5161,12.2069,183.6602,26.5519,10.2705,17.3267,18.58,46.1682,16.5996,14.0566,27.303,15.4303,16.7945,12.4284,24.7626,16.9764,29.2685,91.1349,488.004,25.7996,16.3767,17.31,25.0776,59.2927,35.153,36.4188,99.794,17.0375,18.505,8.7101,15.4186,29.1153,26.5274,52.2792,30.1091,51.3225,24.0362,101.4233,61.9068,289.8671,122.797,29.5751,19.7715,195.248,10.7891,55.9479,98.2912,18.1359,119.1894,149.9254,75.2969,21.9659,284.0689,48.7948,18.7118,125.6462,29.1288,416.2106,216.6529,20.6419,45.666,31.2575,37.2548,78.5915,50.8683,14.8138,15.951,14.6531,15.2899,66.4962,33.655,22.9007,65.1525,36.6614,129.3757,16.4687,43.3443,15.6949,103.2505,51.296,19.0951,19.3136,36.4058,24.1405,14.3418,14.3695,18.7955,58.3605,20.4816,17.7662,62.2393,15.0725,18.1603,80.9557,34.4088,17.1042,268.1103,40.9142,119.1894,83.5477,192.7434,44.8826,205.4085,55.3298,28.6152,414.6298,26.3534,13.9757,410.8308,26.619,249.8706,86.7007,48.3424,19.854,125.3526,58.3918,19.4164,154.5144,152.1554,731.6242,40.5455,111.4022,465.4412,24.6683,24.6683,70.0217,176.8273,78.7414,32.6496,34.0472,21.1895,83.37,73.7563,42.8066,26.7814,264.3787,83.6025,99.4764,36.57,67.9421,188.3158,18.2894,67.909,90.5107,49.3166,53.0789,96.543,20.9623,84.6154,113.1764,11.9648,56.0429,107.6382,25.2267,80.7933,21.1895,28.563,49.3166,16.3255,26.0795,18.6261,188.3158,78.7414,18.6332,34.0472,12.0022,32.3077,74.0123,328.6039,28.3778,121.8563,78.3741,37.8574,17.2859,70.0217,90.5107,72.3123,16.0436,502.7195,188.861,88.9742,14.3384,53.0789,15.669,26.9539,68.9668,15.2455,10.467,21.5161,55.424,116.1394,26.2952,42.8066,183.6602,47.7649,25.1385,14.7129,16.8466,10.5257,38.1383,30.6836,193.1655,7.4979,11.6867,30.0085,68.011,9.7209,66.9155,195.4672,78.7414,62.9996,16.7394,54.6236,34.3933,19.13,174.9304,59.2255,18.505,25.7996,25.0776,35.153,14.0566,56.6707,18.58,29.2685,20.6294,48.7359,33.8911,23.9086,35.2864,27.303,72.0061,23.9359,15.4186,10.3746,62.3737,36.4188,17.6075,26.5519,12.4284,83.7947,94.6294,17.3267,30.0713,158.6046,33.9804,26.5519,14.0566,21.1007,15.8825,14.5563,17.3267,33.5306,14.8298,13.3029,29.5209,27.303,72.0061,32.4609,24.2806,80.4228,444.5456,35.2864,17.6075,59.3805,62.3737,12.1068,75.3641,41.0026,16.3767,18.505,20.6294,31.722,47.1732,24.3324,15.6761,195.4672,57.7766,26.0795,25.2267,12.0022,17.0402,137.8007,18.0105,18.6746,47.6479,255.9917,25.1988,207.1118,75.6449,183.6602,60.55,23.3168,29.4899,14.3384,73.5441,47.7649,70.5466,17.302,92.5655,45.5988,78.7414,39.7545,18.501,62.6919,16.738,13.2504,33.2455,29.4021,59.3407,23.8267,41.0946,11.1707,18.0943,17.5962,14.0997,29.5244,23.2804,57.423,41.7418,12.0581,131.1196,11.2576,15.2533,36.1558,24.7715,33.858,12.1249,16.3018,21.8136,26.3051,13.3329,36.9039,27.303,20.6294,211.2636,17.6075,27.9694,26.5519,72.0061,19.13,41.3068,18.505,15.4186,20.7026,15.4303,62.3737,33.8911,31.722,134.8948,14.0566,33.5306,24.2806,14.5563,29.5209,10.3746,29.2685,7.5026,17.31,41.0026,9.363,58.4937,83.7947,41.0026,80.7163,5.4002,9.3303,14.0935,14.5563,51.2264,19.13,11.3576,29.5209,83.7947,17.3093,19.1126,14.0566,17.6075,15.8865,133.1277,81.0122,15.1843,9.5369,181.8648,19.4666,307.5393,34.0966,121.6699,134.8948,20.335,12.4284,226.6057,16.8279,22.5688,53.7274,59.0295,13.7983,22.437,18.1581,18.6081,45.5084,47.1732,21.1895,144.2603,15.0725,9.8836,121.8563,20.5742,11.7886,50.8683,29.4167,52.8385,41.3313,16.1254,14.8892,28.563,33.566,18.819,25.2267,19.4666,50.776,159.0394,67.9421,66.9463,62.2393,14.3418,14.6531,21.6326,19.9755,79.4323,18.2758,60.1681,29.8484,12.9244,65.1525,18.1603,13.9808,18.6746,601.8783,18.819,14.2968,129.3757,34.3093,14.7796,17.4166,15.0725,51.1713,30.5075,20.4816,41.0068,317.8374,15.5667,36.4058,119.8374,86.8825,213.6129,110.8492,55.3298,401.0297,731.6242,249.3673,86.0299,53.1411,16.738,339.1931,116.8861,53.3957,634.3764,24.6683,237.7098,78.3642,481.0311,237.7098,61.9068,355.1719,238.9583,86.8825,249.8706,151.4054,270.9022,178.0086,188.7793,33.8496,177.5695,100.7123,56.6707,285.3128,601.8783,477.9163,281.3333,387.2027,96.543,229.4013,73.5441,514.0896,103.2505,269.0956,307.5393,620.9109,112.8613,269.0956,620.9109,161.5622,72.0061,77.0939,620.9109,491.05,68.4705,262.1825,226.6057,124.7071,58.4937,36.4188,56.6707,305.3385,95.969,183.6602,129.4146,634.3764,620.9109,390.6068,496.4149,410.8308,731.6242,66.9463,79.1567,211.2636,237.9226,531.9889,48.2011,252.226,408.1417,684.8828,78.5915,135.9856,93.8129,356.8571,42.0413,620.9109,230.285,37.2213,501.148,83.5795,270.9022,229.4013,144.047,211.2636,162.3158,204.5906,75.3641,211.2636,400.2138,66.4962,119.1894,68.9209,251.2164,620.9109,268.1103,221.2653,294.3145,387.2027,83.7947,274.1941,190.1376,75.3641,342.2678,296.3455,76.0332,220.529,198.0999,162.3158,142.7331,183.341,368.334,113.8906,158.6046,237.7098,208.6944,116.8861,145.1981,390.6068,270.9022,29.5244,466.4968,251.2164,174.0279,390.6068,137.7156,491.05,40.5455,601.8783,58.4937,525.6742,185.0497,466.4968,65.5105,404.6056,78.5915,67.909,731.6242,268.1103,121.6699,174.0279,634.3764,289.8671,130.7724,229.4013,634.3764,164.5671,282.1449,208.6944,307.5393,101.4233,309.6153,94.6294,134.8948,127.6761,66.9463,339.1931,457.094,75.3641,174.9304,96.9994,601.8783,496.4149,268.2921,270.9022,213.6129,294.3145,634.3764,233.8861,491.05,42.5526,501.148,237.7098,80.7933,142.7331,235.0768,505.6858,601.8783,153.4859,401.0297,410.8308,401.0297,214.4706,221.2653,138.0673,731.6242,620.9109,401.0297,393.174,107.045,145.798,135.9856,684.8828,86.0299,380.1473,444.5456,111.8106,124.7071,82.4703,684.8828,429.6507,387.2027,452.8021,116.3551,731.6242,214.4706,238.539,121.6699,98.0682,434.289,523.5778,195.248,142.7331,195.248,311.4077,461.1088,612.3117,488.004,294.3145,410.8308,525.6742,495.8811,401.0297,137.197,620.9109,58.5314,127.6761,92.1585,496.4149,387.2027,261.5957,394.907,98.0682,394.1144,42.8491,78.7414,531.9889,731.6242,390.6068,410.8308,251.2164,249.3673,525.6742,46.5735,66.9463,83.37,161.9376,296.7655,274.1941,181.8648,211.2636,274.1941,181.8648,164.5823,315.5864,55.9479,282.1449,634.3764,142.5565,356.8571,183.6602,390.6068,404.6056,117.2622,121.6699,126.6018,294.3145,387.2027,158.6046,457.2253,301.8381,158.6046,129.3757,342.2678,542.2306,496.4149,327.1185,226.6483,294.3145,269.0956,164.5671,355.1719,288.1936,169.0635,137.6176,731.6242,634.3764,393.174,121.6699,317.8374,200.0839,394.907,466.4968,229.333,174.9304,444.5456,337.5934,289.8671,612.3117,27.7162,401.0297,410.8308,164.5823,170.8056,169.0635,652.428,495.8811,408.1417,385.0458,394.907,307.5393,393.174,380.1473,249.8706,137.7119,176.8273,50.201,355.1719,612.3117,355.1719,122.645,514.0896,83.5795,684.8828,612.3117,176.9899,164.5823,307.5393,327.1185,466.4968,142.7331,179.0857,531.9889,531.9889,154.5144,250.3977,410.8308,80.4625,262.2855,502.7048,107.045,458.7422,226.6057,513.055,253.5457,394.1144,525.6742,151.4054,496.4149,193.1655,436.535,113.1764,542.2306,684.8828,339.506,134.8948,296.3455,143.8763,488.004,394.907,140.6216,76.0332,652.428,299.1607,328.9557,105.9232,92.5655,480.7628,82.4703,98.0682,164.5671,496.4149,181.8648,83.7947,226.6483,482.3718,204.5906,339.1931,502.7195,252.226,458.5222,396.1836,101.1522,169.2437,94.6294,172.4899,117.7195,584.3208,183.341,525.6742,214.1371,394.907,213.6129,477.9163,356.8571,103.0307,100.7123,164.5671,612.3117,101.3838,137.8007,229.4013,328.6039,175.1626,121.6699,458.5222,188.3158,492.7008,321.0272,502.4879,214.4706,339.1931,496.4149,466.4968,465.4412,488.004,488.004,126.6018,459.2069,328.6039,123.0757,301.8381,525.6742,282.1449,44.21,59.3407,268.1103,193.1655,174.9304,117.7195,449.1176,121.6699,233.8861,343.1612,307.5393,457.5059,269.6786,501.148,133.6758,356.8571,251.2164,184.794,177.5695,356.8571,466.4968,221.48,390.6068,356.8571,525.6742,296.7655,208.6944,288.1936,457.094,317.8374,328.6039,612.3117,238.9583,269.0956,525.6742,238.9583,360.8283,226.6057,393.174,62.9996,307.5393,444.5456,449.1176,98.0682,380.1473,226.6057,444.5456,533.0145,324.0013,159.0394,67.5126,100.7123,356.8571,166.8905,242.4704,117.2622,531.9889,491.05,338.8922,119.8374,491.05,317.8374,181.8648,282.1449,178.0086,274.1941,229.333,269.0956,359.6646,501.9313,268.2921,581.6331,444.784,188.3158,482.3718,176.9697,408.1417,176.9697,531.9889,249.3673,513.055,394.907,305.3385,289.8671,401.0297,165.812,237.7098,161.5622,339.506,354.1774,121.6699,233.8861,174.9304,502.7195,480.7628,301.8381,612.3117,454.3188,289.8671,584.3208,404.6056,229.4013,226.6483,480.7628,474.6426,183.2977,224.0018,488.004,239.69,288.1936,321.0272,270.9022,492.7008,385.0458,495.8811,337.5934,102.7826,380.1473,162.8141,99.794,511.7358,188.861,164.5823,457.2253,361.7011,269.0956,457.094,137.8007,459.2069,458.5222,161.5622,355.1719,584.3208,359.8657,282.1449,430.9907,127.6761,134.8948,88.0938,366.7532,430.9907,282.1449,505.6858,457.5059,444.3922,337.5934,328.6039,531.9889,220.3582,189.095,69.5115,394.907,457.2253,139.9056,449.1176,262.2855,408.1417,252.226,383.3039,511.7358,495.8811,502.7048,274.1941,457.094,161.5622,203.741,327.1185,496.4149,83.8095,219.5931,436.535,392.6173,577.3229,286.016,83.7947,449.1176,436.1373,302.5225,238.539,408.1417,183.0599,481.0311,360.8283,480.7628,479.9333,352.2525,226.6057,207.1118,477.9163,457.2253,482.3718,454.3188,110.8492,429.6507,652.428,226.6483,235.7208,147.1927,494.1985,302.5225,166.8905,495.8811,436.535,126.6183,465.4412,288.1936,387.2027,309.2312,482.3718,652.428,236.1938,414.6298,188.3158,458.7422,444.3922,269.2435,452.8021,245.7882,269.0956,339.1931,299.245,207.1118,584.3208,542.2306,249.8706,230.285,394.907,265.2912,652.428,219.5931,634.8025,634.8025,584.3208,190.1376,481.0311,531.7109,220.4918,612.3117,461.1088,611.5819,495.8811,361.7011,523.5778,224.0018,169.2437,230.285,457.094,283.5276,444.2282,634.8025,387.2027,461.1088,385.0458,339.1931,531.7109,483.7567,602.2734,184.8074,261.5957,393.174,502.4879,302.8429,169.2437,502.7195,444.3922,502.4879,457.094,172.4899,236.1938,402.4731,512.9217,338.8922,511.7358,181.8648,584.3208,513.055,513.055,499.9801,289.266,379.7005,477.9163,652.428,181.2686,491.05,296.7655,269.2435,408.1417,500.8457,502.4879,483.7567,208.6944,561.6223,172.4899,514.0896,519.4207,419.6152,359.6646,268.1103,339.1931,477.9163,454.28,577.3229,513.055,502.7048,466.4968,289.266,268.1103,531.9889,523.5778,165.812,361.7011,94.6294,249.3673,533.0145,408.1417,269.2435,505.6858,501.9313,731.6242,499.9801,383.3039,531.7109,444.3922,380.1473,383.4531,330.792,404.6056,514.0896,611.5819,553.2047,380.1473,454.3188,483.7567,533.0145,270.9022,314.157,501.9313,483.7567,501.9313,328.9557,402.4731,501.9313,458.5222,282.1449,281.3333,502.7048,286.016,519.4207,137.7156,330.2972,479.9333,436.535,602.2734,436.535,274.1941,531.9889,140.8811,339.1931,602.2734,394.1144,584.3208,283.5276,383.4978,360.8283,385.0458,361.7011,531.7109,444.784,491.05,444.784,360.8283,513.055,328.6039,394.1144,368.334,461.1088,158.6046,416.5547,511.7358,479.9333,612.3117,288.1936,482.3718,492.7008,458.5222,219.5931,134.8948,131.1196,360.8283,577.3229,296.7655,342.2678,495.9206,502.7195,299.1607,495.8811,531.9889,501.9313,611.5819,652.428,481.0311,502.7195,172.4899,477.9163,483.7567,414.6298,219.5931,444.784,584.3208,477.9163,457.2253,396.1836,296.3455,502.7048,294.3678,634.8025,479.9333,533.0145,425.3961,611.5819,577.3229,444.784,452.8021,359.6646,373.9508,523.5778,492.7008,289.266,684.8828,554.1082,512.9217,500.8457,581.6331,434.289,479.9333,295.8738,444.2282,283.5276,488.004,500.8457,634.3764,514.0896,256.4079,499.9801,296.9405,394.1144,465.4412,495.9206,519.4207,279.4587,652.428,611.5819,452.8021,502.7195,652.428,480.7628,402.4731,511.7358,190.1376,458.7422,457.094,531.7109,268.2921,492.7008,291.9352,342.2678,483.7567,427.9678,475.0722,454.28,360.8283,611.5819,492.7008,611.5819,432.2873,425.3961,577.3229,458.5222,577.3229,584.3208,459.2069,392.6173,634.8025,480.7628,188.861,602.2734,523.5778,339.506,474.6426,425.3961,495.9206,584.3208,457.5059,402.4731,454.3188,601.8783,502.7195,481.0311,519.4207,513.055,328.6039,385.0458,432.2873,512.9217,457.094,514.0896,416.2106,430.9907,339.506,400.2138,477.9163,268.1103,652.428,531.7109,501.148,561.6223,404.6056,561.6223,491.05,512.9217,512.9217,461.1088,581.6331,531.7109,328.6039,499.9801,502.7195,499.9801,581.6331,383.3039,461.1088,500.8457,465.4412,393.174,561.6223,581.6331,386.2019,432.2873,380.1473,611.5819,465.4412,414.6298,141.2055,416.2106,454.28,408.1417,553.2047,457.2253,372.2005,352.2525,242.4704,501.9313,495.9206,581.6331,480.7628,602.2734,475.0722,553.2047,238.539,684.8828,495.9206,386.2019,533.0145,465.4412,542.2306,531.7109,334.7643,367.9017,457.094,444.2282,512.9217,581.6331,356.8571,457.094,416.2106,553.2047,296.4442,474.6426,554.1082,337.5934,466.4968,531.7109,354.1774,337.5934,519.4207,519.4207,475.6688,394.907,400.2138,500.8457,542.2306,514.0896,611.5819,492.7008,474.6426,302.8429,634.8025,454.3188,328.6039,301.8381,359.6646,328.6039,427.9678,494.1985,581.6331,430.9907,482.3718,533.0145,416.5547,620.9109,334.7643,554.1082,389.867,461.1088,634.8025,533.0145,584.3208,502.7048,495.8811,523.5778,531.7109,459.2069,634.8025,416.5547,238.539,483.7567,267.4904,372.2005,387.2027,634.8025,495.8811,457.5059,505.6858,475.0722,429.6507,495.9206,542.2306,474.6426,269.6786,577.3229,554.1082,561.6223,449.1176,652.428,444.784,499.9801,379.7005,602.2734,581.6331,392.6173,512.9217,354.1774,444.2282,465.4412,502.7048,554.1082,495.9206,554.1082,305.3385,531.9889,502.7195,465.4412,330.6051,611.5819,494.1985,634.3764,523.5778,505.6858,542.2306,429.6507,634.8025,425.3961,468.9321,461.1088,427.9678,480.7628,514.0896,501.9313,475.6688,392.6173,611.5819,414.6298,401.0297,474.6426,356.6097,577.3229,444.784,394.1144,581.6331,511.7358,436.1373,511.7358,434.289,602.2734,525.6742,581.6331,494.1985,452.8021,501.148,449.1176,296.4442,531.7109,581.6331,396.1836,475.0722,454.28,495.8811,652.428,477.9163,488.004,511.7358,432.2873,475.0722,380.1473,454.3188,427.9678,452.8021,501.148,602.2734,502.4879,684.8828,602.2734,501.9313,501.148,475.0722,531.7109,513.055,513.055,512.9217,477.9163,457.5059,334.7643,416.2106,523.5778,480.7628,479.9333,372.2005,553.2047,419.6152,361.7011,495.9206,492.7008,561.6223,513.055,533.0145,652.428,474.6426,601.8783,482.3718,602.2734,519.4207,512.9217,511.7358,408.1417,483.7567,502.7195,512.9217,577.3229,458.7422,634.8025,419.7113,444.3922,425.3961,611.5819,383.3039,505.6858,553.2047,523.5778,652.428,553.2047,502.4879,502.7195,612.3117,494.1985,602.2734,561.6223,475.6688,457.2253,577.3229,505.6858,561.6223,581.6331,349.3299,457.5059,533.0145,494.1985,267.4904,502.4879,634.8025,602.2734,652.428,390.6068,458.5222,553.2047,611.5819,479.9333,602.2734,468.9321,494.1985,444.2282,480.7628,542.2306,542.2306,434.289,479.9333,561.6223,501.9313,349.3299,479.9333,652.428,553.2047,457.5059,554.1082,561.6223,432.2873,500.8457,542.2306,652.428,652.428,602.2734,602.2734,474.6426,499.9801,402.4731,458.7422,444.2282,634.8025,356.6097,577.3229,457.094,554.1082,393.174,542.2306,505.6858,523.5778,495.8811,468.9321,531.9889,419.7113,519.4207,495.9206],\"Category\":[\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Default\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic3\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic4\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic5\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic6\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic7\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic10\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic11\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic12\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic14\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic15\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic17\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic18\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic20\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic21\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic22\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic23\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic25\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic26\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic27\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic28\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic29\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic31\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic32\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic33\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic34\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic36\",\"Topic2\",\"Topic4\",\"Topic5\",\"Topic7\",\"Topic8\",\"Topic9\",\"Topic9\",\"Topic9\",\"Topic12\",\"Topic18\",\"Topic18\",\"Topic23\",\"Topic24\",\"Topic24\",\"Topic25\",\"Topic27\",\"Topic29\",\"Topic31\",\"Topic32\",\"Topic34\",\"Topic1\",\"Topic4\",\"Topic5\",\"Topic8\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic13\",\"Topic16\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic22\",\"Topic23\",\"Topic24\",\"Topic25\",\"Topic25\",\"Topic26\",\"Topic27\",\"Topic31\",\"Topic32\",\"Topic34\",\"Topic36\",\"Topic5\",\"Topic7\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic13\",\"Topic20\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic25\",\"Topic26\",\"Topic27\",\"Topic27\",\"Topic30\",\"Topic30\",\"Topic30\",\"Topic33\",\"Topic35\",\"Topic36\",\"Topic3\",\"Topic3\",\"Topic4\",\"Topic4\",\"Topic5\",\"Topic9\",\"Topic11\",\"Topic13\",\"Topic14\",\"Topic17\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic30\",\"Topic31\",\"Topic32\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic4\",\"Topic5\",\"Topic8\",\"Topic10\",\"Topic14\",\"Topic15\",\"Topic23\",\"Topic24\",\"Topic25\",\"Topic26\",\"Topic27\",\"Topic29\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic3\",\"Topic5\",\"Topic8\",\"Topic9\",\"Topic9\",\"Topic11\",\"Topic12\",\"Topic17\",\"Topic18\",\"Topic21\",\"Topic22\",\"Topic23\",\"Topic23\",\"Topic24\",\"Topic25\",\"Topic26\",\"Topic27\",\"Topic30\",\"Topic31\",\"Topic32\",\"Topic32\",\"Topic33\",\"Topic33\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic4\",\"Topic5\",\"Topic6\",\"Topic7\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic12\",\"Topic13\",\"Topic19\",\"Topic20\",\"Topic22\",\"Topic25\",\"Topic26\",\"Topic29\",\"Topic35\",\"Topic36\",\"Topic2\",\"Topic3\",\"Topic4\",\"Topic5\",\"Topic7\",\"Topic8\",\"Topic10\",\"Topic11\",\"Topic11\",\"Topic12\",\"Topic13\",\"Topic13\",\"Topic13\",\"Topic14\",\"Topic16\",\"Topic17\",\"Topic18\",\"Topic22\",\"Topic22\",\"Topic23\",\"Topic24\",\"Topic25\",\"Topic26\",\"Topic29\",\"Topic30\",\"Topic1\",\"Topic2\",\"Topic4\",\"Topic4\",\"Topic9\",\"Topic10\",\"Topic10\",\"Topic11\",\"Topic17\",\"Topic23\",\"Topic24\",\"Topic28\",\"Topic30\",\"Topic31\",\"Topic33\",\"Topic35\",\"Topic35\",\"Topic35\",\"Topic3\",\"Topic4\",\"Topic4\",\"Topic5\",\"Topic8\",\"Topic8\",\"Topic10\",\"Topic10\",\"Topic11\",\"Topic11\",\"Topic12\",\"Topic12\",\"Topic18\",\"Topic19\",\"Topic20\",\"Topic21\",\"Topic26\",\"Topic29\",\"Topic31\",\"Topic34\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic3\",\"Topic4\",\"Topic9\",\"Topic11\",\"Topic13\",\"Topic14\",\"Topic15\",\"Topic16\",\"Topic23\",\"Topic23\",\"Topic28\",\"Topic29\",\"Topic31\",\"Topic35\",\"Topic35\",\"Topic5\",\"Topic7\",\"Topic8\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic13\",\"Topic15\",\"Topic19\",\"Topic19\",\"Topic21\",\"Topic24\",\"Topic25\",\"Topic27\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic36\",\"Topic1\",\"Topic3\",\"Topic4\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic10\",\"Topic13\",\"Topic13\",\"Topic17\",\"Topic20\",\"Topic21\",\"Topic23\",\"Topic25\",\"Topic27\",\"Topic29\",\"Topic30\",\"Topic32\",\"Topic33\",\"Topic35\",\"Topic35\",\"Topic1\",\"Topic4\",\"Topic8\",\"Topic9\",\"Topic11\",\"Topic12\",\"Topic13\",\"Topic14\",\"Topic15\",\"Topic16\",\"Topic17\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic34\",\"Topic35\",\"Topic1\",\"Topic1\",\"Topic5\",\"Topic6\",\"Topic7\",\"Topic9\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic12\",\"Topic13\",\"Topic18\",\"Topic19\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic24\",\"Topic28\",\"Topic30\",\"Topic30\",\"Topic32\",\"Topic33\",\"Topic33\",\"Topic35\",\"Topic1\",\"Topic4\",\"Topic6\",\"Topic8\",\"Topic10\",\"Topic15\",\"Topic18\",\"Topic19\",\"Topic23\",\"Topic25\",\"Topic26\",\"Topic27\",\"Topic29\",\"Topic29\",\"Topic31\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic6\",\"Topic8\",\"Topic13\",\"Topic13\",\"Topic16\",\"Topic17\",\"Topic20\",\"Topic24\",\"Topic25\",\"Topic26\",\"Topic30\",\"Topic30\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic36\",\"Topic1\",\"Topic9\",\"Topic11\",\"Topic12\",\"Topic19\",\"Topic24\",\"Topic26\",\"Topic27\",\"Topic28\",\"Topic31\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic4\",\"Topic8\",\"Topic10\",\"Topic12\",\"Topic14\",\"Topic21\",\"Topic25\",\"Topic27\",\"Topic27\",\"Topic29\",\"Topic31\",\"Topic31\",\"Topic33\",\"Topic34\",\"Topic36\",\"Topic36\",\"Topic1\",\"Topic1\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic5\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic11\",\"Topic16\",\"Topic16\",\"Topic17\",\"Topic18\",\"Topic18\",\"Topic19\",\"Topic21\",\"Topic23\",\"Topic29\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic33\",\"Topic34\",\"Topic35\",\"Topic1\",\"Topic1\",\"Topic5\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic15\",\"Topic19\",\"Topic19\",\"Topic20\",\"Topic21\",\"Topic27\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic35\",\"Topic4\",\"Topic4\",\"Topic7\",\"Topic10\",\"Topic13\",\"Topic13\",\"Topic22\",\"Topic26\",\"Topic29\",\"Topic30\",\"Topic34\",\"Topic35\",\"Topic35\",\"Topic3\",\"Topic4\",\"Topic8\",\"Topic11\",\"Topic15\",\"Topic18\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic24\",\"Topic28\",\"Topic29\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic4\",\"Topic8\",\"Topic10\",\"Topic12\",\"Topic13\",\"Topic15\",\"Topic18\",\"Topic19\",\"Topic19\",\"Topic19\",\"Topic23\",\"Topic24\",\"Topic26\",\"Topic27\",\"Topic35\",\"Topic36\",\"Topic8\",\"Topic8\",\"Topic8\",\"Topic9\",\"Topic10\",\"Topic15\",\"Topic17\",\"Topic18\",\"Topic21\",\"Topic22\",\"Topic22\",\"Topic25\",\"Topic29\",\"Topic31\",\"Topic31\",\"Topic34\",\"Topic34\",\"Topic1\",\"Topic3\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic11\",\"Topic13\",\"Topic16\",\"Topic19\",\"Topic19\",\"Topic23\",\"Topic35\",\"Topic1\",\"Topic2\",\"Topic7\",\"Topic9\",\"Topic11\",\"Topic12\",\"Topic18\",\"Topic25\",\"Topic28\",\"Topic30\",\"Topic32\",\"Topic36\",\"Topic1\",\"Topic3\",\"Topic3\",\"Topic4\",\"Topic6\",\"Topic6\",\"Topic10\",\"Topic11\",\"Topic14\",\"Topic15\",\"Topic18\",\"Topic19\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic24\",\"Topic26\",\"Topic26\",\"Topic30\",\"Topic33\",\"Topic34\",\"Topic1\",\"Topic4\",\"Topic5\",\"Topic11\",\"Topic12\",\"Topic13\",\"Topic14\",\"Topic20\",\"Topic21\",\"Topic22\",\"Topic25\",\"Topic26\",\"Topic30\",\"Topic33\",\"Topic34\",\"Topic36\",\"Topic2\",\"Topic6\",\"Topic8\",\"Topic10\",\"Topic12\",\"Topic13\",\"Topic15\",\"Topic24\",\"Topic27\",\"Topic28\",\"Topic29\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic35\",\"Topic35\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic6\",\"Topic7\",\"Topic14\",\"Topic19\",\"Topic20\",\"Topic23\",\"Topic25\",\"Topic27\",\"Topic28\",\"Topic30\",\"Topic30\",\"Topic31\",\"Topic31\",\"Topic32\",\"Topic34\",\"Topic35\",\"Topic1\",\"Topic2\",\"Topic2\",\"Topic11\",\"Topic15\",\"Topic16\",\"Topic16\",\"Topic17\",\"Topic18\",\"Topic18\",\"Topic21\",\"Topic27\",\"Topic31\",\"Topic32\",\"Topic36\",\"Topic3\",\"Topic5\",\"Topic6\",\"Topic6\",\"Topic12\",\"Topic16\",\"Topic17\",\"Topic18\",\"Topic19\",\"Topic20\",\"Topic22\",\"Topic24\",\"Topic26\",\"Topic27\",\"Topic29\",\"Topic30\",\"Topic31\",\"Topic31\",\"Topic32\",\"Topic36\",\"Topic2\",\"Topic4\",\"Topic6\",\"Topic7\",\"Topic13\",\"Topic15\",\"Topic15\",\"Topic16\",\"Topic17\",\"Topic19\",\"Topic20\",\"Topic21\",\"Topic21\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic33\",\"Topic1\",\"Topic3\",\"Topic5\",\"Topic6\",\"Topic8\",\"Topic8\",\"Topic20\",\"Topic24\",\"Topic27\",\"Topic28\",\"Topic28\",\"Topic31\",\"Topic32\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic4\",\"Topic7\",\"Topic9\",\"Topic9\",\"Topic10\",\"Topic11\",\"Topic16\",\"Topic16\",\"Topic17\",\"Topic17\",\"Topic19\",\"Topic20\",\"Topic22\",\"Topic26\",\"Topic27\",\"Topic30\",\"Topic31\",\"Topic35\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic5\",\"Topic8\",\"Topic10\",\"Topic14\",\"Topic15\",\"Topic19\",\"Topic20\",\"Topic21\",\"Topic22\",\"Topic22\",\"Topic24\",\"Topic32\",\"Topic33\",\"Topic36\",\"Topic2\",\"Topic2\",\"Topic2\",\"Topic3\",\"Topic4\",\"Topic11\",\"Topic12\",\"Topic15\",\"Topic16\",\"Topic26\",\"Topic28\",\"Topic29\",\"Topic30\",\"Topic30\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic3\",\"Topic7\",\"Topic8\",\"Topic12\",\"Topic13\",\"Topic14\",\"Topic20\",\"Topic22\",\"Topic23\",\"Topic24\",\"Topic26\",\"Topic29\",\"Topic36\",\"Topic36\",\"Topic4\",\"Topic5\",\"Topic6\",\"Topic10\",\"Topic11\",\"Topic17\",\"Topic18\",\"Topic21\",\"Topic22\",\"Topic25\",\"Topic27\",\"Topic30\",\"Topic30\",\"Topic33\",\"Topic35\",\"Topic1\",\"Topic4\",\"Topic6\",\"Topic10\",\"Topic11\",\"Topic12\",\"Topic12\",\"Topic20\",\"Topic26\",\"Topic34\",\"Topic7\",\"Topic8\",\"Topic8\",\"Topic10\",\"Topic12\",\"Topic14\",\"Topic16\",\"Topic19\",\"Topic22\",\"Topic27\",\"Topic29\",\"Topic30\",\"Topic34\",\"Topic1\",\"Topic7\",\"Topic12\",\"Topic13\",\"Topic18\",\"Topic20\",\"Topic21\",\"Topic23\",\"Topic24\",\"Topic29\",\"Topic30\",\"Topic36\",\"Topic2\",\"Topic3\",\"Topic6\",\"Topic7\",\"Topic10\",\"Topic15\",\"Topic17\",\"Topic18\",\"Topic22\",\"Topic25\",\"Topic26\",\"Topic29\",\"Topic33\",\"Topic6\",\"Topic8\",\"Topic12\",\"Topic16\",\"Topic26\",\"Topic28\",\"Topic30\",\"Topic33\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic5\",\"Topic6\",\"Topic9\",\"Topic10\",\"Topic14\",\"Topic19\",\"Topic22\",\"Topic23\",\"Topic29\",\"Topic31\",\"Topic2\",\"Topic4\",\"Topic10\",\"Topic11\",\"Topic13\",\"Topic16\",\"Topic17\",\"Topic21\",\"Topic24\",\"Topic25\",\"Topic28\",\"Topic29\",\"Topic30\",\"Topic34\",\"Topic35\",\"Topic1\",\"Topic3\",\"Topic6\",\"Topic15\",\"Topic16\",\"Topic16\",\"Topic16\",\"Topic18\",\"Topic22\",\"Topic26\",\"Topic28\",\"Topic31\",\"Topic33\",\"Topic2\",\"Topic4\",\"Topic10\",\"Topic13\",\"Topic15\",\"Topic16\",\"Topic19\",\"Topic31\",\"Topic32\",\"Topic33\",\"Topic1\",\"Topic3\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic11\",\"Topic13\",\"Topic14\",\"Topic15\",\"Topic17\",\"Topic18\",\"Topic20\",\"Topic26\",\"Topic29\",\"Topic33\",\"Topic35\",\"Topic36\",\"Topic2\",\"Topic4\",\"Topic5\",\"Topic6\",\"Topic17\",\"Topic19\",\"Topic29\",\"Topic29\",\"Topic31\",\"Topic34\",\"Topic36\",\"Topic3\",\"Topic16\",\"Topic17\",\"Topic23\",\"Topic27\",\"Topic28\",\"Topic30\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic7\",\"Topic12\",\"Topic15\",\"Topic16\",\"Topic20\",\"Topic21\",\"Topic22\",\"Topic27\",\"Topic32\",\"Topic2\",\"Topic6\",\"Topic10\",\"Topic12\",\"Topic14\",\"Topic19\",\"Topic21\",\"Topic24\",\"Topic28\",\"Topic32\",\"Topic36\",\"Topic8\",\"Topic9\",\"Topic16\",\"Topic16\",\"Topic17\",\"Topic26\",\"Topic28\",\"Topic29\",\"Topic31\",\"Topic33\",\"Topic34\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic9\",\"Topic21\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic27\",\"Topic28\",\"Topic29\",\"Topic30\",\"Topic3\",\"Topic4\",\"Topic11\",\"Topic12\",\"Topic16\",\"Topic18\",\"Topic20\",\"Topic24\",\"Topic26\",\"Topic27\",\"Topic31\",\"Topic34\",\"Topic35\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic8\",\"Topic15\",\"Topic17\",\"Topic21\",\"Topic22\",\"Topic30\",\"Topic30\",\"Topic3\",\"Topic6\",\"Topic8\",\"Topic11\",\"Topic13\",\"Topic15\",\"Topic19\",\"Topic32\",\"Topic2\",\"Topic5\",\"Topic5\",\"Topic8\",\"Topic11\",\"Topic12\",\"Topic14\",\"Topic19\",\"Topic20\",\"Topic22\",\"Topic26\",\"Topic33\",\"Topic34\",\"Topic3\",\"Topic20\",\"Topic27\",\"Topic28\",\"Topic32\",\"Topic36\",\"Topic1\",\"Topic3\",\"Topic9\",\"Topic12\",\"Topic14\",\"Topic15\",\"Topic17\",\"Topic20\",\"Topic21\",\"Topic23\",\"Topic24\",\"Topic24\",\"Topic24\",\"Topic29\",\"Topic30\",\"Topic32\",\"Topic33\",\"Topic34\",\"Topic35\",\"Topic6\",\"Topic7\",\"Topic12\",\"Topic14\",\"Topic20\",\"Topic26\",\"Topic30\",\"Topic34\",\"Topic2\",\"Topic3\",\"Topic7\",\"Topic9\",\"Topic12\",\"Topic18\",\"Topic20\",\"Topic24\",\"Topic28\",\"Topic29\",\"Topic32\",\"Topic35\",\"Topic1\",\"Topic3\",\"Topic6\",\"Topic7\",\"Topic8\",\"Topic14\",\"Topic16\",\"Topic17\",\"Topic21\",\"Topic24\",\"Topic4\",\"Topic5\",\"Topic14\",\"Topic16\",\"Topic20\",\"Topic26\",\"Topic29\",\"Topic30\",\"Topic33\",\"Topic8\",\"Topic15\",\"Topic17\",\"Topic24\",\"Topic27\",\"Topic28\",\"Topic32\",\"Topic10\",\"Topic14\",\"Topic18\",\"Topic19\",\"Topic25\",\"Topic26\",\"Topic28\",\"Topic30\",\"Topic34\",\"Topic1\",\"Topic3\",\"Topic5\",\"Topic6\",\"Topic21\",\"Topic27\",\"Topic29\",\"Topic36\",\"Topic2\",\"Topic4\",\"Topic9\",\"Topic10\",\"Topic19\",\"Topic21\",\"Topic22\",\"Topic24\",\"Topic27\",\"Topic28\",\"Topic28\",\"Topic31\",\"Topic34\",\"Topic1\",\"Topic2\",\"Topic6\",\"Topic7\",\"Topic13\",\"Topic14\",\"Topic15\",\"Topic17\",\"Topic24\",\"Topic28\",\"Topic33\",\"Topic34\",\"Topic3\",\"Topic6\",\"Topic11\",\"Topic16\",\"Topic16\",\"Topic19\",\"Topic20\",\"Topic21\",\"Topic26\",\"Topic28\",\"Topic31\",\"Topic32\",\"Topic35\",\"Topic4\",\"Topic7\",\"Topic12\",\"Topic14\",\"Topic17\",\"Topic18\",\"Topic23\",\"Topic26\",\"Topic29\",\"Topic2\",\"Topic6\",\"Topic13\",\"Topic18\",\"Topic9\",\"Topic10\",\"Topic20\",\"Topic28\",\"Topic32\",\"Topic3\",\"Topic7\",\"Topic8\",\"Topic15\",\"Topic16\",\"Topic17\",\"Topic18\",\"Topic22\",\"Topic23\",\"Topic25\",\"Topic33\",\"Topic36\",\"Topic3\",\"Topic5\",\"Topic32\",\"Topic7\",\"Topic14\",\"Topic17\",\"Topic27\",\"Topic31\",\"Topic36\",\"Topic1\",\"Topic2\",\"Topic3\",\"Topic8\",\"Topic11\",\"Topic12\",\"Topic18\",\"Topic23\",\"Topic24\",\"Topic28\",\"Topic30\",\"Topic34\",\"Topic9\",\"Topic11\",\"Topic12\",\"Topic15\",\"Topic17\",\"Topic18\",\"Topic21\",\"Topic24\",\"Topic26\",\"Topic35\",\"Topic6\",\"Topic16\",\"Topic29\",\"Topic30\",\"Topic3\",\"Topic5\",\"Topic7\",\"Topic18\",\"Topic22\",\"Topic25\",\"Topic30\",\"Topic33\",\"Topic2\",\"Topic10\",\"Topic16\",\"Topic21\",\"Topic7\",\"Topic8\",\"Topic15\",\"Topic17\",\"Topic18\",\"Topic20\",\"Topic21\",\"Topic24\",\"Topic29\",\"Topic1\",\"Topic2\",\"Topic15\",\"Topic16\",\"Topic32\",\"Topic34\",\"Topic7\",\"Topic12\",\"Topic16\",\"Topic18\",\"Topic19\",\"Topic29\",\"Topic36\",\"Topic2\",\"Topic3\",\"Topic5\",\"Topic5\",\"Topic6\",\"Topic7\",\"Topic9\",\"Topic10\",\"Topic15\",\"Topic20\",\"Topic21\",\"Topic22\",\"Topic25\",\"Topic27\",\"Topic36\",\"Topic11\",\"Topic15\",\"Topic28\",\"Topic6\",\"Topic13\",\"Topic14\",\"Topic22\",\"Topic24\",\"Topic29\",\"Topic30\",\"Topic31\",\"Topic9\",\"Topic15\",\"Topic16\",\"Topic27\",\"Topic28\",\"Topic31\",\"Topic32\",\"Topic35\",\"Topic3\",\"Topic9\",\"Topic20\",\"Topic25\",\"Topic30\",\"Topic32\",\"Topic1\",\"Topic22\",\"Topic24\",\"Topic25\",\"Topic36\",\"Topic2\",\"Topic9\",\"Topic23\",\"Topic33\",\"Topic34\",\"Topic34\",\"Topic16\",\"Topic20\",\"Topic28\",\"Topic30\",\"Topic31\",\"Topic2\",\"Topic3\",\"Topic22\",\"Topic33\",\"Topic10\",\"Topic12\",\"Topic19\",\"Topic21\",\"Topic4\",\"Topic8\",\"Topic20\",\"Topic22\",\"Topic24\",\"Topic3\",\"Topic12\",\"Topic16\",\"Topic30\",\"Topic8\",\"Topic9\",\"Topic18\",\"Topic27\",\"Topic3\",\"Topic4\",\"Topic10\",\"Topic12\",\"Topic14\",\"Topic18\",\"Topic23\",\"Topic26\",\"Topic31\",\"Topic32\"]},\"token.table\":{\"Term\":[\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abandon\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abl\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"abus\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"academi\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"access\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"account\",\"acquisit\",\"acquisit\",\"acquisit\",\"acquisit\",\"acquisit\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"across\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"act\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"action\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actor\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"actress\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adapt\",\"adjust\",\"adjust\",\"adjust\",\"adjust\",\"adjust\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"adult\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advert\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"advic\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"affair\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenc\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agenda\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"agricultur\",\"airlin\",\"airlin\",\"airlin\",\"airlin\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"alan\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"album\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alex\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"alli\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"almost\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"although\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"alway\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"american\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"amid\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"among\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"analyst\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"andi\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"angel\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anger\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"anim\",\"ankl\",\"ankl\",\"ankl\",\"ankl\",\"ankl\",\"ankl\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"announc\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"annual\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anoth\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"anti\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"apologis\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appeal\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appear\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appl\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"appli\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"applic\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"approv\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argentina\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argu\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"argument\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"around\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arrest\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"arsenal\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"art\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"articl\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"artist\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"asid\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"ask\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"assembl\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"asset\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"associ\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"asylum\",\"athen\",\"athen\",\"athen\",\"athen\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"athlet\",\"attach\",\"attach\",\"attach\",\"attach\",\"attach\",\"attach\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attack\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attitud\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"attorney\",\"auction\",\"auction\",\"auction\",\"auction\",\"auction\",\"auction\",\"auction\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"audit\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"august\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"australian\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"automat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"aviat\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"award\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"away\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"babi\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"backbench\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ball\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"ban\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"band\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bank\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"bankruptci\",\"barcelona\",\"barcelona\",\"barcelona\",\"barcelona\",\"barcelona\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"barrier\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"bay\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beat\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beaten\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"beauti\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"behind\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"better\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"bid\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"big\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"biggest\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"bill\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"birmingham\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blair\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"blunkett\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"bodi\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"border\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boss\",\"boston\",\"boston\",\"boston\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"bought\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"box\",\"brazilian\",\"brazilian\",\"brazilian\",\"brazilian\",\"brazilian\",\"brazilian\",\"brazilian\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"break.\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brian\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"brief\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"bring\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"britain\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"british\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broadband\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"broke\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"brown\",\"bruce\",\"bruce\",\"bruce\",\"bruce\",\"bruce\",\"bruce\",\"bruce\",\"bruce\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"budget\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"busi\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"buy\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"cabinet\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"calcul\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"california\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"came\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"camera\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"campaign\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"candid\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"capabl\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"captain\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"cardiff\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"care\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"career\",\"carlo\",\"carlo\",\"carlo\",\"carlo\",\"carlo\",\"carlo\",\"carrier\",\"carrier\",\"carrier\",\"carrier\",\"carrier\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"case\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"categori\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"centr\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"ceremoni\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chairman\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"chamber\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"champion\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"championship\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chanc\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"chancellor\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"channel\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charg\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charl\",\"charli\",\"charli\",\"charli\",\"charli\",\"charli\",\"charli\",\"charli\",\"charli\",\"charli\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chart\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"chelsea\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"china\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"chip\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"choic\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"christian\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"cinema\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"circumst\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"citizen\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clark\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"clear\",\"click\",\"click\",\"click\",\"click\",\"click\",\"click\",\"click\",\"click\",\"click\",\"click\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"climb\",\"clinch\",\"clinch\",\"clinch\",\"clinch\",\"clinch\",\"clinch\",\"clinch\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"clive\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"close\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"closer\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"club\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"coach\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"code\",\"cole\",\"cole\",\"cole\",\"cole\",\"cole\",\"cole\",\"cole\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"collabor\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"com\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comedi\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"comfort\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commerc\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"commission\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"common\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compil\",\"compromis\",\"compromis\",\"compromis\",\"compromis\",\"compromis\",\"compromis\",\"compromis\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"comput\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concern\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"concert\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"conduct\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confid\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"confus\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"connect\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"conserv\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consid\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consol\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"consortium\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitu\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"constitut\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"consum\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"content\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"control\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convent\",\"convert\",\"convert\",\"convert\",\"convert\",\"convert\",\"convert\",\"convert\",\"convert\",\"convert\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"cooper\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copi\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"copyright\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"corner\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"cost\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"council\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"court\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"crash\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creat\",\"creativ\",\"creativ\",\"creativ\",\"creativ\",\"creativ\",\"creativ\",\"creativ\",\"creativ\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crime\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"crimin\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"criticis\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"cup\",\"currenc\",\"currenc\",\"currenc\",\"currenc\",\"currenc\",\"currenc\",\"currenc\",\"currenc\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"custom\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"cut\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"data\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"david\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"dead\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"deal\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debt\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"debut\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decemb\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decid\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"decis\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"defeat\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"deficit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"definit\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"deliv\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"dem\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"demand\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"democrat\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"deni\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"depth\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"despit\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detain\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"detect\",\"deutsch\",\"deutsch\",\"deutsch\",\"deutsch\",\"deutsch\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"develop\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"devic\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"diari\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"didn\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"differ\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"digit\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"direct\",\"disc\",\"disc\",\"disc\",\"disc\",\"disc\",\"disc\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"diseas\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"dismiss\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"disput\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"distribut\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"divis\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"document\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"documentari\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"dollar\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"domest\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"don\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"down\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"download\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"drama\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"dress\",\"drink\",\"drink\",\"drink\",\"drink\",\"drink\",\"drink\",\"drink\",\"drink\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"drug\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"dublin\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"due\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvd\",\"dvds\",\"dvds\",\"dvds\",\"dvds\",\"dvds\",\"dvds\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earli\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"earlier\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"econom\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economi\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"economist\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"effici\",\"eighth\",\"eighth\",\"eighth\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elect\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"elector\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"electron\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"encount\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"energi\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"engag\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"england\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"enhanc\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"entertain\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"episod\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equiti\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"equival\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"error\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"euro\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"europ\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"european\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"event\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"ever\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everi\",\"everton\",\"everton\",\"everton\",\"everton\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"exchang\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"execut\",\"expans\",\"expans\",\"expans\",\"expans\",\"expans\",\"expans\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"expert\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"exploit\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"export\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fail\",\"fake\",\"fake\",\"fake\",\"fake\",\"fake\",\"fake\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fall\",\"fame\",\"fame\",\"fame\",\"fame\",\"fame\",\"fame\",\"fame\",\"fame\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"famili\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"far\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"faster\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fastest\",\"fault\",\"fault\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"februari\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"feder\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"fee\",\"femal\",\"femal\",\"femal\",\"femal\",\"femal\",\"femal\",\"femal\",\"femal\",\"femal\",\"ferguson\",\"ferguson\",\"ferguson\",\"ferguson\",\"ferguson\",\"ferguson\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"festiv\",\"fierc\",\"fierc\",\"fierc\",\"fierc\",\"fierc\",\"fierc\",\"fierc\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"fifth\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"figur\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"file\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"film\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"final\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financ\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"financi\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"find\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"fiscal\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"flanker\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"fli\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"flight\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"footbal\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forc\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"forecast\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"foreign\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"form\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"formal\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"format\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"forthcom\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"foundat\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"founder\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fourth\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"fox\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"franc\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"francisco\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"fraud\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"full\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"function.\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"futur\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gadget\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"gamer\",\"garden\",\"garden\",\"garden\",\"garden\",\"garden\",\"garden\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gari\",\"gas\",\"gas\",\"gas\",\"gas\",\"gas\",\"gas\",\"gas\",\"gas\",\"gdp\",\"gdp\",\"gdp\",\"gdp\",\"gdp\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"general\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"generat\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"genr\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"giant\",\"girl\",\"girl\",\"girl\",\"girl\",\"girl\",\"girl\",\"girl\",\"girl\",\"girl\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"given\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"globe\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"glori\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"goal\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"gold\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"golden\",\"googl\",\"googl\",\"googl\",\"googl\",\"googl\",\"googl\",\"googl\",\"googl\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"gordon\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"got\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"grand\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"graphic\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"great\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"grew\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"gross\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"grow\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"growth\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"half\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"halt\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"hand\",\"handheld\",\"handheld\",\"handheld\",\"handheld\",\"handheld\",\"handheld\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"handset\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hard\",\"hardwar\",\"hardwar\",\"hardwar\",\"hardwar\",\"hardwar\",\"hardwar\",\"hardwar\",\"hardwar\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"harri\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"head\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"health\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"held\",\"henri\",\"henri\",\"henri\",\"henri\",\"henri\",\"henri\",\"henri\",\"henri\",\"henri\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hip\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hodgson\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"hold\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"holder\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hole\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"hollywood\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"honour\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hotel\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"hous\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"howard\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"huge\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"hugh\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"human\",\"ibm\",\"ibm\",\"ibm\",\"ibm\",\"ibm\",\"ibm\",\"ibm\",\"ibm\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"imag\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"immigr\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"implement\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"import\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"impos\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"improv\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incid\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incom\",\"incorpor\",\"incorpor\",\"incorpor\",\"incorpor\",\"incorpor\",\"incorpor\",\"incorpor\",\"incorpor\",\"index\",\"index\",\"index\",\"index\",\"index\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"india\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indian\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"indoor\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"industri\",\"infect\",\"infect\",\"infect\",\"infect\",\"infect\",\"infect\",\"infect\",\"infect\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inflat\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"inform\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"infrastructur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injur\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"injuri\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"innov\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"inquiri\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"insist\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"instal\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"insur\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intellig\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"intent\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"interest\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"internet\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"intervent\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"invest\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investig\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"investor\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"invit\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"ipod\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"iraq\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"ireland\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"irish\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"itali\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"italian\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"itun\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jack\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"jami\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"januari\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"japan\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"jason\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"job\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"john\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"join\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jone\",\"jose\",\"jose\",\"jose\",\"jose\",\"jose\",\"jose\",\"jose\",\"jose\",\"jose\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"journalist\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"judgement\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"juli\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"justifi\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"keep\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kelli\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kennedi\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"kick\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"knee\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"known\",\"korea\",\"korea\",\"korea\",\"korea\",\"lab\",\"lab\",\"lab\",\"lab\",\"lab\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"label\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"laboratori\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"labour\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"largest\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"las\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"later\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"latest\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"launch\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"law\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawsuit\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lawyer\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"lay\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leader\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"leagu\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"led\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"lee\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"left\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"leg\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legisl\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"legitim\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"let\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"letwin\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"level\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"liam\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"lib\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liber\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"liberti\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"life\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"limit\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"line\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"link\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"lion\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"littl\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"live\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"local\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"lock\",\"log\",\"log\",\"log\",\"log\",\"log\",\"log\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"london\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"lord\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"los\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lost\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"lot\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"love\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"machin\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"mail\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"maker\",\"malici\",\"malici\",\"malici\",\"malici\",\"malici\",\"malici\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"man\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manchest\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manifesto\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"manufactur\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mari\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"mark\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"marri\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"martin\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"match\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"matt\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"mean\",\"medal\",\"medal\",\"medal\",\"medal\",\"medal\",\"medal\",\"medal\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"media\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"meet\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merg\",\"merger\",\"merger\",\"merger\",\"merger\",\"merger\",\"merger\",\"merger\",\"merger\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"messag\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"metr\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"michael\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"microsoft\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"midfield\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"mike\",\"milan\",\"milan\",\"milan\",\"milan\",\"milan\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"milburn\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"millennium\",\"ministri\",\"ministri\",\"ministri\",\"ministri\",\"ministri\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"minut\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"miss\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"mobil\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"model\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"monetari\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"money\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"morgan\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mortgag\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"mother\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motion\",\"motor\",\"motor\",\"motor\",\"motor\",\"motor\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"movi\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"mps\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"murphi\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"music\",\"musician\",\"musician\",\"musician\",\"musician\",\"musician\",\"musician\",\"musician\",\"musician\",\"musician\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"muslim\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"name\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"necessari\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"net\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"network\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"newcastl\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"night\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomin\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"nomine\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"none\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"northern\",\"object\",\"object\",\"object\",\"object\",\"object\",\"object\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"oblig\",\"odd\",\"odd\",\"odd\",\"odd\",\"odd\",\"odd\",\"odd\",\"odd\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offens\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offic\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"offici\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oil\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"oliv\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"olymp\",\"ongo\",\"ongo\",\"ongo\",\"ongo\",\"ongo\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"onlin\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"oper\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opinion\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opposit\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"opt\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"order\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"ordin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"origin\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"oscar\",\"outlook\",\"outlook\",\"outlook\",\"outlook\",\"outlook\",\"outlook\",\"outlook\",\"outlook\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"output\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"oversea\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"owen\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"own\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"ownership\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"pack\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"paper\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"pari\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"park\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliament\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parliamentari\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"parti\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"partnership\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"past\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"pay\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"payment\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"pcs\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"peac\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penalti\",\"penc\",\"penc\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"pension\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"perform\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"person\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phil\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"phone\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"pictur\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"piraci\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pirat\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"pitch\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"playstat\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"pledg\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polic\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polici\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"polit\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"poll\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"popular\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"portabl\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"posit\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"possibl\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"poster\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"potter\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"poverti\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"power\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"premiership\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"present\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"presid\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"previous\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"price\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prime\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prioriti\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prison\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"prize\",\"proceed\",\"proceed\",\"proceed\",\"proceed\",\"proceed\",\"proceed\",\"proceed\",\"proceed\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"processor\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"produc\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"product\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"profit\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"program\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"programm\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"project\",\"prop\",\"prop\",\"prop\",\"prop\",\"prop\",\"prop\",\"prop\",\"prop\",\"prop\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"proport\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"propos\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"prosecut\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"protect\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"provid\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"publish\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"pull\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"punish\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"purchas\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"pursu\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"push\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualifi\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"qualiti\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"quarter\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"question\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"race\",\"rap\",\"rap\",\"rap\",\"rap\",\"rap\",\"rap\",\"rap\",\"rapper\",\"rapper\",\"rapper\",\"rapper\",\"rapper\",\"rapper\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"rate\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"ray\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"rbs\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"reach\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"react\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"realli\",\"recal\",\"recal\",\"recal\",\"recal\",\"recal\",\"recal\",\"recal\",\"recal\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"receiv\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recommend\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recov\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recoveri\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"recruit\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"reduct\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"refere\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"reform\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"regist\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"releas\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"replac\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"research\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resign\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resist\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"resourc\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"respons\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"result\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retail\",\"retain\",\"retain\",\"retain\",\"retain\",\"retain\",\"retain\",\"retain\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"return\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"reuter\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"ring\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rise\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rival\",\"rob\",\"rob\",\"rob\",\"rob\",\"rob\",\"rob\",\"rob\",\"rob\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"robinson\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"rock\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"role\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"rose\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"ross\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"round\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rugbi\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rule\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"rural\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russia\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"russian\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"sack\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"san\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"saturday\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"scare\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"school\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"score\",\"scorses\",\"scorses\",\"scorses\",\"scorses\",\"scorses\",\"scorses\",\"scorses\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scot\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scotland\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"scrap\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"screen\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrum\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"scrutini\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"seal\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"season\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"seat\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"secretari\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"sector\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"secur\",\"seed\",\"seed\",\"seed\",\"seed\",\"seed\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"seen\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"sell\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"semi\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"send\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sensibl\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"sequel\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"serv\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"server\",\"settlement\",\"settlement\",\"settlement\",\"settlement\",\"settlement\",\"settlement\",\"settlement\",\"settlement\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"seventh\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"sever\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"shadow\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"share\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sharehold\",\"sheffield\",\"sheffield\",\"sheffield\",\"sheffield\",\"sheffield\",\"sheffield\",\"sheffield\",\"sheffield\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"shop\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"side\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"silver\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singer\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"singl\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"sir\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"site\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"sixth\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"skipper\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slam\",\"slide\",\"slide\",\"slide\",\"slide\",\"slide\",\"slide\",\"slide\",\"slot\",\"slot\",\"slot\",\"slot\",\"slot\",\"slot\",\"slot\",\"slot\",\"slot\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slow\",\"slowdown\",\"slowdown\",\"slowdown\",\"slowdown\",\"soar\",\"soar\",\"soar\",\"soar\",\"soar\",\"soar\",\"soar\",\"soar\",\"soar\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"societi\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"softwar\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"sold\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"solid\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"song\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"soni\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"sophist\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"southern\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speak\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"speed\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spend\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"spokesman\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"sport\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spread\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"spring\",\"sprinter\",\"sprinter\",\"sprinter\",\"sprinter\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"squad\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stabil\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stadium\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stake\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"stand\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"star\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"state\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"statement\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"status\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"steven\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stick\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stock\",\"stone\",\"stone\",\"stone\",\"stone\",\"stone\",\"stone\",\"stone\",\"stone\",\"storag\",\"storag\",\"storag\",\"storag\",\"storag\",\"storag\",\"storag\",\"storag\",\"storag\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"store\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"storm\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"strategi\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"straw\",\"stream\",\"stream\",\"stream\",\"stream\",\"stream\",\"stream\",\"stream\",\"stream\",\"stream\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"street\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"striker\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"strong\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"studio\",\"submit\",\"submit\",\"submit\",\"submit\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"subscrib\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"success\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"suggest\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sullivan\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"sum\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"summit\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"sunday\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"super\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"suppli\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"surg\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspect\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspend\",\"suspens\",\"suspens\",\"suspens\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"suspicion\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"sydney\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"system\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"tag\",\"takeov\",\"takeov\",\"takeov\",\"takeov\",\"takeov\",\"takeov\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"talk\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"tax\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"team\",\"techniqu\",\"techniqu\",\"techniqu\",\"techniqu\",\"techniqu\",\"techniqu\",\"techniqu\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"technolog\",\"telecom\",\"telecom\",\"telecom\",\"telecom\",\"telecom\",\"telecom\",\"telecom\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telegraph\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"telephon\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tend\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"tenni\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"term\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terror\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"terrorist\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"test\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"text\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theatr\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theft\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"theme\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thing\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"thoma\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"threat\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"thursday\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"ticket\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"tie\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"titl\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"tommi\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"toni\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"took\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tool\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tori\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"tournament\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"trade\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"transfer\",\"translat\",\"translat\",\"translat\",\"translat\",\"translat\",\"translat\",\"translat\",\"translat\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"treasuri\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trend\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trial\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trick\",\"trillion\",\"trillion\",\"trillion\",\"trillion\",\"trillion\",\"trillion\",\"trillion\",\"trillion\",\"trophi\",\"trophi\",\"trophi\",\"trophi\",\"trophi\",\"trophi\",\"trophi\",\"trophi\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"trust\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"truth\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"tune\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"turn\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"undermin\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"understood\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unemploy\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unfair\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"unit\",\"updat\",\"updat\",\"updat\",\"updat\",\"updat\",\"updat\",\"updat\",\"updat\",\"updat\",\"upgrad\",\"upgrad\",\"upgrad\",\"upgrad\",\"upgrad\",\"upgrad\",\"upgrad\",\"usa\",\"usa\",\"usa\",\"usa\",\"usa\",\"usa\",\"usa\",\"usa\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"user\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"valu\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"van\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"vega\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"version\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"via\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"vice\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"victori\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"video\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"viewer\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"virus\",\"visual\",\"visual\",\"visual\",\"visual\",\"visual\",\"visual\",\"visual\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"vote\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"voter\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"vulner\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wake\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"wale\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"war\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"warn\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"wast\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"watch\",\"water\",\"water\",\"water\",\"water\",\"water\",\"water\",\"water\",\"water\",\"water\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weak\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weapon\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"weather\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"web\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"websit\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welfar\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"welsh\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"went\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"westminst\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whatev\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whether\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"whose\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"william\",\"wimbledon\",\"wimbledon\",\"wimbledon\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"window\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"wing\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winger\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"winner\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"wireless\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"without\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"worth\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"wrote\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X100m\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1993\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1997\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X1bn\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2000\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2003\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2005\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X2006\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X200m\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X2bn\",\"X400m\",\"X400m\",\"X400m\",\"X400m\",\"X400m\",\"X400m\",\"X400m\",\"X400m\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X4bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X5bn\",\"X7bn\",\"X7bn\",\"X7bn\",\"X7bn\",\"X7bn\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800\",\"X800m\",\"X800m\",\"X800m\",\"X800m\",\"X800m\",\"X800m\",\"X800m\",\"X800m\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"xbox\",\"yard\",\"yard\",\"yard\",\"yard\",\"yard\",\"yard\",\"yard\",\"yard\",\"yard\",\"yen\",\"yen\",\"yen\",\"yen\",\"yen\",\"yen\",\"yen\",\"yen\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"york\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\",\"zealand\"],\"Topic\":[1,2,3,4,5,6,8,9,10,11,13,16,18,19,20,22,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,18,19,21,23,24,25,28,29,35,1,2,3,11,12,14,16,20,21,24,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,27,28,29,30,31,32,34,35,36,6,15,18,21,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,11,12,14,15,16,20,24,26,27,29,31,32,35,36,1,2,3,4,11,14,15,16,20,24,26,31,35,36,2,3,4,11,12,14,15,16,18,20,21,22,24,27,28,33,35,1,3,6,18,22,1,2,3,4,5,6,8,9,10,11,12,13,15,18,19,21,27,28,35,2,3,8,12,14,18,21,24,28,36,1,3,4,5,8,9,10,11,12,13,15,18,19,23,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,29,30,32,35,1,2,3,4,5,6,8,10,11,12,13,14,15,17,18,19,21,22,23,25,27,28,30,31,32,36,1,4,5,6,7,8,9,10,11,13,16,18,19,22,25,1,4,5,6,8,9,10,11,13,15,19,25,32,1,6,14,18,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,24,25,29,31,33,35,1,2,3,5,11,12,14,15,18,20,24,26,36,1,2,3,4,7,8,11,15,16,18,20,22,35,1,4,5,6,7,8,9,10,11,13,15,18,19,22,23,29,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,32,33,34,35,36,1,3,4,5,6,7,8,9,10,11,13,15,16,18,19,21,22,25,30,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,29,30,31,32,34,35,1,2,3,4,5,7,8,11,13,14,15,16,17,18,22,24,29,30,31,33,34,35,36,1,2,3,7,11,12,14,15,16,20,21,22,24,26,27,31,32,36,1,3,4,5,6,7,8,9,10,11,13,15,19,24,26,36,1,2,3,8,9,10,12,14,20,24,35,36,7,16,17,22,29,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,33,36,1,3,4,5,7,8,10,11,13,15,19,20,24,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,12,18,21,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,15,18,19,23,25,29,32,33,35,1,3,4,5,6,7,8,9,10,11,12,13,15,17,18,19,21,25,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,21,22,23,25,28,29,30,32,1,6,7,15,16,20,22,29,33,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,1,3,4,5,6,7,8,9,10,11,12,13,15,18,19,23,25,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,12,13,14,15,17,18,19,20,21,23,24,26,29,30,31,36,1,4,5,7,11,15,16,22,33,35,1,2,3,5,7,8,11,12,14,15,18,20,22,24,26,27,30,31,35,36,1,2,4,5,6,8,9,10,11,13,15,19,1,2,3,4,5,8,11,12,14,15,18,20,21,22,23,24,26,27,30,31,35,36,1,2,3,4,5,6,8,9,10,11,13,14,16,18,19,20,22,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,4,5,7,8,9,10,11,13,17,19,30,1,4,5,6,8,9,10,11,12,14,15,16,18,19,22,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,9,10,11,13,15,19,25,16,17,33,34,1,3,16,17,20,22,24,28,29,31,33,34,1,10,12,19,21,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,5,6,8,9,11,15,19,25,30,33,1,4,7,8,10,11,13,18,19,23,1,3,6,8,15,18,32,1,3,4,5,6,7,8,13,19,20,21,30,1,2,3,4,6,7,8,9,10,11,12,15,16,17,18,20,21,22,23,24,26,27,28,29,31,32,33,35,1,2,5,6,7,8,10,11,13,14,16,17,18,19,20,22,23,24,25,27,29,33,34,35,1,2,3,6,7,8,9,10,12,13,16,18,19,20,21,22,25,28,29,1,2,4,5,6,9,11,14,16,18,20,24,26,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,26,27,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,7,8,9,10,11,13,14,15,19,20,21,24,25,26,36,1,4,5,6,8,9,10,11,13,19,1,3,4,5,6,7,8,9,10,14,15,16,22,23,24,29,30,33,34,35,1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,22,23,26,28,29,30,31,32,33,1,2,3,4,5,7,8,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,30,31,33,34,36,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,28,29,30,31,32,35,1,3,6,11,12,15,18,32,7,15,16,22,33,2,3,4,12,16,17,21,27,35,1,4,8,14,15,17,18,19,20,23,28,31,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,20,22,23,24,25,26,27,29,30,31,33,34,35,36,1,2,3,4,7,14,15,16,17,20,22,24,29,30,31,33,34,36,1,2,3,4,6,10,11,14,20,22,24,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,24,29,30,31,32,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,35,1,4,14,16,17,18,20,22,23,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,29,30,32,33,36,1,4,5,7,8,9,10,11,13,19,23,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,29,30,31,33,34,35,36,1,2,3,6,7,8,10,12,13,19,20,21,22,25,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,11,12,15,1,2,3,5,6,8,9,11,12,15,16,18,21,22,24,26,27,28,31,32,35,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,32,33,34,35,36,6,10,12,15,16,17,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,1,3,4,6,7,8,11,14,15,16,18,20,21,22,24,29,30,33,34,1,2,3,4,5,6,8,9,10,11,12,16,19,22,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,12,16,18,21,22,26,27,28,31,1,2,7,15,16,17,22,27,31,34,35,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,23,24,25,27,30,31,32,35,36,1,2,3,14,20,24,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,25,27,28,29,30,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,8,9,10,11,13,15,19,23,25,26,29,32,1,2,3,4,6,8,9,10,11,12,13,16,21,27,31,2,3,6,8,12,14,15,16,18,20,21,24,26,31,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,7,8,10,11,12,14,16,18,20,21,24,26,27,29,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,36,1,2,4,5,6,7,8,9,10,11,13,14,15,16,17,19,20,22,24,25,29,33,1,2,3,4,5,6,7,8,10,11,12,14,15,16,17,18,21,22,24,26,27,28,29,30,31,32,33,34,36,1,2,4,7,8,11,14,15,16,17,18,20,22,24,28,29,30,31,33,34,35,1,4,5,7,8,9,10,11,14,16,18,19,20,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,33,34,36,1,2,3,4,5,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24,26,27,29,30,31,33,34,35,36,6,15,16,17,22,34,1,6,12,14,18,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,36,1,2,3,7,11,12,14,16,17,18,20,24,26,31,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,5,6,8,11,14,15,16,17,20,22,24,26,31,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,1,4,5,6,8,9,10,11,12,13,17,19,1,2,3,4,5,6,7,8,11,14,15,16,17,18,20,22,23,24,29,30,31,33,34,35,1,7,8,11,14,15,16,17,22,24,29,30,31,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,35,36,1,2,4,5,6,7,8,9,10,11,13,14,15,16,18,19,22,23,25,29,30,32,1,2,3,5,7,8,9,10,11,12,14,15,16,18,20,21,22,24,26,27,28,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,23,24,25,29,30,32,35,36,7,14,16,22,24,29,30,33,34,1,2,3,4,5,8,10,11,14,18,20,21,22,24,26,27,31,34,35,36,1,4,5,7,10,11,15,16,18,22,24,29,33,1,3,4,5,6,8,9,10,11,12,15,16,18,19,21,22,23,25,32,1,2,3,7,12,16,18,21,22,27,28,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,25,26,27,29,30,32,33,34,35,1,2,8,12,14,17,19,20,23,24,35,1,2,3,5,10,12,14,18,20,24,27,35,36,1,4,5,6,7,8,10,11,13,15,16,17,19,23,29,1,3,5,6,7,8,9,10,11,12,13,16,18,19,23,25,28,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,25,29,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,32,33,34,35,2,3,7,8,12,21,22,28,29,34,2,5,6,8,9,10,18,20,22,27,32,35,7,16,17,20,22,24,34,1,2,3,7,11,14,16,20,22,24,29,30,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,5,6,7,8,9,10,11,14,18,19,20,21,22,24,26,35,36,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,20,22,23,24,25,29,30,31,32,33,34,35,36,1,4,5,7,8,10,11,14,15,16,17,20,22,24,29,30,31,33,34,35,36,1,2,3,4,5,7,8,9,10,12,13,14,15,16,18,19,20,21,24,27,28,30,33,35,4,7,15,16,22,30,33,2,3,12,14,20,21,24,28,36,2,3,8,9,12,15,18,21,27,28,31,35,1,2,3,4,5,7,10,11,12,14,15,16,17,20,24,26,35,36,1,3,5,7,8,11,13,16,17,18,19,22,29,30,34,1,3,6,8,12,18,19,21,32,1,4,5,6,7,8,9,10,11,12,13,19,23,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,36,1,2,3,5,12,14,16,20,24,27,1,10,11,13,21,28,30,1,2,3,4,5,6,8,10,11,12,14,15,16,18,19,20,21,22,23,24,26,27,28,29,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,12,13,16,20,23,24,26,1,2,3,4,5,6,7,8,9,10,11,12,13,15,18,19,28,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,27,28,29,30,32,33,34,36,1,2,3,8,10,11,12,16,18,21,22,1,2,3,5,6,8,9,10,12,15,16,17,18,20,21,22,23,24,26,27,28,30,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,25,28,29,30,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,8,11,12,16,18,21,22,26,27,31,33,35,36,1,2,3,6,12,15,18,21,27,31,1,4,5,8,9,10,11,13,15,19,25,1,4,5,6,7,8,9,10,11,12,13,15,19,22,23,25,29,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,26,27,28,29,31,32,35,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,24,26,27,28,29,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,5,8,10,11,12,13,15,19,21,23,25,26,2,3,4,7,16,18,22,30,33,1,6,7,8,9,15,19,22,25,30,33,1,2,3,4,5,6,8,12,14,15,16,18,20,21,22,24,26,27,28,31,34,35,36,2,3,8,18,21,26,27,28,31,1,2,3,4,7,8,12,13,14,15,16,19,21,22,29,30,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,6,7,16,17,22,24,29,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,7,12,18,20,26,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,21,22,23,24,25,26,27,28,30,31,35,36,1,2,3,4,5,6,7,8,9,10,11,13,15,17,18,19,21,23,24,25,26,27,28,31,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,22,23,24,25,28,29,30,33,34,1,4,5,7,8,11,14,15,16,17,18,22,24,29,30,33,34,35,36,1,3,6,11,16,18,22,32,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,21,22,23,26,27,28,29,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,21,22,23,26,27,28,29,31,32,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,8,9,10,11,14,15,16,17,20,22,24,29,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,7,8,9,10,11,12,13,15,16,18,19,22,32,1,2,3,4,5,6,7,8,10,11,12,14,15,16,17,18,20,21,22,24,26,27,28,29,30,31,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,35,36,1,4,5,7,8,9,10,11,13,14,15,16,17,18,19,22,23,24,25,29,30,31,33,34,35,1,4,6,7,11,16,19,22,29,30,32,33,34,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,24,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,32,33,34,35,1,4,5,6,7,8,9,10,11,12,13,15,18,19,22,23,25,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,5,6,7,8,9,10,11,13,14,15,16,18,19,20,21,22,23,25,29,30,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,28,29,30,31,32,33,34,35,36,2,3,7,12,16,22,26,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,5,8,10,11,13,14,19,23,25,1,2,8,10,11,14,21,23,24,28,36,6,12,15,18,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,11,12,14,15,16,18,20,21,22,23,24,26,27,28,30,31,36,1,2,3,4,8,9,10,11,12,14,19,20,24,35,36,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,29,30,31,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,8,9,11,12,13,15,16,18,19,20,21,22,23,24,26,27,28,29,30,31,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,2,3,21,24,26,27,1,2,4,5,6,8,9,10,11,18,21,36,1,2,3,4,5,6,7,8,9,10,11,13,15,17,18,19,21,25,29,31,32,1,3,4,5,7,8,9,10,11,15,18,32,1,2,3,4,8,12,14,15,17,18,20,21,22,24,26,27,28,31,33,35,36,1,2,3,4,5,6,8,9,10,11,12,15,16,18,19,21,22,25,27,28,30,31,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,22,23,25,1,2,3,4,7,8,11,14,15,16,20,24,35,36,1,2,3,4,5,6,8,9,11,12,13,14,15,16,18,19,20,22,24,26,29,32,35,36,1,2,3,4,5,6,7,8,11,14,15,16,17,18,19,20,22,24,29,30,32,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,5,6,7,8,9,10,11,13,15,16,17,19,25,2,3,5,8,10,12,15,16,18,20,21,22,23,24,26,27,28,31,35,36,1,2,3,11,14,15,16,17,20,24,26,35,36,2,3,4,5,8,11,13,14,16,20,24,1,5,10,11,13,15,19,26,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,24,26,28,29,31,33,34,36,1,4,7,8,10,11,14,16,18,20,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,11,12,14,20,21,24,26,27,28,35,2,3,14,24,26,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,25,27,28,29,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,25,28,29,32,35,1,4,5,6,7,8,9,15,16,18,19,22,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,21,22,25,28,30,32,16,24,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,25,28,29,30,32,34,1,4,5,6,7,8,9,10,11,13,16,19,23,25,29,1,2,3,5,6,8,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,31,35,2,4,5,7,8,10,11,14,15,16,20,22,24,29,30,33,34,1,2,3,6,7,8,9,12,13,14,15,16,17,18,19,21,22,24,26,28,31,32,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,16,18,19,20,23,24,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,28,29,30,32,33,34,35,36,1,2,3,4,6,7,12,17,18,21,28,31,1,2,3,4,5,6,7,8,11,12,14,15,16,17,18,19,20,21,22,24,26,27,28,29,31,35,36,1,2,3,4,9,15,16,21,24,28,36,1,2,4,5,6,8,13,15,18,3,4,5,6,8,9,10,12,13,19,21,1,4,5,6,7,9,11,13,14,16,18,29,33,34,35,1,2,3,4,6,8,9,11,12,14,15,16,18,20,22,26,27,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,4,11,15,16,1,2,3,4,5,6,8,9,12,14,15,16,17,18,20,22,23,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,6,15,16,22,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,25,26,27,28,29,31,32,36,1,2,3,4,6,8,9,10,11,12,13,18,19,21,22,26,27,28,31,1,3,4,6,8,9,11,15,18,21,22,29,31,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,17,21,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,14,20,24,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,6,10,12,16,17,18,21,22,26,27,28,30,31,36,1,2,3,6,8,12,16,17,21,22,27,28,29,31,34,35,16,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,11,13,15,16,17,18,19,20,21,22,23,24,28,31,32,33,34,36,1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,22,25,29,30,33,2,3,11,14,17,20,24,26,27,1,4,11,15,16,22,1,2,3,4,6,7,8,11,12,14,15,16,18,20,24,35,36,12,15,16,18,21,22,35,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,24,30,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,1,2,3,4,5,6,8,11,12,13,14,15,16,17,18,20,21,22,23,24,26,27,28,29,31,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,4,5,6,7,8,9,10,11,13,14,15,16,18,19,20,21,22,25,30,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,30,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,9,10,13,18,19,25,1,4,7,8,16,22,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,13,14,16,17,18,19,20,21,22,24,25,26,29,30,33,34,35,2,3,4,5,6,8,11,14,16,18,19,20,24,25,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,20,22,24,27,29,30,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,25,29,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,24,25,26,27,29,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,33,34,35,36,1,3,4,5,6,7,8,10,11,12,13,15,17,18,19,1,2,3,9,11,12,15,16,18,20,21,22,24,26,27,28,29,31,1,2,4,5,6,7,8,9,10,11,12,13,15,19,25,3,6,8,9,13,15,18,19,21,22,25,28,1,2,3,4,5,8,10,11,12,15,16,17,18,20,21,22,24,26,27,31,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,24,26,29,30,31,32,33,34,35,36,1,2,4,5,6,7,8,9,10,11,13,14,15,18,19,20,24,25,30,1,2,3,4,5,6,7,8,10,11,12,14,15,16,17,18,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,2,3,12,17,18,21,22,24,26,27,31,35,36,1,3,4,5,8,9,12,15,18,21,23,28,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,1,2,3,7,11,12,13,18,21,26,27,28,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,36,2,3,12,18,21,22,26,27,28,2,3,6,12,18,20,21,22,26,27,31,34,35,2,16,17,20,24,36,1,2,3,4,7,14,15,16,20,22,24,27,28,29,33,35,1,6,11,14,15,18,20,32,4,6,16,18,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,2,3,11,12,14,20,21,22,24,26,31,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,26,27,28,31,32,34,35,2,3,8,16,20,24,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,10,11,14,20,21,24,35,36,3,7,15,16,17,22,29,30,33,34,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,29,30,33,34,35,1,2,3,6,7,11,12,16,17,18,20,22,28,29,30,31,33,34,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,24,26,27,29,30,31,32,33,34,35,36,2,3,8,12,18,21,28,31,1,4,5,6,7,8,9,10,11,13,14,15,16,18,19,22,24,25,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,1,2,3,4,7,8,9,11,12,13,14,16,17,18,19,20,22,24,26,27,28,29,30,31,33,34,35,36,2,3,8,12,21,22,26,27,28,31,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,6,7,12,15,16,18,21,22,26,31,32,1,2,3,4,6,8,14,16,18,20,24,26,27,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,30,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,6,14,15,16,20,22,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,12,15,21,27,1,2,3,8,12,18,21,22,27,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,12,18,21,26,27,28,1,2,3,4,5,7,10,11,12,13,14,15,16,17,20,21,22,24,27,29,30,31,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,4,5,6,7,8,9,10,11,13,15,16,17,18,19,20,21,22,23,25,28,30,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,3,7,15,16,20,22,29,30,33,1,2,3,4,5,11,15,16,20,24,34,36,7,14,16,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,4,6,8,11,15,16,17,18,22,29,1,2,4,5,6,8,9,10,11,13,19,25,28,1,2,3,4,11,14,15,16,18,20,24,26,27,28,35,36,1,2,3,4,5,7,8,9,11,12,14,15,16,17,18,19,20,22,24,26,29,30,31,34,35,36,1,2,3,4,5,10,12,14,15,17,20,24,31,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,19,20,23,24,25,27,30,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,5,10,11,13,14,16,19,20,24,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,28,29,30,31,32,35,36,2,3,12,18,21,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,16,18,19,20,21,24,25,26,27,28,31,1,2,4,5,6,7,8,9,10,11,13,15,16,19,23,25,1,3,4,5,6,8,13,19,21,28,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,7,8,9,10,11,13,15,17,18,19,23,25,26,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,5,7,11,15,21,22,23,24,30,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,22,25,30,32,1,2,3,8,11,18,20,21,1,6,9,18,32,1,2,3,6,8,12,14,15,16,18,20,21,22,32,1,2,6,12,15,16,18,20,22,32,34,1,16,17,22,24,29,31,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,4,5,7,10,12,16,21,28,1,4,5,6,7,8,9,10,11,12,13,15,18,19,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,3,6,12,15,18,21,28,32,1,4,7,15,16,17,22,24,29,30,33,34,35,1,2,4,5,7,8,10,11,14,15,16,17,22,23,24,29,30,31,33,34,35,36,1,2,3,4,5,6,7,8,11,12,13,15,18,20,21,22,26,27,28,31,1,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,25,29,30,31,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,22,23,24,25,26,29,30,32,33,34,36,1,2,3,4,5,8,10,11,12,21,26,27,28,1,4,5,6,8,9,11,13,15,18,32,1,2,3,4,5,7,8,9,10,11,12,13,15,16,18,19,23,25,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,22,23,24,25,28,29,30,33,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,5,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,26,27,28,31,32,35,36,1,4,5,6,8,9,10,11,13,15,19,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,24,26,28,29,30,31,32,36,1,2,4,5,6,7,8,12,13,14,15,16,18,19,21,22,23,32,35,1,2,4,5,8,9,10,14,16,19,20,22,24,2,3,12,18,21,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,13,15,18,19,20,24,25,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,29,30,33,34,35,36,1,3,4,5,7,8,10,11,14,15,16,17,18,20,22,23,24,29,30,31,32,33,34,1,2,3,4,6,7,8,10,11,12,14,15,16,17,18,20,22,24,27,28,29,30,32,33,34,35,4,6,7,15,16,18,22,29,30,33,2,3,12,18,21,22,26,27,28,31,1,2,3,4,5,6,8,9,10,11,12,13,15,18,19,20,22,23,25,2,3,4,5,7,11,14,15,16,17,20,22,24,29,30,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,11,12,13,14,15,16,18,20,21,22,24,26,27,29,32,35,1,2,7,14,16,17,20,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,24,28,29,30,31,33,34,35,36,1,3,6,7,15,16,22,31,33,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,18,19,20,21,24,1,4,5,8,9,10,11,13,17,19,23,25,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,32,33,35,1,2,3,4,5,6,7,8,9,10,11,15,18,19,22,23,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,4,7,8,9,11,16,17,20,21,22,24,26,29,30,31,33,34,35,1,2,4,5,6,7,8,9,10,11,13,15,16,19,23,24,25,1,2,3,4,5,6,7,8,9,10,11,14,15,16,17,20,22,24,25,26,27,29,30,31,33,34,35,36,7,14,15,16,22,24,29,30,32,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,6,16,18,3,12,18,21,28,1,2,3,5,8,9,10,11,12,14,15,17,18,19,20,24,25,26,28,36,1,2,3,12,17,21,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,29,30,32,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,21,22,23,26,27,28,32,34,35,1,2,3,12,14,18,20,22,24,26,27,31,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,1,2,3,4,6,8,11,15,17,18,31,1,2,3,4,5,8,9,10,11,12,13,14,15,16,17,18,19,23,24,25,28,31,32,36,1,4,5,6,7,8,9,10,11,13,15,16,17,19,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,1,2,4,5,7,11,14,15,16,17,18,20,22,23,24,29,30,31,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,35,36,2,3,4,8,14,16,17,20,24,31,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,35,36,1,2,3,4,7,11,15,16,17,18,22,24,29,33,34,1,4,5,7,8,9,10,11,13,15,16,18,19,23,25,26,29,2,3,12,18,21,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,9,10,11,13,19,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,5,6,8,9,10,11,13,14,19,20,24,36,1,4,5,6,7,8,9,10,11,12,13,15,18,19,22,23,25,30,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,25,29,30,34,1,4,5,6,8,9,10,11,13,16,19,23,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,7,14,15,16,20,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,29,30,31,32,34,36,1,2,3,4,5,7,8,10,11,12,13,14,16,18,19,20,21,22,23,24,26,27,28,29,30,31,33,34,3,15,18,21,22,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,29,30,31,35,36,1,2,3,11,12,14,15,16,20,21,22,24,26,27,31,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,10,11,12,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,33,34,35,36,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,18,19,20,21,22,24,26,27,28,31,36,1,2,3,4,5,6,7,8,9,10,12,13,14,15,18,19,20,21,22,23,24,26,27,28,29,30,36,1,2,3,4,5,6,7,8,10,11,12,14,15,16,18,20,21,22,23,24,25,26,27,28,29,31,32,35,36,1,3,12,17,21,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,13,15,16,17,18,19,20,22,24,31,33,35,36,1,4,5,6,8,9,10,11,13,15,19,25,32,1,2,3,6,7,8,12,15,16,18,21,26,27,31,32,36,1,2,3,4,7,11,15,16,20,24,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,8,10,20,24,25,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,26,29,30,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,28,29,30,31,32,33,34,35,1,2,7,8,14,16,20,22,24,29,30,33,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,16,17,22,29,31,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,5,6,8,10,11,13,15,18,32,1,4,6,8,10,15,18,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,30,32,33,34,35,2,3,7,12,15,16,17,22,26,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,8,12,18,21,22,26,27,28,31,35,1,4,7,11,15,16,22,24,29,30,33,1,2,3,4,5,7,8,11,12,14,15,16,18,19,20,22,24,26,28,29,30,32,33,34,35,36,15,16,20,22,33,1,4,5,6,8,9,10,11,13,19,25,1,2,3,4,7,10,16,22,24,29,30,33,1,6,18,20,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,33,34,35,36,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,20,21,22,23,24,26,27,28,29,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,19,20,21,22,24,25,26,27,28,29,31,32,36,1,4,5,6,7,8,9,10,11,15,16,18,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,7,8,10,11,13,14,15,16,18,19,20,22,24,29,30,32,33,34,1,4,5,6,7,8,9,10,11,13,15,18,19,22,1,2,3,4,5,6,8,9,11,13,14,19,20,24,35,36,1,2,3,5,8,10,11,12,13,14,18,20,22,24,28,31,35,36,1,6,15,18,22,1,2,3,4,5,6,8,11,12,14,15,16,18,20,21,22,23,24,25,26,27,28,31,32,34,35,36,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,23,25,29,30,1,4,7,11,14,16,20,22,24,29,33,34,1,2,3,4,5,6,7,8,10,11,12,13,14,15,16,17,18,20,21,22,23,24,25,26,27,28,30,31,34,35,36,1,2,3,11,16,20,22,24,36,1,2,5,6,8,9,10,11,13,19,20,23,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,9,10,11,12,13,15,23,25,30,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,18,19,21,22,23,25,26,27,28,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,31,32,35,36,4,7,11,14,15,16,22,29,30,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,32,33,34,35,36,1,2,3,5,6,7,11,12,14,15,16,20,24,26,29,31,35,36,1,2,3,11,14,16,20,24,26,35,36,1,2,4,5,6,7,8,9,10,11,13,18,19,29,1,2,4,5,6,7,8,9,10,11,13,16,17,18,19,20,22,29,30,32,33,34,1,3,4,12,13,21,1,5,6,7,8,9,10,11,15,19,25,2,6,12,14,16,18,20,24,1,2,3,4,5,6,7,8,9,10,11,13,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,1,2,4,6,7,8,9,11,12,13,14,15,16,17,18,19,21,22,31,32,1,2,3,4,5,6,7,8,9,10,11,13,19,25,1,4,5,7,9,10,11,12,15,16,17,20,22,24,28,29,30,31,33,34,35,1,6,7,15,18,1,2,3,4,5,6,8,9,10,11,12,14,15,16,18,19,20,21,22,23,24,26,27,28,31,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,18,19,20,21,22,23,24,25,26,29,33,36,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,24,25,26,27,29,30,31,33,34,1,2,3,6,7,11,12,15,16,19,22,23,25,29,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,32,33,34,35,1,2,3,4,5,8,9,10,11,13,15,18,19,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,32,33,34,35,36,1,2,3,4,7,8,11,14,15,16,20,24,26,27,29,35,36,1,6,15,16,18,21,28,32,1,3,6,7,8,9,15,16,18,19,20,25,32,1,2,4,6,8,9,10,11,12,13,14,15,16,18,19,20,22,25,32,1,2,7,11,14,16,18,20,22,24,30,33,34,35,36,1,2,3,4,6,8,11,12,14,15,17,18,20,21,22,27,28,31,32,35,36,1,3,4,5,6,8,9,10,11,12,13,15,18,19,21,28,32,1,2,4,5,6,7,8,9,13,14,16,18,22,24,28,29,30,33,34,36,1,2,3,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,27,28,29,30,1,2,6,7,8,15,16,18,20,22,24,29,30,32,33,34,1,2,3,4,7,10,11,15,16,17,18,20,21,22,24,26,27,29,30,31,33,34,35,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,23,25,26,28,30,1,4,5,6,7,8,9,10,11,12,13,15,18,19,25,29,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,32,33,34,35,36,1,2,3,5,7,12,15,18,26,27,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,32,34,35,36,1,3,4,5,6,8,9,10,11,12,13,15,16,18,19,21,22,32,1,2,3,8,12,15,16,21,26,27,28,31,1,2,4,5,6,7,8,9,10,11,13,19,29,1,4,5,6,7,8,10,14,15,16,18,19,20,22,24,29,30,33,35,15,18,1,4,5,6,7,8,9,10,11,12,13,15,16,19,22,25,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,4,7,8,15,16,22,24,29,30,33,34,35,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,18,20,21,22,23,24,26,27,28,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,29,30,33,35,36,1,2,3,8,18,21,22,26,27,28,31,2,3,8,18,21,22,26,28,31,1,2,4,5,7,8,10,11,13,14,15,16,18,19,22,24,30,33,34,2,3,12,21,26,27,31,35,36,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,21,22,25,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,25,28,29,30,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,28,29,30,32,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,28,29,30,32,36,1,2,3,4,5,6,8,10,11,12,14,15,16,17,18,19,20,21,22,24,25,26,27,28,31,32,34,35,36,2,3,12,18,20,21,22,26,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,9,10,11,13,19,2,14,15,20,22,24,27,31,34,35,1,4,5,6,8,9,10,11,13,15,18,19,22,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,7,8,9,10,11,14,15,16,19,22,24,29,30,33,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,29,30,32,36,1,4,5,6,7,8,9,10,11,13,19,22,30,1,2,4,5,6,8,9,10,11,12,13,14,15,18,19,20,23,24,25,26,27,29,32,35,1,2,3,4,5,7,11,14,15,16,17,18,20,22,24,26,27,30,31,34,35,36,3,4,5,8,10,14,17,36,1,2,3,12,18,21,27,28,31,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,8,9,11,12,13,14,15,16,18,19,20,21,22,23,24,25,27,28,32,34,35,1,2,3,5,6,8,12,15,16,17,18,21,23,26,27,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,26,27,28,29,32,35,36,4,7,14,16,22,29,30,33,34,1,2,4,5,6,8,11,13,18,19,21,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,28,29,30,32,33,34,1,3,4,5,7,8,10,11,13,19,23,24,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,30,31,32,34,35,36,1,2,3,4,7,8,11,12,14,15,16,17,18,19,20,21,22,24,27,28,29,30,31,33,34,35,36,1,2,6,7,15,16,17,20,22,23,32,33,1,2,3,5,6,12,15,16,18,21,22,26,28,31,32,36,1,2,3,4,5,11,15,18,20,24,32,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,2,6,7,8,15,16,17,29,33,34,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,21,22,24,25,26,27,28,29,30,31,33,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,24,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,27,29,30,31,33,34,35,36,2,3,15,20,24,26,36,2,3,14,20,24,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,29,30,32,33,35,36,1,2,3,11,14,18,20,24,25,26,27,36,1,4,7,16,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,5,6,7,8,9,10,11,13,15,16,17,25,29,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,7,16,22,24,29,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,5,6,11,12,13,15,16,17,18,19,28,32,1,4,6,7,15,16,17,18,22,28,29,30,32,33,34,1,6,7,8,12,15,16,17,18,21,22,29,30,32,33,34,1,3,5,7,8,9,10,11,12,13,19,23,28,1,5,6,7,8,9,10,11,13,15,19,30,1,4,7,14,15,16,22,29,30,33,34,35,1,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,22,23,24,25,28,30,32,1,2,4,5,6,7,8,9,10,12,13,16,19,29,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,30,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,34,35,36,1,4,5,6,7,8,9,10,11,13,15,18,19,22,23,25,28,29,32,35,1,4,5,7,8,9,10,11,12,13,19,23,34,1,3,4,5,6,8,9,10,12,13,15,18,19,21,22,27,30,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,7,8,11,12,14,15,18,21,22,26,32,35,3,7,15,16,18,22,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,6,12,15,16,18,32,1,2,3,8,12,13,14,16,17,20,21,22,24,26,27,28,31,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,3,7,15,16,22,29,30,33,1,2,4,7,11,14,16,18,20,22,24,25,29,30,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,24,25,31,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,24,25,27,29,30,31,32,35,36,1,2,3,6,10,14,20,24,33,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,20,22,23,24,26,27,29,30,31,32,33,34,35,36,1,7,8,11,14,16,17,22,24,29,30,31,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,3,4,5,7,8,9,10,11,12,13,19,30,1,2,4,6,8,11,15,16,17,18,21,32,34,1,2,6,8,11,15,16,17,18,20,22,23,24,32,34,1,4,5,6,7,8,9,10,11,13,18,19,29,33,2,3,12,16,17,18,20,21,22,24,26,27,28,31,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,20,22,23,24,25,26,29,30,33,34,35,36,1,3,4,5,6,7,8,9,10,11,13,15,16,18,19,25,28,31,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,13,14,15,16,17,18,19,20,22,23,24,29,30,31,33,34,35,36,1,2,11,14,20,24,36,1,2,3,4,7,8,10,15,16,20,22,29,30,33,34,1,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,24,29,30,33,34,35,36,1,3,4,5,6,7,8,9,10,11,13,15,19,20,22,23,24,25,1,2,3,4,5,6,7,8,9,11,12,14,16,17,18,19,20,21,22,24,25,26,27,28,31,35,36,1,4,7,14,16,22,24,29,30,33,34,1,4,5,6,7,8,9,10,11,12,13,18,19,21,23,3,7,14,15,16,18,20,22,29,30,1,2,3,4,5,6,7,8,11,12,14,15,16,17,18,20,22,23,24,26,29,30,31,32,33,34,35,36,1,2,3,4,5,6,8,9,10,11,13,15,16,19,20,25,26,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,28,29,30,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,22,25,26,30,31,32,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,3,16,31,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,26,27,28,31,32,34,35,36,1,2,6,7,8,11,14,15,16,17,20,22,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,21,22,23,25,26,27,28,30,32,33,35,36,1,3,4,5,6,7,8,9,10,11,18,21,30,31,2,14,20,22,24,27,31,35,36,1,2,3,4,5,6,7,8,9,10,11,13,15,16,17,19,20,21,24,26,28,29,30,31,34,2,3,8,12,18,21,22,26,27,28,31,1,2,4,5,8,15,16,18,1,2,3,14,16,17,20,24,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,22,23,25,26,29,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,4,5,6,8,12,15,16,18,32,1,4,10,15,16,17,22,29,1,2,3,5,6,7,10,11,12,15,18,20,21,22,24,26,27,28,29,31,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,27,28,29,30,31,33,34,35,36,1,2,7,16,17,20,22,24,29,30,33,1,2,3,4,5,7,8,10,11,14,15,18,20,23,24,26,27,30,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,27,29,30,33,34,35,36,1,2,3,5,6,8,11,12,15,16,17,18,20,21,22,23,27,28,31,36,1,2,3,5,7,8,10,13,14,15,16,17,22,24,30,33,34,35,7,15,16,22,24,29,30,33,34,1,7,8,11,14,16,22,24,29,30,33,34,1,4,6,8,16,18,22,2,3,7,16,20,22,24,30,33,1,2,3,4,6,7,8,9,11,12,15,16,17,18,21,22,25,26,28,29,32,33,3,6,7,32,2,3,4,6,14,16,17,18,32,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,27,29,30,31,32,35,1,2,3,4,5,6,8,12,15,16,18,21,22,23,26,27,28,31,32,34,35,36,1,2,3,4,5,6,7,8,10,11,12,14,15,16,18,20,21,22,23,24,26,27,30,31,32,34,35,36,2,4,6,7,9,12,16,18,19,20,21,22,24,27,29,31,33,34,36,1,2,3,5,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,31,35,36,1,2,3,6,11,12,14,15,18,20,21,22,24,26,27,28,31,35,36,2,3,6,8,12,18,21,22,27,28,1,3,5,6,8,9,10,11,12,13,15,16,18,19,20,22,30,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,7,8,9,10,12,13,15,16,17,18,21,22,24,25,26,27,31,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,12,14,15,16,17,18,19,20,22,24,26,28,29,30,31,32,33,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,25,26,27,28,29,30,31,34,35,1,3,4,5,6,8,9,10,11,12,13,15,16,19,25,16,17,31,33,1,4,7,8,9,11,14,15,16,17,18,20,22,24,29,30,33,34,1,4,5,6,7,8,9,10,11,13,15,19,25,1,3,4,7,11,15,16,17,18,20,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,15,17,18,20,22,29,32,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,19,20,22,23,25,1,2,4,7,10,11,13,14,15,16,22,24,29,33,34,35,36,1,3,4,5,6,7,8,9,10,11,12,13,16,19,1,2,3,4,5,6,8,10,11,12,14,15,16,18,20,22,24,27,29,31,32,35,36,1,2,3,5,6,20,24,26,2,3,11,12,18,21,26,27,31,1,2,3,4,5,6,7,8,11,12,15,17,18,19,21,26,27,28,36,2,6,14,16,17,20,24,33,34,36,1,2,3,4,5,6,8,9,10,11,12,13,15,17,18,19,21,23,25,1,4,5,6,8,9,10,11,13,15,19,25,1,2,3,12,16,18,19,21,28,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,29,30,31,32,34,35,36,1,4,7,15,16,17,22,30,33,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,29,30,31,32,33,34,35,36,1,2,3,5,6,8,11,14,15,16,18,20,22,24,26,27,28,31,35,36,6,12,17,18,1,2,3,5,8,9,10,12,13,18,21,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,4,7,16,17,22,24,29,30,33,34,1,2,3,4,5,6,8,9,10,11,12,13,16,18,19,1,2,3,4,6,8,10,11,12,18,22,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,27,29,30,31,32,33,34,35,36,1,2,3,8,10,11,12,14,16,18,20,22,24,26,27,1,2,3,5,6,7,8,9,11,12,14,15,17,18,19,20,21,22,24,27,28,29,31,32,36,1,2,4,6,7,15,16,17,22,30,32,35,1,2,3,4,5,7,8,9,10,11,12,13,18,19,23,25,29,30,1,3,4,5,6,7,8,9,10,11,12,13,15,16,17,18,19,23,29,30,31,32,5,17,33,1,4,5,6,8,9,10,11,13,17,19,2,7,14,16,17,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,5,8,9,10,11,13,18,19,20,23,27,29,1,5,12,15,18,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,22,25,28,29,30,31,32,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,2,3,7,21,24,28,30,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,31,32,34,36,1,3,5,6,12,18,21,1,2,4,5,8,9,10,11,13,15,19,1,3,4,5,6,8,9,10,11,12,13,16,18,19,21,23,28,1,2,3,5,7,8,11,12,14,15,16,17,20,21,22,28,33,34,1,7,8,15,16,17,24,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,19,23,25,30,1,8,9,10,11,13,19,20,23,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,8,9,10,12,13,15,16,18,19,20,21,22,27,28,1,2,3,4,10,11,14,16,20,24,26,30,35,36,2,3,5,18,21,22,27,28,31,34,35,1,2,3,4,5,6,8,9,10,11,12,13,19,22,24,25,27,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,6,7,8,11,12,13,14,16,18,19,20,22,24,26,29,30,31,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,27,29,30,32,33,34,36,1,2,3,4,10,11,12,14,18,20,24,26,27,35,36,1,2,3,4,5,7,10,12,13,14,15,16,18,20,22,23,24,27,29,31,35,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,1,2,4,7,14,16,22,29,31,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,22,23,24,25,26,27,29,30,32,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,2,3,6,8,9,12,15,16,18,21,22,23,26,27,28,31,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,22,23,25,28,29,30,34,35,1,2,7,16,18,22,24,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,25,26,27,28,29,31,32,35,36,1,2,3,4,5,6,7,8,9,10,12,15,16,18,19,21,22,23,24,26,27,30,31,32,33,34,1,2,3,14,20,24,28,36,1,4,5,6,7,8,9,10,11,13,19,30,32,2,3,6,12,14,18,21,22,26,27,28,31,32,35,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,21,22,23,24,25,28,29,30,31,32,33,36,1,3,4,5,8,9,10,11,19,21,28,1,2,6,18,21,27,31,32,1,3,4,15,16,20,24,34,1,2,3,4,5,6,8,9,10,11,12,13,15,16,17,18,19,21,22,24,25,28,30,35,1,2,4,5,8,9,10,11,13,15,17,19,25,2,3,12,16,20,21,24,27,31,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,18,19,30,1,2,4,5,7,8,9,10,11,13,15,19,1,3,4,5,6,7,8,9,10,11,13,18,19,22,32,1,3,4,5,6,7,8,9,10,11,12,13,15,19,22,23,25,30,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,35,36,2,3,8,10,12,18,20,21,28,2,3,12,18,21,22,28,3,16,17,20,22,24,33,36,1,2,3,4,5,6,8,9,10,12,14,15,16,18,21,22,23,26,27,28,31,32,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,15,16,18,19,20,21,22,23,24,25,29,30,31,32,35,36,1,2,4,7,11,14,15,16,17,18,22,33,1,2,3,12,14,18,20,22,24,26,27,31,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,20,21,22,24,26,27,28,31,34,35,36,1,2,3,4,5,6,8,9,10,12,13,15,16,18,19,21,22,23,26,27,28,29,32,35,1,2,3,4,5,6,8,9,10,11,12,14,15,16,18,20,21,22,24,26,27,28,30,31,32,34,35,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,22,24,25,29,30,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,18,19,20,21,22,23,24,26,27,28,29,30,31,33,34,35,36,1,2,3,5,12,14,15,16,17,20,21,22,24,26,35,36,1,2,3,6,12,16,17,18,21,28,31,2,3,12,20,21,24,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,34,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,18,19,20,23,24,25,29,30,32,36,1,2,3,5,6,7,8,9,10,11,12,13,18,19,21,28,1,4,5,6,7,8,9,10,11,13,15,19,25,29,1,3,4,5,7,8,9,10,11,12,13,14,15,16,18,19,20,22,23,24,25,29,30,33,34,35,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,3,4,5,6,7,8,9,10,11,12,13,15,16,19,22,25,29,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,31,32,33,34,35,36,1,2,6,12,15,16,18,21,32,1,2,4,5,6,8,10,11,12,13,15,16,18,19,22,23,29,30,32,1,2,3,4,5,8,9,10,11,12,13,15,19,22,36,2,3,4,6,8,14,16,20,24,32,36,1,2,3,5,6,8,9,10,12,15,16,18,19,20,21,22,28,31,32,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28,29,30,31,33,34,35,36,1,4,5,6,8,9,10,11,13,19,25,1,4,5,7,8,9,11,16,19,22,29,30,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,33,34,35,36,1,2,4,5,6,7,8,9,10,11,13,18,19,25,1,3,4,5,6,8,9,10,11,12,13,17,19,25,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,13,14,15,16,17,18,19,20,21,22,23,24,25,26,28,29,30,31,32,33,34,35,36,1,2,3,4,5,7,8,9,10,11,12,13,14,15,16,18,19,20,21,22,23,24,26,27,28,29,30,31,32,33,34,35,36,16,33,34,1,2,3,7,8,12,15,16,18,21,26,27,28,29,31,36,1,2,3,5,6,7,8,11,15,16,18,22,24,29,30,33,34,1,4,7,15,16,22,24,29,30,33,34,1,2,3,4,5,7,8,9,11,12,14,15,16,17,18,20,22,24,25,26,27,29,30,31,32,33,34,35,36,1,2,3,12,15,18,21,26,27,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,24,27,28,29,30,31,32,35,1,2,3,4,5,6,8,9,11,12,13,14,19,20,21,24,28,36,2,4,12,14,15,16,17,18,21,24,31,33,1,2,3,7,8,11,12,13,14,16,18,20,22,24,30,33,36,1,2,3,4,5,6,7,8,9,10,11,13,14,16,18,19,20,22,24,25,29,30,33,1,3,4,5,6,8,9,13,15,18,22,32,1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,20,21,22,23,24,25,28,29,30,31,32,33,34,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,24,25,27,28,29,30,31,32,36,1,15,16,17,18,29,31,33,35,4,5,6,8,11,13,15,16,18,19,22,32,4,6,16,17,18,22,29,33,1,4,5,6,8,9,10,11,13,15,18,19,25,32,1,2,4,5,6,8,9,10,11,13,15,16,18,19,32,1,2,6,18,35,2,3,4,6,8,9,10,11,13,15,18,19,27,1,15,16,17,18,29,33,34,2,3,12,21,22,26,27,31,35,4,7,10,15,16,22,24,30,35,1,2,6,16,18,27,32,35,1,2,3,4,5,6,7,8,9,11,12,14,15,16,17,18,19,20,21,22,23,24,25,28,29,31,32,36,1,2,4,7,14,16,20,22,24,29,30,33,34],\"Freq\":[0.0897,0.0448,0.0448,0.0448,0.0448,0.0448,0.0897,0.0448,0.0448,0.0448,0.0448,0.0448,0.0448,0.0897,0.0448,0.0448,0.0547,0.0745,0.082,0.0273,0.0472,0.0199,0.0447,0.0199,0.0298,0.0273,0.0174,0.0721,0.0298,0.0149,0.0075,0.0124,0.0248,0.0174,0.0124,0.0099,0.0447,0.0124,0.0248,0.0099,0.0273,0.0472,0.0422,0.0323,0.0199,0.0124,0.0199,0.0124,0.005,0.0174,0.0124,0.0174,0.1265,0.0181,0.0181,0.0361,0.0723,0.0181,0.0181,0.1084,0.0361,0.0723,0.0723,0.0181,0.0542,0.0181,0.0181,0.0181,0.0542,0.0181,0.0542,0.0181,0.0542,0.0181,0.0181,0.0181,0.0187,0.206,0.0375,0.0187,0.0187,0.206,0.0187,0.206,0.0187,0.0936,0.0375,0.0724,0.0603,0.1508,0.0181,0.0362,0.0121,0.006,0.0302,0.0422,0.0302,0.0241,0.0965,0.0181,0.0241,0.0181,0.0121,0.0181,0.0241,0.0121,0.0844,0.0121,0.0121,0.0121,0.0362,0.0121,0.0241,0.0302,0.0121,0.006,0.006,0.0181,0.006,0.0181,0.0568,0.0213,0.0497,0.0568,0.0355,0.1491,0.0213,0.0284,0.0355,0.0213,0.0284,0.0284,0.0355,0.0071,0.0213,0.0213,0.0639,0.0284,0.0071,0.0213,0.0213,0.0284,0.0071,0.0284,0.0071,0.0213,0.0284,0.0213,0.0213,0.0355,0.0071,0.0355,0.0142,0.1334,0.1334,0.2667,0.1334,0.1334,0.0334,0.0668,0.0626,0.0375,0.0167,0.0459,0.0167,0.0292,0.0417,0.0209,0.0334,0.0501,0.0334,0.0334,0.0167,0.0167,0.0125,0.0334,0.0167,0.025,0.0209,0.0209,0.0083,0.0167,0.0167,0.0292,0.0417,0.0417,0.0125,0.0209,0.025,0.0292,0.0042,0.0125,0.0167,0.0375,0.095,0.0458,0.0634,0.0669,0.0317,0.0211,0.0282,0.0493,0.0458,0.0458,0.0458,0.0106,0.0387,0.0211,0.0176,0.007,0.0035,0.0106,0.0317,0.0317,0.0106,0.007,0.0774,0.0246,0.0317,0.0387,0.007,0.0176,0.0106,0.0106,0.0106,0.0106,0.0035,0.0035,0.0106,0.0282,0.0682,0.0818,0.0327,0.0409,0.03,0.0382,0.03,0.03,0.0273,0.03,0.0245,0.0273,0.0354,0.0273,0.0218,0.0191,0.0545,0.0164,0.0191,0.0136,0.0164,0.0109,0.0327,0.0136,0.0164,0.03,0.0218,0.0245,0.0191,0.0191,0.0409,0.0218,0.0109,0.0191,0.0109,0.0245,0.0232,0.2164,0.0386,0.0077,0.0077,0.0155,0.0155,0.0077,0.1932,0.0077,0.0077,0.1546,0.1237,0.0077,0.0077,0.0077,0.0155,0.0077,0.0464,0.0618,0.0254,0.2036,0.0254,0.0127,0.0254,0.1781,0.0127,0.0127,0.1654,0.1909,0.0127,0.0127,0.0382,0.0636,0.2416,0.0906,0.0302,0.0302,0.0302,0.0604,0.0604,0.0302,0.0302,0.0604,0.0604,0.0302,0.0906,0.0604,0.0302,0.0302,0.0302,0.1091,0.1091,0.2182,0.1091,0.1091,0.068,0.068,0.102,0.068,0.034,0.034,0.034,0.034,0.034,0.034,0.068,0.034,0.034,0.034,0.034,0.034,0.034,0.034,0.068,0.1187,0.1187,0.0594,0.0594,0.0594,0.0594,0.0594,0.0594,0.1781,0.0594,0.1132,0.0377,0.0377,0.0377,0.0755,0.0377,0.0755,0.0755,0.0377,0.1132,0.0377,0.0377,0.0755,0.0377,0.0377,0.1628,0.0102,0.0305,0.0509,0.061,0.0407,0.0305,0.0712,0.0509,0.061,0.0407,0.0102,0.0712,0.0102,0.0203,0.0102,0.0102,0.0102,0.0509,0.0203,0.0102,0.0814,0.0102,0.0203,0.0102,0.0203,0.0102,0.0102,0.068,0.0272,0.0408,0.0408,0.0136,0.0816,0.0272,0.0136,0.0136,0.0272,0.0408,0.0136,0.0544,0.0952,0.0408,0.0272,0.0408,0.0136,0.0544,0.0408,0.0136,0.0136,0.0272,0.068,0.0816,0.0136,0.0587,0.1174,0.0881,0.0587,0.0294,0.1174,0.0881,0.1174,0.0587,0.0881,0.0294,0.0294,0.0294,0.0294,0.0294,0.1731,0.0577,0.0577,0.1731,0.0577,0.0577,0.0577,0.0577,0.0577,0.0577,0.0577,0.0577,0.0577,0.1019,0.2038,0.1019,0.1019,0.0872,0.0363,0.0145,0.2325,0.0581,0.0291,0.0145,0.0727,0.0581,0.0872,0.0436,0.0581,0.0145,0.0291,0.0145,0.0073,0.0145,0.0291,0.0145,0.0145,0.0145,0.0145,0.0145,0.0073,0.0073,0.0145,0.0214,0.0428,0.428,0.0214,0.0214,0.0214,0.0214,0.0214,0.0214,0.1284,0.0856,0.0428,0.0642,0.0353,0.0353,0.0353,0.0706,0.0353,0.0353,0.0353,0.4236,0.0353,0.0353,0.0353,0.0353,0.0353,0.0834,0.1877,0.0417,0.0626,0.0209,0.1043,0.0626,0.1043,0.0417,0.0417,0.0209,0.0209,0.0626,0.0209,0.0209,0.0209,0.039,0.039,0.0741,0.0429,0.0351,0.0546,0.039,0.0273,0.0195,0.0117,0.0195,0.078,0.0117,0.0117,0.0312,0.0273,0.0273,0.0234,0.0195,0.0195,0.0273,0.0351,0.0273,0.0117,0.0195,0.0273,0.0468,0.0312,0.0156,0.0234,0.0195,0.0156,0.0117,0.0117,0.0156,0.0156,0.0424,0.048,0.0678,0.0282,0.0169,0.0565,0.048,0.0282,0.0198,0.0141,0.0282,0.0339,0.0198,0.0113,0.0141,0.0198,0.0311,0.0198,0.0169,0.0169,0.0452,0.0254,0.0141,0.0113,0.0282,0.0565,0.0424,0.0395,0.0254,0.0226,0.0198,0.0169,0.0198,0.0198,0.0198,0.0085,0.0302,0.0716,0.1018,0.0641,0.0565,0.0075,0.0226,0.0415,0.0339,0.0302,0.0226,0.0377,0.0302,0.0302,0.0377,0.0339,0.0452,0.0151,0.0188,0.0264,0.0226,0.0188,0.0113,0.0188,0.0075,0.0565,0.0226,0.0075,0.0038,0.0188,0.0038,0.0188,0.0151,0.0113,0.029,0.0724,0.0724,0.0097,0.0048,0.0193,0.0048,0.0097,0.0048,0.0097,0.0193,0.0193,0.0097,0.0628,0.0097,0.0869,0.1111,0.0241,0.0097,0.0579,0.0145,0.0097,0.029,0.0338,0.0097,0.0483,0.0193,0.0193,0.0097,0.0724,0.0193,0.0145,0.0193,0.0048,0.0338,0.083,0.0166,0.1162,0.083,0.1162,0.0166,0.1162,0.083,0.0996,0.0498,0.0166,0.0332,0.0166,0.0498,0.0332,0.0166,0.0166,0.0166,0.0166,0.0166,0.051,0.0781,0.0713,0.0306,0.0408,0.051,0.0272,0.0306,0.0306,0.0238,0.0272,0.0374,0.0272,0.0679,0.0306,0.0204,0.0102,0.0136,0.0238,0.0578,0.0102,0.017,0.017,0.0272,0.0204,0.0238,0.0204,0.0034,0.0136,0.0102,0.017,0.0068,0.0034,0.0068,0.0306,0.0238,0.0365,0.062,0.124,0.0073,0.0219,0.124,0.0073,0.0146,0.0073,0.0036,0.0073,0.0912,0.0036,0.0109,0.0219,0.0036,0.0036,0.1021,0.0109,0.0036,0.0401,0.0109,0.0146,0.0036,0.0219,0.0656,0.0182,0.0109,0.0036,0.0365,0.0693,0.0073,0.0292,0.0211,0.0317,0.0106,0.0106,0.0106,0.2536,0.0106,0.0106,0.0106,0.0317,0.0106,0.1057,0.0211,0.0106,0.0951,0.0211,0.0845,0.0634,0.0211,0.0845,0.0528,0.0106,0.0106,0.0149,0.1344,0.0747,0.0149,0.0149,0.0149,0.1195,0.0149,0.0149,0.1195,0.0149,0.0149,0.1046,0.0299,0.0149,0.0299,0.0149,0.2241,0.1112,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.0556,0.1112,0.0556,0.0556,0.0556,0.0353,0.2471,0.0353,0.0353,0.0353,0.0353,0.0353,0.1059,0.0706,0.0706,0.0353,0.0706,0.1928,0.2892,0.0964,0.0964,0.0964,0.0964,0.0789,0.0597,0.0481,0.0674,0.0655,0.0481,0.0212,0.0289,0.0193,0.0308,0.0308,0.0173,0.0385,0.0212,0.0154,0.0077,0.0077,0.027,0.0212,0.025,0.027,0.0116,0.0135,0.0116,0.025,0.0424,0.0385,0.0193,0.0116,0.0193,0.027,0.0135,0.0096,0.0058,0.0289,0.0135,0.0358,0.0537,0.0447,0.0358,0.0358,0.1342,0.0268,0.0179,0.0089,0.0089,0.0179,0.0089,0.0179,0.0358,0.0268,0.0179,0.0179,0.0805,0.0089,0.0358,0.0089,0.0179,0.0179,0.0179,0.0179,0.0358,0.0179,0.0089,0.0089,0.0626,0.0179,0.0358,0.0089,0.0281,0.0732,0.0544,0.0413,0.0394,0.0188,0.0919,0.03,0.0188,0.015,0.0263,0.0319,0.0169,0.03,0.0263,0.0356,0.0244,0.015,0.015,0.0225,0.0244,0.0375,0.0131,0.015,0.015,0.0263,0.0131,0.0263,0.0244,0.0225,0.0131,0.0169,0.0356,0.0394,0.015,0.0056,0.0768,0.0512,0.041,0.0307,0.0563,0.0051,0.0102,0.0512,0.0256,0.0461,0.0615,0.0205,0.0359,0.0154,0.0051,0.0102,0.0615,0.0154,0.0256,0.0102,0.0307,0.0102,0.0871,0.0051,0.0256,0.0154,0.0051,0.0871,0.0051,0.0563,0.0051,0.0051,0.1781,0.0445,0.0445,0.0891,0.0445,0.0891,0.0891,0.0891,0.0891,0.0445,0.0445,0.0445,0.0445,0.0695,0.0556,0.0765,0.0487,0.0556,0.007,0.0139,0.0487,0.0417,0.0348,0.0417,0.0209,0.0348,0.007,0.0139,0.007,0.0556,0.0139,0.0278,0.0139,0.0278,0.0139,0.0487,0.0139,0.0417,0.0278,0.0139,0.007,0.0139,0.0139,0.0556,0.007,0.007,0.0139,0.007,0.0338,0.0788,0.0428,0.063,0.0315,0.0203,0.0338,0.036,0.0315,0.0225,0.0293,0.0203,0.027,0.045,0.018,0.036,0.036,0.0113,0.0158,0.0338,0.0203,0.0113,0.0158,0.0293,0.0158,0.0135,0.0248,0.0405,0.0113,0.0158,0.0315,0.0068,0.018,0.0203,0.0248,0.0293,0.0252,0.0755,0.4025,0.1006,0.0503,0.0755,0.0503,0.0503,0.0503,0.0503,0.1034,0.1034,0.0207,0.0414,0.0621,0.0207,0.0207,0.0621,0.0414,0.0621,0.0414,0.0207,0.0621,0.0207,0.0207,0.0414,0.0414,0.0621,0.0207,0.0207,0.0207,0.0207,0.1114,0.1114,0.0446,0.0446,0.0223,0.0223,0.0223,0.0223,0.0446,0.0223,0.0891,0.0446,0.0223,0.0223,0.0223,0.0446,0.0891,0.0668,0.0223,0.0223,0.0223,0.0223,0.1634,0.0233,0.0233,0.0233,0.0467,0.0467,0.0233,0.0467,0.0467,0.0233,0.0467,0.0233,0.0467,0.0467,0.0233,0.0467,0.07,0.0233,0.0233,0.0467,0.0467,0.0233,0.0233,0.0233,0.0233,0.0688,0.0688,0.0688,0.0688,0.2064,0.0688,0.0688,0.0688,0.0688,0.0688,0.0934,0.0259,0.0259,0.0674,0.0778,0.0623,0.0259,0.0674,0.0674,0.0519,0.0519,0.0104,0.0726,0.0208,0.0104,0.0208,0.0156,0.0363,0.0052,0.0156,0.0104,0.0259,0.0052,0.0674,0.0104,0.0052,0.0104,0.0052,0.0208,0.0971,0.0243,0.0486,0.0728,0.0486,0.0243,0.0971,0.0486,0.0728,0.0971,0.0243,0.0486,0.0243,0.0243,0.0728,0.0243,0.0243,0.0243,0.0243,0.0399,0.0699,0.0879,0.0479,0.0359,0.028,0.0319,0.024,0.0419,0.028,0.026,0.0439,0.024,0.024,0.022,0.02,0.026,0.01,0.02,0.0299,0.0459,0.01,0.008,0.012,0.018,0.0379,0.0379,0.026,0.012,0.014,0.026,0.006,0.006,0.018,0.014,0.026,0.1169,0.039,0.039,0.0195,0.0195,0.0195,0.0585,0.0195,0.0585,0.0779,0.0195,0.039,0.039,0.0195,0.0195,0.0195,0.0585,0.0195,0.0195,0.1364,0.0195,0.0195,0.0195,0.0195,0.0195,0.039,0.0455,0.0455,0.0455,0.091,0.0455,0.4096,0.091,0.0455,0.0455,0.0455,0.0406,0.2032,0.0609,0.0203,0.0203,0.0203,0.0203,0.0406,0.0813,0.0203,0.0203,0.1219,0.0203,0.0609,0.0406,0.0813,0.0203,0.0203,0.0406,0.0406,0.0932,0.0466,0.1398,0.0466,0.0466,0.0932,0.0932,0.0932,0.0466,0.0466,0.0466,0.0466,0.0442,0.0884,0.2356,0.0147,0.0147,0.0147,0.0147,0.0442,0.0147,0.0147,0.0295,0.0884,0.0147,0.0295,0.0147,0.0736,0.0884,0.0295,0.0147,0.0589,0.0147,0.0442,0.0665,0.0332,0.0332,0.1329,0.0332,0.0997,0.0665,0.0332,0.0665,0.0665,0.0665,0.0332,0.0332,0.0332,0.0332,0.0332,0.0332,0.0967,0.0495,0.0517,0.0764,0.0697,0.0225,0.018,0.054,0.0472,0.054,0.0427,0.0202,0.054,0.018,0.036,0.0135,0.027,0.0112,0.0315,0.0157,0.0157,0.009,0.027,0.0112,0.0315,0.0067,0.018,0.0022,0.0157,0.0067,0.0135,0.0112,0.0022,0.0067,0.018,0.0474,0.0474,0.0948,0.0474,0.0948,0.0948,0.0474,0.0474,0.0474,0.0474,0.0948,0.0948,0.0902,0.0602,0.0301,0.0902,0.0301,0.0602,0.0301,0.0301,0.0301,0.0301,0.0602,0.0301,0.1203,0.0301,0.0301,0.2106,0.0283,0.1074,0.0678,0.017,0.0509,0.0339,0.0113,0.0339,0.017,0.0113,0.0283,0.0283,0.0283,0.0226,0.0622,0.017,0.0904,0.017,0.017,0.017,0.0226,0.0113,0.0057,0.017,0.0735,0.0339,0.017,0.0057,0.0226,0.0283,0.0057,0.0113,0.0113,0.0113,0.0226,0.0872,0.0581,0.0581,0.0581,0.0872,0.0872,0.0581,0.0872,0.0872,0.0291,0.0872,0.1453,0.0937,0.6556,0.0468,0.0468,0.021,0.021,0.0839,0.5667,0.021,0.021,0.021,0.021,0.021,0.0839,0.042,0.021,0.0955,0.0955,0.0955,0.0955,0.0955,0.1911,0.0607,0.0236,0.0236,0.0573,0.0674,0.0371,0.027,0.064,0.0404,0.0371,0.0573,0.0034,0.0505,0.0135,0.0371,0.0168,0.0034,0.0202,0.0371,0.0067,0.0067,0.0303,0.0573,0.0067,0.0505,0.0034,0.0539,0.0202,0.0236,0.0135,0.0101,0.0101,0.0135,0.0034,0.0135,0.1064,0.0532,0.0532,0.0532,0.0532,0.0532,0.0532,0.0532,0.0532,0.1064,0.0532,0.0532,0.0532,0.0927,0.0927,0.0927,0.0927,0.0927,0.0927,0.0927,0.0927,0.0927,0.0927,0.0755,0.0755,0.0755,0.0755,0.1509,0.0755,0.2264,0.0561,0.0561,0.1121,0.0561,0.1121,0.0561,0.0561,0.1121,0.0561,0.0561,0.0561,0.0561,0.0429,0.0429,0.0644,0.0215,0.0429,0.0215,0.0429,0.0215,0.0215,0.0215,0.0215,0.0429,0.0215,0.1718,0.0644,0.0215,0.0429,0.0215,0.0215,0.0215,0.0429,0.0215,0.0215,0.0215,0.0429,0.0215,0.0215,0.0215,0.039,0.0586,0.039,0.039,0.039,0.0586,0.0195,0.0195,0.0195,0.039,0.1757,0.039,0.0195,0.0195,0.039,0.0195,0.0195,0.039,0.0195,0.039,0.0195,0.0195,0.1171,0.039,0.0699,0.0349,0.1048,0.0349,0.0349,0.0349,0.0349,0.0349,0.0699,0.0349,0.0349,0.0349,0.0349,0.0349,0.0699,0.0349,0.0699,0.0699,0.0349,0.0171,0.1713,0.0171,0.0171,0.0171,0.0171,0.0171,0.3084,0.0171,0.0171,0.1713,0.1028,0.0171,0.0171,0.0171,0.0514,0.0409,0.129,0.0598,0.0189,0.0063,0.0063,0.022,0.0063,0.0031,0.0063,0.0157,0.0031,0.1636,0.0157,0.0126,0.0157,0.0063,0.0063,0.1762,0.0031,0.0126,0.0063,0.0755,0.0252,0.0063,0.0094,0.0094,0.0157,0.0126,0.0063,0.0094,0.0378,0.0629,0.036,0.0648,0.0696,0.0456,0.0216,0.0288,0.0696,0.036,0.024,0.0264,0.0384,0.0384,0.0264,0.0264,0.036,0.0288,0.0336,0.0096,0.0216,0.012,0.012,0.0336,0.0216,0.012,0.0168,0.0192,0.0096,0.012,0.0192,0.0312,0.024,0.0048,0.0288,0.0288,0.0192,0.0096,0.0392,0.1568,0.0196,0.0196,0.0196,0.0196,0.0196,0.0196,0.0196,0.0392,0.0196,0.2156,0.0196,0.0196,0.1372,0.0196,0.098,0.0196,0.0196,0.0588,0.0528,0.2111,0.0792,0.0264,0.1319,0.0792,0.2111,0.0792,0.0792,0.0528,0.0337,0.0169,0.0506,0.0169,0.0337,0.2361,0.0169,0.0169,0.0169,0.0337,0.0675,0.1012,0.1181,0.0169,0.0169,0.0506,0.0506,0.0506,0.0337,0.0169,0.0992,0.0142,0.0142,0.0425,0.0142,0.0284,0.0425,0.0425,0.0284,0.0142,0.0284,0.0425,0.0425,0.0284,0.2268,0.0142,0.0142,0.0142,0.0142,0.0425,0.0142,0.0142,0.0142,0.0142,0.0709,0.0142,0.0284,0.0435,0.0725,0.2322,0.058,0.0435,0.0145,0.029,0.0145,0.029,0.0145,0.029,0.0145,0.0145,0.0145,0.0145,0.0145,0.0435,0.0145,0.0145,0.0145,0.058,0.058,0.0145,0.0145,0.0145,0.0435,0.0145,0.0145,0.0435,0.0839,0.0229,0.0458,0.0153,0.2364,0.0381,0.0229,0.0305,0.0153,0.0153,0.0153,0.0076,0.0153,0.0534,0.0153,0.0763,0.0153,0.0153,0.0229,0.0229,0.0076,0.0076,0.0305,0.0305,0.0076,0.0076,0.0153,0.0991,0.0076,0.1195,0.0597,0.1195,0.0597,0.0597,0.1195,0.1195,0.239,0.1333,0.1333,0.2666,0.1333,0.1333,0.0672,0.2015,0.0672,0.1343,0.0672,0.1343,0.0672,0.0672,0.0672,0.1603,0.0534,0.0534,0.0534,0.1069,0.0534,0.0534,0.0534,0.0534,0.0534,0.0534,0.0534,0.0159,0.0583,0.0424,0.0265,0.0053,0.0583,0.0212,0.0159,0.0106,0.0159,0.0159,0.0053,0.0689,0.0371,0.1483,0.0371,0.0053,0.0583,0.0424,0.0053,0.0265,0.0053,0.0212,0.0212,0.0265,0.0265,0.0212,0.0371,0.0477,0.0265,0.0265,0.0293,0.0293,0.0293,0.0293,0.1173,0.0293,0.0587,0.1173,0.0587,0.0587,0.0587,0.0587,0.088,0.0293,0.0293,0.0587,0.088,0.0293,0.0437,0.1747,0.0437,0.0437,0.0437,0.0437,0.0437,0.131,0.131,0.0437,0.131,0.0437,0.0468,0.0766,0.0723,0.0213,0.0255,0.0085,0.0425,0.0255,0.017,0.017,0.0255,0.0553,0.0128,0.034,0.0553,0.0255,0.0383,0.017,0.0085,0.0298,0.0255,0.0213,0.017,0.0255,0.017,0.017,0.0213,0.0128,0.0213,0.034,0.0213,0.0085,0.0085,0.0128,0.0468,0.0255,0.061,0.0442,0.0547,0.0505,0.0253,0.0484,0.08,0.0316,0.0316,0.0126,0.021,0.0526,0.0232,0.0084,0.0337,0.0316,0.0295,0.0189,0.0168,0.0063,0.0337,0.0274,0.0105,0.0063,0.0253,0.0189,0.0253,0.0147,0.0295,0.0232,0.0147,0.0126,0.0274,0.0147,0.0189,0.0126,0.0664,0.0111,0.0221,0.0885,0.0664,0.0221,0.0443,0.0553,0.0553,0.0443,0.0221,0.0332,0.0332,0.0221,0.0553,0.0221,0.0332,0.1217,0.0221,0.0111,0.0111,0.0111,0.0111,0.0111,0.0111,0.0332,0.0111,0.0111,0.0221,0.0378,0.0866,0.0567,0.041,0.0473,0.0331,0.0567,0.0252,0.0331,0.0173,0.0236,0.0284,0.0221,0.0331,0.0236,0.0221,0.0221,0.0126,0.0158,0.0299,0.0299,0.0142,0.0047,0.0236,0.0158,0.0378,0.0299,0.0142,0.0252,0.0173,0.0331,0.0095,0.0173,0.0221,0.0268,0.0126,0.0459,0.0753,0.0426,0.0262,0.0164,0.0622,0.0262,0.0197,0.0197,0.0131,0.0131,0.0262,0.0098,0.0688,0.0164,0.0131,0.036,0.0688,0.0066,0.0459,0.0295,0.0197,0.0098,0.0262,0.0098,0.0164,0.0229,0.0131,0.0197,0.0164,0.0164,0.0328,0.0131,0.0131,0.0524,0.0295,0.0606,0.0555,0.0505,0.0555,0.0555,0.0303,0.005,0.0353,0.0404,0.0404,0.0353,0.0252,0.0404,0.0303,0.0202,0.0101,0.0202,0.0202,0.0202,0.0202,0.0151,0.0454,0.0202,0.0151,0.0757,0.0303,0.0151,0.0101,0.0202,0.0252,0.0505,0.0101,0.1155,0.0578,0.0578,0.0578,0.2311,0.0578,0.0578,0.0578,0.0578,0.1155,0.0896,0.0077,0.0026,0.128,0.1024,0.0282,0.0051,0.087,0.0947,0.1357,0.0768,0.0026,0.0742,0.0051,0.0077,0.0051,0.0026,0.0026,0.0486,0.0026,0.0026,0.0256,0.0026,0.0384,0.0051,0.0077,0.0026,0.0026,0.0026,0.0026,0.3096,0.1126,0.0281,0.0281,0.0281,0.0563,0.0844,0.0563,0.0563,0.0844,0.0281,0.0281,0.0632,0.0505,0.0505,0.0126,0.0253,0.0126,0.0632,0.0126,0.0126,0.0126,0.0126,0.0379,0.0253,0.0253,0.0253,0.0253,0.1642,0.0126,0.0253,0.0379,0.0379,0.0253,0.0126,0.0126,0.0126,0.0126,0.0379,0.0379,0.0126,0.0253,0.0126,0.0126,0.0126,0.0126,0.1007,0.0504,0.0504,0.0504,0.0504,0.1007,0.0504,0.0504,0.0504,0.0504,0.0504,0.0504,0.0504,0.0504,0.0221,0.011,0.0221,0.0772,0.011,0.0331,0.0772,0.011,0.0331,0.011,0.0331,0.011,0.011,0.1986,0.0441,0.0331,0.0331,0.011,0.011,0.011,0.0331,0.0221,0.011,0.011,0.0331,0.0331,0.0221,0.0221,0.011,0.0221,0.0331,0.0221,0.011,0.0221,0.1328,0.1328,0.2656,0.0348,0.0522,0.1916,0.0174,0.0522,0.0174,0.0174,0.0174,0.0697,0.0522,0.0174,0.0697,0.0522,0.0174,0.0174,0.0348,0.0348,0.0522,0.0348,0.1045,0.0174,0.025,0.2086,0.1001,0.0083,0.0167,0.0083,0.0167,0.0083,0.0083,0.025,0.0334,0.0083,0.0918,0.0167,0.0167,0.0083,0.0167,0.0083,0.0501,0.025,0.0083,0.0083,0.0417,0.0083,0.0334,0.0584,0.025,0.0083,0.0083,0.0083,0.0083,0.0083,0.0501,0.0334,0.1029,0.1029,0.1029,0.1029,0.1029,0.1029,0.1029,0.0582,0.0317,0.0317,0.0582,0.0529,0.0317,0.0687,0.0317,0.0212,0.0264,0.0317,0.0212,0.0264,0.0212,0.0317,0.0952,0.0212,0.0159,0.0212,0.0159,0.0053,0.0423,0.0423,0.0053,0.0106,0.0106,0.0106,0.0159,0.0212,0.0106,0.0264,0.0317,0.0264,0.0212,0.0159,0.0284,0.0569,0.0284,0.0284,0.1707,0.0284,0.0284,0.0284,0.0284,0.0569,0.0284,0.0284,0.0284,0.1138,0.0569,0.1138,0.0569,0.0853,0.0569,0.043,0.043,0.043,0.086,0.086,0.043,0.129,0.086,0.129,0.043,0.043,0.043,0.043,0.043,0.0862,0.0545,0.0908,0.0363,0.0545,0.0454,0.0182,0.0363,0.0363,0.0272,0.0318,0.0182,0.0318,0.0091,0.0681,0.0091,0.0091,0.0227,0.0318,0.0182,0.0136,0.0091,0.059,0.0136,0.0408,0.0091,0.0091,0.0136,0.0045,0.0227,0.0227,0.0091,0.0227,0.0182,0.1053,0.0207,0.0132,0.109,0.0714,0.0338,0.015,0.0526,0.0658,0.062,0.0489,0.0207,0.0508,0.015,0.015,0.0113,0.0508,0.0075,0.0432,0.0188,0.0056,0.0075,0.0301,0.0094,0.0526,0.0019,0.0094,0.0056,0.0056,0.0019,0.0038,0.0132,0.0188,0.0019,0.0993,0.0565,0.0359,0.0359,0.0274,0.0154,0.0154,0.0291,0.0359,0.0308,0.0394,0.0103,0.0308,0.0736,0.012,0.024,0.0736,0.0086,0.0308,0.0582,0.0068,0.0103,0.0411,0.0291,0.0342,0.0103,0.0017,0.0034,0.012,0.0154,0.0137,0.0086,0.0086,0.0137,0.0274,0.0205,0.1309,0.2618,0.1047,0.0262,0.0524,0.1047,0.0262,0.0524,0.0524,0.0524,0.0262,0.0514,0.1027,0.0514,0.0514,0.2055,0.0514,0.0514,0.0514,0.0514,0.1027,0.0514,0.0637,0.0119,0.004,0.2229,0.1035,0.0597,0.0119,0.0796,0.0876,0.0836,0.0478,0.0517,0.008,0.0279,0.004,0.004,0.008,0.0318,0.004,0.0119,0.008,0.008,0.0199,0.004,0.008,0.004,0.004,0.008,0.004,0.0627,0.1881,0.0627,0.0627,0.1254,0.1254,0.0627,0.0627,0.0791,0.0509,0.0226,0.1187,0.0961,0.1469,0.0113,0.0452,0.0452,0.0396,0.0339,0.0057,0.0622,0.0452,0.0057,0.0057,0.0113,0.0283,0.0283,0.0057,0.0113,0.0226,0.017,0.0113,0.0113,0.0057,0.0057,0.017,0.0113,0.0057,0.0394,0.056,0.1202,0.0539,0.0415,0.0829,0.0104,0.0332,0.0187,0.0311,0.0228,0.0456,0.0187,0.0166,0.0166,0.0124,0.0124,0.0705,0.0187,0.0104,0.0539,0.0083,0.0021,0.0041,0.0083,0.029,0.027,0.0332,0.0021,0.0083,0.0207,0.0435,0.0021,0.0041,0.0104,0.0104,0.0529,0.1006,0.143,0.0424,0.0265,0.0265,0.0106,0.0106,0.0265,0.0053,0.0053,0.0582,0.0159,0.0106,0.0371,0.0106,0.0053,0.0635,0.0053,0.0053,0.0318,0.0106,0.0106,0.0159,0.0106,0.0794,0.0318,0.0053,0.0053,0.0159,0.0635,0.0053,0.0424,0.0053,0.1386,0.032,0.0107,0.1386,0.064,0.0426,0.0853,0.0853,0.1173,0.0746,0.0533,0.0107,0.064,0.0107,0.0107,0.0107,0.0107,0.0107,0.0961,0.048,0.0961,0.0961,0.048,0.048,0.048,0.048,0.048,0.048,0.048,0.048,0.1441,0.048,0.048,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0535,0.0605,0.0327,0.0327,0.0491,0.0343,0.067,0.0752,0.018,0.0229,0.0278,0.018,0.0229,0.018,0.0474,0.0425,0.0441,0.0311,0.018,0.0164,0.0278,0.0082,0.0229,0.0098,0.0164,0.0164,0.0164,0.0049,0.0164,0.0229,0.0278,0.0196,0.0196,0.0278,0.0262,0.0131,0.0229,0.0509,0.1018,0.2037,0.0255,0.0255,0.0255,0.0255,0.1782,0.0509,0.0255,0.0255,0.0255,0.0509,0.0255,0.0509,0.0509,0.0255,0.0544,0.0262,0.0181,0.1229,0.0927,0.0242,0.0161,0.1168,0.0866,0.0725,0.0584,0.0141,0.0604,0.0081,0.0081,0.0121,0.0101,0.0383,0.004,0.006,0.006,0.0181,0.002,0.0483,0.0101,0.0081,0.0141,0.002,0.0101,0.0121,0.0161,0.002,0.0241,0.0241,0.0722,0.1203,0.0241,0.0481,0.0962,0.0962,0.0481,0.0481,0.0241,0.0481,0.0241,0.0241,0.0241,0.0481,0.0241,0.0241,0.0241,0.0241,0.0241,0.0241,0.0405,0.0946,0.1081,0.0135,0.0135,0.0135,0.027,0.0135,0.0135,0.0135,0.0946,0.0135,0.027,0.0135,0.027,0.027,0.0676,0.027,0.0135,0.0676,0.0946,0.0135,0.0135,0.0135,0.054,0.0135,0.0135,0.0135,0.0135,0.0171,0.0171,0.0171,0.2393,0.0171,0.0171,0.0342,0.0342,0.0513,0.0171,0.0171,0.0171,0.1026,0.0342,0.0171,0.0684,0.0684,0.0171,0.1026,0.0684,0.0171,0.0294,0.0294,0.0294,0.1766,0.0294,0.0294,0.0294,0.0589,0.0294,0.0294,0.0294,0.0294,0.0294,0.0589,0.0294,0.0589,0.1177,0.0883,0.0294,0.0798,0.0479,0.0798,0.0638,0.0479,0.0319,0.0479,0.0479,0.0638,0.0319,0.0558,0.008,0.0558,0.0239,0.008,0.008,0.0239,0.0319,0.008,0.016,0.016,0.0319,0.008,0.0558,0.008,0.008,0.016,0.016,0.016,0.008,0.016,0.016,0.0316,0.1027,0.0316,0.0316,0.0316,0.0632,0.0237,0.0158,0.0237,0.0316,0.0079,0.079,0.0237,0.0395,0.079,0.0079,0.0079,0.0632,0.0158,0.0237,0.0079,0.0711,0.0079,0.0079,0.0237,0.0158,0.0079,0.0237,0.0316,0.0237,0.0474,0.1049,0.1049,0.2097,0.1049,0.1049,0.1049,0.122,0.122,0.122,0.122,0.122,0.1198,0.0117,0.0467,0.0467,0.0351,0.0321,0.0205,0.0351,0.0234,0.0263,0.0263,0.0263,0.0292,0.0117,0.0234,0.0117,0.076,0.0263,0.0292,0.0058,0.0205,0.0058,0.0672,0.0058,0.0438,0.0146,0.0088,0.0263,0.0146,0.0175,0.0409,0.0321,0.0088,0.0088,0.0146,0.0481,0.1603,0.0481,0.016,0.016,0.016,0.2083,0.016,0.016,0.016,0.2083,0.0801,0.016,0.0321,0.0321,0.0321,0.0459,0.0388,0.0423,0.06,0.0423,0.0317,0.0988,0.0247,0.0282,0.0212,0.0212,0.0282,0.0282,0.0106,0.0106,0.0106,0.0282,0.0176,0.0141,0.0035,0.0282,0.0494,0.0035,0.0141,0.0317,0.0282,0.0141,0.0247,0.0317,0.0353,0.0212,0.0071,0.0529,0.0212,0.0247,0.0071,0.0395,0.1447,0.0395,0.0132,0.0132,0.0132,0.0263,0.171,0.0132,0.0132,0.0395,0.1973,0.0132,0.1052,0.0263,0.0132,0.0395,0.0526,0.0544,0.0181,0.0227,0.0998,0.0907,0.0227,0.0136,0.0771,0.059,0.0499,0.0499,0.0227,0.0499,0.0136,0.0181,0.0091,0.0544,0.0363,0.0363,0.0045,0.0045,0.0045,0.0272,0.0045,0.0499,0.0181,0.0045,0.0045,0.0045,0.0136,0.0272,0.0136,0.0045,0.0091,0.1136,0.0568,0.0568,0.0568,0.0568,0.0568,0.1136,0.0568,0.0568,0.0568,0.0568,0.1136,0.0225,0.0075,0.0075,0.015,0.0075,0.0075,0.0901,0.0075,0.0075,0.0075,0.0676,0.1728,0.2253,0.0075,0.015,0.0451,0.0075,0.015,0.0376,0.0225,0.0451,0.0526,0.0826,0.015,0.0119,0.1909,0.0119,0.0119,0.0119,0.0239,0.1313,0.1671,0.0358,0.0239,0.0835,0.0597,0.0119,0.0955,0.0835,0.0119,0.0277,0.0194,0.0139,0.061,0.0416,0.0222,0.1219,0.0305,0.0416,0.0333,0.0249,0.0249,0.0139,0.036,0.0637,0.0582,0.0471,0.0055,0.0194,0.0166,0.0083,0.0416,0.0028,0.0139,0.0194,0.0028,0.0388,0.0249,0.0194,0.0111,0.0416,0.0277,0.0111,0.0083,0.0859,0.0045,0.2079,0.113,0.0768,0.009,0.0949,0.0859,0.1085,0.0542,0.0588,0.0045,0.0045,0.0045,0.0045,0.0362,0.0045,0.0045,0.0136,0.0045,0.009,0.0045,0.0235,0.188,0.1175,0.0235,0.0235,0.0235,0.0235,0.0235,0.047,0.047,0.0235,0.0235,0.0235,0.0235,0.047,0.0235,0.0235,0.094,0.0235,0.0235,0.0235,0.0235,0.0235,0.0235,0.0641,0.0236,0.0607,0.0607,0.0236,0.0101,0.0506,0.0506,0.0202,0.0337,0.0304,0.0337,0.0202,0.0169,0.0337,0.0169,0.0877,0.0202,0.0202,0.0101,0.0101,0.0169,0.0675,0.0067,0.0135,0.0169,0.0034,0.0236,0.0135,0.0236,0.0472,0.027,0.0169,0.0034,0.0034,0.0202,0.1006,0.0237,0.0118,0.0532,0.0473,0.0177,0.0059,0.0591,0.0473,0.071,0.1538,0.0828,0.0414,0.0118,0.0059,0.0059,0.0059,0.0651,0.0296,0.0059,0.0473,0.0177,0.0355,0.0059,0.0059,0.0059,0.0118,0.0118,0.3988,0.0399,0.0399,0.1196,0.0399,0.1196,0.0798,0.0798,0.0399,0.0166,0.133,0.1828,0.0166,0.0166,0.0166,0.0166,0.0166,0.0665,0.0166,0.0997,0.0166,0.0166,0.0831,0.0332,0.0499,0.0332,0.0166,0.0499,0.0831,0.0492,0.0492,0.0492,0.0983,0.0492,0.0492,0.295,0.1475,0.0492,0.0492,0.0492,0.0492,0.0492,0.1629,0.0233,0.0465,0.0233,0.1629,0.0465,0.0233,0.0233,0.0233,0.0233,0.0465,0.0233,0.0698,0.0233,0.0698,0.0233,0.0233,0.0233,0.0698,0.0424,0.0424,0.1271,0.0847,0.1271,0.0424,0.0424,0.1271,0.0847,0.0847,0.0424,0.0424,0.0424,0.028,0.0505,0.0561,0.0729,0.1065,0.0224,0.0449,0.0617,0.0617,0.0505,0.0617,0.028,0.0561,0.0224,0.0168,0.0112,0.0056,0.028,0.0224,0.0056,0.0112,0.0168,0.0392,0.0392,0.0224,0.0056,0.0112,0.0056,0.0168,0.0112,0.0056,0.1194,0.1194,0.0597,0.0597,0.1194,0.0597,0.0597,0.1194,0.0597,0.0597,0.0597,0.0379,0.3974,0.0379,0.0189,0.0189,0.0189,0.1325,0.0189,0.0757,0.0946,0.0379,0.0568,0.0189,0.0884,0.0442,0.0884,0.0442,0.0442,0.0884,0.0884,0.0884,0.0442,0.0442,0.0442,0.0884,0.0884,0.0442,0.0442,0.16,0.064,0.064,0.064,0.064,0.032,0.032,0.032,0.032,0.032,0.032,0.032,0.032,0.032,0.064,0.032,0.032,0.032,0.032,0.1609,0.0357,0.0179,0.0179,0.0179,0.0179,0.0179,0.0536,0.0357,0.0715,0.0894,0.0179,0.0536,0.0179,0.0357,0.0179,0.0179,0.0179,0.0715,0.0179,0.0179,0.0894,0.0357,0.0179,0.0357,0.0179,0.0583,0.0339,0.0339,0.0715,0.0752,0.032,0.0282,0.047,0.0451,0.0433,0.047,0.0188,0.0527,0.0301,0.0376,0.0244,0.0545,0.0188,0.0301,0.0113,0.015,0.015,0.032,0.0075,0.032,0.0169,0.0132,0.0056,0.0169,0.0169,0.0075,0.0094,0.0132,0.0075,0.1269,0.1269,0.0634,0.0634,0.1269,0.1269,0.0634,0.0634,0.0634,0.0634,0.0551,0.0551,0.1101,0.0551,0.0551,0.0551,0.1101,0.0551,0.0551,0.0551,0.0551,0.0551,0.088,0.1761,0.1761,0.088,0.088,0.088,0.088,0.0234,0.1171,0.0234,0.164,0.0234,0.164,0.0234,0.0937,0.0234,0.0937,0.0469,0.0234,0.0469,0.0469,0.0234,0.0234,0.0403,0.043,0.0457,0.0484,0.0269,0.0484,0.0242,0.0242,0.0403,0.0296,0.0161,0.043,0.0188,0.0349,0.0376,0.0296,0.0457,0.0376,0.0134,0.0296,0.0242,0.0296,0.0134,0.0161,0.0215,0.0161,0.0081,0.0376,0.0322,0.0161,0.0322,0.0134,0.0054,0.0269,0.0161,0.0188,0.0257,0.1287,0.0257,0.0257,0.0257,0.0257,0.0257,0.0257,0.0257,0.0257,0.1802,0.0257,0.0257,0.1287,0.0257,0.0257,0.0772,0.0257,0.0257,0.0257,0.0583,0.0146,0.0146,0.0364,0.0146,0.0364,0.2041,0.0146,0.0146,0.0364,0.0073,0.0073,0.0219,0.0948,0.051,0.0146,0.0437,0.0073,0.051,0.0146,0.0219,0.0073,0.0437,0.0437,0.0073,0.0073,0.0583,0.0146,0.0219,0.0073,0.0142,0.0095,0.0047,0.2556,0.0095,0.0047,0.0095,0.0237,0.0189,0.0379,0.0852,0.0142,0.0947,0.0142,0.0757,0.0615,0.0142,0.1562,0.0663,0.0142,0.0095,0.0524,0.0524,0.0787,0.0787,0.0262,0.0262,0.0262,0.0262,0.0524,0.1049,0.0262,0.0262,0.0262,0.0262,0.0262,0.0262,0.0262,0.0524,0.0262,0.0262,0.1311,0.0262,0.0262,0.0262,0.0974,0.1947,0.1947,0.0974,0.1947,0.0974,0.0974,0.0809,0.1618,0.0809,0.0809,0.0809,0.1618,0.0809,0.0809,0.0809,0.0611,0.1222,0.0611,0.0611,0.0611,0.0611,0.0611,0.1832,0.0611,0.0611,0.0611,0.0611,0.0301,0.2557,0.0301,0.015,0.015,0.015,0.015,0.015,0.015,0.1504,0.015,0.015,0.015,0.1353,0.1353,0.0301,0.0301,0.0602,0.0492,0.0492,0.0492,0.0492,0.0492,0.0492,0.0492,0.1475,0.0492,0.0492,0.0492,0.0492,0.0492,0.0492,0.0984,0.0715,0.0715,0.2146,0.0715,0.0715,0.0715,0.0715,0.0715,0.0715,0.0796,0.0398,0.0796,0.0796,0.0398,0.1193,0.0398,0.0398,0.0796,0.0796,0.1193,0.0398,0.0398,0.0398,0.1145,0.0212,0.0509,0.0594,0.0806,0.0297,0.0127,0.0594,0.0594,0.0594,0.0594,0.0255,0.0636,0.0042,0.0085,0.0085,0.0042,0.0085,0.0382,0.0085,0.0424,0.0042,0.0339,0.0042,0.0467,0.0085,0.017,0.017,0.0042,0.0127,0.0212,0.0042,0.0042,0.0085,0.0665,0.0665,0.2659,0.0665,0.0665,0.0665,0.0665,0.0665,0.0665,0.0665,0.1711,0.0856,0.0856,0.0856,0.0856,0.0856,0.0856,0.0256,0.046,0.1381,0.0102,0.0153,0.0153,0.0051,0.0051,0.0051,0.0767,0.0051,0.0205,0.0051,0.0153,0.0051,0.0051,0.22,0.0153,0.0153,0.0051,0.0307,0.0563,0.1126,0.0051,0.0921,0.0051,0.0051,0.0205,0.0153,0.1234,0.0209,0.0303,0.0419,0.0419,0.0465,0.0489,0.0396,0.0349,0.0489,0.0326,0.0233,0.0512,0.0093,0.0163,0.014,0.0303,0.0209,0.0303,0.014,0.0279,0.0116,0.0489,0.0023,0.0326,0.0209,0.0093,0.0233,0.0116,0.0093,0.0186,0.0233,0.0163,0.0093,0.0093,0.0047,0.0532,0.0532,0.3192,0.0532,0.0532,0.0532,0.0532,0.0532,0.1064,0.0532,0.1734,0.0347,0.0347,0.0693,0.0693,0.0347,0.0347,0.104,0.0347,0.0693,0.0693,0.0347,0.0693,0.0347,0.0347,0.0347,0.0347,0.0347,0.0273,0.0327,0.0109,0.0491,0.0327,0.0382,0.1418,0.0273,0.0218,0.0273,0.0273,0.0109,0.0327,0.0109,0.0273,0.06,0.0655,0.0218,0.0164,0.0109,0.0546,0.0164,0.0109,0.0218,0.0109,0.0055,0.0382,0.0491,0.0109,0.0382,0.0436,0.0055,0.1039,0.0519,0.1558,0.0519,0.0519,0.0519,0.1558,0.0519,0.0519,0.0519,0.0519,0.024,0.084,0.1679,0.012,0.012,0.024,0.012,0.024,0.084,0.012,0.012,0.024,0.036,0.012,0.108,0.024,0.012,0.012,0.096,0.06,0.048,0.012,0.048,0.068,0.0102,0.0034,0.0917,0.1461,0.034,0.0068,0.0917,0.0747,0.0883,0.0815,0.0034,0.1019,0.017,0.0102,0.0068,0.0068,0.0612,0.0068,0.0034,0.017,0.0442,0.0034,0.0068,0.0136,0.0034,0.0034,0.0679,0.0371,0.0556,0.0247,0.0371,0.0309,0.0309,0.0432,0.0185,0.0247,0.0247,0.0247,0.0185,0.0124,0.0371,0.0185,0.0185,0.0432,0.0309,0.0124,0.0309,0.0185,0.0679,0.0124,0.0309,0.0618,0.0062,0.0185,0.0124,0.0185,0.0309,0.0247,0.0124,0.0124,0.0062,0.0185,0.0203,0.1622,0.1217,0.0203,0.0203,0.0203,0.0203,0.0608,0.0203,0.0203,0.0608,0.0203,0.0811,0.1622,0.0608,0.0203,0.0406,0.0203,0.0833,0.0833,0.0833,0.0833,0.0833,0.0833,0.0833,0.0833,0.0833,0.0833,0.0714,0.0714,0.1903,0.1189,0.0951,0.0951,0.0714,0.0714,0.0238,0.0714,0.0238,0.198,0.0495,0.0742,0.0495,0.0247,0.0742,0.099,0.0495,0.0495,0.0247,0.0495,0.0247,0.0742,0.0247,0.0495,0.0495,0.0247,0.0247,0.0339,0.0905,0.1866,0.0226,0.017,0.1018,0.0113,0.017,0.017,0.0113,0.0113,0.0848,0.0057,0.0057,0.0057,0.0057,0.0339,0.0057,0.0113,0.0226,0.0113,0.1301,0.0566,0.0226,0.0113,0.0396,0.017,0.0113,0.0101,0.1608,0.1709,0.0201,0.0101,0.0101,0.0101,0.0201,0.0101,0.0101,0.0101,0.0704,0.0201,0.0201,0.0101,0.0101,0.0302,0.0201,0.0503,0.0201,0.0201,0.0905,0.0402,0.0302,0.0101,0.0503,0.0101,0.0101,0.0101,0.0101,0.0201,0.0602,0.0365,0.0816,0.0086,0.0279,0.0301,0.0387,0.0258,0.0193,0.0258,0.0258,0.0387,0.0344,0.0086,0.0387,0.0279,0.0043,0.0236,0.0279,0.0021,0.0408,0.0172,0.0365,0.0021,0.0537,0.058,0.0473,0.0365,0.0086,0.015,0.0236,0.0322,0.0129,0.015,0.0107,0.0021,0.1373,0.0343,0.0687,0.0343,0.0343,0.0687,0.0687,0.0687,0.0343,0.0343,0.0687,0.0687,0.0687,0.0343,0.0343,0.1191,0.0595,0.0595,0.1191,0.1191,0.0595,0.1191,0.0595,0.0595,0.1349,0.0674,0.1349,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0147,0.1619,0.1619,0.0147,0.0147,0.0147,0.0147,0.0294,0.0147,0.0294,0.0147,0.0442,0.0294,0.0442,0.0294,0.0442,0.0883,0.0589,0.0294,0.0442,0.0147,0.0589,0.0294,0.1678,0.2796,0.0559,0.0559,0.0559,0.0559,0.0559,0.0559,0.0559,0.0404,0.0404,0.0404,0.0404,0.1212,0.0404,0.0404,0.0404,0.0404,0.0404,0.0808,0.0404,0.0404,0.1212,0.0404,0.0808,0.0404,0.0404,0.0404,0.0537,0.0744,0.091,0.0393,0.0413,0.0868,0.0496,0.0227,0.0186,0.0083,0.0165,0.0661,0.0372,0.0165,0.0145,0.0083,0.0021,0.0455,0.0165,0.0062,0.0269,0.0103,0.0145,0.0062,0.0393,0.0413,0.0351,0.0145,0.0165,0.0083,0.0186,0.0165,0.0062,0.0124,0.0103,0.0021,0.0712,0.0324,0.0065,0.0777,0.1165,0.0518,0.0129,0.0582,0.0647,0.0518,0.0777,0.0194,0.0971,0.0129,0.0129,0.0065,0.0065,0.0129,0.0518,0.0129,0.0065,0.0065,0.0194,0.0065,0.0582,0.0065,0.0129,0.0065,0.0129,0.0129,0.0952,0.0634,0.0476,0.0317,0.0238,0.0198,0.0079,0.0278,0.0159,0.0198,0.0198,0.0119,0.0119,0.0317,0.0159,0.0476,0.0674,0.0119,0.0159,0.0238,0.0079,0.0079,0.0634,0.0198,0.0278,0.0357,0.0198,0.0119,0.0079,0.004,0.0595,0.0555,0.004,0.0317,0.0079,0.0278,0.1178,0.0589,0.0589,0.1178,0.0589,0.1768,0.0589,0.0589,0.0589,0.0589,0.0589,0.0408,0.079,0.0637,0.0433,0.0408,0.0484,0.0357,0.0255,0.0255,0.0204,0.0153,0.0433,0.028,0.0102,0.0204,0.0153,0.0178,0.0357,0.0255,0.0127,0.0408,0.0127,0.0229,0.0102,0.0102,0.0509,0.0357,0.0408,0.0178,0.0204,0.0255,0.0178,0.0102,0.0127,0.0178,0.0076,0.0855,0.2993,0.0855,0.0855,0.0428,0.1283,0.0428,0.0428,0.0807,0.0231,0.0231,0.0692,0.0692,0.0231,0.0115,0.0923,0.0577,0.0577,0.0577,0.0231,0.0577,0.0115,0.0115,0.0115,0.0115,0.0346,0.0231,0.0115,0.0461,0.0115,0.0577,0.0231,0.0115,0.0231,0.0115,0.0115,0.0115,0.0231,0.082,0.0205,0.0205,0.0205,0.0615,0.0205,0.0205,0.041,0.041,0.0205,0.041,0.0205,0.0205,0.082,0.0205,0.041,0.041,0.082,0.0205,0.041,0.0205,0.0205,0.082,0.0205,0.0205,0.041,0.1317,0.0239,0.012,0.0718,0.0359,0.0359,0.0479,0.0718,0.0598,0.0718,0.0718,0.012,0.0479,0.0479,0.012,0.0239,0.012,0.0598,0.012,0.012,0.012,0.012,0.0718,0.012,0.012,0.012,0.012,0.012,0.0164,0.0329,0.0082,0.1973,0.0082,0.0164,0.0329,0.0986,0.1233,0.0247,0.0164,0.0904,0.0247,0.0658,0.0575,0.074,0.074,0.0164,0.0082,0.1219,0.061,0.3658,0.061,0.061,0.061,0.061,0.061,0.0465,0.0581,0.186,0.0116,0.0232,0.0232,0.0349,0.0116,0.0116,0.0116,0.0116,0.1395,0.0232,0.0232,0.0116,0.0581,0.1046,0.0116,0.0232,0.0116,0.0232,0.0349,0.0116,0.0349,0.0116,0.0465,0.0116,0.0312,0.0499,0.0291,0.0894,0.0894,0.0686,0.0312,0.0458,0.0458,0.0333,0.0354,0.0229,0.0562,0.0208,0.0354,0.0125,0.025,0.0333,0.0104,0.0083,0.0146,0.0166,0.0062,0.0416,0.0125,0.0187,0.0104,0.0083,0.027,0.0042,0.0229,0.0104,0.0104,0.0104,0.0062,0.0265,0.1149,0.1237,0.0088,0.0265,0.0795,0.0088,0.0353,0.0177,0.0088,0.0088,0.0795,0.0088,0.0088,0.0088,0.0177,0.0088,0.0972,0.0177,0.0177,0.0795,0.053,0.0619,0.0088,0.0265,0.0177,0.0088,0.0088,0.1874,0.0363,0.0242,0.0605,0.0544,0.0151,0.0363,0.0242,0.0302,0.0453,0.0484,0.0212,0.0484,0.0091,0.0302,0.0242,0.0121,0.0121,0.0333,0.0151,0.003,0.0212,0.0514,0.0121,0.0181,0.006,0.0121,0.0151,0.0121,0.0151,0.003,0.006,0.0242,0.0151,0.0091,0.0121,0.0732,0.1219,0.0488,0.0488,0.0732,0.0244,0.0244,0.0244,0.0244,0.0975,0.0244,0.0244,0.0244,0.0975,0.0488,0.0732,0.0244,0.0244,0.0732,0.0945,0.0473,0.0315,0.0833,0.036,0.0338,0.0225,0.0428,0.0293,0.045,0.0405,0.0338,0.027,0.0383,0.027,0.0135,0.0113,0.0473,0.027,0.0225,0.0203,0.018,0.0338,0.0113,0.0113,0.0135,0.009,0.0068,0.0135,0.0203,0.0068,0.045,0.009,0.0045,0.0068,0.009,0.1037,0.1185,0.0889,0.1926,0.0148,0.0592,0.0444,0.0444,0.0296,0.0148,0.0444,0.0444,0.0148,0.0741,0.0296,0.0148,0.0148,0.0097,0.0973,0.0876,0.0097,0.0195,0.0097,0.0876,0.0097,0.0097,0.0195,0.0097,0.0389,0.0486,0.0195,0.0195,0.0195,0.0681,0.0097,0.0292,0.0778,0.0389,0.0292,0.0195,0.0195,0.0292,0.0195,0.0389,0.0195,0.0389,0.0389,0.0685,0.0742,0.0457,0.0343,0.0114,0.0685,0.0228,0.0114,0.0114,0.0114,0.0114,0.0171,0.0057,0.0457,0.0343,0.0285,0.0971,0.0628,0.0114,0.0228,0.0228,0.0171,0.0114,0.0114,0.0114,0.0114,0.04,0.0114,0.0114,0.0114,0.0685,0.0057,0.0057,0.0285,0.0285,0.0627,0.0396,0.0627,0.0462,0.0429,0.0165,0.0429,0.0231,0.0264,0.0363,0.0297,0.0198,0.0231,0.0231,0.0165,0.0528,0.0792,0.0165,0.0198,0.0231,0.0033,0.0165,0.033,0.0132,0.0198,0.0231,0.0198,0.0132,0.0198,0.0396,0.0264,0.0066,0.0231,0.033,0.0066,0.0033,0.1107,0.0332,0.0092,0.0609,0.0424,0.0314,0.0756,0.0295,0.0443,0.0332,0.0277,0.0074,0.0295,0.035,0.035,0.0129,0.0756,0.0148,0.0277,0.0221,0.0037,0.0092,0.0295,0.0092,0.0443,0.0111,0.0074,0.0258,0.0166,0.0166,0.0148,0.024,0.0148,0.0037,0.0074,0.0204,0.0102,0.0408,0.1937,0.0408,0.0204,0.0204,0.0408,0.0204,0.0102,0.0408,0.1326,0.0306,0.0102,0.0204,0.051,0.0102,0.0204,0.0102,0.0714,0.0306,0.0102,0.0612,0.0612,0.0102,0.0815,0.0408,0.3668,0.0408,0.0408,0.0815,0.0408,0.0408,0.0408,0.0408,0.0408,0.0408,0.0408,0.0331,0.1547,0.0884,0.011,0.011,0.0331,0.0994,0.011,0.011,0.011,0.0221,0.0331,0.011,0.0331,0.011,0.011,0.011,0.011,0.0221,0.0221,0.011,0.011,0.0884,0.0884,0.011,0.0221,0.011,0.0221,0.011,0.0221,0.011,0.0221,0.011,0.0601,0.0492,0.0219,0.1147,0.0874,0.0656,0.0219,0.0601,0.0656,0.0546,0.0437,0.0109,0.0601,0.0055,0.0382,0.0164,0.0164,0.0164,0.0219,0.0055,0.0055,0.0055,0.0164,0.0055,0.0382,0.0382,0.0164,0.0055,0.0109,0.0055,0.0055,0.0055,0.0055,0.0712,0.0801,0.0979,0.0356,0.0089,0.0801,0.0623,0.0801,0.0979,0.0089,0.1958,0.0089,0.0089,0.0801,0.0089,0.0267,0.0267,0.0089,0.0343,0.0801,0.061,0.0267,0.0305,0.0915,0.0153,0.0229,0.0229,0.0191,0.0191,0.0381,0.0267,0.0191,0.0191,0.0076,0.0343,0.0343,0.0267,0.0076,0.0534,0.0114,0.0229,0.0038,0.0191,0.0191,0.0763,0.0153,0.0114,0.0038,0.0305,0.042,0.0038,0.0114,0.0229,0.0076,0.1034,0.0037,0.0812,0.1034,0.0332,0.0074,0.0738,0.0849,0.0701,0.0886,0.0997,0.0037,0.0111,0.0037,0.0037,0.1034,0.0037,0.0037,0.0037,0.0443,0.0517,0.0037,0.0111,0.0037,0.0746,0.0213,0.0036,0.0889,0.0746,0.032,0.0746,0.0675,0.0462,0.0569,0.0355,0.0036,0.0427,0.0107,0.0178,0.0178,0.0427,0.0071,0.032,0.0071,0.0213,0.0249,0.0107,0.0533,0.0071,0.0213,0.0178,0.0071,0.0178,0.032,0.0071,0.0142,0.0107,0.0752,0.1503,0.0752,0.0752,0.0752,0.0752,0.0752,0.0752,0.0752,0.0752,0.0752,0.0423,0.0565,0.0343,0.0524,0.0161,0.0504,0.0766,0.0282,0.0242,0.0302,0.0343,0.0423,0.0161,0.0484,0.0141,0.0262,0.0161,0.0222,0.0161,0.0403,0.0101,0.0343,0.0101,0.0202,0.006,0.0181,0.0101,0.0242,0.0262,0.0242,0.006,0.0262,0.0363,0.0282,0.0161,0.0181,0.2325,0.0332,0.0664,0.0664,0.0664,0.0996,0.0332,0.0996,0.1993,0.0332,0.0715,0.0715,0.0715,0.0715,0.0715,0.0715,0.1431,0.0715,0.0715,0.0715,0.0715,0.0895,0.0895,0.0895,0.179,0.179,0.0915,0.0855,0.0696,0.0298,0.0139,0.0398,0.0119,0.0139,0.0239,0.0139,0.0139,0.0537,0.0099,0.0378,0.0139,0.008,0.006,0.0318,0.0139,0.0199,0.0716,0.008,0.002,0.008,0.0239,0.0398,0.0816,0.0278,0.004,0.0119,0.0358,0.0358,0.002,0.006,0.0259,0.0139,0.0104,0.0621,0.259,0.0104,0.0104,0.0104,0.0104,0.0104,0.0104,0.0104,0.1554,0.0104,0.0104,0.0104,0.0207,0.0207,0.1243,0.0104,0.0104,0.0104,0.0829,0.0725,0.0414,0.0104,0.0207,0.0104,0.032,0.16,0.064,0.064,0.032,0.032,0.032,0.032,0.032,0.096,0.032,0.16,0.096,0.032,0.032,0.0426,0.0768,0.0256,0.0171,0.0256,0.1364,0.0341,0.0085,0.0085,0.0171,0.0085,0.0085,0.0256,0.0938,0.1109,0.0512,0.0256,0.0085,0.0256,0.0085,0.0426,0.0256,0.0256,0.0085,0.0341,0.0085,0.0171,0.0171,0.0426,0.0594,0.0748,0.1013,0.0264,0.0286,0.0088,0.0198,0.0286,0.0242,0.022,0.0198,0.077,0.0242,0.0198,0.0242,0.0198,0.0352,0.011,0.0154,0.0154,0.0528,0.0088,0.033,0.0088,0.0198,0.0396,0.0374,0.0286,0.0176,0.0154,0.033,0.0066,0.0066,0.0176,0.0044,0.0176,0.0174,0.0959,0.3008,0.0044,0.0087,0.0174,0.0087,0.0044,0.0044,0.1264,0.0044,0.0044,0.0087,0.0262,0.0044,0.0087,0.0741,0.0087,0.0131,0.0044,0.0741,0.0654,0.0305,0.0044,0.0044,0.061,0.0044,0.0087,0.026,0.1038,0.0482,0.063,0.0334,0.0297,0.0222,0.0519,0.0297,0.0334,0.026,0.0445,0.0297,0.0556,0.0148,0.0148,0.0148,0.0148,0.0371,0.0222,0.0111,0.0148,0.0408,0.0111,0.0482,0.026,0.0185,0.0074,0.0037,0.0371,0.0185,0.0037,0.0148,0.0408,0.3675,0.1225,0.0613,0.0613,0.0613,0.1225,0.0558,0.0558,0.1673,0.0558,0.1115,0.0558,0.0558,0.0558,0.0558,0.0558,0.0558,0.0558,0.0768,0.0192,0.0384,0.1536,0.0576,0.0576,0.0192,0.0768,0.0576,0.096,0.0384,0.0576,0.0192,0.0192,0.0192,0.0576,0.0192,0.0192,0.0192,0.0192,0.0192,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.1311,0.0173,0.0865,0.1385,0.0173,0.0173,0.0346,0.0346,0.0173,0.0692,0.0519,0.0519,0.0519,0.0173,0.0346,0.0519,0.0346,0.0692,0.0865,0.0173,0.0173,0.0173,0.0283,0.0848,0.0848,0.0565,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0565,0.0848,0.0283,0.1413,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.0978,0.0244,0.0489,0.0244,0.0489,0.0489,0.0244,0.0489,0.0733,0.0489,0.0489,0.0489,0.0489,0.0244,0.0244,0.0244,0.0244,0.0733,0.0244,0.0244,0.0733,0.0328,0.295,0.0328,0.0328,0.0328,0.0328,0.0328,0.0656,0.0328,0.0328,0.0656,0.0983,0.0328,0.0656,0.0395,0.0888,0.0099,0.0296,0.0197,0.1578,0.0099,0.0099,0.0197,0.0099,0.0099,0.217,0.0099,0.0099,0.0493,0.0099,0.1085,0.0197,0.0493,0.0099,0.0099,0.0395,0.0099,0.0493,0.0593,0.0395,0.0198,0.0593,0.0198,0.3756,0.0395,0.0395,0.0198,0.0395,0.0198,0.0395,0.0198,0.0395,0.0198,0.0395,0.0198,0.0198,0.0198,0.0198,0.0593,0.0198,0.0764,0.0498,0.0515,0.0631,0.0531,0.0216,0.0714,0.0349,0.0365,0.0482,0.0299,0.0183,0.0349,0.0382,0.0415,0.0315,0.0249,0.0133,0.0249,0.0266,0.01,0.0149,0.0166,0.0166,0.0133,0.0116,0.0066,0.0066,0.0216,0.0166,0.0116,0.005,0.0199,0.01,0.0066,0.0183,0.1157,0.0165,0.1322,0.0661,0.0331,0.0165,0.1322,0.0827,0.1157,0.0827,0.0496,0.0165,0.0331,0.0165,0.0661,0.0165,0.0934,0.2989,0.0093,0.0187,0.0093,0.1308,0.0093,0.0093,0.028,0.0093,0.0841,0.0187,0.0093,0.0093,0.0374,0.0561,0.0841,0.028,0.0187,0.0187,0.0393,0.2162,0.0393,0.0197,0.1376,0.0197,0.0197,0.0197,0.1573,0.1573,0.0197,0.059,0.059,0.1689,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.1126,0.2531,0.0844,0.0844,0.0844,0.0844,0.0844,0.0844,0.0844,0.0661,0.033,0.033,0.0165,0.0165,0.0165,0.0165,0.033,0.033,0.033,0.0165,0.0165,0.0165,0.0165,0.033,0.2642,0.033,0.0165,0.0165,0.0165,0.0165,0.033,0.0165,0.0165,0.0165,0.0661,0.0165,0.0165,0.0495,0.0291,0.0291,0.2326,0.0291,0.0291,0.0291,0.0291,0.0291,0.0291,0.0291,0.0872,0.0291,0.2326,0.0291,0.0872,0.0582,0.042,0.0485,0.0938,0.0388,0.0291,0.0453,0.0226,0.0323,0.0259,0.0259,0.0226,0.0323,0.0129,0.0485,0.0129,0.0097,0.0226,0.0259,0.0162,0.0291,0.0388,0.0259,0.0162,0.0259,0.0162,0.0162,0.042,0.0259,0.0097,0.0194,0.042,0.0291,0.0032,0.0065,0.0226,0.0226,0.0278,0.3616,0.1669,0.0278,0.0278,0.0278,0.0278,0.0278,0.0556,0.0835,0.0556,0.0278,0.0278,0.5207,0.1157,0.0579,0.0579,0.0579,0.0579,0.0377,0.0548,0.0651,0.0411,0.0171,0.0377,0.0274,0.0171,0.0171,0.0206,0.024,0.0445,0.0137,0.0171,0.0411,0.0617,0.0377,0.0343,0.0171,0.0171,0.0274,0.024,0.0103,0.0137,0.0171,0.0343,0.0343,0.024,0.0171,0.0308,0.0308,0.0137,0.0137,0.0171,0.0308,0.0206,0.0795,0.0487,0.0539,0.0513,0.0359,0.0769,0.0282,0.0282,0.0128,0.0385,0.0282,0.018,0.0359,0.0205,0.041,0.0359,0.0359,0.0205,0.0256,0.0205,0.018,0.0103,0.0256,0.0154,0.0103,0.0154,0.0154,0.0231,0.0205,0.0154,0.0308,0.0205,0.0103,0.0154,0.0205,0.0103,0.0596,0.0033,0.0033,0.1093,0.0961,0.2584,0.0066,0.0497,0.0596,0.0431,0.0431,0.0066,0.0497,0.0033,0.0133,0.0099,0.0099,0.0331,0.0066,0.0033,0.0066,0.0066,0.0497,0.0033,0.0033,0.0066,0.0033,0.0431,0.0033,0.0033,0.0033,0.0559,0.0037,0.0037,0.1267,0.0783,0.2646,0.0149,0.0485,0.0708,0.041,0.0335,0.0075,0.0447,0.0037,0.0186,0.0112,0.0037,0.0224,0.0224,0.0037,0.0075,0.0112,0.0261,0.0037,0.0075,0.0596,0.0037,0.0542,0.0542,0.0542,0.4336,0.0271,0.0542,0.0542,0.0271,0.0271,0.0271,0.0271,0.0271,0.0271,0.0813,0.0554,0.0277,0.0554,0.0277,0.0554,0.0554,0.0277,0.0554,0.0277,0.0277,0.0554,0.0554,0.1109,0.0277,0.0277,0.0277,0.0554,0.0277,0.0277,0.0554,0.0277,0.0277,0.0277,0.3659,0.0915,0.0915,0.0709,0.0047,0.0016,0.1324,0.123,0.0536,0.0095,0.0804,0.1166,0.0851,0.0709,0.0047,0.0804,0.0032,0.0079,0.0032,0.0032,0.0032,0.052,0.0032,0.0016,0.0095,0.0536,0.0047,0.0032,0.0126,0.0063,0.0016,0.073,0.1095,0.0912,0.0182,0.0182,0.1095,0.1642,0.0912,0.0547,0.073,0.0182,0.0912,0.0182,0.0182,0.0182,0.0143,0.0857,0.1428,0.0143,0.0286,0.0143,0.0143,0.0857,0.0143,0.0143,0.0143,0.0143,0.0286,0.0143,0.0143,0.0428,0.0286,0.0143,0.0143,0.1571,0.0857,0.0571,0.0428,0.0286,0.0418,0.0418,0.0418,0.0418,0.0418,0.0418,0.0418,0.0418,0.0836,0.0836,0.0418,0.0836,0.0418,0.0836,0.0836,0.0418,0.0418,0.0487,0.0487,0.0243,0.0973,0.0487,0.0243,0.0243,0.0243,0.0243,0.0487,0.0487,0.0487,0.0487,0.0487,0.0243,0.0243,0.0243,0.0243,0.0243,0.0243,0.0243,0.146,0.0243,0.0243,0.0243,0.0242,0.0484,0.0484,0.0969,0.0969,0.0242,0.0242,0.0969,0.0969,0.0484,0.0484,0.0242,0.0726,0.0242,0.0242,0.0242,0.0242,0.0242,0.0242,0.0484,0.0242,0.0315,0.0157,0.0067,0.0405,0.027,0.0247,0.2699,0.0157,0.0202,0.0112,0.018,0.0045,0.0225,0.0202,0.0247,0.0225,0.0067,0.0067,0.0135,0.0067,0.0562,0.018,0.009,0.009,0.0045,0.063,0.081,0.009,0.0675,0.0427,0.0225,0.0112,0.0555,0.0555,0.111,0.0555,0.0555,0.0555,0.0555,0.111,0.0555,0.0555,0.0555,0.0555,0.0112,0.1686,0.1911,0.0112,0.0112,0.0112,0.0112,0.0112,0.0112,0.0337,0.0337,0.0225,0.0225,0.0225,0.0225,0.0112,0.045,0.0337,0.0112,0.0337,0.0787,0.0787,0.0112,0.0112,0.0337,0.0225,0.0225,0.0524,0.2618,0.0524,0.0524,0.0524,0.0524,0.0524,0.0524,0.1047,0.0524,0.0524,0.0626,0.0626,0.0626,0.0626,0.1251,0.0626,0.0626,0.0626,0.1877,0.1081,0.1081,0.1081,0.1081,0.1081,0.0541,0.0541,0.0541,0.1081,0.0541,0.0541,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.0565,0.0376,0.0376,0.0376,0.2258,0.0188,0.0188,0.0188,0.0188,0.0188,0.0565,0.0188,0.1129,0.0376,0.0376,0.0188,0.0565,0.0376,0.0565,0.0677,0.0589,0.1001,0.0118,0.0295,0.0501,0.0324,0.0206,0.0236,0.0236,0.0295,0.0648,0.0236,0.0118,0.0265,0.0206,0.0118,0.0353,0.0206,0.0177,0.0236,0.0147,0.0029,0.0118,0.0353,0.056,0.0619,0.0147,0.0236,0.0059,0.0147,0.0206,0.0029,0.0029,0.0118,0.0177,0.0941,0.0314,0.0506,0.0314,0.0362,0.0868,0.0145,0.0362,0.0386,0.0193,0.041,0.0386,0.0217,0.0096,0.0241,0.0217,0.0675,0.0193,0.0289,0.0096,0.0217,0.0217,0.041,0.0048,0.0603,0.0145,0.0121,0.0145,0.0193,0.0121,0.0072,0.0169,0.0145,0.0145,0.0072,0.0024,0.0393,0.0687,0.0294,0.0638,0.0344,0.0196,0.0147,0.0344,0.0245,0.0245,0.0294,0.0196,0.0196,0.0785,0.0294,0.0638,0.1129,0.0098,0.0196,0.0491,0.0098,0.0098,0.0344,0.0098,0.0098,0.0049,0.0196,0.0098,0.0098,0.0196,0.0049,0.0294,0.0049,0.0294,0.0349,0.0634,0.0697,0.0539,0.0349,0.0095,0.0317,0.0444,0.038,0.0317,0.0317,0.0444,0.0253,0.0475,0.019,0.0317,0.0349,0.0095,0.0222,0.0285,0.0063,0.0158,0.0095,0.019,0.019,0.0063,0.0317,0.0095,0.0158,0.0127,0.038,0.0095,0.0158,0.0285,0.0444,0.0095,0.0548,0.0391,0.06,0.0469,0.0522,0.0183,0.0782,0.0261,0.0391,0.0261,0.0209,0.0495,0.0209,0.0261,0.0287,0.0209,0.0209,0.0104,0.0183,0.0183,0.0469,0.0235,0.0156,0.013,0.0156,0.0209,0.0235,0.0261,0.0287,0.013,0.0287,0.0052,0.0183,0.0183,0.0078,0.0156,0.1159,0.1159,0.3478,0.1159,0.0713,0.0475,0.0475,0.0238,0.0238,0.1664,0.0238,0.0238,0.0238,0.0238,0.0713,0.0238,0.0238,0.2139,0.0238,0.0238,0.0238,0.0238,0.0713,0.0743,0.0646,0.0711,0.0452,0.0194,0.0258,0.0226,0.0194,0.0129,0.0161,0.0388,0.0355,0.0194,0.0484,0.0452,0.0161,0.0194,0.0969,0.0161,0.0323,0.0226,0.0065,0.0291,0.0194,0.0258,0.0161,0.0097,0.0065,0.0097,0.042,0.0194,0.0097,0.0065,0.0226,0.0161,0.075,0.3,0.075,0.075,0.075,0.075,0.0473,0.0709,0.1182,0.0355,0.0591,0.0473,0.0118,0.0473,0.0355,0.0118,0.0236,0.0236,0.0118,0.0236,0.0118,0.0118,0.0355,0.0236,0.0118,0.0473,0.0118,0.0118,0.0118,0.0827,0.0236,0.0355,0.0118,0.0355,0.0236,0.0118,0.0333,0.0666,0.0666,0.0666,0.0333,0.0333,0.0333,0.0333,0.0333,0.0333,0.0333,0.0333,0.0333,0.0666,0.0333,0.0666,0.0333,0.1333,0.0333,0.1198,0.024,0.0479,0.4073,0.024,0.024,0.024,0.024,0.0479,0.024,0.0479,0.024,0.024,0.0958,0.0481,0.0455,0.0241,0.0615,0.0642,0.0214,0.0428,0.0348,0.0481,0.0401,0.0374,0.0134,0.0508,0.0241,0.008,0.0294,0.0776,0.016,0.0267,0.0214,0.0107,0.016,0.0267,0.0107,0.0187,0.0267,0.0107,0.0107,0.0134,0.016,0.016,0.0134,0.0267,0.0107,0.0134,0.0214,0.0914,0.0914,0.0914,0.2741,0.0914,0.0914,0.0331,0.0662,0.0386,0.0331,0.0497,0.1379,0.0607,0.0166,0.0276,0.0055,0.0166,0.0221,0.0221,0.0276,0.0221,0.0166,0.0166,0.0607,0.011,0.011,0.011,0.0166,0.0221,0.011,0.0221,0.0166,0.0166,0.0166,0.0331,0.0386,0.0497,0.0055,0.0221,0.0166,0.011,0.0551,0.1652,0.1101,0.0551,0.0551,0.1101,0.1101,0.0551,0.0682,0.0487,0.0536,0.0682,0.0487,0.0389,0.0146,0.0487,0.0389,0.0341,0.0584,0.0195,0.0584,0.0146,0.0292,0.0097,0.0195,0.0146,0.0341,0.0195,0.0049,0.0049,0.0389,0.0292,0.0633,0.0097,0.0097,0.0049,0.0146,0.0049,0.0146,0.0097,0.0049,0.0195,0.0243,0.0484,0.0264,0.0462,0.0484,0.0286,0.033,0.0682,0.0264,0.0308,0.0264,0.0264,0.0638,0.0176,0.0264,0.0308,0.0286,0.033,0.0132,0.0198,0.022,0.0154,0.0176,0.0396,0.011,0.0264,0.0198,0.011,0.022,0.0242,0.0198,0.0352,0.0176,0.0286,0.0264,0.0044,0.0132,0.0319,0.0319,0.0956,0.0637,0.0319,0.1912,0.0319,0.0319,0.0319,0.0956,0.0319,0.0319,0.0637,0.0319,0.0319,0.0319,0.0319,0.0486,0.0486,0.0486,0.0486,0.0486,0.0972,0.0486,0.0972,0.0486,0.0486,0.0972,0.0486,0.0486,0.0486,0.0486,0.0486,0.3704,0.1852,0.021,0.1174,0.0419,0.021,0.0252,0.0126,0.0713,0.0252,0.0168,0.0084,0.0168,0.0084,0.0084,0.1132,0.0293,0.0168,0.0755,0.021,0.0042,0.0587,0.0084,0.0293,0.0461,0.0084,0.0084,0.0126,0.021,0.0168,0.0126,0.021,0.0335,0.021,0.0168,0.0377,0.0397,0.0132,0.0397,0.0264,0.0132,0.0793,0.0132,0.0132,0.0132,0.0132,0.0132,0.0132,0.1058,0.2247,0.0264,0.0132,0.0132,0.0132,0.0264,0.0132,0.0132,0.0264,0.0661,0.0264,0.0264,0.0529,0.0132,0.0405,0.0203,0.081,0.1013,0.0203,0.0203,0.0405,0.0608,0.081,0.1013,0.0203,0.1013,0.0405,0.0203,0.0203,0.0405,0.0608,0.0405,0.0203,0.0203,0.0203,0.0203,0.1553,0.1036,0.0518,0.0518,0.0518,0.1553,0.1036,0.0518,0.0518,0.0562,0.0562,0.0562,0.5619,0.0562,0.0562,0.0461,0.2769,0.0692,0.0231,0.0231,0.0231,0.0231,0.0231,0.0231,0.0923,0.0231,0.0231,0.0231,0.0923,0.1154,0.0231,0.0231,0.1012,0.1012,0.1012,0.1012,0.1012,0.1012,0.1012,0.0274,0.0274,0.0548,0.0274,0.0548,0.0274,0.0274,0.0274,0.0274,0.0274,0.0274,0.0548,0.0822,0.0548,0.1644,0.0548,0.0274,0.0548,0.0274,0.0274,0.0274,0.0274,0.0274,0.0274,0.0274,0.0274,0.0544,0.0544,0.0501,0.0675,0.0544,0.1089,0.0152,0.0348,0.037,0.0392,0.0305,0.0436,0.0348,0.024,0.0087,0.0065,0.0087,0.0196,0.0305,0.0109,0.0152,0.0152,0.0131,0.0087,0.0196,0.0305,0.0392,0.0131,0.0044,0.0196,0.0261,0.0174,0.0044,0.0022,0.0348,0.0108,0.1188,0.2053,0.0108,0.0108,0.0108,0.0216,0.0108,0.0216,0.0108,0.0108,0.0216,0.0108,0.0432,0.054,0.0108,0.054,0.0108,0.0216,0.0108,0.0432,0.0216,0.0756,0.0108,0.0648,0.0756,0.0216,0.0175,0.257,0.0555,0.0131,0.0058,0.0029,0.0088,0.0073,0.0015,0.0044,0.0117,0.0277,0.0015,0.1416,0.0073,0.0073,0.0058,0.0015,0.0934,0.0131,0.0029,0.0044,0.0628,0.0073,0.0321,0.054,0.0117,0.0029,0.0015,0.0277,0.0029,0.0015,0.0073,0.0496,0.0467,0.0331,0.0311,0.0097,0.0233,0.0156,0.0253,0.0836,0.0097,0.0175,0.0175,0.0175,0.0039,0.0078,0.035,0.035,0.1712,0.1128,0.0097,0.0097,0.0272,0.0019,0.0331,0.0039,0.0175,0.0117,0.0058,0.0019,0.0097,0.035,0.0233,0.0136,0.0078,0.0408,0.07,0.0175,0.0136,0.0593,0.0099,0.1087,0.089,0.1582,0.0099,0.0494,0.0494,0.0297,0.0395,0.0494,0.0099,0.0494,0.0198,0.0593,0.0395,0.0099,0.0099,0.0198,0.0297,0.0099,0.0791,0.0099,0.048,0.0206,0.0412,0.0549,0.048,0.1166,0.0137,0.0206,0.0137,0.0206,0.048,0.0137,0.0274,0.0069,0.048,0.0206,0.096,0.0274,0.0137,0.0343,0.0137,0.0274,0.0069,0.0274,0.0343,0.0274,0.0137,0.0274,0.0617,0.0137,0.0137,0.0347,0.0976,0.0759,0.0217,0.0239,0.0282,0.0304,0.0152,0.0108,0.0065,0.0152,0.0542,0.013,0.0672,0.0239,0.013,0.0347,0.0173,0.013,0.0412,0.0369,0.0217,0.0217,0.0173,0.0065,0.0282,0.0239,0.0434,0.0087,0.0217,0.026,0.0108,0.0152,0.013,0.0434,0.0195,0.0729,0.1458,0.0729,0.328,0.0364,0.0729,0.0364,0.0364,0.0364,0.0364,0.0364,0.0366,0.0366,0.2198,0.0366,0.0733,0.1099,0.0733,0.0733,0.2198,0.0733,0.0361,0.0271,0.0361,0.0271,0.0541,0.009,0.2075,0.0451,0.009,0.018,0.018,0.009,0.0722,0.0271,0.009,0.009,0.009,0.0361,0.009,0.0722,0.0451,0.009,0.009,0.0631,0.0361,0.0722,0.0271,0.009,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0716,0.0241,0.0121,0.0362,0.0241,0.0121,0.0121,0.0964,0.0121,0.0121,0.0121,0.0121,0.0121,0.0121,0.2531,0.0603,0.0362,0.0603,0.0121,0.0362,0.0362,0.0241,0.0362,0.0362,0.0482,0.0121,0.0241,0.0121,0.067,0.0408,0.0408,0.0408,0.0408,0.0408,0.0495,0.035,0.035,0.0291,0.0291,0.0233,0.0321,0.0233,0.0233,0.0437,0.0117,0.0175,0.0262,0.0204,0.0175,0.0204,0.0408,0.0087,0.035,0.0233,0.0146,0.0117,0.0146,0.0204,0.0204,0.0583,0.0175,0.0087,0.0087,0.0058,0.0256,0.0128,0.0128,0.064,0.064,0.307,0.0256,0.0384,0.0256,0.0128,0.0256,0.0384,0.0256,0.0128,0.0384,0.0128,0.0767,0.0256,0.0128,0.0128,0.0256,0.0128,0.0128,0.0512,0.0128,0.0128,0.2522,0.042,0.0042,0.0504,0.0294,0.0588,0.0168,0.0252,0.0294,0.0294,0.0462,0.0168,0.0294,0.0462,0.0084,0.0126,0.0168,0.0294,0.0294,0.0084,0.0715,0.021,0.0378,0.0168,0.0042,0.0042,0.0336,0.0126,0.0126,0.0245,0.0594,0.0524,0.0455,0.0489,0.021,0.0594,0.035,0.0524,0.0245,0.021,0.028,0.035,0.0175,0.035,0.0664,0.042,0.0315,0.021,0.0175,0.0245,0.0245,0.007,0.014,0.0035,0.014,0.021,0.0455,0.028,0.0175,0.0245,0.0175,0.007,0.0175,0.1471,0.0368,0.0736,0.0736,0.0368,0.0368,0.0736,0.0736,0.0368,0.0368,0.0368,0.0736,0.0368,0.0736,0.0368,0.0468,0.2107,0.2575,0.0234,0.0234,0.0234,0.0234,0.0234,0.0468,0.0234,0.0234,0.0234,0.0234,0.0468,0.0702,0.0234,0.0234,0.0234,0.0751,0.0376,0.0751,0.0751,0.0751,0.0376,0.1127,0.1127,0.0376,0.0751,0.0376,0.0751,0.0376,0.0751,0.0751,0.1209,0.0604,0.0604,0.0604,0.0604,0.0604,0.0604,0.1209,0.0604,0.0604,0.0604,0.0604,0.0678,0.0678,0.1017,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0339,0.0678,0.0339,0.0678,0.0678,0.0339,0.0163,0.0408,0.0408,0.0326,0.0163,0.0571,0.0978,0.0082,0.0082,0.0163,0.0245,0.0082,0.0082,0.0326,0.0408,0.1223,0.0652,0.0408,0.0082,0.0163,0.0326,0.0245,0.0245,0.0326,0.0163,0.0082,0.0163,0.0245,0.0326,0.0245,0.0326,0.022,0.0661,0.1102,0.0661,0.0441,0.022,0.1322,0.0441,0.0881,0.0881,0.0881,0.022,0.022,0.022,0.0441,0.022,0.022,0.022,0.022,0.0337,0.0294,0.0168,0.0126,0.0042,0.0337,0.2188,0.0084,0.0042,0.0084,0.0168,0.0252,0.0084,0.0547,0.0337,0.0126,0.021,0.0084,0.0631,0.0042,0.0168,0.0084,0.0168,0.0042,0.0799,0.0631,0.0042,0.0168,0.0841,0.0715,0.0042,0.0126,0.0411,0.1233,0.0411,0.0822,0.0411,0.0822,0.0411,0.0411,0.0411,0.0822,0.2466,0.0411,0.0411,0.0553,0.0553,0.0553,0.0553,0.0553,0.0553,0.0553,0.1105,0.1105,0.1105,0.0553,0.0553,0.1105,0.0394,0.0545,0.0394,0.0636,0.0575,0.0212,0.0908,0.0272,0.0303,0.0303,0.0333,0.0121,0.0272,0.0333,0.0121,0.0212,0.0303,0.0242,0.0182,0.0182,0.0242,0.0333,0.0151,0.0212,0.0091,0.0061,0.0151,0.0212,0.0212,0.0363,0.0212,0.0333,0.0303,0.0061,0.0212,0.0306,0.0919,0.1531,0.0613,0.0306,0.1531,0.0306,0.0306,0.0613,0.1225,0.0613,0.0306,0.0306,0.0603,0.0673,0.065,0.0464,0.0371,0.0325,0.0162,0.0418,0.0464,0.0348,0.0278,0.0371,0.0371,0.0116,0.0093,0.0232,0.0116,0.0302,0.0209,0.0116,0.0302,0.0139,0.0093,0.0093,0.0186,0.0418,0.0487,0.0186,0.0209,0.0278,0.0394,0.0255,0.0116,0.0116,0.0093,0.0881,0.3231,0.1469,0.0587,0.0294,0.0294,0.0881,0.0881,0.0294,0.2451,0.105,0.035,0.07,0.035,0.035,0.035,0.035,0.07,0.1751,0.035,0.035,0.07,0.1392,0.1392,0.2784,0.0696,0.1392,0.0696,0.0488,0.0975,0.0488,0.0488,0.0488,0.0488,0.1463,0.0488,0.0975,0.0488,0.0488,0.0488,0.0488,0.0488,0.0488,0.0488,0.0541,0.1081,0.0541,0.0541,0.1081,0.0541,0.0541,0.3784,0.0634,0.571,0.0634,0.0634,0.0634,0.0751,0.031,0.018,0.1045,0.0931,0.049,0.018,0.0653,0.0947,0.0523,0.049,0.0147,0.0653,0.0098,0.0114,0.0049,0.0065,0.0114,0.0441,0.0065,0.0098,0.0065,0.0261,0.0016,0.0441,0.0049,0.0196,0.0082,0.0082,0.0131,0.0098,0.0065,0.0016,0.0033,0.0049,0.0049,0.0208,0.1319,0.1388,0.0139,0.0139,0.0278,0.0139,0.0139,0.0208,0.0139,0.0208,0.0764,0.0069,0.0278,0.0139,0.0139,0.0208,0.0069,0.0139,0.0555,0.0208,0.0069,0.0139,0.0694,0.0764,0.0139,0.0139,0.0069,0.0347,0.0139,0.0069,0.0069,0.0417,0.0208,0.0547,0.1094,0.2189,0.0547,0.0547,0.0547,0.0547,0.0547,0.0547,0.0547,0.0547,0.0547,0.0547,0.0527,0.1229,0.0702,0.0263,0.0263,0.0527,0.0088,0.0088,0.0176,0.0088,0.0263,0.0527,0.0088,0.0263,0.0263,0.0176,0.0615,0.0088,0.0176,0.0439,0.0088,0.0088,0.0702,0.0527,0.0527,0.0088,0.079,0.0088,0.0088,0.1327,0.0663,0.0663,0.0663,0.1327,0.1327,0.0663,0.0663,0.0663,0.0568,0.0547,0.0273,0.0505,0.0441,0.0294,0.0547,0.0189,0.0273,0.0336,0.0252,0.0357,0.0294,0.0526,0.0252,0.0315,0.0547,0.0105,0.021,0.0294,0.0084,0.021,0.021,0.0231,0.0231,0.0063,0.0189,0.0126,0.021,0.0189,0.0273,0.0168,0.0168,0.021,0.0105,0.0189,0.0297,0.1783,0.0297,0.0297,0.0594,0.1783,0.1783,0.0297,0.1189,0.0297,0.0594,0.0687,0.1374,0.0687,0.0687,0.0687,0.0687,0.0687,0.1374,0.1374,0.1374,0.0099,0.0099,0.0496,0.0099,0.0298,0.1887,0.0298,0.0099,0.0199,0.0199,0.0099,0.0099,0.0199,0.0894,0.0695,0.0199,0.0099,0.0099,0.0099,0.0199,0.0993,0.0099,0.0099,0.0099,0.0397,0.0397,0.0695,0.0199,0.0298,0.0274,0.0548,0.0274,0.0274,0.0548,0.0274,0.0274,0.1096,0.3289,0.0274,0.0274,0.0548,0.0274,0.0274,0.0274,0.0274,0.0548,0.0274,0.0358,0.1312,0.0358,0.0597,0.0358,0.0716,0.0239,0.0239,0.0119,0.0119,0.0239,0.0119,0.0955,0.0119,0.0119,0.0119,0.0119,0.0119,0.1074,0.0358,0.0716,0.0239,0.0119,0.0119,0.0119,0.0239,0.0119,0.0119,0.0119,0.0119,0.0239,0.068,0.2039,0.068,0.068,0.1359,0.1359,0.1359,0.068,0.0655,0.2153,0.1077,0.0655,0.0375,0.0889,0.0936,0.0889,0.0468,0.0562,0.0047,0.014,0.0047,0.0047,0.0328,0.014,0.0047,0.0094,0.0094,0.0094,0.014,0.0047,0.036,0.046,0.042,0.048,0.038,0.012,0.096,0.024,0.024,0.034,0.032,0.024,0.03,0.04,0.038,0.04,0.04,0.01,0.018,0.03,0.016,0.032,0.014,0.02,0.016,0.012,0.016,0.012,0.036,0.016,0.024,0.032,0.022,0.022,0.012,0.0124,0.0248,0.0124,0.0124,0.1115,0.0248,0.0124,0.0124,0.0124,0.0124,0.0124,0.0743,0.0496,0.0124,0.0124,0.0248,0.0372,0.0248,0.0248,0.0248,0.0124,0.0496,0.0372,0.0372,0.0619,0.2106,0.0372,0.0124,0.1534,0.1534,0.0383,0.0767,0.115,0.0383,0.0767,0.115,0.0383,0.0767,0.0383,0.0379,0.0478,0.0657,0.0398,0.0438,0.0139,0.0717,0.0279,0.0219,0.0219,0.0179,0.01,0.012,0.0418,0.0398,0.0398,0.0717,0.008,0.008,0.0319,0.0139,0.0379,0.012,0.0179,0.0139,0.0319,0.008,0.0139,0.0339,0.0398,0.0159,0.004,0.0319,0.0319,0.012,0.008,0.037,0.074,0.111,0.259,0.037,0.037,0.037,0.037,0.037,0.037,0.037,0.037,0.037,0.074,0.0446,0.0891,0.0446,0.0446,0.312,0.0446,0.0446,0.0446,0.0446,0.0446,0.0446,0.0446,0.0446,0.0446,0.0891,0.0378,0.054,0.0811,0.027,0.0108,0.1135,0.0162,0.0162,0.0378,0.0162,0.0162,0.0811,0.0108,0.0216,0.0162,0.0216,0.0054,0.0432,0.0162,0.027,0.0378,0.0162,0.0054,0.0162,0.0108,0.0757,0.027,0.0378,0.0162,0.0108,0.0162,0.0378,0.0054,0.0216,0.0108,0.048,0.0262,0.048,0.061,0.0523,0.266,0.0131,0.0262,0.0262,0.0131,0.0131,0.0436,0.0218,0.0087,0.0218,0.0087,0.0785,0.0174,0.0044,0.0349,0.0131,0.0044,0.0044,0.0305,0.0131,0.0131,0.0174,0.0044,0.0698,0.0044,0.0369,0.0225,0.0328,0.0307,0.0082,0.0266,0.168,0.0082,0.0082,0.0082,0.0143,0.0348,0.0143,0.0123,0.0348,0.0287,0.0184,0.0082,0.0082,0.0082,0.0123,0.1127,0.002,0.0082,0.002,0.0246,0.0164,0.0041,0.0512,0.0451,0.0246,0.0164,0.0615,0.0389,0.0266,0.0164,0.0709,0.0709,0.0709,0.1418,0.0709,0.1418,0.0709,0.0709,0.0709,0.1418,0.0404,0.0454,0.0555,0.0429,0.0505,0.0278,0.0581,0.0227,0.0328,0.0227,0.0177,0.0151,0.0202,0.0429,0.0429,0.0278,0.0404,0.0151,0.0101,0.0177,0.0303,0.0202,0.0202,0.0202,0.0076,0.0278,0.0278,0.0353,0.0151,0.0151,0.0454,0.0126,0.0303,0.0151,0.0101,0.0177,0.1074,0.2148,0.1611,0.0537,0.1611,0.1074,0.0417,0.0417,0.1669,0.0417,0.5007,0.0417,0.0417,0.0417,0.0417,0.0417,0.0337,0.0621,0.0932,0.0492,0.0414,0.0129,0.0777,0.0285,0.0337,0.0259,0.0285,0.0259,0.0233,0.0259,0.0129,0.0285,0.0259,0.0104,0.0129,0.0155,0.0311,0.0259,0.0129,0.0181,0.0052,0.0337,0.0155,0.0259,0.0207,0.0181,0.0233,0.0052,0.0311,0.0311,0.0181,0.0155,0.1257,0.1886,0.1257,0.0629,0.1257,0.0629,0.0629,0.0629,0.0372,0.1117,0.0372,0.0186,0.0186,0.0558,0.0186,0.0186,0.0186,0.0186,0.0372,0.0186,0.0186,0.0186,0.0558,0.0186,0.0372,0.0558,0.0372,0.0186,0.0186,0.0558,0.0186,0.0186,0.242,0.0446,0.0541,0.0286,0.0605,0.0255,0.0382,0.0414,0.0255,0.0286,0.0223,0.0191,0.0477,0.0127,0.035,0.0509,0.035,0.0477,0.0191,0.0095,0.0255,0.0064,0.0318,0.0127,0.0064,0.0064,0.0255,0.0318,0.0255,0.0191,0.0255,0.0191,0.0318,0.0223,0.0223,0.0223,0.0159,0.0945,0.0172,0.1031,0.0859,0.0688,0.0086,0.0688,0.0859,0.0688,0.0516,0.0688,0.0258,0.0086,0.0086,0.0172,0.0516,0.0086,0.0172,0.0086,0.0172,0.043,0.0086,0.0258,0.0172,0.0708,0.0561,0.0266,0.0384,0.0354,0.0177,0.0354,0.0413,0.0236,0.0354,0.0443,0.0148,0.0354,0.0767,0.0177,0.0207,0.0266,0.0236,0.0325,0.0443,0.003,0.0207,0.0561,0.0266,0.0207,0.0059,0.0177,0.0059,0.0177,0.0207,0.0148,0.0059,0.0089,0.0177,0.0207,0.0236,0.0648,0.1296,0.1296,0.0648,0.0648,0.1296,0.0648,0.0648,0.1296,0.0501,0.0501,0.2002,0.0501,0.0501,0.0501,0.0501,0.0501,0.1001,0.0501,0.0501,0.1001,0.3876,0.0388,0.0388,0.1163,0.0388,0.1163,0.0388,0.0775,0.0388,0.0815,0.0734,0.0625,0.0299,0.0381,0.0353,0.0435,0.0272,0.0408,0.0299,0.0381,0.0326,0.019,0.0326,0.0136,0.0245,0.0245,0.0408,0.0272,0.0082,0.0163,0.0163,0.0326,0.0109,0.0217,0.0299,0.0217,0.0245,0.0109,0.0082,0.0163,0.0163,0.0109,0.0217,0.0082,0.0082,0.0575,0.0575,0.0575,0.0575,0.0575,0.0575,0.0575,0.1151,0.1726,0.0575,0.0575,0.0575,0.0334,0.0334,0.1335,0.1001,0.1001,0.1001,0.0668,0.0668,0.0668,0.0668,0.0668,0.0334,0.0334,0.012,0.3709,0.0359,0.012,0.012,0.1675,0.012,0.012,0.012,0.1077,0.0957,0.0239,0.0239,0.012,0.012,0.0359,0.05,0.1332,0.0333,0.0333,0.0167,0.0167,0.0333,0.0167,0.0333,0.0167,0.0999,0.0167,0.0333,0.05,0.0167,0.0167,0.1166,0.0333,0.0833,0.0167,0.0167,0.0167,0.0167,0.0167,0.0167,0.0167,0.0433,0.13,0.0433,0.0433,0.0433,0.0433,0.0433,0.0867,0.0433,0.0433,0.13,0.0867,0.0433,0.0433,0.0841,0.0386,0.014,0.0561,0.0736,0.0491,0.0175,0.0386,0.0456,0.0456,0.0526,0.0245,0.0561,0.0526,0.014,0.007,0.014,0.035,0.0245,0.014,0.007,0.0701,0.021,0.028,0.021,0.0105,0.0035,0.0105,0.0175,0.007,0.0175,0.0035,0.007,0.014,0.0699,0.0326,0.0047,0.0839,0.1119,0.0187,0.0047,0.0979,0.0606,0.0793,0.0979,0.0839,0.0466,0.0187,0.0093,0.042,0.028,0.0187,0.014,0.0466,0.0047,0.0047,0.0047,0.0093,0.071,0.0676,0.0777,0.0406,0.0304,0.0338,0.0439,0.027,0.0304,0.0304,0.0135,0.0575,0.0101,0.0237,0.0169,0.0237,0.0135,0.0101,0.0169,0.0203,0.027,0.0203,0.0101,0.0101,0.0237,0.0304,0.0507,0.0372,0.027,0.0237,0.0135,0.0135,0.0101,0.0135,0.0203,0.0068,0.0249,0.1742,0.0498,0.0249,0.0249,0.0249,0.0249,0.1991,0.0498,0.0249,0.1245,0.0747,0.0249,0.151,0.0839,0.0252,0.0336,0.0336,0.042,0.0168,0.042,0.042,0.0336,0.0503,0.0168,0.0336,0.0168,0.0336,0.0168,0.0168,0.0336,0.0168,0.0503,0.0084,0.0755,0.0084,0.0671,0.0084,0.0084,0.0084,0.0084,0.0168,0.0084,0.0084,0.0623,0.1247,0.1247,0.0623,0.374,0.0623,0.0623,0.0623,0.0292,0.1314,0.146,0.0146,0.0584,0.0146,0.0146,0.0584,0.0146,0.0146,0.0146,0.1022,0.0146,0.0146,0.0292,0.0146,0.0292,0.0438,0.0146,0.0146,0.073,0.0438,0.0438,0.0146,0.1235,0.0247,0.0371,0.0865,0.0371,0.0124,0.0988,0.0618,0.0618,0.0741,0.0865,0.0124,0.0124,0.0618,0.0371,0.1606,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0674,0.0906,0.0429,0.0667,0.0453,0.0238,0.0477,0.0334,0.0381,0.0453,0.0405,0.0238,0.0381,0.0262,0.0167,0.0238,0.0214,0.0143,0.0095,0.0262,0.0095,0.0381,0.0167,0.0238,0.0071,0.0262,0.0214,0.0214,0.0262,0.0191,0.0095,0.0238,0.0238,0.0095,0.0191,0.0238,0.0119,0.148,0.0493,0.0493,0.0493,0.0247,0.0987,0.0493,0.0493,0.074,0.0987,0.0247,0.0247,0.0247,0.074,0.0493,0.0493,0.0247,0.0247,0.0911,0.027,0.0337,0.0439,0.0472,0.0911,0.0708,0.0236,0.0439,0.0337,0.0135,0.0439,0.0304,0.0202,0.027,0.027,0.0202,0.0439,0.0202,0.0067,0.0304,0.0169,0.0034,0.0034,0.0337,0.0067,0.027,0.0202,0.0169,0.0034,0.0304,0.0169,0.0101,0.0034,0.0067,0.0527,0.0527,0.0527,0.0527,0.1053,0.0527,0.158,0.0527,0.0527,0.0527,0.0527,0.0527,0.0527,0.0811,0.0116,0.0232,0.1043,0.0579,0.1043,0.0116,0.0695,0.0695,0.0463,0.0927,0.0116,0.0927,0.0232,0.0116,0.0348,0.0579,0.0232,0.0348,0.0116,0.0116,0.07,0.07,0.21,0.07,0.07,0.07,0.07,0.14,0.0651,0.3256,0.0651,0.1953,0.0651,0.1082,0.0361,0.0361,0.2165,0.0361,0.0722,0.0361,0.0722,0.0722,0.0722,0.0361,0.0361,0.0361,0.0722,0.1375,0.0458,0.1375,0.0458,0.0917,0.0917,0.0458,0.0458,0.0458,0.0917,0.0458,0.0594,0.1783,0.416,0.0594,0.0594,0.0594,0.0594,0.0594,0.0594,0.035,0.1072,0.1072,0.0219,0.0284,0.0547,0.0022,0.0131,0.0109,0.0175,0.0109,0.0678,0.0197,0.0372,0.0197,0.0066,0.0044,0.0284,0.0153,0.0394,0.0416,0.0088,0.0088,0.0109,0.0044,0.07,0.0547,0.0175,0.0022,0.0022,0.0263,0.0438,0.0022,0.0284,0.0263,0.0656,0.0656,0.0656,0.0656,0.0656,0.0656,0.1312,0.2624,0.0398,0.1195,0.0996,0.1992,0.0199,0.0996,0.0598,0.0598,0.0398,0.0199,0.0598,0.0199,0.0398,0.0398,0.0199,0.075,0.045,0.085,0.025,0.025,0.015,0.015,0.05,0.045,0.01,0.025,0.07,0.035,0.01,0.03,0.01,0.045,0.03,0.03,0.01,0.055,0.01,0.045,0.01,0.01,0.01,0.08,0.015,0.015,0.03,0.02,0.005,0.005,0.005,0.005,0.1074,0.1074,0.161,0.161,0.0537,0.0537,0.1074,0.0537,0.0537,0.0358,0.0358,0.2145,0.0358,0.0715,0.0715,0.1073,0.0358,0.0715,0.0715,0.143,0.0358,0.0358,0.0222,0.0074,0.0222,0.0074,0.215,0.0074,0.0074,0.0074,0.0074,0.0445,0.089,0.089,0.0964,0.0074,0.0222,0.0667,0.0519,0.0074,0.1112,0.0741,0.0148,0.0074,0.0301,0.0301,0.1804,0.0301,0.0301,0.0301,0.0301,0.0301,0.0301,0.1203,0.0301,0.0301,0.0301,0.0301,0.1203,0.0301,0.0601,0.0301,0.0601,0.0301,0.1288,0.0515,0.0773,0.0258,0.0258,0.0773,0.0258,0.0515,0.0515,0.0258,0.103,0.0258,0.0258,0.0515,0.0258,0.0515,0.0258,0.0258,0.0258,0.0515,0.0795,0.0042,0.1004,0.1046,0.046,0.0544,0.0795,0.0711,0.0753,0.0544,0.0042,0.067,0.0042,0.0167,0.0126,0.0126,0.0084,0.0377,0.0167,0.0251,0.0042,0.0293,0.0084,0.0167,0.0167,0.0084,0.0167,0.0167,0.0042,0.0398,0.0796,0.1193,0.0398,0.0398,0.0398,0.0398,0.0398,0.1193,0.1591,0.0398,0.0398,0.1591,0.0575,0.1149,0.0575,0.1149,0.0575,0.0575,0.0575,0.1149,0.0575,0.1149,0.0575,0.1182,0.0591,0.0591,0.0295,0.0591,0.0295,0.0591,0.0295,0.0886,0.0886,0.0295,0.0886,0.0295,0.0295,0.0295,0.0886,0.0591,0.0295,0.0758,0.019,0.019,0.0948,0.0758,0.019,0.0569,0.1137,0.0569,0.0379,0.0379,0.0379,0.0569,0.0379,0.019,0.019,0.019,0.019,0.019,0.019,0.019,0.019,0.019,0.0379,0.019,0.019,0.019,0.019,0.0746,0.0618,0.0533,0.0554,0.0554,0.0597,0.0427,0.0299,0.0427,0.0384,0.0299,0.0427,0.0277,0.0192,0.0277,0.0128,0.0171,0.0277,0.0256,0.0235,0.0192,0.0107,0.0171,0.0085,0.0341,0.0064,0.0064,0.0235,0.0149,0.0107,0.0107,0.032,0.0064,0.0064,0.0171,0.0043,0.0392,0.1175,0.1723,0.0078,0.0157,0.0157,0.0078,0.0157,0.0862,0.0235,0.0078,0.0078,0.0313,0.0157,0.0078,0.1018,0.0157,0.0705,0.0078,0.0078,0.0313,0.0313,0.0783,0.0392,0.0078,0.0157,0.0078,0.0946,0.1419,0.0473,0.0473,0.0946,0.0473,0.1419,0.0473,0.0473,0.0473,0.0946,0.0644,0.0234,0.0176,0.0878,0.0761,0.1288,0.0117,0.0234,0.0468,0.0234,0.0293,0.0234,0.041,0.0293,0.0527,0.0117,0.0117,0.0878,0.0176,0.0176,0.0117,0.0059,0.0117,0.0059,0.0176,0.0176,0.0059,0.0059,0.0176,0.0585,0.0059,0.0117,0.0664,0.0398,0.0398,0.0133,0.0398,0.0266,0.0266,0.0398,0.0398,0.0266,0.0266,0.0266,0.0398,0.0133,0.0133,0.0266,0.093,0.0531,0.0266,0.0133,0.0266,0.0797,0.0133,0.0133,0.0266,0.0133,0.0266,0.0531,0.0133,0.0133,0.0875,0.0219,0.0219,0.0219,0.1969,0.0219,0.0219,0.0438,0.0219,0.0219,0.0656,0.0438,0.2188,0.0219,0.0219,0.0219,0.0219,0.0656,0.0438,0.0573,0.0573,0.0573,0.1146,0.1146,0.1146,0.0573,0.0573,0.0573,0.0573,0.0573,0.0573,0.0573,0.0704,0.4577,0.1056,0.0704,0.0704,0.0352,0.0704,0.0352,0.0352,0.0582,0.0291,0.0097,0.1165,0.0776,0.0485,0.0097,0.1165,0.0971,0.1359,0.0776,0.0679,0.0097,0.0097,0.0582,0.0097,0.0097,0.0194,0.0097,0.0194,0.0286,0.0057,0.0057,0.0229,0.0229,0.0171,0.2401,0.0171,0.0286,0.0114,0.0114,0.0057,0.0057,0.0171,0.0057,0.04,0.0286,0.0171,0.0114,0.0114,0.0743,0.0114,0.0114,0.1543,0.0629,0.08,0.0514,0.0057,0.0057,0.0338,0.0338,0.0169,0.0169,0.2364,0.0169,0.0169,0.0169,0.0169,0.0338,0.0338,0.0169,0.0507,0.0338,0.0507,0.0169,0.0338,0.152,0.0169,0.0169,0.0169,0.0844,0.0507,0.0398,0.0133,0.0398,0.0133,0.0265,0.1858,0.0133,0.0133,0.0133,0.0398,0.0133,0.0265,0.0531,0.0398,0.0133,0.0133,0.0929,0.0133,0.0133,0.0133,0.0796,0.0796,0.0133,0.0929,0.0398,0.0133,0.0577,0.0577,0.1154,0.0577,0.0577,0.0577,0.1731,0.0577,0.1154,0.0577,0.0874,0.4808,0.1311,0.0437,0.0437,0.0437,0.0437,0.0437,0.0437,0.0437,0.3702,0.0185,0.037,0.0555,0.037,0.037,0.037,0.037,0.0555,0.0555,0.0185,0.037,0.0185,0.0185,0.037,0.0185,0.0185,0.0185,0.037,0.1327,0.0221,0.0221,0.0221,0.1106,0.0221,0.1549,0.0221,0.0221,0.0221,0.1106,0.0664,0.0885,0.0221,0.0442,0.0442,0.0221,0.0442,0.0416,0.0681,0.0605,0.034,0.0227,0.0681,0.0378,0.0151,0.0113,0.0113,0.0076,0.0416,0.0151,0.0378,0.0113,0.034,0.0303,0.0454,0.0113,0.0227,0.0189,0.0113,0.0227,0.0151,0.0151,0.0946,0.0265,0.0227,0.0227,0.0113,0.0378,0.0038,0.0076,0.0189,0.0151,0.0265,0.0893,0.1276,0.1021,0.0128,0.1276,0.0128,0.051,0.0128,0.0255,0.0255,0.0383,0.051,0.0383,0.0255,0.0128,0.0128,0.0383,0.0893,0.0128,0.0255,0.0255,0.0281,0.0281,0.225,0.0281,0.0844,0.1125,0.0281,0.0844,0.0562,0.0562,0.0562,0.0562,0.0281,0.1137,0.0201,0.0301,0.0936,0.0401,0.0669,0.0501,0.0435,0.0501,0.0535,0.0234,0.0134,0.0267,0.0201,0.0334,0.01,0.0134,0.0234,0.0201,0.01,0.0134,0.0134,0.0167,0.0067,0.0067,0.0134,0.01,0.0267,0.0201,0.0201,0.0201,0.0201,0.0167,0.0334,0.01,0.0578,0.061,0.0257,0.0803,0.0417,0.0161,0.045,0.0482,0.0385,0.0482,0.0257,0.0032,0.0225,0.0353,0.045,0.0161,0.0064,0.0193,0.0257,0.0385,0.0096,0.0289,0.0064,0.0225,0.0193,0.0161,0.0161,0.0032,0.0225,0.0225,0.0128,0.0193,0.0225,0.0128,0.045,0.0225,0.0593,0.0508,0.0169,0.072,0.0381,0.0212,0.0593,0.072,0.0296,0.0508,0.0423,0.0169,0.0296,0.0296,0.0296,0.0169,0.0127,0.0085,0.0212,0.0296,0.0042,0.0212,0.0254,0.0339,0.0212,0.0042,0.0296,0.0254,0.0042,0.0169,0.0254,0.0042,0.0381,0.0381,0.0249,0.0746,0.0373,0.0249,0.0124,0.0497,0.1492,0.0124,0.0124,0.0124,0.0124,0.0124,0.0373,0.0124,0.0249,0.0373,0.0249,0.0124,0.0249,0.0622,0.0373,0.0124,0.0373,0.087,0.0249,0.0622,0.0124,0.0124,0.0249,0.1734,0.0578,0.0578,0.0578,0.1156,0.2312,0.0578,0.0578,0.0578,0.088,0.0352,0.0176,0.1408,0.0704,0.0176,0.1056,0.0704,0.1056,0.0528,0.0352,0.0352,0.0176,0.0176,0.0176,0.0176,0.0352,0.0176,0.0176,0.0176,0.1288,0.0644,0.0644,0.0644,0.0644,0.0644,0.1288,0.0644,0.0644,0.0644,0.0644,0.0644,0.1069,0.0611,0.0458,0.0458,0.0153,0.0763,0.0305,0.0305,0.0153,0.0153,0.0153,0.0305,0.0305,0.0305,0.0153,0.0153,0.0305,0.0305,0.0305,0.0153,0.0305,0.0458,0.0458,0.0458,0.0153,0.0153,0.0153,0.0305,0.0153,0.0153,0.0458,0.2071,0.0345,0.0345,0.069,0.0345,0.0345,0.0345,0.069,0.0345,0.069,0.069,0.0345,0.0345,0.069,0.0345,0.0345,0.0345,0.0687,0.0315,0.0744,0.0515,0.0515,0.0515,0.0544,0.0315,0.0372,0.0229,0.0172,0.0544,0.0372,0.0086,0.0172,0.0487,0.0172,0.0086,0.0229,0.0086,0.02,0.0229,0.0172,0.0086,0.0286,0.0229,0.0115,0.0372,0.0115,0.0286,0.0143,0.0086,0.0115,0.0229,0.0057,0.0057,0.0414,0.0414,0.0414,0.1036,0.0207,0.0207,0.0207,0.0622,0.1865,0.0207,0.0207,0.0622,0.0414,0.0207,0.0414,0.0207,0.0414,0.0622,0.0414,0.0207,0.0611,0.0122,0.0855,0.0611,0.0244,0.0122,0.0978,0.0733,0.0855,0.1833,0.1222,0.0122,0.0122,0.0855,0.0122,0.0122,0.0244,0.02,0.02,0.01,0.0501,0.01,0.01,0.2706,0.02,0.02,0.02,0.01,0.02,0.0501,0.0501,0.01,0.01,0.1102,0.02,0.01,0.01,0.02,0.0701,0.0501,0.01,0.0701,0.0301,0.01,0.01,0.1704,0.0568,0.0568,0.0568,0.0568,0.0568,0.1136,0.0568,0.0568,0.1704,0.1136,0.0335,0.0614,0.1228,0.0056,0.0223,0.0279,0.0168,0.0223,0.0223,0.0223,0.0223,0.0503,0.0056,0.0447,0.0335,0.0168,0.0056,0.0391,0.0112,0.0391,0.0279,0.0168,0.0223,0.0335,0.0223,0.0223,0.0223,0.0335,0.0112,0.0168,0.0335,0.0503,0.0056,0.0112,0.0056,0.0447,0.1912,0.1912,0.0956,0.0956,0.2175,0.2175,0.1088,0.1088,0.1088,0.0268,0.1073,0.2415,0.0268,0.0537,0.0268,0.0268,0.0268,0.0268,0.0268,0.0268,0.0268,0.0268,0.0268,0.0805,0.0537,0.0268,0.0268,0.0268,0.0268,0.0697,0.0697,0.0697,0.1395,0.1395,0.0697,0.0697,0.0697,0.0697,0.0697,0.066,0.0032,0.0032,0.1305,0.1272,0.0451,0.0064,0.095,0.087,0.0902,0.0709,0.0016,0.0902,0.0032,0.0097,0.0032,0.0016,0.0016,0.058,0.0016,0.0032,0.0225,0.0016,0.0531,0.0048,0.0032,0.0097,0.0032,0.0032,0.0016,0.0407,0.0813,0.0542,0.0271,0.0136,0.1356,0.0136,0.0271,0.0136,0.0136,0.0271,0.0542,0.0136,0.0407,0.0136,0.0949,0.0136,0.0271,0.0271,0.0136,0.0949,0.0678,0.0136,0.0271,0.0136,0.0136,0.0405,0.1216,0.1622,0.0405,0.0405,0.0405,0.0405,0.0405,0.0405,0.2838,0.0811,0.0405,0.0405,0.0393,0.0505,0.0533,0.0729,0.0477,0.0337,0.0252,0.0561,0.0308,0.0393,0.0337,0.0196,0.0308,0.028,0.0308,0.0196,0.0589,0.0168,0.0168,0.028,0.0168,0.0168,0.014,0.0224,0.0056,0.0084,0.0196,0.0224,0.0196,0.0224,0.0168,0.014,0.0084,0.0112,0.0056,0.028,0.0486,0.0636,0.1009,0.0262,0.0262,0.0336,0.0262,0.0299,0.0187,0.0224,0.015,0.0598,0.0187,0.0336,0.0299,0.0037,0.0112,0.0449,0.0187,0.0187,0.0449,0.0112,0.015,0.0187,0.015,0.0336,0.0411,0.0486,0.0112,0.0075,0.015,0.0449,0.0037,0.0037,0.0224,0.015,0.0364,0.0545,0.1169,0.0571,0.0467,0.0312,0.0104,0.0571,0.0364,0.0467,0.0286,0.0779,0.0234,0.0104,0.013,0.0078,0.026,0.0182,0.0052,0.0338,0.0078,0.0104,0.0078,0.0182,0.0286,0.0623,0.0286,0.0052,0.0078,0.039,0.0104,0.0052,0.013,0.013,0.013,0.1173,0.0207,0.0379,0.031,0.031,0.0207,0.0138,0.0517,0.0448,0.0517,0.0793,0.0138,0.069,0.0207,0.0138,0.0069,0.0103,0.0483,0.0138,0.0207,0.0034,0.1,0.0069,0.0448,0.0069,0.0034,0.0172,0.0103,0.0103,0.0103,0.0379,0.0034,0.0069,0.0103,0.0587,0.1174,0.1174,0.0587,0.0587,0.0587,0.0587,0.0587,0.0587,0.1174,0.0587,0.0876,0.0876,0.0438,0.0438,0.0219,0.0438,0.0219,0.0219,0.0219,0.0219,0.0219,0.0219,0.0219,0.0219,0.1533,0.0219,0.0219,0.0657,0.0438,0.0219,0.0219,0.0219,0.0657,0.0219,0.0786,0.1179,0.0786,0.0393,0.0393,0.0786,0.0786,0.1179,0.0786,0.0786,0.0393,0.0393,0.0393,0.0393,0.0723,0.0171,0.0076,0.1046,0.0856,0.0285,0.0152,0.0704,0.0609,0.0799,0.1141,0.0038,0.0723,0.0114,0.0228,0.0095,0.0076,0.0057,0.0438,0.0057,0.0057,0.0057,0.0266,0.0019,0.0495,0.0095,0.0057,0.0095,0.0133,0.0057,0.0114,0.0019,0.0114,0.0038,0.0019,0.0387,0.0194,0.0194,0.0194,0.1162,0.0194,0.0194,0.2324,0.1162,0.0387,0.0194,0.0194,0.0581,0.0194,0.0387,0.0194,0.0581,0.0194,0.0581,0.0387,0.0194,0.0693,0.0485,0.0416,0.0416,0.0208,0.0277,0.0485,0.0416,0.0208,0.0208,0.0208,0.0139,0.0208,0.0624,0.0208,0.0347,0.0277,0.0416,0.0139,0.0416,0.0069,0.0208,0.0139,0.0277,0.0069,0.0139,0.0277,0.0277,0.0277,0.0139,0.0208,0.0347,0.0624,0.0139,0.1465,0.0976,0.0488,0.0488,0.0976,0.0488,0.0488,0.0488,0.0976,0.0488,0.0488,0.0488,0.0488,0.0404,0.0674,0.0135,0.0404,0.0404,0.0337,0.0539,0.0303,0.0539,0.0236,0.037,0.0101,0.0236,0.0606,0.0337,0.0606,0.0236,0.0135,0.0202,0.0337,0.0067,0.0269,0.0236,0.0236,0.0168,0.0303,0.0202,0.0269,0.0135,0.0135,0.0168,0.0236,0.0303,0.0135,0.0448,0.0448,0.0448,0.0448,0.0896,0.0448,0.1343,0.0896,0.0896,0.0448,0.0896,0.0448,0.0448,0.0448,0.0448,0.2147,0.0268,0.0537,0.0268,0.0537,0.0537,0.0805,0.0537,0.0537,0.0268,0.0268,0.0268,0.0805,0.0805,0.0537,0.0268,0.0268,0.1792,0.1792,0.0597,0.0597,0.1195,0.0597,0.0597,0.1195,0.0597,0.0359,0.0759,0.1158,0.0359,0.028,0.02,0.02,0.0319,0.0319,0.0359,0.0319,0.1038,0.02,0.0439,0.012,0.024,0.028,0.02,0.012,0.0399,0.012,0.008,0.008,0.016,0.0559,0.028,0.0479,0.012,0.012,0.004,0.004,0.004,0.008,0.008,0.004,0.0246,0.1478,0.1971,0.0739,0.1232,0.0739,0.0986,0.0493,0.1232,0.0739,0.0246,0.0665,0.0393,0.0333,0.0423,0.0393,0.0605,0.0484,0.0272,0.0363,0.0212,0.0242,0.0272,0.0333,0.0091,0.0302,0.0302,0.0333,0.0242,0.0212,0.003,0.0181,0.0181,0.0212,0.003,0.0212,0.0514,0.0363,0.0181,0.0242,0.0212,0.0151,0.0333,0.0151,0.0272,0.0151,0.006,0.0285,0.0285,0.1139,0.0854,0.0285,0.1424,0.0569,0.1139,0.1139,0.0854,0.0285,0.0569,0.0285,0.0285,0.0285,0.07,0.0787,0.105,0.035,0.0087,0.0787,0.0612,0.0787,0.0962,0.0087,0.2012,0.0087,0.0087,0.0787,0.0087,0.0262,0.0262,0.0087,0.1115,0.0074,0.0818,0.1041,0.0297,0.0074,0.078,0.078,0.0706,0.0855,0.0037,0.0966,0.0037,0.0111,0.0037,0.0037,0.1041,0.0037,0.0037,0.0409,0.0483,0.0037,0.0111,0.0037,0.1691,0.0338,0.0338,0.0338,0.0676,0.0338,0.0676,0.1014,0.0676,0.0338,0.1014,0.1014,0.0338,0.0704,0.0861,0.0939,0.0365,0.0339,0.0313,0.0261,0.0235,0.0235,0.0235,0.0209,0.0652,0.0157,0.0313,0.0157,0.0235,0.0313,0.0157,0.0209,0.0365,0.0391,0.0157,0.0287,0.0235,0.0104,0.0078,0.0183,0.013,0.0104,0.0157,0.0104,0.0052,0.0078,0.0157,0.0261,0.0339,0.0907,0.0453,0.0726,0.0227,0.0453,0.0589,0.0045,0.0363,0.0317,0.0317,0.0499,0.0544,0.0453,0.0272,0.0091,0.0045,0.0227,0.0363,0.0227,0.0453,0.0045,0.0453,0.0136,0.0544,0.0181,0.0317,0.0181,0.0045,0.0091,0.0136,0.0091,0.0045,0.0045,0.0091,0.0279,0.0577,0.0239,0.0657,0.0338,0.0259,0.1333,0.0299,0.0318,0.0279,0.0159,0.0239,0.0259,0.0259,0.0338,0.0299,0.0299,0.0119,0.0119,0.0159,0.0179,0.0398,0.008,0.01,0.0119,0.006,0.0239,0.0179,0.0378,0.0219,0.0119,0.0139,0.0418,0.0199,0.0219,0.0119,0.1035,0.0716,0.0637,0.0239,0.0318,0.0239,0.0478,0.0478,0.0159,0.0239,0.0239,0.0398,0.0318,0.008,0.0239,0.0159,0.008,0.0478,0.008,0.008,0.0398,0.008,0.0796,0.008,0.0318,0.0159,0.0318,0.0318,0.0159,0.008,0.0159,0.0159,0.008,0.008,0.008,0.008,0.0824,0.2059,0.0412,0.0412,0.0412,0.0412,0.0412,0.0824,0.0824,0.0824,0.1236,0.0824,0.0358,0.0394,0.068,0.0501,0.0465,0.0501,0.0322,0.0322,0.0286,0.0179,0.0215,0.025,0.025,0.025,0.025,0.0501,0.0358,0.0143,0.025,0.025,0.0143,0.0143,0.025,0.0179,0.0322,0.0072,0.0215,0.0215,0.0143,0.0143,0.0107,0.0465,0.0143,0.0322,0.0215,0.0036,0.0434,0.0651,0.0723,0.0434,0.0398,0.0343,0.0343,0.0235,0.0289,0.0181,0.0343,0.038,0.0235,0.0488,0.0181,0.0181,0.038,0.0163,0.0199,0.0307,0.0235,0.0181,0.0217,0.0271,0.0289,0.0181,0.0217,0.009,0.0181,0.0181,0.0072,0.0235,0.0145,0.0199,0.0108,0.0253,0.0618,0.0225,0.0169,0.0674,0.0955,0.0449,0.0169,0.0449,0.073,0.0393,0.0674,0.0281,0.0899,0.0225,0.0225,0.0281,0.0056,0.0225,0.0393,0.0112,0.0169,0.0112,0.0169,0.0056,0.0281,0.0056,0.0056,0.0281,0.0056,0.0281,0.0056,0.0169,0.0622,0.0207,0.083,0.0415,0.0207,0.1245,0.0415,0.0207,0.0207,0.0207,0.0207,0.0207,0.0415,0.0415,0.0207,0.0207,0.0207,0.083,0.0207,0.0207,0.0207,0.0207,0.0207,0.0415,0.0622,0.0207,0.0622,0.0207,0.095,0.095,0.095,0.19,0.095,0.095,0.0569,0.0634,0.0328,0.0416,0.0481,0.0109,0.0284,0.0394,0.0284,0.0262,0.0394,0.0262,0.0306,0.0591,0.0087,0.0109,0.0437,0.0569,0.0284,0.0612,0.0066,0.0109,0.0591,0.0306,0.0284,0.0044,0.0044,0.0262,0.0087,0.0087,0.0131,0.0087,0.0066,0.0328,0.0109,0.1067,0.0734,0.0133,0.0267,0.06,0.0067,0.0133,0.0534,0.0534,0.0667,0.0667,0.0133,0.0534,0.0333,0.0067,0.0133,0.0067,0.0067,0.0534,0.02,0.0067,0.0067,0.08,0.0133,0.0267,0.02,0.0067,0.02,0.0067,0.0467,0.0133,0.0161,0.1285,0.0643,0.0161,0.0161,0.1285,0.0161,0.0161,0.1125,0.0161,0.0161,0.1125,0.0161,0.0161,0.0321,0.2249,0.0502,0.0458,0.0109,0.0545,0.0327,0.0305,0.1178,0.0305,0.0305,0.0371,0.0218,0.0153,0.0218,0.0174,0.024,0.0502,0.0131,0.0284,0.0174,0.0196,0.0044,0.0349,0.0174,0.0131,0.0109,0.0196,0.0109,0.0087,0.0523,0.024,0.0109,0.0109,0.0414,0.0436,0.0174,0.0087,0.0358,0.0653,0.0674,0.0274,0.0232,0.0147,0.0822,0.0147,0.0253,0.0211,0.0126,0.0379,0.019,0.0295,0.0379,0.0442,0.0569,0.0126,0.0126,0.0211,0.0253,0.0232,0.0147,0.0169,0.0105,0.0506,0.0253,0.0211,0.0253,0.019,0.0274,0.0021,0.0295,0.0253,0.0126,0.0126,0.0595,0.1614,0.0934,0.0255,0.017,0.017,0.017,0.0085,0.0255,0.017,0.0934,0.017,0.034,0.0255,0.0085,0.0085,0.0849,0.0085,0.0085,0.017,0.0765,0.017,0.0255,0.0085,0.0085,0.0085,0.0085,0.0085,0.034,0.051,0.0255,0.0159,0.1111,0.1429,0.0317,0.0476,0.0159,0.0159,0.0159,0.0159,0.0159,0.0317,0.0159,0.0159,0.0159,0.0159,0.0159,0.0159,0.0159,0.1111,0.0159,0.0159,0.0317,0.0794,0.1111,0.0635,0.0159,0.0299,0.0149,0.0897,0.0448,0.1046,0.0149,0.0299,0.0598,0.0448,0.0149,0.1046,0.0448,0.0149,0.0149,0.0149,0.0149,0.0149,0.0897,0.0149,0.0149,0.0149,0.0149,0.0149,0.1046,0.0149,0.0149,0.0149,0.0378,0.1794,0.0661,0.0094,0.0094,0.0566,0.0094,0.0189,0.0094,0.0094,0.0661,0.0661,0.0189,0.0189,0.0661,0.0378,0.0472,0.0189,0.0094,0.0378,0.0094,0.0094,0.0378,0.0283,0.0094,0.0472,0.0189,0.0283,0.0094,0.0638,0.0638,0.1276,0.0638,0.1276,0.4467,0.0504,0.1155,0.0296,0.0563,0.0237,0.0089,0.0355,0.0296,0.0178,0.0267,0.0267,0.003,0.0059,0.0652,0.0622,0.0237,0.0326,0.0118,0.0118,0.0444,0.0059,0.0148,0.0237,0.0355,0.0059,0.0059,0.0296,0.0118,0.0207,0.0178,0.0207,0.0089,0.0178,0.0326,0.0415,0.0267,0.0181,0.0362,0.0362,0.0362,0.0543,0.0362,0.0362,0.0181,0.0362,0.0362,0.0181,0.362,0.0543,0.0181,0.0543,0.0181,0.0181,0.0181,0.0181,0.0181,0.0181,0.0181,0.0181,0.0528,0.1759,0.088,0.0528,0.1232,0.1584,0.1232,0.0528,0.0528,0.0176,0.0528,0.0176,0.0176,0.0658,0.0439,0.1754,0.1535,0.0219,0.0219,0.1097,0.0219,0.0219,0.0439,0.0877,0.0219,0.0658,0.0658,0.0439,0.0219,0.0537,0.1612,0.0537,0.0537,0.0537,0.0537,0.0537,0.0537,0.0537,0.1075,0.0537,0.0631,0.0149,0.0334,0.0297,0.0371,0.0186,0.1337,0.026,0.0223,0.026,0.0223,0.0149,0.0409,0.0149,0.0149,0.052,0.0966,0.0149,0.0149,0.0074,0.0111,0.0334,0.052,0.0111,0.0186,0.0037,0.0111,0.0446,0.0186,0.0037,0.0186,0.0297,0.026,0.0111,0.0074,0.1308,0.1308,0.0654,0.1308,0.0654,0.0654,0.0654,0.0654,0.0654,0.1308,0.0654,0.0354,0.1133,0.0212,0.0142,0.0071,0.0991,0.0071,0.0071,0.0071,0.0212,0.0071,0.0071,0.2408,0.0142,0.0283,0.0071,0.0142,0.0071,0.085,0.0283,0.0212,0.0567,0.0071,0.0283,0.0071,0.0071,0.0212,0.0142,0.0212,0.0354,0.026,0.0228,0.0033,0.0358,0.026,0.0033,0.1983,0.0065,0.0228,0.0098,0.0065,0.0098,0.0098,0.0163,0.0488,0.1268,0.0228,0.0033,0.0033,0.0065,0.0033,0.0618,0.0065,0.013,0.0033,0.0618,0.0553,0.0098,0.0065,0.0618,0.078,0.0325,0.0295,0.059,0.2361,0.0295,0.059,0.0295,0.0295,0.0885,0.059,0.0885,0.0295,0.118,0.0295,0.0295,0.0624,0.0779,0.0641,0.0312,0.0537,0.0225,0.0312,0.0312,0.0381,0.0242,0.0294,0.0589,0.0329,0.026,0.0208,0.0104,0.0087,0.0139,0.0242,0.0173,0.0364,0.0104,0.0364,0.0052,0.0191,0.0398,0.045,0.0277,0.0104,0.0191,0.0191,0.0121,0.0052,0.0121,0.0173,0.0104,0.1615,0.4845,0.0538,0.0538,0.0538,0.0538,0.0538,0.0458,0.0686,0.1144,0.0686,0.0381,0.0114,0.0229,0.0496,0.0305,0.0419,0.0305,0.0534,0.0153,0.0191,0.0153,0.0076,0.0153,0.0191,0.0191,0.0191,0.0343,0.0038,0.0114,0.0114,0.0076,0.0648,0.0572,0.0153,0.0114,0.0038,0.0305,0.0076,0.0076,0.0153,0.0751,0.0345,0.0101,0.0974,0.0467,0.0731,0.0304,0.0467,0.0426,0.0609,0.0365,0.0142,0.0244,0.0284,0.0426,0.0467,0.0284,0.0183,0.0244,0.0183,0.0041,0.0183,0.0304,0.0081,0.0203,0.0061,0.0041,0.0041,0.0304,0.0142,0.0041,0.0162,0.0101,0.0162,0.0101,0.0041,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.1705,0.1137,0.1137,0.0802,0.0802,0.0802,0.0802,0.0802,0.0802,0.2407,0.0802,0.0508,0.0436,0.0654,0.0654,0.0726,0.0436,0.0145,0.0581,0.0436,0.0363,0.0363,0.1307,0.0363,0.0073,0.0073,0.0073,0.0145,0.0218,0.0073,0.029,0.0145,0.0073,0.0073,0.0363,0.0145,0.0218,0.0799,0.0073,0.0073,0.0073,0.0073,0.0073,0.0836,0.0836,0.0836,0.0836,0.0836,0.0836,0.0836,0.0836,0.0836,0.0836,0.0766,0.0625,0.0202,0.0706,0.0807,0.0202,0.0141,0.0565,0.0464,0.0524,0.0706,0.0121,0.0565,0.0444,0.0081,0.0141,0.0262,0.006,0.0363,0.0262,0.002,0.0101,0.0141,0.0161,0.0464,0.0202,0.0141,0.004,0.004,0.0141,0.0141,0.002,0.0081,0.0081,0.0121,0.0101,0.0889,0.2159,0.0127,0.0508,0.0381,0.0889,0.0127,0.127,0.1016,0.1143,0.0635,0.0254,0.0578,0.0578,0.1733,0.0578,0.1155,0.1155,0.1155,0.0578,0.0578,0.0578,0.1155,0.0227,0.0795,0.0341,0.0114,0.0114,0.1249,0.0114,0.0114,0.0454,0.1022,0.0227,0.0341,0.0114,0.0114,0.0681,0.0454,0.0454,0.0114,0.0114,0.0454,0.0568,0.0227,0.0681,0.0341,0.0227,0.0114,0.2396,0.2396,0.1198,0.1198,0.1198,0.0558,0.2605,0.0744,0.0558,0.1302,0.093,0.1116,0.0744,0.0744,0.0558,0.0186,0.063,0.063,0.063,0.063,0.1259,0.063,0.063,0.063,0.063,0.063,0.1259,0.063,0.1659,0.1659,0.0829,0.0829,0.0829,0.0228,0.0364,0.0501,0.0364,0.0137,0.0273,0.1321,0.0137,0.0091,0.0228,0.0228,0.0273,0.0091,0.0228,0.0455,0.0729,0.0364,0.0046,0.0046,0.0137,0.0091,0.0592,0.0228,0.0228,0.0091,0.0137,0.0137,0.041,0.0455,0.0137,0.0046,0.0455,0.041,0.0228,0.0046,0.0309,0.0176,0.0176,0.0397,0.0221,0.0265,0.1721,0.0176,0.0309,0.0132,0.0221,0.0088,0.0088,0.0221,0.0574,0.0397,0.1235,0.0088,0.0088,0.0088,0.0044,0.0618,0.0044,0.0221,0.0088,0.0088,0.0397,0.0309,0.0044,0.0044,0.0574,0.0309,0.0265,0.0044,0.0244,0.0325,0.1869,0.0081,0.0244,0.0081,0.0163,0.0081,0.0163,0.0081,0.3169,0.0081,0.0081,0.0163,0.0081,0.0081,0.0244,0.0081,0.0569,0.0163,0.0081,0.0081,0.0325,0.0488,0.0406,0.0081,0.0163,0.0081,0.0081,0.0081,0.0115,0.0806,0.2532,0.0115,0.0115,0.0115,0.0115,0.023,0.023,0.0115,0.0115,0.0921,0.0115,0.023,0.0115,0.023,0.0115,0.0115,0.0806,0.023,0.023,0.023,0.0806,0.0345,0.0345,0.0115,0.0345,0.0115,0.0115,0.1321,0.0881,0.044,0.3524,0.044,0.044,0.044,0.044,0.044,0.044,0.044,0.044,0.044,0.0567,0.0749,0.0728,0.0567,0.0789,0.0465,0.0142,0.0324,0.0324,0.0304,0.0344,0.0263,0.0445,0.0283,0.0202,0.0162,0.0263,0.0202,0.0304,0.0202,0.0283,0.0081,0.0142,0.0101,0.0121,0.0324,0.0223,0.0202,0.004,0.0101,0.0283,0.0202,0.004,0.004,0.004,0.0202,0.0616,0.0616,0.0308,0.0308,0.0308,0.0616,0.0308,0.0308,0.0308,0.0308,0.0308,0.0616,0.0616,0.0616,0.0308,0.0308,0.0616,0.0308,0.0308,0.0924,0.0308,0.0308,0.0308,0.0431,0.1292,0.0861,0.0861,0.0431,0.1292,0.0861,0.0861,0.0431,0.0861,0.0431,0.0431,0.0431,0.0431,0.0414,0.1243,0.0414,0.0828,0.0414,0.0414,0.0414,0.0414,0.0414,0.0414,0.0414,0.0414,0.0828,0.1243,0.0414,0.0414,0.0353,0.2118,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.1059,0.0353,0.0706,0.0353,0.0706,0.0353,0.0353,0.0353,0.0353,0.1148,0.1148,0.1148,0.1148,0.1148,0.0144,0.2827,0.091,0.0048,0.0096,0.0048,0.0096,0.0096,0.0192,0.115,0.0144,0.0096,0.0144,0.0623,0.0192,0.0048,0.0048,0.0671,0.0048,0.0288,0.0623,0.0192,0.024,0.0048,0.0048,0.0479,0.0383,0.1255,0.0066,0.0925,0.1123,0.033,0.0132,0.0925,0.0727,0.0991,0.066,0.0132,0.0727,0.0066,0.0198,0.0066,0.0066,0.0528,0.0066,0.033,0.033,0.0066,0.0132,0.0538,0.0538,0.1076,0.0538,0.0538,0.1076,0.0538,0.1615,0.0538,0.1076,0.1076,0.0538,0.0158,0.1026,0.3051,0.0079,0.0158,0.0053,0.0053,0.0105,0.0053,0.0053,0.0605,0.0026,0.0368,0.0105,0.0079,0.0053,0.0184,0.0552,0.0237,0.0079,0.0132,0.0289,0.0026,0.071,0.0526,0.021,0.0026,0.0421,0.0026,0.0158,0.0421,0.0699,0.0699,0.2098,0.0699,0.0699,0.0699,0.0699,0.0699,0.0699,0.0911,0.0455,0.0911,0.0455,0.0911,0.0455,0.0911,0.0911,0.0455,0.0911,0.0455,0.0911,0.0247,0.089,0.0568,0.0395,0.0321,0.0148,0.0346,0.0297,0.0124,0.0222,0.0173,0.0173,0.0074,0.1063,0.0173,0.0198,0.0272,0.0074,0.0025,0.0692,0.0173,0.0198,0.0198,0.0445,0.0173,0.0198,0.0124,0.0148,0.0173,0.0148,0.0222,0.0173,0.0198,0.0198,0.0198,0.0519,0.1564,0.0521,0.0521,0.0521,0.0521,0.0521,0.1043,0.0521,0.0521,0.0521,0.0521,0.0521,0.0521,0.0521,0.0414,0.0466,0.1294,0.0311,0.0207,0.0362,0.0155,0.0155,0.0104,0.0155,0.1087,0.0052,0.0052,0.0414,0.0311,0.0362,0.0155,0.0828,0.0207,0.0155,0.0104,0.0466,0.0104,0.1346,0.0311,0.0052,0.0155,0.0207,0.0052,0.0158,0.0789,0.142,0.0105,0.0263,0.0158,0.0053,0.0158,0.0105,0.0053,0.0053,0.1525,0.0053,0.0263,0.0053,0.0053,0.0263,0.0053,0.0158,0.1052,0.0105,0.0158,0.0158,0.0105,0.0526,0.0316,0.0631,0.0368,0.021,0.0053,0.0421,0.0418,0.251,0.0418,0.0418,0.0837,0.0837,0.0837,0.0837,0.0418,0.0837,0.0543,0.0868,0.0434,0.0326,0.0217,0.0109,0.0217,0.0326,0.0326,0.0326,0.0217,0.0217,0.0217,0.1085,0.0217,0.0217,0.0434,0.0109,0.0109,0.0977,0.0109,0.0217,0.0217,0.0868,0.0109,0.0109,0.0109,0.0109,0.0109,0.0109,0.0109,0.0326,0.0326,0.0257,0.1454,0.0599,0.0086,0.0086,0.0086,0.0171,0.0086,0.2053,0.0086,0.0171,0.2395,0.1027,0.0086,0.0086,0.0086,0.0342,0.0599,0.0195,0.1755,0.0195,0.0195,0.2144,0.0195,0.2729,0.117,0.0195,0.0195,0.039,0.0848,0.0424,0.1697,0.0424,0.0848,0.0424,0.0848,0.0848,0.0848,0.0848,0.0424,0.0424,0.0424,0.0424,0.0821,0.0205,0.0616,0.0616,0.0205,0.041,0.0616,0.0616,0.0616,0.0616,0.0616,0.0205,0.041,0.0205,0.0616,0.0205,0.0205,0.1026,0.041,0.0205,0.0205,0.0205,0.177,0.0885,0.0885,0.0885,0.0885,0.0885,0.0585,0.1169,0.0585,0.0585,0.0585,0.0585,0.0585,0.0585,0.1169,0.0585,0.1169,0.0675,0.0675,0.0675,0.135,0.0675,0.0675,0.0675,0.135,0.0522,0.0522,0.0522,0.0522,0.1044,0.0522,0.0522,0.1044,0.0522,0.1044,0.0522,0.0522,0.0996,0.072,0.0199,0.0521,0.0674,0.0521,0.0107,0.023,0.0322,0.0215,0.0307,0.0307,0.0414,0.049,0.0077,0.0061,0.0153,0.0092,0.0291,0.0261,0.0245,0.0046,0.0552,0.0138,0.0368,0.0107,0.0414,0.0077,0.0061,0.0138,0.0215,0.023,0.0015,0.0015,0.0276,0.0169,0.1183,0.0316,0.0316,0.0316,0.0434,0.067,0.0355,0.0197,0.0394,0.0316,0.0316,0.0158,0.0355,0.0118,0.0316,0.0118,0.0749,0.0118,0.0276,0.0197,0.0276,0.0197,0.0237,0.0039,0.0276,0.0197,0.0158,0.0197,0.0276,0.0197,0.0079,0.0355,0.0118,0.0079,0.0079,0.0479,0.016,0.0319,0.2233,0.016,0.016,0.016,0.016,0.016,0.016,0.016,0.0638,0.016,0.016,0.0479,0.016,0.016,0.016,0.016,0.335,0.0397,0.0199,0.0199,0.1192,0.2185,0.0596,0.0199,0.1192,0.0795,0.0795,0.0397,0.0993,0.0596,0.0199,0.0165,0.0165,0.0165,0.0165,0.0165,0.0165,0.0165,0.0165,0.0165,0.0825,0.5611,0.0165,0.0165,0.0165,0.0165,0.0165,0.0165,0.033,0.033,0.033,0.0165,0.1447,0.1447,0.1447,0.1447,0.1447,0.0232,0.0927,0.2241,0.0077,0.0077,0.0155,0.0155,0.0155,0.0077,0.0077,0.1005,0.0077,0.0077,0.0155,0.0386,0.0077,0.0155,0.0541,0.0232,0.0155,0.0077,0.0695,0.0464,0.0695,0.0464,0.0077,0.0232,0.0077,0.0458,0.0356,0.0839,0.0305,0.028,0.0356,0.0254,0.0254,0.0254,0.0203,0.0153,0.117,0.0076,0.0203,0.0153,0.0076,0.0178,0.0661,0.0153,0.0839,0.0127,0.0203,0.0025,0.0254,0.0331,0.0534,0.0076,0.0102,0.0483,0.0382,0.0025,0.0025,0.0153,0.0025,0.1028,0.0343,0.0343,0.0343,0.0514,0.0171,0.0685,0.0514,0.0685,0.0514,0.0343,0.0343,0.0514,0.0171,0.0343,0.0171,0.0343,0.0343,0.0171,0.0171,0.0171,0.0343,0.0514,0.0171,0.0171,0.0171,0.0171,0.0918,0.0076,0.0535,0.0841,0.0306,0.0229,0.0688,0.0612,0.0765,0.0841,0.0076,0.0765,0.0076,0.0153,0.0229,0.0153,0.0612,0.0076,0.0229,0.0382,0.0076,0.0229,0.0153,0.0076,0.0306,0.0229,0.0076,0.0153,0.0153,0.2023,0.0506,0.0506,0.0506,0.1012,0.0506,0.0506,0.0506,0.0506,0.0506,0.0506,0.1012,0.0506,0.0506,0.0506,0.1062,0.0415,0.0462,0.0415,0.0277,0.06,0.0323,0.0277,0.0231,0.0369,0.0508,0.0323,0.0369,0.0185,0.0231,0.0092,0.0185,0.0185,0.0369,0.0092,0.0231,0.0138,0.0739,0.0138,0.0323,0.0323,0.0185,0.0185,0.0231,0.0231,0.0046,0.0092,0.0138,0.081,0.0405,0.081,0.1619,0.0405,0.1214,0.081,0.081,0.0405,0.0405,0.0405,0.0405,0.0405,0.0405,0.0569,0.1493,0.0924,0.0142,0.0142,0.0142,0.0071,0.0142,0.0142,0.0142,0.0142,0.0284,0.0213,0.0498,0.0284,0.0142,0.0071,0.0071,0.0213,0.0498,0.0213,0.0142,0.0356,0.0498,0.0213,0.0142,0.0356,0.0569,0.0071,0.0142,0.0071,0.0071,0.0071,0.0356,0.0498,0.0194,0.2228,0.0097,0.0097,0.0097,0.0097,0.0097,0.2518,0.0097,0.0097,0.184,0.1162,0.0097,0.0097,0.0097,0.0291,0.0581,0.0623,0.3738,0.0623,0.0623,0.0623,0.0623,0.1246,0.0623,0.1355,0.0677,0.2371,0.0339,0.0339,0.0339,0.0677,0.0339,0.0677,0.0339,0.0339,0.0339,0.1355,0.0759,0.0379,0.0379,0.1138,0.0759,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0379,0.0759,0.0379,0.028,0.1399,0.0839,0.028,0.1679,0.028,0.028,0.1119,0.056,0.1119,0.056,0.056,0.028,0.028,0.028,0.0506,0.0506,0.1854,0.0169,0.0506,0.0169,0.0169,0.0337,0.0169,0.0843,0.0169,0.1011,0.0169,0.0506,0.0169,0.0337,0.0169,0.0337,0.1854,0.0169,0.0169,0.043,0.0859,0.0859,0.043,0.0859,0.043,0.043,0.043,0.043,0.043,0.043,0.0859,0.0859,0.043,0.043,0.043,0.1289,0.0283,0.0283,0.0283,0.0567,0.0283,0.1417,0.0283,0.0283,0.0283,0.0283,0.0283,0.0283,0.085,0.0283,0.0283,0.085,0.085,0.0567,0.0283,0.0283,0.0979,0.0392,0.0392,0.0783,0.0196,0.0196,0.0392,0.0979,0.0392,0.0392,0.0196,0.0392,0.0392,0.0196,0.0196,0.0196,0.0196,0.0392,0.0196,0.0196,0.0196,0.0196,0.0196,0.0196,0.0392,0.0196,0.0196,0.0298,0.0298,0.0895,0.1193,0.0298,0.0298,0.0895,0.0895,0.0298,0.0895,0.0298,0.0596,0.0895,0.0298,0.1193,0.0596,0.0537,0.0806,0.0537,0.0537,0.0269,0.0269,0.0269,0.1075,0.0806,0.0537,0.0269,0.0269,0.0269,0.0537,0.0537,0.0269,0.0269,0.0269,0.0269,0.0269,0.0269,0.0269,0.0269,0.1443,0.0103,0.0515,0.0928,0.0619,0.0103,0.0619,0.0825,0.0825,0.0619,0.0103,0.0619,0.0103,0.0103,0.0103,0.0103,0.0206,0.0619,0.0103,0.0103,0.0515,0.0309,0.0103,0.0103,0.0206,0.1025,0.1538,0.0683,0.0513,0.0171,0.1025,0.0683,0.1367,0.0683,0.0171,0.0683,0.0171,0.0171,0.0683,0.0171,0.0171,0.0171,0.0711,0.0082,0.0096,0.1203,0.1367,0.0314,0.0055,0.0806,0.0902,0.0779,0.0697,0.0109,0.0875,0.0082,0.0109,0.0027,0.0055,0.0027,0.0519,0.0068,0.0041,0.0027,0.0205,0.0014,0.056,0.0014,0.0055,0.0096,0.0027,0.0014,0.0027,0.0055,0.0014,0.0547,0.0547,0.1094,0.0547,0.0547,0.164,0.0547,0.0547,0.1094,0.0547,0.0547,0.0426,0.0483,0.0426,0.0596,0.0426,0.0483,0.0255,0.0426,0.0397,0.0369,0.0284,0.0284,0.0255,0.0369,0.0568,0.0397,0.0284,0.0199,0.0199,0.0397,0.0199,0.0255,0.0085,0.0114,0.0057,0.0142,0.0114,0.0142,0.0199,0.0312,0.0057,0.017,0.017,0.0199,0.0114,0.0114,0.0577,0.0454,0.0825,0.0619,0.0495,0.033,0.0082,0.0412,0.0206,0.0247,0.0495,0.0701,0.0701,0.0165,0.0289,0.0124,0.0041,0.0412,0.0289,0.0124,0.033,0.0124,0.0041,0.0124,0.0206,0.0082,0.0165,0.0165,0.0206,0.0124,0.0495,0.0082,0.0082,0.0124,0.0978,0.0326,0.0652,0.0326,0.1305,0.0326,0.0326,0.0326,0.0652,0.0326,0.0978,0.0326,0.0326,0.0652,0.0652,0.0326,0.0326,0.0326,0.0234,0.0934,0.1635,0.0234,0.0701,0.0234,0.0234,0.1635,0.0934,0.0701,0.1635,0.0234,0.1362,0.0454,0.0908,0.0454,0.0454,0.0454,0.0908,0.0908,0.0908,0.0908,0.0454,0.0454,0.0454,0.0217,0.0217,0.0217,0.0217,0.2383,0.0217,0.0217,0.0217,0.065,0.0866,0.0217,0.0217,0.0217,0.13,0.0217,0.0433,0.065,0.0866,0.0217,0.1062,0.6374,0.0543,0.1494,0.1087,0.0815,0.0136,0.0951,0.0815,0.0543,0.0679,0.0136,0.1223,0.0136,0.0136,0.0679,0.0136,0.0272,0.0136,0.0292,0.078,0.0585,0.0292,0.0214,0.0331,0.0468,0.0156,0.0117,0.0156,0.0214,0.0058,0.0175,0.076,0.0331,0.0234,0.0702,0.0156,0.0058,0.0507,0.0136,0.0214,0.0058,0.039,0.0078,0.0448,0.0195,0.0097,0.0234,0.0214,0.0253,0.0117,0.0273,0.0156,0.0136,0.039,0.0507,0.0721,0.0585,0.0487,0.0604,0.0175,0.0078,0.0468,0.0312,0.037,0.039,0.0331,0.0546,0.0331,0.0234,0.0175,0.0604,0.0058,0.0292,0.0273,0.0273,0.0078,0.0234,0.0136,0.0175,0.037,0.0097,0.0331,0.0097,0.0078,0.0058,0.0058,0.0039,0.0117,0.0078,0.0253,0.0377,0.0377,0.0377,0.1885,0.0377,0.0754,0.0377,0.1131,0.0377,0.0754,0.0377,0.0754,0.0377,0.0377,0.034,0.0408,0.1631,0.0068,0.0136,0.0136,0.0204,0.0068,0.0068,0.0068,0.3193,0.0204,0.0068,0.0136,0.0068,0.0204,0.0136,0.0611,0.0136,0.0204,0.0068,0.0136,0.0476,0.0476,0.0068,0.0204,0.0068,0.0068,0.0068,0.0068,0.0366,0.2198,0.0586,0.022,0.044,0.044,0.0073,0.0366,0.0147,0.0147,0.0147,0.044,0.0147,0.0879,0.0073,0.0147,0.022,0.0147,0.0659,0.0147,0.0147,0.0073,0.0366,0.0366,0.0366,0.0147,0.0073,0.0073,0.0073,0.0147,0.022,0.052,0.1561,0.3122,0.052,0.052,0.052,0.052,0.052,0.052,0.052,0.052,0.2937,0.1958,0.049,0.0979,0.049,0.049,0.049,0.0979,0.049,0.0375,0.0375,0.0375,0.0375,0.0749,0.0375,0.0375,0.0375,0.0375,0.0375,0.1499,0.0375,0.0375,0.0375,0.0375,0.0375,0.0375,0.0749,0.0375,0.1586,0.1189,0.0396,0.0793,0.0793,0.2775,0.0793,0.0396,0.0396,0.062,0.0089,0.1506,0.1063,0.062,0.0089,0.1152,0.0975,0.0975,0.062,0.0089,0.0797,0.0089,0.0089,0.0089,0.0089,0.0443,0.0089,0.0089,0.0266,0.0089,0.0814,0.057,0.0326,0.0489,0.0733,0.0163,0.0163,0.0489,0.0326,0.0651,0.0489,0.0081,0.057,0.0326,0.0244,0.0081,0.0081,0.0081,0.0326,0.0326,0.0081,0.0081,0.0977,0.0407,0.0081,0.0081,0.0163,0.0244,0.0163,0.0081,0.0081,0.0326,0.0821,0.0075,0.0075,0.0932,0.1044,0.1156,0.0112,0.0709,0.0858,0.0448,0.0559,0.0037,0.0671,0.0075,0.0075,0.0075,0.0037,0.0112,0.0522,0.0075,0.0037,0.0261,0.0821,0.0112,0.0075,0.0112,0.0149,0.0869,0.0224,0.0056,0.1037,0.1037,0.0364,0.014,0.0729,0.1009,0.0757,0.0701,0.0084,0.0645,0.014,0.0168,0.0112,0.0056,0.0476,0.0112,0.0028,0.0056,0.0196,0.0056,0.0308,0.0056,0.0056,0.0056,0.0392,0.0028,0.0632,0.0057,0.0172,0.1149,0.0919,0.0402,0.0057,0.0977,0.1149,0.0919,0.0632,0.0172,0.069,0.0115,0.0115,0.0057,0.0115,0.0057,0.0402,0.0115,0.0057,0.0115,0.0057,0.0402,0.0057,0.0057,0.0057,0.0057,0.0057,0.0252,0.1132,0.1698,0.0063,0.0314,0.0377,0.0189,0.0126,0.0126,0.0943,0.0189,0.0189,0.0252,0.0063,0.0314,0.0063,0.0252,0.0252,0.0189,0.0189,0.0063,0.0252,0.0629,0.0377,0.0377,0.0063,0.0189,0.0566,0.0252,0.1057,0.3434,0.1849,0.0264,0.0264,0.0264,0.0264,0.0792,0.0792,0.0596,0.0229,0.039,0.0619,0.0481,0.039,0.0619,0.0367,0.0252,0.0436,0.0344,0.0229,0.0459,0.0344,0.0183,0.0252,0.0573,0.0206,0.0229,0.0069,0.0115,0.0183,0.016,0.0069,0.0275,0.0321,0.0115,0.0138,0.0183,0.0183,0.039,0.0138,0.0252,0.016,0.0023,0.0046,0.0861,0.0417,0.0417,0.0445,0.0667,0.0417,0.0445,0.0306,0.0333,0.025,0.0389,0.05,0.0361,0.0222,0.0111,0.0222,0.0167,0.0278,0.0333,0.0139,0.025,0.0139,0.0556,0.0083,0.0278,0.0222,0.0195,0.0167,0.0167,0.0083,0.0111,0.0111,0.0139,0.0111,0.0083,0.0056,0.0293,0.1466,0.1173,0.0293,0.2053,0.088,0.1173,0.088,0.0587,0.0587,0.2215,0.0443,0.0443,0.0886,0.0443,0.0886,0.0443,0.0443,0.0443,0.2215,0.0855,0.171,0.0641,0.0641,0.1069,0.0855,0.1069,0.0641,0.0641,0.0214,0.0214,0.0427,0.0214,0.0214,0.0707,0.0267,0.0611,0.0554,0.0535,0.0248,0.0286,0.042,0.0458,0.0535,0.0401,0.042,0.0439,0.0076,0.0172,0.0267,0.0038,0.0076,0.0325,0.0057,0.0477,0.0134,0.0592,0.0038,0.0248,0.021,0.0325,0.0153,0.0115,0.0134,0.0229,0.0095,0.0134,0.0172,0.0057,0.0057,0.0452,0.0679,0.0226,0.181,0.0452,0.0226,0.0452,0.0452,0.0226,0.1131,0.0905,0.0226,0.0679,0.0226,0.0452,0.0452,0.0679,0.0226,0.0521,0.0999,0.0434,0.0391,0.0261,0.0174,0.013,0.0174,0.0304,0.0174,0.0347,0.0087,0.0217,0.1216,0.0217,0.013,0.0478,0.0087,0.0217,0.0738,0.013,0.0174,0.013,0.0565,0.0217,0.0174,0.013,0.0087,0.0087,0.0043,0.0174,0.013,0.0087,0.0087,0.0261,0.0347,0.0765,0.1032,0.0535,0.042,0.0229,0.0726,0.0076,0.0229,0.0268,0.0268,0.0229,0.0191,0.0191,0.0344,0.0191,0.0115,0.0076,0.0191,0.0153,0.0268,0.0229,0.0115,0.0153,0.0153,0.0153,0.0573,0.042,0.0268,0.0115,0.0076,0.0268,0.0688,0.0076,0.0115,0.0191,0.0425,0.075,0.035,0.055,0.0325,0.08,0.02,0.03,0.03,0.02,0.03,0.0275,0.0325,0.045,0.0225,0.025,0.0225,0.0225,0.0225,0.0425,0.01,0.01,0.0075,0.02,0.0175,0.03,0.0275,0.015,0.0125,0.0175,0.0125,0.0325,0.0025,0.015,0.05,0.0125,0.0489,0.0978,0.1222,0.0391,0.0244,0.1173,0.0098,0.0147,0.0098,0.0147,0.0049,0.0538,0.0049,0.0293,0.0293,0.0098,0.0049,0.0831,0.0098,0.0049,0.0342,0.0098,0.0049,0.0049,0.0098,0.0538,0.0147,0.0098,0.0049,0.0049,0.0782,0.0049,0.0049,0.0244,0.0845,0.0028,0.0056,0.138,0.107,0.0479,0.0084,0.0817,0.1014,0.1126,0.0704,0.0056,0.0732,0.0056,0.0141,0.0056,0.0028,0.0028,0.045,0.0028,0.0028,0.0028,0.0169,0.0028,0.031,0.0056,0.0084,0.0056,0.0028,0.0028,0.0832,0.1665,0.0416,0.1249,0.0416,0.0416,0.0832,0.0832,0.0832,0.0832,0.0416,0.0416,0.0416,0.1318,0.0879,0.0439,0.0439,0.022,0.0659,0.022,0.0439,0.0439,0.022,0.022,0.022,0.022,0.022,0.0439,0.022,0.0439,0.0439,0.022,0.022,0.022,0.022,0.022,0.0659,0.0249,0.1491,0.0621,0.0249,0.0124,0.0249,0.0124,0.1119,0.0124,0.0373,0.0124,0.0249,0.1616,0.0124,0.087,0.0373,0.0124,0.0124,0.0249,0.0124,0.0249,0.0497,0.0774,0.0774,0.0774,0.0774,0.0774,0.0774,0.0774,0.0774,0.1073,0.1073,0.161,0.1073,0.0537,0.161,0.1073,0.0537,0.0537,0.0537,0.0304,0.1421,0.0812,0.0254,0.0127,0.033,0.0127,0.0127,0.0127,0.0152,0.0178,0.0178,0.0127,0.066,0.0152,0.0203,0.0203,0.0203,0.0051,0.0507,0.0381,0.0152,0.0178,0.0406,0.0152,0.0203,0.0304,0.0254,0.0076,0.0101,0.0279,0.0355,0.0025,0.0152,0.0279,0.0457,0.0343,0.1054,0.0686,0.0196,0.0147,0.1152,0.0123,0.0147,0.0074,0.0074,0.0147,0.0343,0.0049,0.0466,0.0172,0.0147,0.0147,0.0515,0.0049,0.0343,0.0245,0.0098,0.0049,0.0319,0.0025,0.0637,0.0466,0.0123,0.0074,0.0025,0.0392,0.0784,0.0049,0.0123,0.0245,0.0713,0.0594,0.0357,0.0238,0.0238,0.1308,0.0119,0.0119,0.0238,0.0476,0.0119,0.0238,0.0476,0.0238,0.2259,0.0119,0.0119,0.0476,0.0119,0.0119,0.0119,0.0119,0.0357,0.0119,0.0476,0.0119,0.0119,0.0145,0.116,0.145,0.0145,0.0145,0.0145,0.0725,0.0145,0.0145,0.0145,0.029,0.1305,0.0145,0.0145,0.0145,0.319,0.029,0.0762,0.0762,0.0691,0.0715,0.0405,0.0381,0.0167,0.0357,0.0524,0.0453,0.0429,0.0334,0.0357,0.0119,0.0095,0.0119,0.0119,0.0119,0.031,0.0095,0.0286,0.0048,0.031,0.0143,0.0214,0.0405,0.0167,0.031,0.0024,0.0095,0.0214,0.0095,0.0071,0.0191,0.0048,0.0436,0.1743,0.0799,0.0218,0.0218,0.0726,0.0073,0.0145,0.029,0.0145,0.0145,0.029,0.0073,0.0581,0.0218,0.0073,0.0073,0.029,0.0073,0.0436,0.0508,0.0073,0.0508,0.0218,0.0363,0.0218,0.0073,0.0436,0.0073,0.0363,0.054,0.3242,0.054,0.054,0.1081,0.1081,0.054,0.1081,0.054,0.0629,0.0629,0.0629,0.0629,0.0629,0.0629,0.1259,0.0629,0.0629,0.0629,0.0629,0.0629,0.1201,0.004,0.008,0.084,0.088,0.044,0.02,0.052,0.088,0.052,0.048,0.012,0.068,0.008,0.028,0.012,0.004,0.028,0.048,0.004,0.008,0.008,0.048,0.06,0.008,0.008,0.012,0.016,0.008,0.004,0.004,0.1832,0.0458,0.0458,0.0458,0.0458,0.0916,0.0916,0.0916,0.0458,0.0916,0.0458,0.0458,0.0676,0.0614,0.0737,0.0246,0.0369,0.0246,0.0061,0.0369,0.0246,0.0246,0.043,0.0491,0.0246,0.0307,0.0307,0.0061,0.0061,0.0307,0.0307,0.0123,0.043,0.0061,0.0369,0.0061,0.0307,0.043,0.0123,0.0737,0.0061,0.0369,0.0553,0.0061,0.0123,0.0418,0.0568,0.0986,0.0448,0.0418,0.0508,0.0179,0.0179,0.0538,0.0239,0.0209,0.0657,0.0299,0.0119,0.0299,0.009,0.0358,0.0329,0.0239,0.006,0.0448,0.0119,0.0119,0.009,0.0209,0.0418,0.0209,0.0299,0.0119,0.0239,0.009,0.0209,0.003,0.006,0.003,0.0149,0.0789,0.0526,0.046,0.0526,0.0657,0.0657,0.0131,0.046,0.0592,0.0329,0.0329,0.0263,0.0526,0.0066,0.0066,0.0066,0.0066,0.0131,0.0329,0.0131,0.0066,0.0131,0.0131,0.0131,0.0526,0.0394,0.0394,0.0066,0.0329,0.0131,0.0066,0.0394,0.0131,0.0197,0.1182,0.0591,0.0197,0.0591,0.0197,0.0197,0.0394,0.0394,0.0394,0.0591,0.0591,0.0591,0.0197,0.0394,0.0197,0.0394,0.0394,0.0197,0.0197,0.0394,0.0197,0.0197,0.0197,0.0197,0.0591,0.0394,0.1126,0.0563,0.0563,0.0563,0.1126,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.0563,0.0313,0.0313,0.3127,0.0313,0.0313,0.0625,0.0313,0.0313,0.0938,0.0625,0.0313,0.0313,0.0313,0.0625,0.0313,0.0313,0.0677,0.1353,0.0677,0.0677,0.0677,0.0677,0.0677,0.0677,0.0677,0.0677,0.0677,0.0677,0.0279,0.0372,0.1115,0.0279,0.0186,0.065,0.0186,0.0186,0.0186,0.0093,0.0093,0.0557,0.0093,0.0372,0.0279,0.0465,0.0279,0.0186,0.0093,0.0465,0.0279,0.0093,0.0093,0.0836,0.0465,0.0186,0.0093,0.0093,0.0372,0.0372,0.0186,0.0093,0.0093,0.0093,0.0468,0.0468,0.0468,0.0468,0.0468,0.0468,0.2341,0.0937,0.0937,0.0468,0.0937,0.0359,0.1435,0.1077,0.0239,0.0239,0.012,0.0239,0.012,0.0239,0.012,0.012,0.0837,0.012,0.0478,0.012,0.0359,0.0239,0.0239,0.012,0.012,0.0957,0.0598,0.012,0.012,0.0239,0.0359,0.0239,0.012,0.0239,0.0433,0.0108,0.0649,0.0325,0.0162,0.1245,0.0703,0.0108,0.0108,0.0108,0.0271,0.0379,0.0162,0.0162,0.0271,0.0866,0.0108,0.0487,0.0108,0.0271,0.0487,0.0054,0.0108,0.0162,0.0162,0.0216,0.0379,0.0108,0.0595,0.0216,0.0325,0.0054,0.0054,0.108,0.037,0.0432,0.0741,0.0679,0.0309,0.0247,0.0525,0.0525,0.0556,0.034,0.034,0.0494,0.0093,0.0278,0.0123,0.037,0.0154,0.0278,0.0093,0.0062,0.0123,0.034,0.0031,0.0401,0.0062,0.0031,0.0031,0.0216,0.0247,0.0154,0.0093,0.0062,0.0093,0.0062,0.0237,0.0395,0.0316,0.0158,0.0316,0.0079,0.0474,0.0237,0.0237,0.0158,0.0316,0.0237,0.0158,0.0474,0.0553,0.0474,0.1422,0.0237,0.0158,0.0474,0.0316,0.0079,0.0237,0.0237,0.0079,0.0237,0.0316,0.0079,0.0158,0.0158,0.0553,0.0237,0.0158,0.0697,0.2789,0.0697,0.0697,0.1395,0.0697,0.1395,0.1365,0.273,0.0682,0.1365,0.1365,0.1365,0.0514,0.07,0.0187,0.056,0.0514,0.1541,0.042,0.0467,0.0374,0.0374,0.0233,0.0233,0.042,0.0233,0.014,0.0093,0.0047,0.028,0.0233,0.0187,0.014,0.0187,0.0093,0.0187,0.0327,0.014,0.0327,0.014,0.014,0.042,0.0047,0.0093,0.0047,0.0291,0.204,0.0583,0.0583,0.1457,0.0291,0.1457,0.0874,0.0291,0.0291,0.0291,0.0583,0.0485,0.0485,0.2908,0.0485,0.0969,0.0485,0.0969,0.0969,0.1454,0.0485,0.0735,0.0568,0.0635,0.0401,0.0234,0.0535,0.0301,0.0134,0.0134,0.0201,0.0234,0.0401,0.0234,0.0167,0.0234,0.0769,0.0702,0.0134,0.0167,0.0234,0.0267,0.0134,0.01,0.0067,0.01,0.0334,0.0167,0.0167,0.0167,0.0167,0.0267,0.0167,0.0334,0.0267,0.0167,0.103,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0515,0.0481,0.0809,0.0743,0.0415,0.024,0.0197,0.0372,0.0219,0.024,0.0262,0.024,0.0306,0.0175,0.0328,0.0153,0.0415,0.0284,0.0066,0.0153,0.0262,0.0175,0.024,0.0175,0.0175,0.0175,0.0415,0.035,0.0131,0.0197,0.0153,0.024,0.0022,0.0284,0.0415,0.0306,0.0197,0.1297,0.0649,0.0649,0.0649,0.1297,0.0649,0.0649,0.1297,0.0608,0.1023,0.0525,0.0221,0.0166,0.0055,0.0249,0.0194,0.0194,0.0138,0.0194,0.0332,0.0166,0.0719,0.0304,0.0194,0.0387,0.0249,0.0166,0.0608,0.0221,0.0166,0.0332,0.0304,0.0221,0.0221,0.0138,0.0194,0.0166,0.0166,0.0332,0.0055,0.0138,0.0138,0.0332,0.0138,0.1944,0.0486,0.0486,0.0486,0.0486,0.0486,0.0486,0.0486,0.0486,0.0486,0.0486,0.0972,0.0486,0.0242,0.0242,0.121,0.1937,0.0484,0.0968,0.0242,0.0242,0.0484,0.0242,0.0484,0.0484,0.0242,0.121,0.0242,0.0611,0.336,0.0611,0.0305,0.0305,0.0305,0.0611,0.0305,0.0611,0.0305,0.0305,0.0305,0.0305,0.0611,0.0611,0.0305,0.1654,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.0551,0.055,0.1101,0.1101,0.055,0.055,0.055,0.055,0.055,0.055,0.055,0.1101,0.055,0.0342,0.0342,0.2733,0.0342,0.1025,0.0683,0.1025,0.1025,0.0342,0.1025,0.0683,0.0342,0.0944,0.0094,0.085,0.1039,0.1227,0.0094,0.085,0.1039,0.0661,0.0378,0.0094,0.0661,0.0189,0.0094,0.0094,0.0472,0.0189,0.0094,0.0094,0.0472,0.0094,0.0189,0.0094,0.0994,0.0497,0.0497,0.0497,0.0497,0.0497,0.0497,0.0994,0.0497,0.0497,0.0497,0.0497,0.0497,0.0497,0.0497,0.0578,0.1156,0.1035,0.0061,0.0183,0.0213,0.003,0.0152,0.0091,0.0061,0.0122,0.0274,0.003,0.0669,0.0152,0.0061,0.003,0.0152,0.0091,0.0517,0.0517,0.0061,0.0426,0.0274,0.0061,0.0304,0.0913,0.0426,0.0061,0.0456,0.003,0.0061,0.0396,0.0365,0.0357,0.0268,0.0491,0.0402,0.0312,0.0134,0.1071,0.0223,0.0268,0.0268,0.0536,0.0402,0.0625,0.0089,0.0179,0.0223,0.0134,0.0223,0.0045,0.0268,0.058,0.0312,0.0089,0.0179,0.0045,0.0179,0.0312,0.0312,0.0089,0.0045,0.0625,0.0357,0.0312,0.0045,0.0225,0.0563,0.1464,0.0394,0.0225,0.0732,0.0056,0.0225,0.0394,0.0113,0.0113,0.107,0.0225,0.0056,0.0113,0.0056,0.0394,0.0113,0.0113,0.1126,0.0113,0.0113,0.0056,0.0113,0.0507,0.0225,0.0563,0.0113,0.0056,0.0056,0.0113,0.0056,0.0113,0.0056,0.1743,0.0436,0.0654,0.0218,0.0218,0.0654,0.0654,0.0436,0.0872,0.0436,0.0218,0.0218,0.0654,0.0218,0.0436,0.0436,0.0218,0.0218,0.0218,0.0218,0.1387,0.0462,0.0462,0.0462,0.0462,0.0462,0.0925,0.0925,0.0462,0.0925,0.0925,0.0462,0.0462,0.0807,0.0404,0.0404,0.0404,0.0807,0.0404,0.0404,0.0404,0.0404,0.0404,0.0807,0.0404,0.0404,0.0404,0.0404,0.0404,0.0404,0.0807,0.1125,0.0243,0.0365,0.0578,0.0547,0.0395,0.0395,0.0334,0.0486,0.0517,0.0456,0.0243,0.0486,0.0182,0.0213,0.0122,0.0182,0.0091,0.0334,0.0213,0.0152,0.0091,0.0456,0.0091,0.0456,0.0061,0.0122,0.0213,0.0091,0.0243,0.0061,0.0213,0.0061,0.003,0.0152,0.0584,0.035,0.0584,0.035,0.0421,0.0397,0.0841,0.0234,0.0234,0.021,0.021,0.035,0.0234,0.0164,0.035,0.0234,0.035,0.0374,0.0164,0.0164,0.028,0.0164,0.0257,0.007,0.0164,0.007,0.007,0.0397,0.0257,0.0234,0.0304,0.014,0.014,0.021,0.028,0.0164,0.0745,0.0745,0.0372,0.0372,0.1862,0.0372,0.0372,0.0372,0.0372,0.0372,0.0372,0.149,0.0372,0.0372,0.0372,0.0372,0.0372,0.0959,0.0959,0.0959,0.0959,0.0959,0.0959,0.0959,0.0646,0.0583,0.0229,0.0375,0.0458,0.0208,0.0563,0.0292,0.0313,0.0167,0.0313,0.0208,0.0146,0.0354,0.05,0.0292,0.0479,0.0271,0.0208,0.0271,0.0042,0.025,0.0417,0.0146,0.0125,0.0125,0.0083,0.0125,0.0313,0.0229,0.0104,0.0125,0.0396,0.025,0.0292,0.0146,0.0613,0.0613,0.0613,0.184,0.0613,0.1227,0.0613,0.184,0.0613,0.0484,0.1936,0.0484,0.0242,0.0484,0.0242,0.0726,0.0242,0.0242,0.0726,0.0242,0.0242,0.0484,0.0242,0.0484,0.0242,0.0242,0.0484,0.0484,0.0336,0.0397,0.0245,0.0856,0.0581,0.159,0.0459,0.0336,0.0397,0.0275,0.0367,0.0275,0.0336,0.0153,0.0245,0.0183,0.0642,0.0245,0.0031,0.0031,0.0092,0.0031,0.0092,0.0183,0.0183,0.0061,0.0092,0.0214,0.0122,0.0031,0.0642,0.0031,0.0183,0.0061,0.0092,0.05,0.0715,0.0786,0.0357,0.0071,0.0214,0.0143,0.0214,0.0143,0.0214,0.0143,0.0143,0.0429,0.0715,0.0357,0.0715,0.0858,0.0143,0.0357,0.0143,0.0143,0.0071,0.0357,0.0572,0.0214,0.0143,0.0143,0.0214,0.0214,0.0071,0.0143,0.0143,0.0143,0.0826,0.1652,0.0826,0.0826,0.0826,0.0826,0.0826,0.0826,0.0353,0.0176,0.0176,0.3706,0.0176,0.0353,0.0353,0.0176,0.0176,0.1059,0.0176,0.0176,0.1059,0.0706,0.0882,0.0353,0.0176,0.0391,0.0782,0.1368,0.0391,0.0195,0.0195,0.0195,0.0391,0.0195,0.0195,0.0391,0.0391,0.0195,0.0586,0.0195,0.0195,0.0586,0.0195,0.0195,0.0782,0.0195,0.0586,0.0195,0.0195,0.0195,0.0586,0.055,0.0939,0.0275,0.0687,0.0321,0.0298,0.0252,0.0206,0.0412,0.0367,0.0275,0.0137,0.0183,0.0962,0.0229,0.0069,0.0092,0.0092,0.0183,0.0596,0.0092,0.0092,0.0275,0.0481,0.016,0.0229,0.0183,0.0023,0.0092,0.0115,0.0206,0.0229,0.0092,0.0069,0.0252,0.0275,0.0485,0.0364,0.0606,0.0364,0.0364,0.1819,0.0606,0.0364,0.0243,0.0364,0.0243,0.0243,0.0121,0.0121,0.0243,0.0121,0.0728,0.0121,0.0243,0.0243,0.0121,0.0121,0.0121,0.0121,0.0121,0.0243,0.0121,0.0364,0.0485,0.0121,0.0607,0.1214,0.1822,0.0607,0.0607,0.0607,0.0607,0.1214,0.0607,0.0607,0.0494,0.0617,0.037,0.0123,0.0123,0.0247,0.0247,0.0247,0.0123,0.0123,0.0247,0.0247,0.0247,0.0247,0.1728,0.0494,0.0123,0.0123,0.037,0.0123,0.0123,0.0123,0.037,0.037,0.0247,0.0123,0.0123,0.037,0.0864,0.037,0.0123,0.0278,0.3194,0.0139,0.0139,0.0278,0.0556,0.0139,0.0972,0.0278,0.0833,0.0833,0.0139,0.125,0.0556,0.0691,0.0322,0.0276,0.0391,0.0414,0.0599,0.0553,0.0253,0.0276,0.0299,0.0345,0.0184,0.0484,0.0138,0.0115,0.0184,0.0714,0.0069,0.0299,0.0115,0.0138,0.0115,0.0622,0.0069,0.0322,0.0184,0.0092,0.0138,0.0276,0.0207,0.0322,0.0253,0.0207,0.0276,0.0046,0.0023,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.0568,0.1136,0.0568,0.1136,0.0568,0.0568,0.0839,0.042,0.042,0.0839,0.042,0.042,0.1259,0.0839,0.042,0.042,0.042,0.1679,0.042,0.034,0.034,0.034,0.034,0.034,0.102,0.136,0.068,0.034,0.034,0.034,0.034,0.034,0.2041,0.068,0.0976,0.1301,0.0976,0.0325,0.0325,0.0976,0.0651,0.0651,0.0325,0.0976,0.0325,0.0651,0.0325,0.0325,0.0636,0.106,0.0212,0.0424,0.0636,0.0212,0.0212,0.0636,0.0212,0.0212,0.0424,0.0848,0.0212,0.2544,0.0212,0.0636,0.0212,0.0295,0.0414,0.0177,0.0414,0.0355,0.0059,0.1182,0.0236,0.0236,0.0295,0.0295,0.0059,0.0236,0.0414,0.0295,0.0414,0.0414,0.0118,0.0414,0.065,0.0059,0.0414,0.0118,0.0118,0.0473,0.0473,0.0768,0.0295,0.0236,0.0118,0.1114,0.0371,0.0371,0.0371,0.0371,0.0371,0.0742,0.0742,0.0742,0.0742,0.0371,0.0371,0.1114,0.0371,0.0742,0.0371,0.0371,0.0371,0.0772,0.014,0.0351,0.0772,0.1122,0.0351,0.0281,0.0701,0.0842,0.0631,0.0421,0.021,0.0491,0.007,0.021,0.007,0.007,0.007,0.0281,0.0281,0.007,0.014,0.014,0.021,0.0351,0.007,0.007,0.014,0.007,0.007,0.007,0.014,0.007,0.014,0.007,0.0219,0.0329,0.011,0.0219,0.0219,0.1865,0.0219,0.011,0.011,0.0219,0.011,0.0549,0.0439,0.0768,0.011,0.011,0.011,0.0329,0.1097,0.011,0.0219,0.0549,0.0439,0.011,0.0658,0.0219,0.011,0.011,0.0275,0.2197,0.0275,0.3021,0.1923,0.1099,0.0549,0.0483,0.0483,0.0483,0.0483,0.1449,0.0483,0.0483,0.0483,0.0483,0.0483,0.0483,0.0483,0.0483,0.0966,0.0483,0.042,0.007,0.028,0.035,0.007,0.2172,0.028,0.028,0.021,0.021,0.021,0.014,0.042,0.049,0.014,0.014,0.007,0.014,0.056,0.014,0.0701,0.0701,0.0841,0.056,0.007,0.007,0.0813,0.0271,0.0813,0.0542,0.0271,0.0271,0.0813,0.0542,0.0271,0.1084,0.1084,0.0271,0.0542,0.0542,0.0271,0.0271,0.0271,0.0271,0.0243,0.243,0.0891,0.0081,0.0081,0.0081,0.0081,0.0081,0.0081,0.0162,0.0567,0.081,0.0162,0.0081,0.0081,0.0081,0.0648,0.0486,0.0081,0.0486,0.0243,0.0567,0.0486,0.0162,0.0162,0.0243,0.0324,0.0377,0.0377,0.1883,0.0377,0.0377,0.226,0.0377,0.0753,0.113,0.113,0.0377,0.0947,0.0474,0.0474,0.0474,0.0474,0.0474,0.0474,0.0474,0.0947,0.0474,0.0474,0.0474,0.0947,0.0474,0.0474,0.0611,0.1221,0.0611,0.0611,0.1832,0.0611,0.0611,0.1221,0.0611,0.0611,0.0182,0.0425,0.0061,0.0304,0.0061,0.0182,0.1276,0.0182,0.0061,0.0182,0.0425,0.0911,0.0668,0.0608,0.0122,0.0182,0.0486,0.0061,0.0243,0.0365,0.0486,0.0608,0.0182,0.0061,0.0668,0.0486,0.0486,0.0061,0.0704,0.0141,0.0282,0.0704,0.1267,0.0141,0.1126,0.1126,0.0845,0.0985,0.0704,0.0282,0.0141,0.0704,0.0141,0.0282,0.0141,0.2447,0.0059,0.0914,0.059,0.0324,0.0147,0.0472,0.0619,0.0649,0.056,0.0029,0.0678,0.0059,0.0088,0.0059,0.0029,0.0029,0.0531,0.0029,0.0029,0.0029,0.0737,0.0501,0.0118,0.0029,0.0088,0.0118,0.0059,0.0029,0.0816,0.0163,0.0326,0.0326,0.0163,0.2447,0.0326,0.0326,0.0326,0.0326,0.0489,0.0326,0.0489,0.0163,0.0489,0.0163,0.0489,0.0163,0.0163,0.0163,0.0163,0.0163,0.0163,0.0163,0.0653,0.0163,0.0978,0.02,0.0319,0.0339,0.0339,0.0399,0.0359,0.0299,0.0259,0.0319,0.0379,0.0239,0.0279,0.0319,0.018,0.0379,0.01,0.0299,0.0319,0.016,0.0279,0.018,0.0678,0.01,0.0299,0.008,0.0818,0.01,0.016,0.014,0.02,0.014,0.018,0.006,0.012,0.0523,0.0523,0.5755,0.0523,0.1046,0.0541,0.0564,0.0517,0.0588,0.0376,0.0329,0.0447,0.0329,0.0541,0.0376,0.0259,0.04,0.0259,0.0094,0.0376,0.0141,0.0094,0.04,0.0212,0.0141,0.0306,0.0141,0.0118,0.0118,0.0165,0.0071,0.0188,0.0353,0.0188,0.0259,0.0212,0.0259,0.0141,0.0118,0.0306,0.0047,0.0616,0.0801,0.0863,0.0123,0.0185,0.0493,0.0062,0.0123,0.0308,0.0123,0.0123,0.037,0.0062,0.037,0.037,0.0062,0.0123,0.0678,0.0123,0.0185,0.0308,0.0123,0.0185,0.0185,0.0123,0.0739,0.0185,0.0616,0.0431,0.0123,0.0431,0.0308,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.4237,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.0353,0.0788,0.0394,0.0657,0.0131,0.0394,0.0131,0.0525,0.0263,0.0131,0.0131,0.0131,0.1444,0.0263,0.0131,0.0263,0.0394,0.0131,0.0131,0.0525,0.0394,0.0131,0.0263,0.0263,0.0263,0.0788,0.0394,0.0131,0.0131,0.0131,0.0131,0.0607,0.0607,0.1214,0.0607,0.0607,0.0607,0.0607,0.0607,0.1214,0.0607,0.0607,0.0607,0.0607,0.0607,0.3188,0.1063,0.1063,0.0531,0.1063,0.0531,0.0531,0.0531,0.0531,0.0863,0.0144,0.0432,0.0575,0.0719,0.0288,0.0144,0.0719,0.0575,0.0863,0.0432,0.0432,0.0288,0.1295,0.0144,0.0432,0.0144,0.0144,0.0144,0.0144,0.0144,0.0288,0.0144,0.0144,0.0288,0.1587,0.1587,0.0397,0.0397,0.0397,0.1587,0.0397,0.0397,0.0794,0.0794,0.0794,0.0808,0.0808,0.1615,0.0808,0.0808,0.0808,0.0808,0.1615,0.0659,0.0659,0.0659,0.0659,0.3293,0.0659,0.0659,0.0659,0.0659,0.0313,0.0664,0.0781,0.0195,0.0117,0.0469,0.0586,0.0156,0.0078,0.0195,0.0156,0.0508,0.0156,0.0078,0.0117,0.0234,0.0195,0.0234,0.0078,0.0078,0.043,0.0273,0.0234,0.0117,0.0078,0.0508,0.043,0.0469,0.0195,0.0156,0.0742,0.0156,0.0156,0.0156,0.0352,0.0078,0.1544,0.0147,0.0074,0.0809,0.1471,0.0441,0.0074,0.0735,0.0588,0.0735,0.0515,0.0147,0.0735,0.0074,0.0074,0.0074,0.0662,0.0074,0.0368,0.0221,0.0074,0.0074,0.0074,0.0436,0.0523,0.1112,0.0371,0.0196,0.0632,0.0262,0.024,0.0174,0.0131,0.0153,0.048,0.0153,0.0174,0.0283,0.0087,0.0065,0.1504,0.0087,0.0109,0.0283,0.0196,0.0196,0.0044,0.0087,0.0283,0.024,0.0174,0.0153,0.0087,0.0458,0.0371,0.0022,0.0087,0.0087,0.0087,0.0996,0.0498,0.0498,0.0498,0.0498,0.0498,0.1494,0.0498,0.3486,0.0498,0.1434,0.0717,0.0717,0.0717,0.0717,0.1434,0.0717,0.0717,0.031,0.0929,0.0929,0.031,0.031,0.031,0.031,0.031,0.0929,0.031,0.031,0.031,0.0929,0.031,0.031,0.031,0.0929,0.031,0.031,0.031,0.031,0.031,0.0429,0.03,0.0171,0.0322,0.03,0.0043,0.1844,0.0257,0.0236,0.0171,0.0322,0.0129,0.0193,0.0343,0.0622,0.0429,0.0064,0.0129,0.015,0.015,0.0579,0.0107,0.0129,0.0107,0.0021,0.0021,0.0686,0.0536,0.0043,0.0665,0.0343,0.0107,0.0086,0.0518,0.0518,0.0518,0.1036,0.259,0.0518,0.1036,0.0518,0.0518,0.0518,0.0518,0.0307,0.1535,0.1842,0.0153,0.0153,0.0153,0.0153,0.0153,0.0153,0.0767,0.0153,0.0153,0.1228,0.0153,0.1228,0.046,0.0153,0.0153,0.0153,0.0153,0.0153,0.0767,0.0391,0.0586,0.2085,0.0195,0.0391,0.0391,0.0326,0.0391,0.013,0.0195,0.0195,0.0391,0.0065,0.0195,0.0326,0.0391,0.013,0.013,0.013,0.0521,0.0195,0.013,0.013,0.0261,0.0065,0.0326,0.0326,0.013,0.0065,0.0065,0.013,0.0065,0.0065,0.013,0.013,0.0195,0.1077,0.0287,0.0144,0.0431,0.0431,0.0215,0.1005,0.0287,0.0431,0.0287,0.0287,0.0144,0.0503,0.0144,0.1364,0.0144,0.0072,0.0072,0.0287,0.0072,0.0215,0.0287,0.0215,0.0287,0.0215,0.0072,0.0287,0.0072,0.0144,0.0215,0.0144,0.0072,0.0147,0.0882,0.1911,0.0294,0.0294,0.0441,0.0147,0.0882,0.0147,0.0147,0.0147,0.0441,0.0294,0.0735,0.0294,0.0294,0.0147,0.1323,0.0147,0.0294,0.0447,0.0894,0.0447,0.0447,0.0447,0.0447,0.0447,0.0447,0.0894,0.0447,0.1341,0.0447,0.0447,0.0447,0.0447,0.0447,0.0447,0.0447,0.2134,0.0711,0.0711,0.1423,0.0711,0.1423,0.1423,0.1423,0.0711,0.0244,0.1463,0.0244,0.0244,0.0244,0.1219,0.0732,0.0488,0.0732,0.0732,0.0976,0.2439,0.0855,0.0855,0.2565,0.0855,0.0855,0.0855,0.0855,0.0589,0.1767,0.1178,0.0589,0.0589,0.1178,0.0589,0.0589,0.0589,0.0251,0.0251,0.1006,0.0251,0.2766,0.0251,0.0251,0.0251,0.0251,0.0503,0.0503,0.0251,0.0251,0.0503,0.0251,0.0503,0.0251,0.0251,0.0251,0.0251,0.0251,0.0251,0.0862,0.3446,0.0862,0.0862,0.0825,0.0825,0.0825,0.2474,0.0825,0.0825,0.0825,0.0825,0.0825,0.0612,0.0306,0.0764,0.0612,0.0764,0.0306,0.0306,0.0612,0.0917,0.0306,0.0459,0.0153,0.0306,0.0153,0.0459,0.0153,0.0306,0.0306,0.0306,0.0306,0.0153,0.0306,0.0153,0.0153,0.0153,0.0306,0.0153,0.0153,0.0153,0.0086,0.0775,0.155,0.0086,0.0086,0.0172,0.0086,0.0861,0.0086,0.0086,0.0344,0.155,0.0172,0.0086,0.0517,0.0603,0.1808,0.0517,0.0086,0.0086,0.0172,0.0086,0.0246,0.0657,0.1723,0.0082,0.0082,0.0328,0.0082,0.0164,0.0082,0.0082,0.0574,0.0246,0.0492,0.0082,0.0657,0.0246,0.0246,0.0082,0.0082,0.0328,0.041,0.0903,0.0082,0.041,0.0657,0.0082,0.0657,0.0246,0.0429,0.0429,0.0858,0.0429,0.0429,0.0429,0.0429,0.0429,0.0429,0.0429,0.0858,0.0429,0.0429,0.0429,0.0429,0.0858,0.0429,0.0429,0.0429,0.0104,0.0729,0.3334,0.0208,0.0104,0.0104,0.0104,0.0208,0.0313,0.0104,0.0313,0.0104,0.0104,0.0208,0.0104,0.0625,0.0208,0.0208,0.0104,0.0625,0.0104,0.0313,0.0208,0.0104,0.0521,0.0208,0.0625,0.0124,0.1733,0.1609,0.0124,0.0124,0.0743,0.0124,0.0124,0.0248,0.0124,0.0495,0.0124,0.0248,0.0743,0.198,0.0124,0.0619,0.0248,0.0124,0.065,0.1949,0.065,0.065,0.1949,0.065,0.1299,0.065,0.065,0.065,0.0412,0.0412,0.0412,0.0824,0.0412,0.0412,0.0824,0.0824,0.0412,0.0824,0.0412,0.0824,0.0412,0.0412,0.0412,0.0412,0.0412,0.0412,0.0959,0.012,0.03,0.0839,0.0659,0.0419,0.018,0.0839,0.0539,0.0539,0.0719,0.018,0.0599,0.006,0.024,0.006,0.03,0.018,0.03,0.012,0.012,0.012,0.03,0.006,0.024,0.006,0.006,0.012,0.012,0.018,0.012,0.006,0.018,0.006,0.006,0.0415,0.083,0.0968,0.0277,0.0277,0.0138,0.0138,0.0138,0.0138,0.1521,0.0138,0.0277,0.0138,0.0138,0.0415,0.0553,0.0277,0.0138,0.0138,0.0691,0.083,0.0415,0.0138,0.0138,0.0138,0.0374,0.0374,0.028,0.1059,0.1121,0.1215,0.0093,0.0498,0.0498,0.0312,0.0405,0.0125,0.053,0.0125,0.0125,0.0093,0.0156,0.0218,0.0312,0.0093,0.0156,0.0093,0.0093,0.0062,0.028,0.0374,0.0125,0.0093,0.0093,0.0125,0.0062,0.0125,0.0031,0.0031,0.0125,0.0093,0.0957,0.0244,0.0387,0.0509,0.0692,0.0326,0.0081,0.0407,0.0407,0.055,0.0448,0.0224,0.0835,0.0285,0.0204,0.0041,0.0183,0.0143,0.0428,0.0143,0.0122,0.0041,0.0631,0.0143,0.0529,0.0122,0.0081,0.0122,0.0061,0.0183,0.0061,0.0163,0.0041,0.002,0.0102,0.0061,0.029,0.0232,0.0174,0.0116,0.0174,0.1507,0.0058,0.0116,0.0116,0.0116,0.0116,0.0174,0.029,0.0638,0.2145,0.0058,0.0058,0.0116,0.0464,0.0116,0.0116,0.0058,0.0348,0.0464,0.0406,0.0058,0.0638,0.0522,0.0116,0.0549,0.0549,0.0732,0.0183,0.0183,0.0366,0.0366,0.0366,0.0183,0.0183,0.0183,0.0732,0.0183,0.0183,0.0183,0.0549,0.0183,0.0366,0.0366,0.0366,0.0183,0.0366,0.0183,0.1098,0.0183,0.0183,0.0366,0.0183,0.0183,0.071,0.071,0.071,0.0946,0.0237,0.1183,0.0946,0.071,0.0473,0.0237,0.071,0.0237,0.0237,0.0473,0.0473,0.0638,0.6379,0.1276,0.0638,0.016,0.0321,0.2084,0.016,0.016,0.016,0.0321,0.0321,0.0641,0.0641,0.016,0.016,0.0802,0.0321,0.0802,0.0802,0.1122,0.0481,0.1048,0.1677,0.1048,0.1467,0.021,0.0838,0.0838,0.0629,0.0419,0.0629,0.021,0.0629,0.021,0.0343,0.0343,0.0343,0.1374,0.0343,0.0343,0.1374,0.0687,0.0687,0.0343,0.103,0.0343,0.0687,0.0687,0.0687,0.0343,0.0737,0.0246,0.0246,0.0491,0.0737,0.0737,0.0246,0.0737,0.0491,0.0246,0.0246,0.0246,0.0246,0.0983,0.0246,0.172,0.0246,0.0491,0.0246,0.0246,0.0246,0.0814,0.0081,0.0244,0.0936,0.0854,0.0448,0.0407,0.057,0.0732,0.0732,0.0448,0.0122,0.0285,0.0163,0.0163,0.0285,0.0448,0.0122,0.0285,0.0163,0.0163,0.0081,0.0163,0.0163,0.0041,0.0041,0.0122,0.0163,0.0122,0.0122,0.0163,0.0203,0.0122,0.0122,0.015,0.1695,0.0482,0.0133,0.0083,0.0598,0.0066,0.0033,0.005,0.0116,0.0083,0.0017,0.1429,0.0133,0.0166,0.0183,0.0017,0.0017,0.0997,0.0033,0.0166,0.0033,0.0997,0.0017,0.0216,0.0133,0.0017,0.0133,0.01,0.0166,0.0033,0.015,0.0266,0.0449,0.0681,0.0894,0.0478,0.0333,0.0499,0.0333,0.1039,0.027,0.0291,0.0312,0.0249,0.0249,0.0104,0.0229,0.0374,0.0291,0.0083,0.0083,0.0166,0.0166,0.0187,0.0249,0.0146,0.0249,0.0146,0.0208,0.0208,0.027,0.0042,0.0166,0.0104,0.0333,0.0832,0.0146,0.0042,0.0042,0.0249,0.1254,0.0218,0.0491,0.0327,0.0327,0.0436,0.0218,0.0218,0.0164,0.0218,0.0491,0.0273,0.0436,0.0109,0.0273,0.0109,0.06,0.0436,0.0218,0.0109,0.0273,0.0055,0.0655,0.0164,0.0109,0.0109,0.0382,0.0218,0.0164,0.06,0.0218,0.0055,0.0055,0.0055,0.1529,0.0306,0.0306,0.0306,0.0612,0.0306,0.0306,0.0612,0.0306,0.0306,0.0612,0.0306,0.0306,0.0306,0.0306,0.0612,0.0306,0.0306,0.0612,0.0612,0.0344,0.0687,0.0344,0.2405,0.0344,0.0344,0.0344,0.0344,0.0344,0.0687,0.0687,0.0344,0.0687,0.0687,0.0344,0.0344,0.0344,0.0367,0.0367,0.1102,0.0735,0.0735,0.0367,0.1102,0.0367,0.0735,0.0735,0.0367,0.1102,0.0367,0.0735,0.0411,0.0206,0.0411,0.0206,0.0411,0.1646,0.0206,0.0206,0.0206,0.0206,0.0206,0.0411,0.0206,0.2675,0.0206,0.0206,0.0206,0.0206,0.0206,0.0206,0.0206,0.0206,0.0411,0.065,0.065,0.2599,0.065,0.065,0.065,0.065,0.065,0.112,0.2987,0.0373,0.1494,0.0373,0.112,0.112,0.0747,0.0373,0.0188,0.113,0.2638,0.0188,0.0188,0.0188,0.0188,0.0188,0.0188,0.0754,0.0188,0.0188,0.0377,0.0188,0.0565,0.0754,0.0754,0.0565,0.0188,0.0632,0.0632,0.0632,0.1265,0.1897,0.0632,0.0632,0.0632,0.0632,0.0632,0.0584,0.0584,0.0195,0.1558,0.0974,0.0584,0.0974,0.0584,0.0584,0.0584,0.039,0.0779,0.0195,0.0195,0.039,0.039,0.0195,0.0195,0.039,0.3728,0.0932,0.0311,0.0311,0.0621,0.0311,0.0621,0.0311,0.0621,0.0311,0.0621,0.0311,0.055,0.055,0.2202,0.1651,0.055,0.055,0.055,0.1101,0.055,0.1086,0.0362,0.029,0.1014,0.0579,0.0362,0.0072,0.0869,0.0579,0.0942,0.0652,0.0217,0.0507,0.0145,0.0145,0.0072,0.0145,0.029,0.0145,0.0145,0.0072,0.0145,0.0072,0.0145,0.0072,0.0145,0.0072,0.0072,0.0072,0.0145,0.0072,0.0072,0.0145,0.0587,0.0587,0.1174,0.2935,0.1174,0.0587,0.1174,0.0587,0.0587,0.0587,0.0562,0.0529,0.0099,0.0297,0.0297,0.119,0.0331,0.0231,0.0231,0.0231,0.0331,0.0198,0.0165,0.0496,0.0264,0.0264,0.0364,0.0264,0.0198,0.0397,0.0033,0.0297,0.0297,0.0132,0.0297,0.0165,0.0099,0.0264,0.0264,0.0099,0.0529,0.0198,0.0066,0.0132,0.0099,0.0114,0.309,0.0915,0.0114,0.0114,0.0229,0.0114,0.0801,0.0114,0.0114,0.0229,0.0572,0.0114,0.0687,0.0572,0.0572,0.0114,0.0458,0.0229,0.0458,0.0962,0.0962,0.1923,0.0962,0.0497,0.0497,0.1987,0.0497,0.0497,0.0497,0.0497,0.1987,0.0993,0.0497,0.0497,0.0293,0.0703,0.1114,0.0391,0.0215,0.0195,0.0449,0.0195,0.0195,0.0195,0.0215,0.0371,0.0078,0.0449,0.0195,0.0293,0.0489,0.0234,0.0078,0.0528,0.0137,0.0117,0.0078,0.0313,0.0078,0.0254,0.0332,0.0176,0.0254,0.0156,0.0371,0.0117,0.0156,0.0293,0.0098,0.0176,0.0837,0.0293,0.0377,0.0774,0.0481,0.0502,0.0251,0.0502,0.067,0.0439,0.046,0.0481,0.0523,0.0105,0.0146,0.0126,0.0063,0.0146,0.0377,0.0021,0.0105,0.0063,0.0293,0.0021,0.0544,0.0188,0.0188,0.0209,0.0126,0.0146,0.0126,0.0209,0.0042,0.0021,0.0105,0.0042,0.0523,0.1568,0.0523,0.0523,0.1045,0.0523,0.1568,0.0523,0.1045,0.1045,0.0414,0.0414,0.0414,0.0414,0.0828,0.0414,0.0828,0.0414,0.0414,0.0414,0.0414,0.0828,0.0414,0.0414,0.0828,0.1688,0.0563,0.0563,0.0563,0.1125,0.0563,0.1125,0.0563,0.0563,0.0563,0.0563,0.0484,0.0346,0.0138,0.0449,0.0346,0.0104,0.121,0.0346,0.0242,0.0415,0.0415,0.0035,0.0277,0.0415,0.0519,0.0484,0.0346,0.0173,0.0173,0.038,0.0277,0.0035,0.0311,0.0069,0.0035,0.0415,0.0277,0.0104,0.0242,0.0277,0.0173,0.0138,0.0346,0.0477,0.1431,0.0954,0.0477,0.0477,0.0477,0.0477,0.0477,0.0477,0.0477,0.0477,0.0477,0.0477,0.0954,0.0477,0.0295,0.0886,0.0591,0.0295,0.0886,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0591,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0295,0.0886,0.0295,0.0725,0.0725,0.0725,0.1449,0.0725,0.0725,0.0725,0.0725,0.0725,0.0725,0.0725,0.0725,0.153,0.0191,0.0383,0.0191,0.0191,0.0191,0.0383,0.0191,0.0574,0.0765,0.0191,0.0574,0.0191,0.0765,0.2104,0.0191,0.0191,0.0191,0.0816,0.0272,0.0272,0.0816,0.0272,0.0272,0.0272,0.0544,0.0272,0.0272,0.0272,0.0272,0.0272,0.0272,0.1632,0.0544,0.0272,0.0544,0.0272,0.0272,0.0272,0.0272,0.1068,0.2136,0.1068,0.0698,0.2093,0.0698,0.0349,0.1395,0.1046,0.1395,0.0698,0.0349,0.0349,0.0698,0.053,0.053,0.053,0.106,0.265,0.053,0.053,0.053,0.053,0.053,0.053,0.0601,0.0623,0.0802,0.0445,0.0334,0.0334,0.0067,0.0245,0.0401,0.0267,0.0334,0.0512,0.0468,0.0111,0.0067,0.0089,0.0089,0.0178,0.0289,0.0111,0.0557,0.0111,0.02,0.0067,0.0445,0.0312,0.0245,0.0623,0.0111,0.0111,0.0379,0.0156,0.0022,0.0045,0.0111,0.0178,0.1453,0.0484,0.0484,0.0484,0.0484,0.0484,0.0484,0.0969,0.0484,0.0969,0.0484,0.0969,0.0484,0.0484,0.0661,0.0661,0.0661,0.1323,0.3968,0.0661,0.0671,0.0393,0.0393,0.0694,0.0509,0.0393,0.0393,0.0532,0.0509,0.0463,0.0347,0.0208,0.0254,0.0231,0.0416,0.0139,0.0116,0.0324,0.0208,0.0185,0.0254,0.0162,0.0116,0.0069,0.0116,0.0347,0.0162,0.0139,0.0231,0.0208,0.0069,0.0093,0.0162,0.0231,0.0139,0.0116,0.0319,0.0071,0.0035,0.117,0.1347,0.1099,0.0071,0.0638,0.0709,0.039,0.0638,0.0851,0.0071,0.0213,0.0071,0.0071,0.0354,0.039,0.0071,0.0496,0.0035,0.0071,0.0071,0.0071,0.0532,0.0106,0.0279,0.0329,0.0101,0.0228,0.0253,0.0152,0.1443,0.0127,0.0051,0.0127,0.0101,0.0076,0.0127,0.0228,0.0582,0.0481,0.0912,0.0228,0.0025,0.0076,0.0101,0.0456,0.0127,0.0177,0.0051,0.0076,0.0025,0.0228,0.0582,0.0532,0.0152,0.0734,0.0481,0.0177,0.0127,0.2458,0.0819,0.0819,0.0819,0.0819,0.0819,0.0819,0.0258,0.1033,0.1911,0.0077,0.0077,0.0155,0.0232,0.0155,0.0155,0.0052,0.0077,0.1291,0.0155,0.0129,0.0052,0.0026,0.0155,0.0052,0.0129,0.0852,0.0077,0.0103,0.0052,0.0775,0.0646,0.0542,0.0155,0.0362,0.0129,0.0026,0.0103,0.0625,0.125,0.0625,0.125,0.2501,0.125,0.125,0.1117,0.0372,0.1117,0.0744,0.0744,0.0744,0.1117,0.0744,0.0744,0.0372,0.1117,0.0863,0.0288,0.0288,0.0863,0.0575,0.0863,0.0575,0.0575,0.0575,0.0863,0.115,0.0288,0.0288,0.0575,0.0288,0.0575,0.0288,0.0309,0.0928,0.1238,0.0309,0.0309,0.0309,0.0309,0.1547,0.0309,0.0309,0.0309,0.0309,0.0309,0.0619,0.0309,0.0309,0.0309,0.0309,0.071,0.071,0.071,0.071,0.2838,0.071,0.071,0.071,0.2129,0.064,0.0486,0.0309,0.117,0.0773,0.0663,0.0177,0.0486,0.0596,0.053,0.0265,0.0088,0.042,0.0088,0.0243,0.0066,0.0155,0.0265,0.0243,0.0066,0.011,0.0133,0.0088,0.0044,0.0265,0.0265,0.0221,0.0088,0.0199,0.011,0.0066,0.0265,0.0066,0.0044,0.0221,0.011,0.1615,0.0162,0.0162,0.0323,0.0485,0.0323,0.0162,0.0808,0.0485,0.0808,0.0969,0.0808,0.0162,0.0808,0.0969,0.0323,0.0162,0.208,0.0832,0.0416,0.0832,0.0832,0.0832,0.0832,0.0416,0.1248,0.0257,0.0214,0.0342,0.0428,0.0342,0.0086,0.0983,0.0299,0.0214,0.0171,0.0171,0.0128,0.0299,0.0128,0.0086,0.0385,0.1454,0.0086,0.0171,0.0128,0.0257,0.0428,0.0128,0.0128,0.0086,0.0128,0.0214,0.0257,0.0342,0.047,0.0086,0.0641,0.0257,0.0128,0.0043,0.0205,0.0616,0.1233,0.0616,0.0822,0.0205,0.0411,0.0411,0.0411,0.2055,0.0411,0.0205,0.0205,0.0205,0.0205,0.0205,0.0822,0.0205,0.0205,0.0411,0.0273,0.2182,0.0818,0.0273,0.0273,0.0273,0.1091,0.0273,0.1364,0.1364,0.0273,0.0273,0.0273,0.0546,0.124,0.124,0.062,0.062,0.124,0.062,0.062,0.062,0.062,0.062,0.062,0.0607,0.0607,0.0303,0.1517,0.0607,0.0607,0.091,0.0607,0.091,0.0303,0.0303,0.0303,0.0303,0.0303,0.0303,0.0303,0.0303,0.0303,0.0541,0.0469,0.0523,0.065,0.0614,0.0307,0.0523,0.0433,0.0379,0.0343,0.0253,0.0433,0.0235,0.0235,0.0289,0.0199,0.0343,0.0054,0.0144,0.0162,0.0199,0.0217,0.0144,0.0144,0.0126,0.0235,0.0271,0.0162,0.0217,0.018,0.0126,0.0108,0.0271,0.0289,0.0036,0.0144,0.0505,0.0674,0.0505,0.0168,0.0168,0.101,0.0337,0.0168,0.0168,0.0168,0.0674,0.0505,0.0168,0.0168,0.0505,0.0674,0.0505,0.0168,0.0337,0.0842,0.0168,0.0505,0.0505,0.0168,0.0168,0.0908,0.0649,0.0389,0.013,0.0259,0.0389,0.013,0.0389,0.0259,0.0389,0.0519,0.0259,0.0259,0.0259,0.0389,0.0389,0.013,0.0259,0.0389,0.013,0.0389,0.013,0.0778,0.013,0.0259,0.013,0.0389,0.013,0.013,0.013,0.0259,0.013,0.1515,0.062,0.0138,0.0413,0.0482,0.0413,0.0344,0.0413,0.0413,0.0275,0.0275,0.0069,0.0344,0.0207,0.0344,0.0275,0.0207,0.0482,0.0207,0.0138,0.0138,0.0413,0.0207,0.0344,0.0207,0.0207,0.0138,0.0207,0.0138,0.0069,0.0069,0.0138,0.0894,0.2383,0.0894,0.0298,0.0298,0.0298,0.0894,0.0596,0.0298,0.0298,0.0894,0.0298,0.0298,0.0596,0.0298,0.0601,0.0301,0.0601,0.0601,0.0301,0.0301,0.0301,0.0601,0.0301,0.0301,0.0902,0.1804,0.0902,0.0301,0.0301,0.0301,0.0301,0.0301,0.0301,0.0301,0.0301,0.0177,0.0971,0.0353,0.0088,0.0088,0.0132,0.0397,0.0088,0.0044,0.0044,0.0088,0.0177,0.0353,0.0485,0.0838,0.1147,0.0088,0.0265,0.0044,0.0265,0.0044,0.0265,0.0353,0.075,0.0044,0.0177,0.0132,0.0485,0.0044,0.0132,0.075,0.0441,0.0221,0.0756,0.0756,0.0756,0.0756,0.0756,0.2267,0.0756,0.0756,0.0756,0.0756,0.0756,0.0848,0.01,0.005,0.1222,0.0972,0.0274,0.0075,0.0823,0.0898,0.1396,0.0748,0.0025,0.0773,0.005,0.01,0.005,0.0025,0.0025,0.0449,0.0075,0.005,0.0249,0.005,0.0399,0.005,0.0025,0.005,0.005,0.0025,0.0025,0.0025,0.0722,0.0653,0.0413,0.0327,0.0275,0.0275,0.0653,0.0189,0.0292,0.012,0.0189,0.0309,0.0189,0.0499,0.0292,0.043,0.0309,0.0155,0.0172,0.0327,0.012,0.0155,0.0258,0.0224,0.0309,0.0172,0.0138,0.0155,0.0241,0.0155,0.0206,0.0155,0.0138,0.0258,0.0241,0.0309,0.0652,0.1955,0.0326,0.0326,0.0326,0.1304,0.0326,0.0326,0.0326,0.1304,0.0326,0.0326,0.0326,0.0652,0.1304,0.0326,0.0852,0.0049,0.1193,0.1339,0.0268,0.0049,0.0852,0.0755,0.0779,0.0828,0.0024,0.1241,0.0024,0.0049,0.0024,0.0049,0.0536,0.0024,0.0268,0.0584,0.0024,0.0049,0.0049,0.0024,0.0024,0.0339,0.0339,0.1694,0.2032,0.0339,0.0677,0.0339,0.0677,0.1016,0.1016,0.1016,0.0768,0.0452,0.0497,0.0587,0.0406,0.0903,0.0045,0.0181,0.0452,0.0361,0.0226,0.0316,0.0361,0.0406,0.0135,0.0181,0.0768,0.0226,0.0181,0.009,0.0135,0.0135,0.0045,0.0181,0.0406,0.0226,0.0135,0.009,0.0226,0.0497,0.0226,0.009,0.0273,0.0547,0.1641,0.0273,0.0273,0.0547,0.0273,0.0273,0.0273,0.0273,0.082,0.0547,0.0273,0.0547,0.0273,0.0547,0.0273,0.0273,0.0273,0.082,0.0273,0.0273,0.0273,0.0273,0.0273,0.0273,0.0637,0.1274,0.0637,0.0637,0.1911,0.1274,0.0637,0.0637,0.0891,0.1603,0.1069,0.1247,0.0178,0.0713,0.0534,0.0713,0.0713,0.0713,0.0713,0.0178,0.0178,0.0935,0.1558,0.0935,0.1558,0.0312,0.0623,0.0935,0.0312,0.0312,0.0312,0.0312,0.0312,0.0312,0.0312,0.1085,0.0296,0.0394,0.0099,0.0197,0.0099,0.0394,0.0197,0.0296,0.0493,0.0592,0.0296,0.0099,0.0099,0.0197,0.1578,0.0394,0.0394,0.0099,0.0099,0.1183,0.0099,0.0296,0.0099,0.0197,0.0099,0.0394,0.0099,0.0099,0.0099,0.1017,0.1017,0.0508,0.0508,0.1017,0.0508,0.0508,0.1017,0.0508,0.0508,0.0508,0.0888,0.0888,0.1777,0.0888,0.0888,0.0888,0.0888,0.0888,0.0797,0.0797,0.0797,0.0797,0.1595,0.0797,0.0797,0.0797,0.0575,0.0115,0.0345,0.1496,0.0691,0.046,0.1151,0.0806,0.1151,0.0575,0.0115,0.0691,0.0115,0.0115,0.0115,0.0115,0.046,0.0115,0.0115,0.0115,0.023,0.0115,0.0115,0.0115,0.0981,0.0327,0.0654,0.0981,0.0981,0.0654,0.0654,0.0981,0.0654,0.0327,0.0327,0.0327,0.0327,0.0559,0.2793,0.0559,0.0559,0.1117,0.0559,0.0559,0.0559,0.0559,0.0559,0.0338,0.0659,0.0499,0.0534,0.0623,0.0285,0.0392,0.0267,0.0392,0.0321,0.0249,0.0178,0.0338,0.0267,0.0231,0.0303,0.0231,0.0125,0.0214,0.0249,0.0196,0.0214,0.0071,0.0142,0.0249,0.0231,0.0089,0.0214,0.0214,0.0303,0.0214,0.0321,0.0231,0.0249,0.0142,0.0214,0.1516,0.0505,0.0505,0.0505,0.0505,0.0505,0.1011,0.0505,0.1011,0.0505,0.0505,0.0505,0.0505,0.1392,0.0464,0.0464,0.0464,0.0464,0.0928,0.0928,0.0928,0.0928,0.0464,0.0464,0.0464,0.0449,0.0225,0.1348,0.0899,0.1797,0.0225,0.1123,0.0899,0.0899,0.0449,0.0449,0.0225,0.0449,0.0225,0.0225,0.075,0.0375,0.075,0.075,0.0375,0.0375,0.075,0.0375,0.0375,0.075,0.0375,0.1125,0.0375,0.075,0.0375,0.0375,0.0375,0.0375,0.0679,0.0434,0.0217,0.038,0.0244,0.0462,0.0163,0.0244,0.0353,0.0217,0.0271,0.0136,0.0163,0.0244,0.2118,0.0244,0.0109,0.0353,0.0244,0.0109,0.0244,0.0136,0.019,0.0136,0.0434,0.0217,0.0054,0.0054,0.0081,0.0109,0.076,0.0081,0.0081,0.019,0.093,0.2324,0.0465,0.0465,0.0465,0.0465,0.0465,0.1394,0.1859,0.0683,0.2733,0.205,0.0683,0.1367,0.0683,0.0683,0.0574,0.1148,0.1722,0.0574,0.0574,0.0574,0.0574,0.0574,0.0163,0.0653,0.2232,0.0054,0.0054,0.0054,0.0109,0.0054,0.0054,0.1143,0.0054,0.0109,0.0054,0.0272,0.1198,0.0109,0.0054,0.0599,0.0218,0.1633,0.0708,0.0054,0.0054,0.0109,0.0054,0.0727,0.0436,0.0872,0.0436,0.0799,0.1017,0.0073,0.0363,0.0436,0.0291,0.0363,0.0218,0.0436,0.0436,0.0073,0.0945,0.0291,0.0145,0.0145,0.0145,0.0145,0.0073,0.0291,0.0218,0.0145,0.0073,0.0291,0.0073,0.0073,0.0498,0.0498,0.0498,0.0498,0.0498,0.0498,0.1992,0.0996,0.0498,0.0498,0.0996,0.0498,0.0405,0.1216,0.1622,0.0405,0.0405,0.0405,0.0405,0.0405,0.0405,0.2838,0.0811,0.0405,0.0405,0.0073,0.1379,0.1742,0.0073,0.0218,0.0145,0.0073,0.0218,0.0145,0.0073,0.0073,0.0653,0.0145,0.0073,0.0073,0.0218,0.0145,0.0943,0.0073,0.0435,0.0218,0.0581,0.0726,0.0798,0.0073,0.0145,0.029,0.0429,0.0429,0.1002,0.0572,0.0286,0.0286,0.0429,0.0429,0.0286,0.1717,0.0143,0.0286,0.0143,0.0429,0.0143,0.0715,0.0286,0.0143,0.0429,0.0429,0.0572,0.0143,0.0143,0.0143,0.0357,0.1249,0.1249,0.0178,0.0178,0.0535,0.0357,0.0178,0.0178,0.0178,0.0357,0.0178,0.0357,0.0178,0.0357,0.0178,0.0535,0.0178,0.0178,0.0892,0.0535,0.0357,0.0178,0.0535,0.0178,0.0178,0.0357,0.011,0.011,0.0055,0.022,0.0275,0.0055,0.1595,0.0275,0.0165,0.011,0.022,0.011,0.0385,0.0275,0.1155,0.055,0.0055,0.011,0.022,0.0605,0.022,0.011,0.0715,0.044,0.011,0.077,0.077,0.0055,0.0055,0.0106,0.1381,0.1593,0.0053,0.0053,0.0053,0.0637,0.0106,0.0053,0.0053,0.0053,0.0743,0.0212,0.0159,0.0053,0.0159,0.0053,0.0212,0.0372,0.0106,0.0053,0.0159,0.0903,0.1115,0.0212,0.0212,0.0053,0.0266,0.0159,0.0159,0.0425,0.0106,0.0328,0.2294,0.1311,0.0328,0.0328,0.0655,0.0328,0.0328,0.0328,0.0983,0.0328,0.0328,0.0983,0.0328,0.0655,0.0328,0.0371,0.0371,0.1113,0.0371,0.0742,0.0371,0.0371,0.0371,0.1855,0.371,0.0371,0.0823,0.1647,0.1647,0.0823,0.0823,0.0823,0.0823,0.0561,0.0321,0.016,0.0481,0.1203,0.0281,0.012,0.0561,0.0922,0.0401,0.0642,0.0201,0.0802,0.0401,0.016,0.016,0.016,0.016,0.0441,0.0401,0.004,0.004,0.0241,0.0241,0.0361,0.004,0.004,0.008,0.004,0.008,0.004,0.0241,0.0668,0.0182,0.0061,0.1094,0.1094,0.0304,0.0061,0.0911,0.1094,0.0911,0.0729,0.0061,0.0911,0.0304,0.0061,0.0061,0.0061,0.0608,0.0243,0.0061,0.0061,0.0243,0.0061,0.0061,0.0061,0.0122,0.038,0.038,0.038,0.038,0.0761,0.038,0.0761,0.038,0.038,0.038,0.0761,0.038,0.038,0.038,0.0761,0.1901,0.114,0.057,0.057,0.057,0.057,0.057,0.114,0.114,0.057,0.057,0.057,0.057,0.057,0.057,0.0378,0.0063,0.0252,0.0252,0.2144,0.0252,0.0126,0.0189,0.0252,0.0063,0.0252,0.0063,0.0126,0.0189,0.0063,0.0126,0.0063,0.0883,0.0189,0.0126,0.0063,0.0567,0.1702,0.0883,0.0567,0.0063,0.0649,0.1028,0.0271,0.0812,0.0595,0.0325,0.0162,0.0758,0.0595,0.0812,0.0487,0.0054,0.0433,0.0054,0.0162,0.0162,0.0162,0.0216,0.0379,0.0108,0.0108,0.0108,0.0162,0.0162,0.0162,0.0162,0.0271,0.0108,0.0108,0.0054,0.0054,0.0108,0.0108,0.0054,0.0473,0.0167,0.025,0.0862,0.0584,0.0918,0.0139,0.0556,0.05,0.0556,0.0306,0.025,0.0556,0.0056,0.0167,0.0222,0.0111,0.0334,0.0334,0.0028,0.0195,0.0111,0.0417,0.0056,0.0278,0.0083,0.0167,0.0639,0.0028,0.0056,0.0111,0.0195,0.0111,0.0028,0.0083,0.0028,0.0573,0.0191,0.0955,0.0955,0.0573,0.0382,0.0764,0.0573,0.0764,0.0764,0.0191,0.1146,0.0382,0.0191,0.0573,0.0191,0.0191,0.0191,0.0299,0.1646,0.0973,0.015,0.0299,0.0075,0.015,0.0374,0.015,0.0224,0.015,0.0449,0.015,0.0299,0.0299,0.0299,0.0374,0.0075,0.0075,0.0374,0.015,0.0224,0.015,0.0224,0.0224,0.0673,0.0299,0.0299,0.015,0.0075,0.0075,0.015,0.0224,0.015,0.0788,0.1577,0.0788,0.0788,0.1577,0.0788,0.0788,0.0788,0.0788,0.1471,0.0294,0.0294,0.0294,0.2354,0.0294,0.0294,0.0588,0.0294,0.0294,0.0294,0.0294,0.0588,0.0294,0.0294,0.0294,0.0294,0.0294,0.0294,0.1141,0.038,0.038,0.0761,0.038,0.1141,0.038,0.0761,0.0761,0.038,0.038,0.038,0.038,0.038,0.038,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.0642,0.018,0.0541,0.1804,0.018,0.0361,0.0361,0.018,0.018,0.0902,0.018,0.018,0.0541,0.018,0.018,0.1443,0.018,0.1804,0.0361,0.018,0.018,0.018,0.0312,0.1249,0.118,0.0139,0.0347,0.0035,0.0208,0.0416,0.0173,0.0069,0.0139,0.1041,0.0173,0.0208,0.0139,0.0104,0.0139,0.0173,0.0069,0.0173,0.0451,0.0104,0.0104,0.0104,0.0625,0.0278,0.0625,0.0104,0.0104,0.0278,0.0104,0.0069,0.0312,0.0208,0.0791,0.1979,0.0791,0.0791,0.1187,0.0791,0.0791,0.0396,0.0791,0.0791,0.0396,0.0333,0.0333,0.0333,0.133,0.0333,0.0333,0.0333,0.0333,0.0333,0.0998,0.0665,0.266,0.0665,0.0333,0.0579,0.079,0.0342,0.0606,0.0369,0.0132,0.0658,0.0316,0.0342,0.0448,0.029,0.0026,0.0211,0.0474,0.0316,0.0474,0.0421,0.0053,0.0158,0.029,0.0053,0.0158,0.0184,0.0237,0.0132,0.0184,0.0184,0.0053,0.0184,0.0079,0.0263,0.0211,0.0237,0.0184,0.0316,0.0963,0.0241,0.0963,0.0963,0.0482,0.0241,0.0963,0.0723,0.0963,0.0963,0.0963,0.0241,0.0723,0.0241,0.0333,0.1334,0.1,0.0667,0.0333,0.1334,0.0667,0.1,0.0667,0.0333,0.0333,0.0333,0.0667,0.0333,0.0913,0.0156,0.0574,0.0574,0.0443,0.0365,0.0548,0.0391,0.0365,0.0365,0.0391,0.0209,0.0495,0.0261,0.0261,0.0209,0.0391,0.0209,0.0287,0.013,0.0156,0.0078,0.0469,0.0052,0.0156,0.013,0.0052,0.0156,0.013,0.0156,0.0183,0.0183,0.0235,0.0209,0.0052,0.0078,0.0449,0.0898,0.0359,0.0359,0.0539,0.009,0.0269,0.0449,0.0269,0.0359,0.0359,0.0269,0.0898,0.0269,0.018,0.018,0.0269,0.0269,0.0449,0.009,0.018,0.018,0.0359,0.0539,0.018,0.009,0.018,0.018,0.009,0.009,0.018,0.009,0.009,0.0269,0.0401,0.0642,0.0481,0.016,0.016,0.0962,0.0241,0.0241,0.016,0.0321,0.008,0.016,0.0481,0.008,0.0401,0.008,0.016,0.0321,0.008,0.0561,0.008,0.0401,0.0241,0.008,0.008,0.0241,0.0722,0.0321,0.008,0.0561,0.0642,0.0241,0.016,0.3215,0.1072,0.2144,0.0209,0.0419,0.2303,0.0419,0.0209,0.0419,0.0209,0.0209,0.0209,0.1675,0.0419,0.0209,0.1675,0.0209,0.0628,0.0209,0.0275,0.0275,0.0549,0.0275,0.0275,0.1648,0.0549,0.0275,0.0275,0.0275,0.0275,0.1098,0.0275,0.0824,0.0824,0.0824,0.0549,0.0805,0.0805,0.1609,0.0805,0.0805,0.1609,0.0805,0.0805,0.0805,0.0805,0.0805,0.0248,0.099,0.0309,0.0124,0.0124,0.0557,0.0124,0.0062,0.0124,0.0062,0.1052,0.0248,0.0928,0.0371,0.0062,0.1176,0.0309,0.0681,0.0062,0.0062,0.0062,0.0309,0.0186,0.0186,0.0062,0.0248,0.0495,0.0433,0.0433,0.0352,0.1057,0.2467,0.2114,0.0352,0.0352,0.1057,0.0705,0.0705,0.0865,0.0264,0.0577,0.0288,0.0264,0.0192,0.0817,0.0216,0.0216,0.0216,0.0384,0.0312,0.024,0.0096,0.0336,0.0144,0.0216,0.0096,0.0264,0.0096,0.0408,0.0216,0.0769,0.0072,0.0336,0.0072,0.0264,0.0264,0.0264,0.0288,0.0336,0.0048,0.0216,0.0216,0.0024,0.0072,0.0678,0.0847,0.1016,0.0339,0.0339,0.0508,0.0339,0.0339,0.0169,0.0169,0.0339,0.0339,0.0169,0.0169,0.0339,0.0169,0.0678,0.0169,0.0169,0.0508,0.0169,0.0169,0.0169,0.0169,0.0169,0.0339,0.0169,0.0169,0.0678,0.067,0.134,0.067,0.067,0.0335,0.0335,0.0335,0.0335,0.0335,0.0335,0.0335,0.0335,0.0335,0.067,0.0335,0.067,0.0335,0.067,0.0429,0.0429,0.0429,0.0429,0.0429,0.0858,0.3431,0.0429,0.0429,0.0429,0.0429,0.0429,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0462,0.0925,0.0453,0.0302,0.0302,0.0906,0.1208,0.0755,0.0302,0.0755,0.0755,0.0755,0.0453,0.0453,0.0302,0.0302,0.0151,0.0302,0.0302,0.0151,0.0151,0.0151,0.0151,0.0151,0.0151,0.0504,0.0504,0.1513,0.0504,0.2018,0.0504,0.0504,0.0504,0.0504,0.1009,0.0504,0.0504,0.0416,0.0277,0.0416,0.0277,0.0139,0.0554,0.0416,0.0277,0.0139,0.0277,0.0139,0.0139,0.0139,0.0139,0.0693,0.1802,0.0416,0.0139,0.0139,0.0277,0.0277,0.0277,0.0277,0.0139,0.0277,0.0277,0.0277,0.0139,0.0139,0.0416,0.0416,0.0415,0.0534,0.0415,0.0593,0.0218,0.0633,0.0396,0.0396,0.0277,0.0396,0.0198,0.0336,0.0218,0.0396,0.0257,0.0257,0.0297,0.0297,0.0218,0.0158,0.0158,0.0257,0.0178,0.0119,0.002,0.0099,0.0178,0.0218,0.0297,0.0277,0.0257,0.0079,0.0376,0.0455,0.0138,0.0378,0.0756,0.0597,0.0358,0.0199,0.1034,0.0318,0.0179,0.0219,0.0139,0.0179,0.0577,0.0159,0.0318,0.0219,0.0119,0.0219,0.0398,0.0159,0.0259,0.0179,0.0099,0.002,0.0139,0.0278,0.0438,0.0577,0.0179,0.0119,0.008,0.0259,0.0239,0.0099,0.0199,0.0259,0.0119,0.0893,0.0766,0.0383,0.0255,0.0255,0.0893,0.0255,0.0255,0.0255,0.0128,0.0255,0.0383,0.0128,0.0128,0.051,0.0128,0.0128,0.0638,0.0255,0.0128,0.051,0.0128,0.0255,0.0255,0.0638,0.0128,0.0128,0.0128,0.0638,0.0128,0.0128,0.0426,0.0426,0.1278,0.4259,0.0852,0.0426,0.0426,0.0426,0.0426,0.0962,0.0481,0.1444,0.0481,0.0481,0.0481,0.0962,0.0481,0.1444,0.0481,0.0481,0.0481,0.073,0.073,0.146,0.292,0.073,0.073,0.073,0.073,0.038,0.076,0.076,0.114,0.076,0.038,0.076,0.038,0.038,0.076,0.1521,0.038,0.038,0.076,0.083,0.0277,0.0553,0.083,0.1383,0.0553,0.0277,0.0277,0.0277,0.0277,0.083,0.0277,0.1936,0.0277,0.083,0.0848,0.0848,0.2545,0.0848,0.0848,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0668,0.0594,0.1189,0.1189,0.2972,0.1189,0.0594,0.0594,0.0594,0.1888,0.1416,0.0472,0.0472,0.0472,0.0944,0.1888,0.0472,0.0472,0.0602,0.1205,0.0602,0.1807,0.1205,0.1205,0.0602,0.0602,0.0602,0.0634,0.1902,0.2536,0.0634,0.0634,0.0634,0.0634,0.0634,0.0378,0.0755,0.0755,0.0252,0.0126,0.0504,0.0126,0.0126,0.0126,0.0252,0.0378,0.0881,0.0252,0.0126,0.0755,0.0504,0.0126,0.0504,0.0252,0.0126,0.0252,0.0504,0.0126,0.0378,0.0126,0.0126,0.0252,0.0755,0.0315,0.0315,0.0315,0.2207,0.063,0.063,0.0315,0.0946,0.0315,0.063,0.063,0.0946,0.0315]},\"R\":[30],\"lambda.step\":[0.01],\"plot.opts\":{\"xlab\":[\"PC1\"],\"ylab\":[\"PC2\"]},\"topic.order\":[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36]}");

        // set the number of topics to global variable K:
        K = data['mdsDat'].x.length;

        // R is the number of top relevant (or salient) words whose bars we display
        R = data['R'];

        // a (K x 5) matrix with columns x, y, topics, Freq, cluster (where x and y are locations for left panel)
        mdsData = [];
        for (var i = 0; i < K; i++) {
            var obj = {};
            for (var key in data['mdsDat']) {
                obj[key] = data['mdsDat'][key][i];
            }
            mdsData.push(obj);
        }

        // a huge matrix with 3 columns: Term, Topic, Freq, where Freq is all non-zero probabilities of topics given terms
        // for the terms that appear in the barcharts for this data
        mdsData3 = [];
        for (var i = 0; i < data['token.table'].Term.length; i++) {
            var obj = {};
            for (var key in data['token.table']) {
                obj[key] = data['token.table'][key][i];
            }
            mdsData3.push(obj);
        }

        // large data for the widths of bars in bar-charts. 6 columns: Term, logprob, loglift, Freq, Total, Category
        // Contains all possible terms for topics in (1, 2, ..., k) and lambda in the user-supplied grid of lambda values
	// which defaults to (0, 0.01, 0.02, ..., 0.99, 1).
        lamData = [];
        for (var i = 0; i < data['tinfo'].Term.length; i++) {
            var obj = {};
            for (var key in data['tinfo']) {
                obj[key] = data['tinfo'][key][i];
            }
            lamData.push(obj);
        }

        // Create the topic input & lambda slider forms. Inspired from:
        // http://bl.ocks.org/d3noob/10632804
        // http://bl.ocks.org/d3noob/10633704
        init_forms(topicID, lambdaID, visID);

        // When the value of lambda changes, update the visualization
        d3.select(lambda_select)
            .on("mouseup", function() {
                // store the previous lambda value
                lambda.old = lambda.current;
                lambda.current = document.getElementById(lambdaID).value;
                vis_state.lambda = +this.value;
                // adjust the text on the range slider
                d3.select(lambda_select).property("value", vis_state.lambda);
                d3.select(lambda_select + "-value").text(vis_state.lambda);
                // transition the order of the bars
                var increased = lambda.old < vis_state.lambda;
                if (vis_state.topic > 0) reorder_bars(increased);
                // store the current lambda value
                state_save(true);
                document.getElementById(lambdaID).value = vis_state.lambda;
            });

        d3.select("#" + topicUp)
            .on("click", function() {
		// remove term selection if it exists (from a saved URL)
		var termElem = document.getElementById(termID + vis_state.term);
		if (termElem !== undefined) term_off(termElem);
		vis_state.term = "";
                var value_old = document.getElementById(topicID).value;
                var value_new = Math.min(K, +value_old + 1).toFixed(0);
                // increment the value in the input box
                document.getElementById(topicID).value = value_new;
                topic_off(document.getElementById(topicID + value_old));
                topic_on(document.getElementById(topicID + value_new));
                vis_state.topic = value_new;
                state_save(true);
            })

        d3.select("#" + topicDown)
            .on("click", function() {
		// remove term selection if it exists (from a saved URL)
		var termElem = document.getElementById(termID + vis_state.term);
		if (termElem !== undefined) term_off(termElem);
		vis_state.term = "";
                var value_old = document.getElementById(topicID).value;
                var value_new = Math.max(0, +value_old - 1).toFixed(0);
                // increment the value in the input box
                document.getElementById(topicID).value = value_new;
                topic_off(document.getElementById(topicID + value_old));
                topic_on(document.getElementById(topicID + value_new));
                vis_state.topic = value_new;
                state_save(true);
            })

        d3.select("#" + topicID)
            .on("keyup", function() {
		// remove term selection if it exists (from a saved URL)
		var termElem = document.getElementById(termID + vis_state.term);
		if (termElem !== undefined) term_off(termElem);
		vis_state.term = "";
                topic_off(document.getElementById(topicID + vis_state.topic))
                var value_new = document.getElementById(topicID).value;
                if (!isNaN(value_new) && value_new > 0) {
                    value_new = Math.min(K, Math.max(1, value_new))
                    topic_on(document.getElementById(topicID + value_new));
                    vis_state.topic = value_new;
                    state_save(true);
                    document.getElementById(topicID).value = vis_state.topic;
                }
            })

        d3.select("#" + topicClear)
            .on("click", function() {
                state_reset();
                state_save(true);
            })

        // create linear scaling to pixels (and add some padding on outer region of scatterplot)
        var xrange = d3.extent(mdsData, function(d) {
            return d.x;
        }); //d3.extent returns min and max of an array
        var xdiff = xrange[1] - xrange[0],
        xpad = 0.05;
        var yrange = d3.extent(mdsData, function(d) {
            return d.y;
        });
        var ydiff = yrange[1] - yrange[0],
        ypad = 0.05;

	if (xdiff > ydiff) {
            var xScale = d3.scale.linear()
		.range([0, mdswidth])
		.domain([xrange[0] - xpad * xdiff, xrange[1] + xpad * xdiff]);
	    
            var yScale = d3.scale.linear()
		.range([mdsheight, 0])
		.domain([yrange[0] - 0.5*(xdiff - ydiff) - ypad*xdiff, yrange[1] + 0.5*(xdiff - ydiff) + ypad*xdiff]);
	} else {
            var xScale = d3.scale.linear()
		.range([0, mdswidth])
		.domain([xrange[0] - 0.5*(ydiff - xdiff) - xpad*ydiff, xrange[1] + 0.5*(ydiff - xdiff) + xpad*ydiff]);
	    
            var yScale = d3.scale.linear()
		.range([mdsheight, 0])
		.domain([yrange[0] - ypad * ydiff, yrange[1] + ypad * ydiff]);
	}

        // Create new svg element (that will contain everything):
        var svg = d3.select(to_select).append("svg")
            .attr("width", mdswidth + barwidth + margin.left + termwidth + margin.right)
            .attr("height", mdsheight + 2 * margin.top + margin.bottom + 2 * rMax);

        // Create a group for the mds plot
        var mdsplot = svg.append("g")
            .attr("id", "leftpanel")
            .attr("class", "points")
            .attr("transform", "translate(" + margin.left + "," + 2 * margin.top + ")");

        // Clicking on the mdsplot should clear the selection
        mdsplot
            .append("rect")
            .attr("x", 0)
            .attr("y", 0)
            .attr("height", mdsheight)
            .attr("width", mdswidth)
            .style("fill", color1)
            .attr("opacity", 0)
            .on("click", function() {
                state_reset();
                state_save(true);
            });

        mdsplot.append("line") // draw x-axis
            .attr("x1", 0)
            .attr("x2", mdswidth)
            .attr("y1", mdsheight / 2)
            .attr("y2", mdsheight / 2)
            .attr("stroke", "gray")
            .attr("opacity", 0.3);
    	mdsplot.append("text") // label x-axis
    	    .attr("x", 0)
    	    .attr("y", mdsheight/2 - 5)
    	    .text(data['plot.opts'].xlab)
    	    .attr("fill", "gray");

        mdsplot.append("line") // draw y-axis
            .attr("x1", mdswidth / 2)
            .attr("x2", mdswidth / 2)
            .attr("y1", 0)
            .attr("y2", mdsheight)
            .attr("stroke", "gray")
            .attr("opacity", 0.3);
    	mdsplot.append("text") // label y-axis
    	    .attr("x", mdswidth/2 + 5)
    	    .attr("y", 7)
    	    .text(data['plot.opts'].ylab)
    	    .attr("fill", "gray");

    	// new definitions based on fixing the sum of the areas of the default topic circles:
    	var newSmall = Math.sqrt(0.02*mdsarea*circle_prop/Math.PI);
    	var newMedium = Math.sqrt(0.05*mdsarea*circle_prop/Math.PI);
    	var newLarge = Math.sqrt(0.10*mdsarea*circle_prop/Math.PI);
    	var cx = 10 + newLarge,
        cx2 = cx + 1.5 * newLarge;
	
        // circle guide inspired from
        // http://www.nytimes.com/interactive/2012/02/13/us/politics/2013-budget-proposal-graphic.html?_r=0
        circleGuide = function(rSize, size) {
            d3.select("#leftpanel").append("circle")
                .attr('class', "circleGuide" + size)
                .attr('r', rSize)
                .attr('cx', cx)
                .attr('cy', mdsheight + rSize)
                .style('fill', 'none')
                .style('stroke-dasharray', '2 2')
                .style('stroke', '#999');
            d3.select("#leftpanel").append("line")
                .attr('class', "lineGuide" + size)
                .attr("x1", cx)
                .attr("x2", cx2)
                .attr("y1", mdsheight + 2 * rSize)
                .attr("y2", mdsheight + 2 * rSize)
                .style("stroke", "gray")
                .style("opacity", 0.3);
        }

        circleGuide(newSmall, "Small");
        circleGuide(newMedium, "Medium");
        circleGuide(newLarge, "Large");

        var defaultLabelSmall = "2%";
        var defaultLabelMedium = "5%";
        var defaultLabelLarge = "10%";

        d3.select("#leftpanel").append("text")
            .attr("x", 10)
            .attr("y", mdsheight - 10)
            .attr('class', "circleGuideTitle")
            .style("text-anchor", "left")
            .style("fontWeight", "bold")
            .text("Marginal topic distribtion");
        d3.select("#leftpanel").append("text")
            .attr("x", cx2 + 10)
            .attr("y", mdsheight + 2 * newSmall)
            .attr('class', "circleGuideLabelSmall")
            .style("text-anchor", "start")
            .text(defaultLabelSmall);
        d3.select("#leftpanel").append("text")
            .attr("x", cx2 + 10)
            .attr("y", mdsheight + 2 * newMedium)
            .attr('class', "circleGuideLabelMedium")
            .style("text-anchor", "start")
            .text(defaultLabelMedium);
        d3.select("#leftpanel").append("text")
            .attr("x", cx2 + 10)
            .attr("y", mdsheight + 2 * newLarge)
            .attr('class', "circleGuideLabelLarge")
            .style("text-anchor", "start")
            .text(defaultLabelLarge);

        // bind mdsData to the points in the left panel:
        var points = mdsplot.selectAll("points")
            .data(mdsData)
            .enter();

        // text to indicate topic
        points.append("text")
            .attr("class", "txt")
            .attr("x", function(d) {
                return (xScale(+d.x));
            })
            .attr("y", function(d) {
                return (yScale(+d.y) + 4);
            })
            .attr("stroke", "black")
            .attr("opacity", 1)
            .style("text-anchor", "middle")
            .style("font-size", "11px")
            .style("fontWeight", 100)
            .text(function(d) {
                return d.topics;
            });

        // draw circles
        points.append("circle")
            .attr("class", "dot")
            .style("opacity", 0.2)
            .style("fill", color1)
            .attr("r", function(d) {
                //return (rScaleMargin(+d.Freq));
                return (Math.sqrt((d.Freq/100)*mdswidth*mdsheight*circle_prop/Math.PI));
            })
            .attr("cx", function(d) {
                return (xScale(+d.x));
            })
            .attr("cy", function(d) {
                return (yScale(+d.y));
            })
            .attr("stroke", "black")
            .attr("id", function(d) {
                return (topicID + d.topics)
            })
            .on("mouseover", function(d) {
                var old_topic = topicID + vis_state.topic;
                if (vis_state.topic > 0 && old_topic != this.id) {
                    topic_off(document.getElementById(old_topic));
                }
                topic_on(this);
            })
            .on("click", function(d) {
                // prevent click event defined on the div container from firing 
                // http://bl.ocks.org/jasondavies/3186840
                d3.event.stopPropagation();
                var old_topic = topicID + vis_state.topic;
                if (vis_state.topic > 0 && old_topic != this.id) {
                    topic_off(document.getElementById(old_topic));
                }
                // make sure topic input box value and fragment reflects clicked selection
                document.getElementById(topicID).value = vis_state.topic = d.topics;
                state_save(true);
                topic_on(this);
            })
            .on("mouseout", function(d) {
                if (vis_state.topic != d.topics) topic_off(this);
                if (vis_state.topic > 0) topic_on(document.getElementById(topicID + vis_state.topic));
            });

        svg.append("text")
            .text("Intertopic Distance Map (via multidimensional scaling)")
            .attr("x", mdswidth/2 + margin.left)
            .attr("y", 30)
	    .style("font-size", "16px")
	    .style("text-anchor", "middle");

        // establish layout and vars for bar chart
        var barDefault2 = lamData.filter(function(d) {
            return d.Category == "Default"
        });

        var y = d3.scale.ordinal()
            .domain(barDefault2.map(function(d) {
                return d.Term;
            }))
            .rangeRoundBands([0, barheight], 0.15);
        var x = d3.scale.linear()
            .domain([0, d3.max(barDefault2, function(d) {
                return d.Total;
            })])
            .range([0, barwidth])
            .nice();
        var yAxis = d3.svg.axis()
            .scale(y);

        // Add a group for the bar chart
        var chart = svg.append("g")
            .attr("transform", "translate(" + +(mdswidth + margin.left + termwidth) + "," + 2 * margin.top + ")")
            .attr("id", "bar-freqs");

        // bar chart legend/guide:
        var barguide = {"width": 100, "height": 15};
        d3.select("#bar-freqs").append("rect")
            .attr("x", 0)
            .attr("y", mdsheight + 10)
            .attr("height", barguide.height)
            .attr("width", barguide.width)
            .style("fill", color1)
            .attr("opacity", 0.4);
        d3.select("#bar-freqs").append("text")
            .attr("x", barguide.width + 5)
            .attr("y", mdsheight + 10 + barguide.height/2)
            .style("dominant-baseline", "middle")
            .text("Overall term frequency");

        d3.select("#bar-freqs").append("rect")
            .attr("x", 0)
            .attr("y", mdsheight + 10 + barguide.height + 5)
            .attr("height", barguide.height)
            .attr("width", barguide.width/2)
            .style("fill", color2)
            .attr("opacity", 0.8);
        d3.select("#bar-freqs").append("text")
            .attr("x", barguide.width/2 + 5)
            .attr("y", mdsheight + 10 + (3/2)*barguide.height + 5)
            .style("dominant-baseline", "middle")
            .text("Estimated term frequency within the selected topic");

	// footnotes:
        d3.select("#bar-freqs")
            .append("a")
            .attr("xlink:href", "http://vis.stanford.edu/files/2012-Termite-AVI.pdf")
            .attr("target", "_blank")
            .append("text")
            .attr("x", 0)
            .attr("y", mdsheight + 10 + (6/2)*barguide.height + 5)
            .style("dominant-baseline", "middle")
            .text("1. saliency(term w) = frequency(w) * [sum_t p(t | w) * log(p(t | w)/p(t))] for topics t; see Chuang et. al (2012)");
        d3.select("#bar-freqs")
            .append("a")
            .attr("xlink:href", "http://nlp.stanford.edu/events/illvi2014/papers/sievert-illvi2014.pdf")
            .attr("target", "_blank")
            .append("text")
            .attr("x", 0)
            .attr("y", mdsheight + 10 + (8/2)*barguide.height + 5)
            .style("dominant-baseline", "middle")
            .text("2. relevance(term w | topic t) = \u03BB * p(w | t) + (1 - \u03BB) * p(w | t)/p(w); see Sievert & Shirley (2014)");

        // Bind 'default' data to 'default' bar chart
        var basebars = chart.selectAll(".bar-totals")
            .data(barDefault2)
            .enter();

        // Draw the gray background bars defining the overall frequency of each word
        basebars
            .append("rect")
            .attr("class", "bar-totals")
            .attr("x", 0)
            .attr("y", function(d) {
                return y(d.Term);
            })
            .attr("height", y.rangeBand())
            .attr("width", function(d) {
                return x(d.Total);
            })
            .style("fill", color1)
            .attr("opacity", 0.4);

        // Add word labels to the side of each bar
        basebars
            .append("text")
            .attr("x", -5)
            .attr("class", "terms")
            .attr("y", function(d) {
                return y(d.Term) + 12;
            })
            .attr("cursor", "pointer")
            .attr("id", function(d) {
                return (termID + d.Term)
            })
            .style("text-anchor", "end") // right align text - use 'middle' for center alignment
            .text(function(d) {
                return d.Term;
            })
            .on("mouseover", function() {
                term_hover(this);
            })
        // .on("click", function(d) {
        // 	var old_term = termID + vis_state.term;
        // 	if (vis_state.term != "" && old_term != this.id) {
        // 	    term_off(document.getElementById(old_term));
        // 	}
        // 	vis_state.term = d.Term;
        // 	state_save(true);
        // 	term_on(this);
        // 	debugger;
        // })
            .on("mouseout", function() {
                vis_state.term = "";
                term_off(this);
                state_save(true);
            });

        var title = chart.append("text")
            .attr("x", barwidth/2)
            .attr("y", -30)
            .attr("class", "bubble-tool") //  set class so we can remove it when highlight_off is called  
            .style("text-anchor", "middle")
            .style("font-size", "16px")
            .text("Top-" + R + " Most Salient Terms");
	
        title.append("tspan")
	    .attr("baseline-shift", "super")	    
	    .attr("font-size", "12px")
	    .text("(1)");
	
        // barchart axis adapted from http://bl.ocks.org/mbostock/1166403
        var xAxis = d3.svg.axis().scale(x)
            .orient("top")
            .tickSize(-barheight)
            .tickSubdivide(true)
            .ticks(6);

        chart.attr("class", "xaxis")
            .call(xAxis);

	// dynamically create the topic and lambda input forms at the top of the page:
        function init_forms(topicID, lambdaID, visID) {

            // create container div for topic and lambda input:
	    var inputDiv = document.createElement("div");
	    inputDiv.setAttribute("id", "top");
	    inputDiv.setAttribute("style", "width: 1210px"); // to match the width of the main svg element
	    document.getElementById(visID).appendChild(inputDiv);

	    // topic input container:
	    var topicDiv = document.createElement("div");
	    topicDiv.setAttribute("style", "padding: 5px; background-color: #e8e8e8; display: inline-block; width: " + mdswidth + "px; height: 50px; float: left");
	    inputDiv.appendChild(topicDiv);

            var topicLabel = document.createElement("label");
            topicLabel.setAttribute("for", topicID);
            topicLabel.setAttribute("style", "font-family: sans-serif; font-size: 14px");
            topicLabel.innerHTML = "Selected Topic: <span id='" + topicID + "-value'></span>";
            topicDiv.appendChild(topicLabel);

            var topicInput = document.createElement("input");
            topicInput.setAttribute("style", "width: 50px");
            topicInput.type = "text";
            topicInput.min = "0";
            topicInput.max = K; // assumes the data has already been read in
            topicInput.step = "1";
            topicInput.value = "0"; // a value of 0 indicates no topic is selected
            topicInput.id = topicID;
            topicDiv.appendChild(topicInput);

 	    var previous = document.createElement("button");
	    previous.setAttribute("id", topicDown);
	    previous.setAttribute("style", "margin-left: 5px");
	    previous.innerHTML = "Previous Topic";
            topicDiv.appendChild(previous);

	    var next = document.createElement("button");
	    next.setAttribute("id", topicUp);
	    next.setAttribute("style", "margin-left: 5px");
	    next.innerHTML = "Next Topic";
            topicDiv.appendChild(next);
            
	    var clear = document.createElement("button");
	    clear.setAttribute("id", topicClear);
	    clear.setAttribute("style", "margin-left: 5px");
	    clear.innerHTML = "Clear Topic";
            topicDiv.appendChild(clear);

            // lambda inputs
    	    //var lambdaDivLeft = 8 + mdswidth + margin.left + termwidth;
    	    var lambdaDivWidth = barwidth;
    	    var lambdaDiv = document.createElement("div");
    	    lambdaDiv.setAttribute("id", "lambdaInput");
    	    lambdaDiv.setAttribute("style", "padding: 5px; background-color: #e8e8e8; display: inline-block; height: 50px; width: " + lambdaDivWidth + "px; float: right; margin-right: 30px");
    	    inputDiv.appendChild(lambdaDiv);

    	    var lambdaZero = document.createElement("div");
    	    lambdaZero.setAttribute("style", "padding: 5px; height: 20px; width: 220px; font-family: sans-serif; float: left");
	    lambdaZero.setAttribute("id", "lambdaZero");
    	    lambdaDiv.appendChild(lambdaZero);
	    var xx = d3.select("#lambdaZero")
		.append("text")
		.attr("x", 0)
		.attr("y", 0)
		.style("font-size", "14px")
		.text("Slide to adjust relevance metric:");
	    var yy = d3.select("#lambdaZero")
		.append("text")
		.attr("x", 125)
		.attr("y", -5)
		.style("font-size", "10px")
		.style("position", "absolute")
		.text("(2)");
	    
    	    var sliderDiv = document.createElement("div");
    	    sliderDiv.setAttribute("id", "sliderdiv");
    	    sliderDiv.setAttribute("style", "padding: 5px; height: 40px; width: 250px; float: right; margin-top: -5px; margin-right: 10px");
    	    lambdaDiv.appendChild(sliderDiv);

            var lambdaInput = document.createElement("input");
            lambdaInput.setAttribute("style", "width: 250px; margin-left: 0px; margin-right: 0px");
            lambdaInput.type = "range";
            lambdaInput.min = 0;
            lambdaInput.max = 1;
            lambdaInput.step = data['lambda.step'];
            lambdaInput.value = vis_state.lambda;
            lambdaInput.id = lambdaID;
	    lambdaInput.setAttribute("list", "ticks"); // to enable automatic ticks (with no labels, see below)
            sliderDiv.appendChild(lambdaInput);

            var lambdaLabel = document.createElement("label");
	    lambdaLabel.setAttribute("id", "lamlabel");
            lambdaLabel.setAttribute("for", lambdaID);
	    lambdaLabel.setAttribute("style", "height: 20px; width: 60px; font-family: sans-serif; font-size: 14px; margin-left: 80px");
	    lambdaLabel.innerHTML = "&#955 = <span id='" + lambdaID + "-value'>" + vis_state.lambda + "</span>";
            lambdaDiv.appendChild(lambdaLabel);

	    // Create the svg to contain the slider scale:
	    var scaleContainer = d3.select("#sliderdiv").append("svg")
		.attr("width", 250)
		.attr("height", 25);

            var sliderScale = d3.scale.linear()
		.domain([0, 1])
		.range([7.5, 242.5])  // trimmed by 7.5px on each side to match the input type=range slider:
		.nice();

            // adapted from http://bl.ocks.org/mbostock/1166403
            var sliderAxis = d3.svg.axis()
		.scale(sliderScale)
		.orient("bottom")
		.tickSize(10)
		.tickSubdivide(true)
		.ticks(6);

	    // group to contain the elements of the slider axis:
	    var sliderAxisGroup = scaleContainer.append("g")
		.attr("class", "slideraxis")
		.attr("margin-top", "-10px")
		.call(sliderAxis);
            
	    // Another strategy for tick marks on the slider; simpler, but not labels
	    // var sliderTicks = document.createElement("datalist");
	    // sliderTicks.setAttribute("id", "ticks");
	    // for (var tick = 0; tick <= 10; tick++) {
	    // 	var tickOption = document.createElement("option");
	    // 	//tickOption.value = tick/10;
	    // 	tickOption.innerHTML = tick/10;
	    // 	sliderTicks.appendChild(tickOption);
	    // }
            // append the forms to the containers
	    //lambdaDiv.appendChild(sliderTicks);

        }

        // function to re-order the bars (gray and red), and terms:
        function reorder_bars(increase) {
            // grab the bar-chart data for this topic only:
            var dat2 = lamData.filter(function(d) {
                //return d.Category == "Topic" + Math.min(K, Math.max(0, vis_state.topic)) // fails for negative topic numbers...
                return d.Category == "Topic" + vis_state.topic;
            });
            // define relevance:
            for (var i = 0; i < dat2.length; i++) {
                dat2[i].relevance = vis_state.lambda * dat2[i].logprob +
                    (1 - vis_state.lambda) * dat2[i].loglift;
            }

            // sort by relevance:
            dat2.sort(fancysort("relevance"));

            // truncate to the top R tokens:
            var dat3 = dat2.slice(0, R);

            var y = d3.scale.ordinal()
                .domain(dat3.map(function(d) {
                    return d.Term;
                }))
                .rangeRoundBands([0, barheight], 0.15);
            var x = d3.scale.linear()
                .domain([0, d3.max(dat3, function(d) {
                    return d.Total;
                })])
                .range([0, barwidth])
                .nice();

            // Change Total Frequency bars
            var graybars = d3.select("#bar-freqs")
                .selectAll(".bar-totals")
                .data(dat3, function(d) {
                    return d.Term;
                });

            // Change word labels
            var labels = d3.select("#bar-freqs")
                .selectAll(".terms")
                .data(dat3, function(d) {
                    return d.Term;
                });

            // Create red bars (drawn over the gray ones) to signify the frequency under the selected topic
            var redbars = d3.select("#bar-freqs")
                .selectAll(".overlay")
                .data(dat3, function(d) {
                    return d.Term;
                });

            // adapted from http://bl.ocks.org/mbostock/1166403
            var xAxis = d3.svg.axis().scale(x)
                .orient("top")
                .tickSize(-barheight)
                .tickSubdivide(true)
                .ticks(6);

            // New axis definition:
            var newaxis = d3.selectAll(".xaxis");

            // define the new elements to enter:
            var graybarsEnter = graybars.enter().append("rect")
                .attr("class", "bar-totals")
                .attr("x", 0)
                .attr("y", function(d) {
                    return y(d.Term) + barheight + margin.bottom + 2 * rMax;
                })
                .attr("height", y.rangeBand())
                .style("fill", color1)
                .attr("opacity", 0.4);

            var labelsEnter = labels.enter()
                .append("text")
                .attr("x", -5)
                .attr("class", "terms")
                .attr("y", function(d) {
                    return y(d.Term) + 12 + barheight + margin.bottom + 2 * rMax;
                })
                .attr("cursor", "pointer")
                .style("text-anchor", "end")
                .attr("id", function(d) {
                    return (termID + d.Term)
                })
                .text(function(d) {
                    return d.Term;
                })
                .on("mouseover", function() {
                    term_hover(this);
                })
            // .on("click", function(d) {
            //     var old_term = termID + vis_state.term;
            //     if (vis_state.term != "" && old_term != this.id) {
            // 	term_off(document.getElementById(old_term));
            //     }
            //     vis_state.term = d.Term;
            //     state_save(true);
            //     term_on(this);
            // })
                .on("mouseout", function() {
                    vis_state.term = "";
                    term_off(this);
                    state_save(true);
                });

            var redbarsEnter = redbars.enter().append("rect")
                .attr("class", "overlay")
                .attr("x", 0)
                .attr("y", function(d) {
                    return y(d.Term) + barheight + margin.bottom + 2 * rMax;
                })
                .attr("height", y.rangeBand())
                .style("fill", color2)
                .attr("opacity", 0.8);


            if (increase) {
                graybarsEnter
                    .attr("width", function(d) {
                        return x(d.Total);
                    })
                    .transition().duration(duration)
                    .delay(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    });
                labelsEnter
                    .transition().duration(duration)
                    .delay(duration)
                    .attr("y", function(d) {
                        return y(d.Term) + 12;
                    });
                redbarsEnter
                    .attr("width", function(d) {
                        return x(d.Freq);
                    })
                    .transition().duration(duration)
                    .delay(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    });

                graybars.transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Total);
                    })
                    .transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    });
                labels.transition().duration(duration)
                    .delay(duration)
                    .attr("y", function(d) {
                        return y(d.Term) + 12;
                    });
                redbars.transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Freq);
                    })
                    .transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    });

                // Transition exiting rectangles to the bottom of the barchart:
                graybars.exit()
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Total);
                    })
                    .transition().duration(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 6 + i * 18;
                    })
                    .remove();
                labels.exit()
                    .transition().duration(duration)
                    .delay(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 18 + i * 18;
                    })
                    .remove();
                redbars.exit()
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Freq);
                    })
                    .transition().duration(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 6 + i * 18;
                    })
                    .remove();
                // https://github.com/mbostock/d3/wiki/Transitions#wiki-d3_ease
                newaxis.transition().duration(duration)
                    .call(xAxis)
                    .transition().duration(duration);
            } else {
                graybarsEnter
                    .attr("width", 100) // FIXME by looking up old width of these bars
                    .transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    })
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Total);
                    });
                labelsEnter
                    .transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term) + 12;
                    });
                redbarsEnter
                    .attr("width", 50) // FIXME by looking up old width of these bars
                    .transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    })
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Freq);
                    });

                graybars.transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    })
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Total);
                    });
                labels.transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term) + 12;
                    });
                redbars.transition().duration(duration)
                    .attr("y", function(d) {
                        return y(d.Term);
                    })
                    .transition().duration(duration)
                    .attr("width", function(d) {
                        return x(d.Freq);
                    });

                // Transition exiting rectangles to the bottom of the barchart:
                graybars.exit()
                    .transition().duration(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 6 + i * 18 + 2 * rMax;
                    })
                    .remove();
                labels.exit()
                    .transition().duration(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 18 + i * 18 + 2 * rMax;
                    })
                    .remove();
                redbars.exit()
                    .transition().duration(duration)
                    .attr("y", function(d, i) {
                        return barheight + margin.bottom + 6 + i * 18 + 2 * rMax;
                    })
                    .remove();

                // https://github.com/mbostock/d3/wiki/Transitions#wiki-d3_ease
                newaxis.transition().duration(duration)
                    .transition().duration(duration)
                    .call(xAxis);
            }
        }

        //////////////////////////////////////////////////////////////////////////////

        // function to update bar chart when a topic is selected
        // the circle argument should be the appropriate circle element
        function topic_on(circle) {
            if (circle == null) return null;
            
	    // grab data bound to this element
            var d = circle.__data__
            var Freq = Math.round(d.Freq * 10) / 10,
            topics = d.topics;
            
	    // change opacity and fill of the selected circle
            circle.style.opacity = highlight_opacity;
            circle.style.fill = color2;
            
	    // Remove 'old' bar chart title
            var text = d3.select(".bubble-tool");
            text.remove();
            
	    // append text with info relevant to topic of interest
            d3.select("#bar-freqs")
		.append("text")
		.attr("x", barwidth/2)
		.attr("y", -30)
		.attr("class", "bubble-tool") //  set class so we can remove it when highlight_off is called  
		.style("text-anchor", "middle")
		.style("font-size", "16px")
		.text("Top-" + R + " Most Relevant Terms for Topic " + topics + " (" + Freq + "% of tokens)");
	    
            // grab the bar-chart data for this topic only:
            var dat2 = lamData.filter(function(d) {
                return d.Category == "Topic" + topics
            });
	    
            // define relevance:
            for (var i = 0; i < dat2.length; i++) {
                dat2[i].relevance = lambda.current * dat2[i].logprob +
                    (1 - lambda.current) * dat2[i].loglift;
            }
	    
            // sort by relevance:
            dat2.sort(fancysort("relevance"));
	    
            // truncate to the top R tokens:
            var dat3 = dat2.slice(0, R);

            // scale the bars to the top R terms:
            var y = d3.scale.ordinal()
                .domain(dat3.map(function(d) {
                    return d.Term;
                }))
                .rangeRoundBands([0, barheight], 0.15);
            var x = d3.scale.linear()
                .domain([0, d3.max(dat3, function(d) {
                    return d.Total;
                })])
                .range([0, barwidth])
                .nice();

            // remove the red bars if there are any:
            d3.selectAll(".overlay").remove();

            // Change Total Frequency bars
            d3.selectAll(".bar-totals")
                .data(dat3)
                .attr("x", 0)
                .attr("y", function(d) {
                    return y(d.Term);
                })
                .attr("height", y.rangeBand())
                .attr("width", function(d) {
                    return x(d.Total);
                })
                .style("fill", color1)
                .attr("opacity", 0.4);

            // Change word labels
            d3.selectAll(".terms")
                .data(dat3)
                .attr("x", -5)
                .attr("y", function(d) {
                    return y(d.Term) + 12;
                })
                .attr("id", function(d) {
                    return (termID + d.Term)
                })
                .style("text-anchor", "end") // right align text - use 'middle' for center alignment
                .text(function(d) {
                    return d.Term;
                });

            // Create red bars (drawn over the gray ones) to signify the frequency under the selected topic
            d3.select("#bar-freqs").selectAll(".overlay")
                .data(dat3)
                .enter()
                .append("rect")
                .attr("class", "overlay")
                .attr("x", 0)
                .attr("y", function(d) {
                    return y(d.Term);
                })
                .attr("height", y.rangeBand())
                .attr("width", function(d) {
                    return x(d.Freq);
                })
                .style("fill", color2)
                .attr("opacity", 0.8);

            // adapted from http://bl.ocks.org/mbostock/1166403
            var xAxis = d3.svg.axis().scale(x)
                .orient("top")
                .tickSize(-barheight)
                .tickSubdivide(true)
                .ticks(6);

            // redraw x-axis
            d3.selectAll(".xaxis")
            //.attr("class", "xaxis")
                .call(xAxis);
        }


        function topic_off(circle) {
            if (circle == null) return circle;
            // go back to original opacity/fill
            circle.style.opacity = base_opacity;
            circle.style.fill = color1;

            var title = d3.selectAll(".bubble-tool")
		.text("Top-" + R + " Most Salient Terms");
	    title.append("tspan")
	     	.attr("baseline-shift", "super")	    
	     	.attr("font-size", 12)
	     	.text(1);

            // remove the red bars
            d3.selectAll(".overlay").remove();

            // go back to 'default' bar chart
            var dat2 = lamData.filter(function(d) {
                return d.Category == "Default"
            });

            var y = d3.scale.ordinal()
                .domain(dat2.map(function(d) {
                    return d.Term;
                }))
                .rangeRoundBands([0, barheight], 0.15);
            var x = d3.scale.linear()
                .domain([0, d3.max(dat2, function(d) {
                    return d.Total;
                })])
                .range([0, barwidth])
                .nice();

            // Change Total Frequency bars
            d3.selectAll(".bar-totals")
                .data(dat2)
                .attr("x", 0)
                .attr("y", function(d) {
                    return y(d.Term);
                })
                .attr("height", y.rangeBand())
                .attr("width", function(d) {
                    return x(d.Total);
                })
                .style("fill", color1)
                .attr("opacity", 0.4);

            //Change word labels
            d3.selectAll(".terms")
                .data(dat2)
                .attr("x", -5)
                .attr("y", function(d) {
                    return y(d.Term) + 12;
                })
                .style("text-anchor", "end") // right align text - use 'middle' for center alignment
                .text(function(d) {
                    return d.Term;
                });

            // adapted from http://bl.ocks.org/mbostock/1166403
            var xAxis = d3.svg.axis().scale(x)
                .orient("top")
                .tickSize(-barheight)
                .tickSubdivide(true)
                .ticks(6);

            // redraw x-axis
            d3.selectAll(".xaxis")
                .attr("class", "xaxis")
                .call(xAxis);
        }

        // event definition for mousing over a term
        function term_hover(term) {
            var old_term = termID + vis_state.term;
            if (vis_state.term != "" && old_term != term.id) {
                term_off(document.getElementById(old_term));
            }
            vis_state.term = term.innerHTML;
            term_on(term);
            state_save(true);
        }
        // updates vis when a term is selected via click or hover
        function term_on(term) {
            if (term == null) return null;
            term.style["fontWeight"] = "bold";
            var d = term.__data__
            var Term = d.Term;
            var dat2 = mdsData3.filter(function(d2) {
                return d2.Term == Term
            });

            var k = dat2.length; // number of topics for this token with non-zero frequency

            var radius = [];
            for (var i = 0; i < K; ++i) {
                radius[i] = 0;
            }
            for (i = 0; i < k; i++) {
                radius[dat2[i].Topic - 1] = dat2[i].Freq;
            }

            var size = [];
            for (var i = 0; i < K; ++i) {
                size[i] = 0;
            }
            for (i = 0; i < k; i++) {
                // If we want to also re-size the topic number labels, do it here
                // 11 is the default, so leaving this as 11 won't change anything.
                size[dat2[i].Topic - 1] = 11;
            }

            var rScaleCond = d3.scale.sqrt()
                .domain([0, 1]).range([0, rMax]);

            // Change size of bubbles according to the word's distribution over topics
            d3.selectAll(".dot")
                .data(radius)
                .transition()
                .attr("r", function(d) {
                    //return (rScaleCond(d));
		    return (Math.sqrt(d*mdswidth*mdsheight*word_prop/Math.PI)); 
                });

            // re-bind mdsData so we can handle multiple selection
            d3.selectAll(".dot")
                .data(mdsData)

            // Change sizes of topic numbers:
            d3.selectAll(".txt")
                .data(size)
                .transition()
                .style("font-size", function(d) {
                    return +d;
                });

            // Alter the guide
            d3.select(".circleGuideTitle")
                .text("Conditional topic distribution given term = '" + term.innerHTML + "'");
        }

        function term_off(term) {
            if (term == null) return null;
            term.style["fontWeight"] = "normal";

            d3.selectAll(".dot")
                .data(mdsData)
                .transition()
                .attr("r", function(d) {
                    //return (rScaleMargin(+d.Freq));
                    return (Math.sqrt((d.Freq/100)*mdswidth*mdsheight*circle_prop/Math.PI));
                });

            // Change sizes of topic numbers:
            d3.selectAll(".txt")
                .transition()
                .style("font-size", "11px");

            // Go back to the default guide
            d3.select(".circleGuideTitle")
                .text("Marginal topic distribution");
            d3.select(".circleGuideLabelLarge")
                .text(defaultLabelLarge);
            d3.select(".circleGuideLabelSmall")
                .attr("y", mdsheight + 2 * newSmall)
                .text(defaultLabelSmall);
            d3.select(".circleGuideSmall")
                .attr("r", newSmall)
                .attr("cy", mdsheight + newSmall);
            d3.select(".lineGuideSmall")
                .attr("y1", mdsheight + 2 * newSmall)
                .attr("y2", mdsheight + 2 * newSmall);
        }


        // serialize the visualization state using fragment identifiers -- http://en.wikipedia.org/wiki/Fragment_identifier
        // location.hash holds the address information
        
        var params = location.hash.split("&");
        if (params.length > 1) {
            vis_state.topic = params[0].split("=")[1];
            vis_state.lambda = params[1].split("=")[1];
            vis_state.term = params[2].split("=")[1];

	    // Idea: write a function to parse the URL string
	    // only accept values in [0,1] for lambda, {0, 1, ..., K} for topics (any string is OK for term)
	    // Allow for subsets of the three to be entered:
	    // (1) topic only (lambda = 1 term = "")
	    // (2) lambda only (topic = 0 term = "") visually the same but upon hovering a topic, the effect of lambda will be seen
	    // (3) term only (topic = 0 lambda = 1) only fires when the term is among the R most salient
	    // (4) topic + lambda (term = "")
	    // (5) topic + term (lambda = 1)
	    // (6) lambda + term (topic = 0) visually lambda doesn't make a difference unless a topic is hovered
	    // (7) topic + lambda + term

	    // Short-term: assume format of "#topic=k&lambda=l&term=s" where k, l, and s are strings (b/c they're from a URL)

	    // Force k (topic identifier) to be an integer between 0 and K:
	    vis_state.topic = Math.round(Math.min(K, Math.max(0, vis_state.topic)));

	    // Force l (lambda identifier) to be in [0, 1]:
	    vis_state.lambda = Math.min(1, Math.max(0, vis_state.lambda));

            // impose the value of lambda:
            document.getElementById(lambdaID).value = vis_state.lambda;
	    document.getElementById(lambdaID + "-value").innerHTML = vis_state.lambda;

            // select the topic and transition the order of the bars (if approporiate)
            if (!isNaN(vis_state.topic)) {
		document.getElementById(topicID).value = vis_state.topic;
		if (vis_state.topic > 0) {
                    topic_on(document.getElementById(topicID + vis_state.topic));
		}
                if (vis_state.lambda < 1 && vis_state.topic > 0) {
		    reorder_bars(false);
		}
            }
	    lambda.current = vis_state.lambda;
            var termElem = document.getElementById(termID + vis_state.term);
            if (termElem !== undefined) term_on(termElem);
        }

        function state_url() {
            return location.origin + location.pathname + "#topic=" + vis_state.topic +
                "&lambda=" + vis_state.lambda + "&term=" + vis_state.term;
        }

        function state_save(replace) {
            if (replace)
                history.replaceState(vis_state, "Query", state_url());
            else
                history.pushState(vis_state, "Query", state_url());
        }

        function state_reset() {
            if (vis_state.topic > 0) {
                topic_off(document.getElementById(topicID + vis_state.topic));
            }
            if (vis_state.term != "") {
                term_off(document.getElementById(termID + vis_state.term));
            }
            vis_state.term = "";
            document.getElementById(topicID).value = vis_state.topic = 0;
            state_save(true);
        }


    // var current_clicked = {
    //     what: "nothing",
    //     element: undefined
    // },

    //debugger;

}

</script>

<style>
path {
  fill: none;
  stroke: none;
}

.xaxis .tick.major {
    fill: black;
    stroke: black;
    stroke-width: 0.1;
    opacity: 0.7;
}

.slideraxis {
    fill: black;
    stroke: black;
    stroke-width: 0.4;
    opacity: 1;
}

text {
    font-family: sans-serif;
    font-size: 11px;
}
</style>
  </head>

  <body>
    <div id = "lda"></div>
    <script>
      var vis = new LDAvis("#lda", "lda.json");
    </script>
  </body>

</html>






Overall, 36 distinct topics are discovered with a relatively satisfying coherence score of 0.41 and no significant overlaps, indicating that the utilized approach is indeed an acceptable alternative for topic modelling tasks. By briefly observing the main words of the topics included in the network, we distinguish some highly interpretable subclasses that are strongly related to the five main classes e.g. cinema and films, labor parties and elections, music and related technologies, economy etc. Moreover, without reviewing the initial texts of the dataset, we successfully distribute the extracted topics into the five main classes based on our inspections of the most probable words and the main network.


|Topic No|Class|Topic No|Class|Topic No|Class|Topic No|Class|
| :- | :- | :- | :- | :- | :- | :- | :- |
|1|politics|10|politics|19|politics|28|tech|
|2|entertainment|11|politics|20|entertainment|29|sports|
|3|entertainment|12|tech|21|tech|30|sports|
|4|politics|13|politics|22|sports|31|tech|
|5|politics|14|entertainment|23|business|32|business|
|6|business|15|sports|24|entertainment|33|sports|
|7|sport|16|sports|25|politics|34|sports|
|8|politics|17|sports|26|tech|35|entertainment|
|9|politics|18|business|27|politics|36|entertainment|

As the main classes of this case study are totally independent, the estimations of the GLM, Multinomial Logistic Regression in this case, should be thoroughly investigated in order to identify the most relevant topics of each class. Indicatively, we observe the potential change of the log odds in a unit increase of cluster memberships, when the reference class is *sports*. Thus, we can observe that the log odds of an observation belonging to another class, apart from *sports*, are decreased when the memberships of clusters 15, 16, 17 are increased.  We previously distinguished that the first four clusters are associated to this class, meaning that the extracted coefficients from the Multinomial Logistic Regression confirm the information provided in [Table 5](#_ref126145825).

![bbc case study 9](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_9.jpg?raw=true)



Finally, by leveraging the topic distributions of the documents that are produced from the previous analysis, we build classification models to predict the classes of the test dataset. The evaluation of the trained models is presented below, where we should mention that the evaluations of precision, recall and F1 score are averaged across the five labels since the classification task is not binary. By examining the extracted results, we can easily infer that the classification models present high values in all evaluation metrics as they correctly predict the majority of the observations included in the test dataset. Consequently, we conclude that the extracted topics from the *Leiden* algorithm contain substantial information as they capture the semantics of the texts effectively both in terms of topic coherence and text classification. 

![bbc case study 10](https://github.com/koncharman/FastTMtool/blob/main/bbc_case_study_images/bbc_10.jpg?raw=true)

## **REFERENCES**
Fleuret, F. (2004). Fast binary feature selection with conditional mutual information. Journal of Machine learning research, 5(9).

Greene, D., & Cunningham, P. (2006, June). Practical solutions to the problem of diagonal dominance in kernel document clustering. In Proceedings of the 23rd international conference on Machine learning (pp. 377-384).


# Installation Instructions
## **Python installation**
We propose the first option (python install, pip install and reticulate later from Rstudio). Currently, you can avoid installing python as we tried to eliminate all python dependencies. In the future, we intend to add neural networks to train document and word representations that require these installations.
### Option 1
Install python, useful link: <https://www.python.org/downloads/>. Currently tested on the version 3.10.2 <https://www.python.org/downloads/release/python-3916/> . Make sure that the installer fits the specifications of your console. We downloaded the Windows installer (64-bit). Settings: <https://www.youtube.com/watch?v=8cAEH1i_5s0> . Also, in the last slide disable the path length limit if it is not disabled yet.

![Python installation 1](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_1.PNG?raw=true)

![Python installation 2](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_2.PNG?raw=true)

![Python installation 3](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/Python_3.PNG?raw=true)

Next, you will need to install the following python packages from the command line prompt. If some errors occur, we encourage the users try other versions of the following packages, usually older. For example, for tensorflow both in R (see later) and python, other versions could be compatible too. Make sure that the installed version of tensorflow is compatible with the installed version of keras as these two packages are aligned. In our case, the following installations from command line prompt were suitbale with ClickTMtool.

- pip install torch
- pip install keras
- pip install tensorflow==2.8
### Option 2
In contrast to option 1, you are able to call python from Rstudio that will create a virtual environment for python. If you do so, you need to install the python dependencies using the following scripts:

torch::install\_torch()

#https://tensorflow.rstudio.com/reference/tensorflow/install\_tensorflow 

keras::install\_keras(tensorflow = "2.8")

The versions of torch, keras and tensorflow should be compatible with the machine �s system. Also, you may need to install specific versions of all libraries, it is an important step that affects some functionalities of ClickTMtool. In the future, you might want to install more recent versions so you will need to re-run both scripts from Rstudio.
## **Installation of R and Rstudio**
The following step is to install R and Rstudio. For R <https://cran.r-project.org/bin/windows/base/> and Rstudio <https://support--rstudio-com.netlify.app/products/rstudio/download/#download>. Current version of Rstudio [RStudio Desktop - Posit](https://posit.co/download/rstudio-desktop/). Need to update Rstudio to the latest version. No changes in the default settings are needed.

![R installation 1](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_1.PNG?raw=true)

![R installation 2](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_2.PNG?raw=true)

![R installation 3](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_3.PNG?raw=true)

![R installation 4](https://github.com/koncharman/FastTMtool/blob/main/Installation_images/R_4.PNG?raw=true)


## **Additional installations for GPU**
This part is optional, it can be omitted at this moment. In the future, we intend to add neural networks to train document and word representations that require these installations.

Download a CUDA version, example of 11.2.2: <https://developer.nvidia.com/cuda-11.2.2-download-archive>. It is needed for the packages torch, keras and tensorflow which is used for neural networks. Also, the package torch is compatible with several CUDA versions so you need to pick the installed version accordingly. Also, you need to look for your compute capability before selecting the appropriate version capability. 

An important step is to download additional files for CUDA, in our case we needed the file CUDNN64\_8.DLL. We saved the file in the following directory: \Program Files\NVIDIA GPU Computing Toolkit\CUDA\v11.2\bin or search for a similar directory depending on your installation.
## **H2o dependencies**
Java JDK and the H2o library is required to train models using word2vec (Word Representations) and Deep Averaging Networks (Document Vectors). Also, H2o is required to train machine learning models (Prediction Models) when this library is selected instead of CARET. If you don�t intend to explore these utilities, you can proceed with the rest functionalities of ClickTMtool.

Potential error resulting when 32-bit Java is installed.

Warning: Error in value[[3L]]: You have a 32-bit version of Java. H2O works best with 64-bit Java.

Please download the latest 

Java SE JDK from the following URL:

https://www.oracle.com/technetwork/java/javase/downloads/index.html

Set the JAVA environment variable value depending on the file installation of java JDK, which is selected from the online link above. We installed JDK in D:\Java\jdk-19\. In your system search for **Environment Variables** and** then **Edit the system environment variables.** Useful Link: <https://confluence.atlassian.com/doc/setting-the-java_home-variable-in-windows-8895.html> 

Variable Name: JAVA\_HOME Variable Value:'D:\Java\jdk-19\'

Where the directory is the same of the JDK installation.
## **ClickTMtool and Rstudio**
### Package installations
Next download the ClickTMtool from the github repository. In this guide we unzipped the folder into the directory D:/ClickTMtool. Now open Rstudio and type the following scripts.

#Path of ClickTMtool in your machine

setwd("D:/ClickTMtool/ClickTMtool-main/ClickTMtool-main/") 

install.packages("readxl")

library(readxl)

packages\_to\_install <- read\_xlsx(path = "ClickTMtool\_all\_required\_packages.xlsx")

install.packages(packages\_to\_install$new\_values)

#maybe try installing in batches for example install.packages(packages\_to\_install$new\_values[1:10])

install.packages(packages\_to\_install$new\_values[11:20]) #etc.

### To run the project.
#If you used option 1 for python, then you should define the python path.

reticulate::use\_python("D:/Python/python.exe",required = T)

setwd("D:/ClickTMtool/ClickTMtool-main/ClickTMtool-main/")  #ClickTMtool directory

library(shiny)

runApp("ClickTMtool\_main\_UI.R")



