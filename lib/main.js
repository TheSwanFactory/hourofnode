(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var Item, bind, editor, items, main;

_.mixin(_.str.exports());

bind = rx.bind;

rxt.importTags();

Item = (function() {
  function Item(data) {
    this.data = rx.cell(data);
  }

  return Item;

})();

items = rx.array([new Item('Item the First'), new Item('Item the Second')]);

editor = function(opts) {
  var data, item, theForm;
  item = function() {
    return opts.item.get();
  };
  theForm = form([
    h2('Edit Item'), data = input({
      type: 'text',
      value: bind(function() {
        return item().data.get();
      })
    }), button('Update')
  ]);
  return theForm.submit(function() {
    opts.onSubmit(data.val().trim());
    return false;
  });
};

main = function() {
  var currentItem;
  currentItem = rx.cell(items.at(0));
  return $('body').append(div({
    "class": 'item-manager'
  }, [
    h1(bind(function() {
      return "" + (items.length()) + " Items";
    })), ul({
      "class": 'items'
    }, items.map(function(item) {
      return li({
        "class": 'item',
        init: function() {
          return _.defer((function(_this) {
            return function() {
              return _this.slideDown('fast');
            };
          })(this));
        }
      }, [
        span({
          "class": 'data'
        }, bind(function() {
          return "" + (item.data.get()) + " ";
        })), a({
          href: 'javascript: void 0',
          click: function() {
            return currentItem.set(item);
          }
        }, 'Edit')
      ]);
    })), button({
      click: function() {
        var title;
        title = "Item #" + (items.length() + 1);
        return items.push(new Item(title));
      }
    }, 'Add Item'), editor({
      item: bind(function() {
        return currentItem.get();
      }),
      onSubmit: function(data) {
        return currentItem.get().data.set(data);
      }
    })
  ]));
};

$(main);



},{}]},{},[1]);
