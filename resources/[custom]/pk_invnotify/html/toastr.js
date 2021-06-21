/*
 * Toastr
 * Copyright 2012-2015
 * Authors: John Papa, Hans Fjällemark, and Tim Ferrell.
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * ARIA Support: Greta Krafsig
 *
 * Project: https://github.com/CodeSeven/toastr
 */
/* global define */
(function (define) {
    define(['jquery'], function ($) {
        return (function () {
            var $container;
            var listener;
            var toastId = 0;
            var notifyType = {
                error: 'error',
                info: 'info',
                success: 'success',
                warning: 'warning'
            };

            var toastr = {
                clear: clear,
                remove: remove,
                error: error,
                getContainer: getContainer,
                info: info,
                options: {},
                subscribe: subscribe,
                success: success,
                version: '2.1.4',
                warning: warning
            };

            var previousToast;

            return toastr;

            ////////////////

            function error(name, image, optionsOverride) {
                return notify({
                    type: notifyType.error,
                    actionClass: getOptions().actionClasses.error,
                    name: '<span class="test">-   </span>' + name,
                    optionsOverride: optionsOverride,
                    image: image,
                    
                });
            }

            function getContainer(options, create) {
                if (!options) { options = getOptions(); }
                $container = $('#' + options.containerId);
                if ($container.length) {
                    return $container;
                }
                if (create) {
                    $container = createContainer(options);
                }
                return $container;
            }

            function info(name, image, optionsOverride) {
                return notify({
                    type: notifyType.info,
                    actionClass: getOptions().actionClasses.info,
                    name: name,
                    optionsOverride: optionsOverride,
                    image: image
                });
            }

            function subscribe(callback) {
                listener = callback;
            }

            function success(name, image, optionsOverride) {
                return notify({
                    type: notifyType.success,
                    actionClass: getOptions().actionClasses.success,
                    name: '<span class="test">+   </span>' + name,
                    optionsOverride: optionsOverride,
                    image: image,
                
                });
            }

            function warning(name, image, optionsOverride) {
                return notify({
                    type: notifyType.warning,
                    actionClass: getOptions().actionClasses.warning,
                    name: '<span class="test">-   </span>' + name,
                    optionsOverride: optionsOverride,
                    image: image,
                   
                });
            }

            function clear($cardElement, clearOptions) {
                var options = getOptions();
                if (!$container) { getContainer(options); }
                if (!clearToast($cardElement, options, clearOptions)) {
                    clearContainer(options);
                }
            }

            function remove($cardElement) {
                var options = getOptions();
                if (!$container) { getContainer(options); }
                if ($cardElement && $(':focus', $cardElement).length === 0) {
                    removeToast($cardElement);
                    return;
                }
                if ($container.children().length) {
                    $container.remove();
                }
            }

            // internal functions

            function clearContainer (options) {
                var toastsToClear = $container.children();
                for (var i = toastsToClear.length - 1; i >= 0; i--) {
                    clearToast($(toastsToClear[i]), options);
                }
            }

            function clearToast ($cardElement, options, clearOptions) {
                var force = clearOptions && clearOptions.force ? clearOptions.force : false;
                if ($cardElement && (force || $(':focus', $cardElement).length === 0)) {
                    $cardElement[options.hideMethod]({
                        duration: options.hideDuration,
                        easing: options.hideEasing,
                        complete: function () { removeToast($cardElement); }
                    });
                    return true;
                }
                return false;
            }

            function createContainer(options) {
                $container = $('<div/>')
                    .attr('id', options.containerId)
                    .addClass(options.positionClass)
                    .addClass('row justify-content-md-center')

                $container.appendTo($(options.target));
                return $container;
            }

            function getDefaults() {
                return {
                    tapToDismiss: true,
                    containerId: 'card-container',
                    debug: false,

                    showMethod: 'slideDown', //fadeIn, slideDown, and show are built into jQuery
                    showDuration: 200,
                    showEasing: 'swing', //swing and linear are built into jQuery
                    onShown: undefined,
                    hideMethod: 'slideUp',
                    hideDuration: 200,
                    hideEasing: 'swing',
                    onHidden: undefined,
                    closeMethod: false,
                    closeDuration: false,
                    closeEasing: false,
                    closeOnHover: true,

                    extendedTimeOut: 1000,
                    actionClasses: {
                        error: 'remove',
                        info: 'info',
                        success: 'add',
                        warning: 'use'
                    },
                    actionClass: 'info',
                    action: '--',
                    positionClass: 'toast-top-right',
                    timeOut: 2000, // Set timeOut and extendedTimeOut to 0 to make it sticky
                    headerClass: 'card-header',
                    bodyClass: 'card-body',
                    escapeHtml: false,
                    target: 'section',
                    closeHtml: '<button type="button">&times;</button>',
                    closeClass: 'toast-close-button',
                    newestOnTop: true,
                    preventDuplicates: false,
                    progressBar: false,
                    progressClass: 'toast-progress',
                    rtl: false
                };
            }

            function publish(args) {
                if (!listener) { return; }
                listener(args);
            }

            function notify(map) {
                var options = getOptions();
                var actionClass = map.actionClass || options.actionClass;
                var action = map.action || options.action;

                if (typeof (map.optionsOverride) !== 'undefined') {
                    options = $.extend(options, map.optionsOverride);
                    actionClass = map.optionsOverride.actionClass || actionClass;
                    action = map.optionsOverride.action || action;

                }


                if (shouldExit(options, map)) { return; }

                toastId++;

                $container = getContainer(options, true);

                var intervalId = null;
                var $cardElement = $('<div/>');
                var $cardSubElement = $('<div/>');
                var $headerElement = $('<div/>');
                var $bodyElement = $('<div/>');
                var $progressElement = $('<div/>');
                var $actionElement = $('<h4/>');
                var $imageElement = $('<img/>');
                var $nameElement = $('<span/>');
                var $closeElement = $(options.closeHtml);
                var progressBar = {
                    intervalId: null,
                    hideEta: null,
                    maxHideTime: null
                };
                var response = {
                    toastId: toastId,
                    state: 'visible',
                    startTime: new Date(),
                    options: options,
                    map: map
                };

                personalizeToast();

                displayToast();

                handleEvents();

                publish(response);

                if (options.debug && console) {
                    console.log(response);
                }

                return $cardElement;

                function escapeHtml(source) {
                    if (source == null) {
                        source = '';
                    }

                    return source
                        .replace(/&/g, '&amp;')
                        .replace(/"/g, '&quot;')
                        .replace(/'/g, '&#39;')
                        .replace(/</g, '&lt;')
                        .replace(/>/g, '&gt;');
                }

                function personalizeToast() {
                    setAction();
                    setHeader();
                    setBody();
                    setMain();
                    setCloseButton();
                    setProgressBar();
                    setRTL();
                    setSequence();
                    setAria();
                }

                function setAria() {
                    var ariaValue = '';
                    switch (map.actionClass) {
                        case 'add':
                        case 'info':
                            ariaValue =  'polite';
                            break;
                        default:
                            ariaValue = 'assertive';
                    }
                    $cardElement.attr('aria-live', ariaValue);
                }

                function handleEvents() {
                    if (options.closeOnHover) {
                        $cardElement.hover(stickAround, delayedHideToast);
                    }

                    if (!options.onclick && options.tapToDismiss) {
                        $cardElement.click(hideToast);
                    }

                    if (options.closeButton && $closeElement) {
                        $closeElement.click(function (event) {
                            if (event.stopPropagation) {
                                event.stopPropagation();
                            } else if (event.cancelBubble !== undefined && event.cancelBubble !== true) {
                                event.cancelBubble = true;
                            }

                            if (options.onCloseClick) {
                                options.onCloseClick(event);
                            }

                            hideToast(true);
                        });
                    }

                    if (options.onclick) {
                        $cardElement.click(function (event) {
                            options.onclick(event);
                            hideToast();
                        });
                    }
                }

                function displayToast() {
                    $cardElement.hide();
                   
                    $cardElement[options.showMethod](
                        {duration: options.showDuration, easing: options.showEasing, complete: options.onShown}
                    );

                    if (options.timeOut > 0) {
                        intervalId = setTimeout(hideToast, options.timeOut);
                        progressBar.maxHideTime = parseFloat(options.timeOut);
                        progressBar.hideEta = new Date().getTime() + progressBar.maxHideTime;
                        if (options.progressBar) {
                            progressBar.intervalId = setInterval(updateProgress, 10);
                        }
                    }
                }

               

                function setSequence() {
                    if (options.newestOnTop) {
                        $container.prepend($cardElement);
                    } else {
                        $container.append($cardElement);
                    }
                }

                function setHeader() {
                    if (map.image) {
                        var suffix = map.image;
                        if (options.escapeHtml) {
                            suffix = escapeHtml(map.image);
                        }


                        $actionElement.addClass('al-item-action').addClass('my-0');
                        $headerElement.append($actionElement);
                        
                        $imageElement.attr('src', suffix).addClass('item-img');
                        var $nameBlockElement = $('<div/>').addClass('al-item-img');
                        $nameBlockElement.append($imageElement);
                        $headerElement.append($nameBlockElement).addClass(options.headerClass).addClass('al-item-header text-center align-items-center px-3 py-3');
                        $cardSubElement.append($headerElement).addClass('al-price-box mb-4');

                    }
                }


                 function setAction() {
                    if (map.actionClass) {
                        $actionElement.addClass(actionClass);
                    }

                	if (map.action) {
                        var suffix = action;
                        if (options.escapeHtml) {
                            suffix = escapeHtml(action);
                        }

                        $actionElement.append(suffix);
                    }
                
                }


                function setBody() {
                    if (map.name) {
                        var suffix = map.name;
                        if (options.escapeHtml) {
                            suffix = escapeHtml(map.name);
                        }
                        $nameElement.append(suffix).addClass('item-name');
                        $bodyElement.append($nameElement).addClass(options.bodyClass).addClass('al-item-features');
                        $cardSubElement.append($bodyElement);
                    }
                }

                function setMain() {
                    
                    $cardSubElement.addClass('card al-price-box mb-4');
                    $cardElement.append($cardSubElement).addClass('card-element');
                }

                function setCloseButton() {
                    if (options.closeButton) {
                        $closeElement.addClass(options.closeClass).attr('role', 'button');
                        $cardElement.prepend($closeElement);
                    }
                }

                function setProgressBar() {
                    if (options.progressBar) {
                        $progressElement.addClass(options.progressClass);
                        $cardElement.prepend($progressElement);
                    }
                }

                function setRTL() {
                    if (options.rtl) {
                        $cardElement.addClass('rtl');
                    }
                }

                function shouldExit(options, map) {
                    if (options.preventDuplicates) {
                        if (map.name === previousToast) {
                            return true;
                        } else {
                            previousToast = map.name;
                        }
                    }
                    return false;
                }

                function hideToast(override) {
                    var method = override && options.closeMethod !== false ? options.closeMethod : options.hideMethod;
                    var duration = override && options.closeDuration !== false ?
                        options.closeDuration : options.hideDuration;
                    var easing = override && options.closeEasing !== false ? options.closeEasing : options.hideEasing;
                    if ($(':focus', $cardElement).length && !override) {
                        return;
                    }
                    clearTimeout(progressBar.intervalId);
                    return $cardElement[method]({
                        duration: duration,
                        easing: easing,
                        complete: function () {
                            removeToast($cardElement);
                            clearTimeout(intervalId);
                            if (options.onHidden && response.state !== 'hidden') {
                                options.onHidden();
                            }
                            response.state = 'hidden';
                            response.endTime = new Date();
                            publish(response);
                        }
                    });
                }

                function delayedHideToast() {
                    if (options.timeOut > 0 || options.extendedTimeOut > 0) {
                        intervalId = setTimeout(hideToast, options.extendedTimeOut);
                        progressBar.maxHideTime = parseFloat(options.extendedTimeOut);
                        progressBar.hideEta = new Date().getTime() + progressBar.maxHideTime;
                    }
                }

                function stickAround() {
                    clearTimeout(intervalId);
                    progressBar.hideEta = 0;
                    $cardElement.stop(true, true)[options.showMethod](
                        {duration: options.showDuration, easing: options.showEasing}
                    );
                }

                function updateProgress() {
                    var percentage = ((progressBar.hideEta - (new Date().getTime())) / progressBar.maxHideTime) * 100;
                    $progressElement.width(percentage + '%');
                }
            }

            function getOptions() {
                return $.extend({}, getDefaults(), toastr.options);
            }

            function removeToast($cardElement) {
                if (!$container) { $container = getContainer(); }
                if ($cardElement.is(':visible')) {
                    return;
                }
                $cardElement.remove();
                $cardElement = null;
                if ($container.children().length === 0) {
                    $container.remove();
                    previousToast = undefined;
                }
            }

        })();
    });
}(typeof define === 'function' && define.amd ? define : function (deps, factory) {
    if (typeof module !== 'undefined' && module.exports) { //Node
        module.exports = factory(require('jquery'));
    } else {
        window.toastr = factory(window.jQuery);
    }
}));