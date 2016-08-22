(function () {
  var Analytics = function (options) {
    this.endpointURL = options.endpointURL;
  };

  Analytics.prototype.addClickListeners = function () {
    var selector = '[data-toggle="analytics"]',
        elements = document.querySelectorAll(selector);

    for (var i = 0, counter = elements.length; i < counter; i++) {
      elements[i].addEventListener('click', this.didClick.bind(this));
    }
  };

  Analytics.prototype.didClick = function (event) {
    var element = event.target;

    this.track({
      event_code: element.dataset.event
    });
  };

  Analytics.prototype.track = function (traits) {
    var request = new XMLHttpRequest(),
        formData = new FormData(),
        csrfParam = this.discoverCSRFParam();

    if (csrfParam) {
      for (var field in csrfParam) {
        formData.append(field, csrfParam[field]);
      }
    }

    for (var field in traits) {
      formData.append(field, traits[field]);
    }

    request.open('post', this.endpointURL);
    request.send(formData);
  };

  Analytics.prototype.discoverCSRFParam = function () {
    var paramElement = document.querySelector('[name="csrf-param"]'),
        tokenElement = document.querySelector('[name="csrf-token"]'),
        csrfParam = {};

    csrfParam[paramElement.getAttribute('content')] = tokenElement.getAttribute('content')

    return csrfParam;
  };

  window.Analytics = Analytics;
})();
