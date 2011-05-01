// This file is automatically included by javascript_include_tag :defaults

$(document).delegate('[data-target]', 'ajax:success', function(e, data, status, xhr) {
    // could look for id, then widget.  or could take selector
    // could make this only apply for json data
    $($(this).attr('data-target')).actuate(data);
});


$.fn.fight = function(rounds) {
    // this is automatically run, specified by the data-fight parameter.
    if (typeof rounds == 'string') {
        return;
    }

    var $ring = this.find('.holder'),
        template = this.next('script').html();

    this.show();

    jQuery.each(rounds, function(index, round) {
        round.class = round.c_score > round.d_score && round.good ? 'challenger' : 'defender';
        (function(round, timeout) {
            setTimeout(function() {
                $ring.append($.tmpl(template, round));
                window.scrollBy(0, 50);
            }, timeout);
        })(round, index * 700);

    });
}

$(function() {
    $("form").submit(function() {
        flash_lightning(Math.random() * 100 + 50, Math.random() * 60 + 60);
        flash_lightning(Math.random() * 100 + 190, Math.random() * 60 + 60);
        flash_lightning(Math.random() * 500 + 800, Math.random() * 100 + 200);
    });
});


$.fn.dynamic_label = function(field) {
    var write_name = function($from, $to) {
        var val = $from.val(),
            matches = val.match(new RegExp(/github.com\/(.*)\/(.*)/i));
        if (matches && matches.length > 2)
            $to.html('<strong>' + matches[1] + '</strong> with <strong><a href="' + val + '">' + matches[2] + '</a></strong>');
    }

    write_name($(field), this);
    this.keyup(function() {
        write_name($(field), this);
    });
}

function flash_lightning(delay, duration) {
    return;//disable for now
    setTimeout(function() {
        $('#background_graphic').show();
        setTimeout(function() {
            $('#background_graphic').hide();
        }, duration);
    }, delay);

}