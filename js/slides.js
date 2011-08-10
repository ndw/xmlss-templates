// -*- Espresso -*-
//
// Copyright (C) 2002,2011 Norman Walsh
//
// You are free to use, modify and distribute this software without limitation.
// This software is provided "AS IS," without a warranty of any kind.
//
// This script assumes that jQuery has been loaded

var ARR_R = 39;
var ARR_L = 37;
var ARR_U = 38;
var ARR_D = 40;
var KEY_F1 = 112;
var KEY_ESC = 27;
var KEY_h = 72;
var KEY_t = 84;
var KEY_space = 32;
var KEY_p = 80;
var KEY_n = 78;
var KEY_u = 85;
var KEY_d = 68;

var titleSlides = 1;
var curSlide = 1;
var totSlides = 0;

$(document).ready(function(){
    titleSlides = $(".titlefoil").length;

    totSlides = 0;
    $(".foil").each(function() {
        $(this).css("display", "none");
        totSlides++
    });

    var hashSlide = window.location.hash.substring(1)
    if (hashSlide != "") {
        hashSlide = parseInt(hashSlide);
        curSlide = hashSlide + titleSlides
    }

    $($(".foil")[curSlide - 1]).css("display", "block")
});

$(document).keydown(navigate);

function navigate(event) {
    var code = event.keyCode ? event.keyCode : event.which;
    //console.log("code: " + code)
    //console.log(curSlide + " of " + totSlides)

    if ((code == ARR_R || code == KEY_n || code == KEY_space) && curSlide < totSlides) {
        goto(curSlide+1)
    }

    if ((code == ARR_L || code == KEY_p) && curSlide > 1) {
        goto(curSlide-1)
    }

    if (code == KEY_h) {
        goto(1)
    }

    if (code == KEY_t) {
        goto(totSlides)
    }

    return true;
}

function goto(slide) {
    $($(".foil")[curSlide - 1]).css("display","none")
    curSlide = slide
    $($(".foil")[curSlide - 1]).css("display","block")

    var hash = ""
    if (curSlide > titleSlides) {
        hash = "#" + (curSlide - titleSlides)
    }
    window.location.hash = hash
}
