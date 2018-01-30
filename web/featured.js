/* Develop your answer to Question 2 here */
"use strict";


var current_banner_num = 1;

function crossfade() {
    $("#banner-" + current_banner_num).fadeOut();

    if (current_banner_num == 4) {
        current_banner_num = 1;
    } else {
        current_banner_num++;
    }
    $("#banner-" + current_banner_num).fadeIn();
}


$(document).ready(function () {

    $("#banner-base").css("visibility", "hidden"); // Use hidden to keep width and height of div same as image
    $("#banner-" + current_banner_num).show();
    window.intervalTimer = setInterval(crossfade, 3000);

});

