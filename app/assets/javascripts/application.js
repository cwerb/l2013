// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require_self

//transition scroll


function set_size( elem, w_const, h_const )
{
    if ( typeof h_const == 'undefined' ) h_const = w_const;

    var h = elem.height();
    var w = elem.width();

    var k = h/w;
    var w_ = w_const;
    var h_ = w_*k;
    if ( h_ < h_const )
    {
        h_ = h_const;
        w_ = h_/k;
    }

    elem.css({
        position : 'absolute',
        width: w_,
        height: h_,
        margin: (h_const-h_)/2+'px 0 0 '+(w_const-w_)/2+'px'
    });
}