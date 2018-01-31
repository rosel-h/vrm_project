/* Develop your answer to Question 2 here */
"use strict";


var current_banner_num = 1;

function crossfade() {

    if (current_banner_num == 5) {
        current_banner_num = 1;
    } else {
        current_banner_num++;
    }
    $("#banner-" + current_banner_num).fadeIn();

    var old_banner_num;
    if (current_banner_num == 1) {
        old_banner_num = 5;
    }else {
        old_banner_num = current_banner_num - 1;
    }

    $("#banner-" + old_banner_num).fadeOut();

}


$(document).ready(function () {

    $("#banner-base").css("visibility", "hidden"); // Use hidden to keep width and height of div same as image
    $("#banner-" + current_banner_num).show();
    window.intervalTimer = setInterval(crossfade, 3000);

});

