// this would automatically respond to ajax calls by filling in load objects
$(document).delegate('[data-remote=true]', 'ajax:success', function(e, data, status, xhr) {
    // todo: do we want more than data-remote?
//    $target = $
//    $($(this).attr('data-target')).actuate(data);
});

/*
 Seems impossible to silently get the response url -- it isin't supplied in a header.
 chrome debugger and firebug do get it, but I don't know how.
 http://stackoverflow.com/questions/1794140/is-there-a-way-to-see-the-final-url-retrieved-by-an-xmlhttprequest
 http://stackoverflow.com/questions/3093506/how-to-get-jquery-ajax-final-url
 */

//$(document).delegate('[data-remote~=true]', 'ajax:success', function(e, data, status, xhr) {
//    console.log(this);
//    // todo: do we want more than data-remote?
////    $target = $
////    $($(this).attr('data-target')).actuate(data);
//});

$.fn.loadContent = function(dataType, url) {
    $.ajax({
        type: 'GET',
        url: url,
        context: this,
        dataType: dataType,
        success: function(data) {
            // if widgets, use them:
            if ($(this).filter(':widget').get(0) == $(this).get(0)) {
                $(this).actuate(data);
            } else {
                // if no other widgets, default handlers
                if (dataType == 'json') {
                    // todo: look for template, fill it in
                    $(this).find('.holder').html($.tmpl($(this).find('script').html(), data));
                } else { // includes 'text'
                    $(this).html(data);
                }
            }

        },
        error: function(jqXHR, textStatus, errorThrown) {
            console.log(jqXHR, textStatus, errorThrown);
            $(this).html(jqXHR.responseText);
        }
    });
}

// todo: merge with jquery load?
$.ajaxSettings.xhrUrl = function() {
    return window.location.hash.replace(/^#!/, '') || '/';
}

$(window).bind('hashchange', function() {
    var dataType = $(this).data('type') || ($.ajaxSettings && $.ajaxSettings.dataType); // todo - can this be dried?
    $('[data-remote=main]').loadContent(dataType, $.ajaxSettings.xhrUrl());
});

$(function() {
    $('[data-remote]').each(function() {
        var url = $(this).data('remote');
        if (url == 'true') return;  // skip links
        if (url == 'main') url = $.ajaxSettings.xhrUrl();
        var dataType = $(this).data('type') || ($.ajaxSettings && $.ajaxSettings.dataType);
        $(this).loadContent(dataType, url);
    });
});


// could overwrite $.fn.load and have it loaded through a widget.
// However, we don't want the loader called again to handle the callback.
// how would this be done sanely?  Have the callback look for non-load widget data?


