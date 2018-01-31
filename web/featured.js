/* Develop your answer to Question 2 here */
"use strict";

var imgtime = "";
var current_banner_num = 1;

function crossfade() {

/*    if (current_banner_num == 5) {
        current_banner_num = 1;
    } else {
        current_banner_num++;
    }*/
    current_banner_num = current_banner_num == 5 ? 1 : current_banner_num + 1;

    $("#banner-" + current_banner_num).fadeIn();

    var old_banner_num = current_banner_num == 1 ? 5 : current_banner_num - 1;
/*    if (current_banner_num == 1) {
        old_banner_num = 5;
    } else {
        old_banner_num = current_banner_num - 1;
    }*/

    $("#banner-" + old_banner_num).fadeOut();
    // imgtime = setTimeout("crossfade()", 3000)
}

var time = "";
var index = 1;

function showimg(num) {
    index = num;
    $(".imgnum span").removeClass("onselect").eq(index - 1).addClass("onselect");
    $("#banner_img li").hide().stop(true, true).eq(index - 1).fadeIn("slow");
    index = index + 1 > 5 ? 1 : index + 1;
    time = setTimeout("showimg(" + index + ")", 3000);

}


$(document).ready(function () {

    $("#banner-base").css("visibility", "hidden"); // Use hidden to keep width and height of div same as image
    // $("#banner-1").show();
    // console.log("#banner-" + current_banner_num);
    // imgtime = setInterval(crossfade, 3000);


    // crossfade();
    showimg(index);

    $(".imgnum span").hover(function () {
        clearTimeout(time);
        // clearTimeout(imgtime);
        var icon = $(this).text();
        $(".imgnum span").removeClass("onselect").eq(icon - 1).addClass("onselect");
        $("#banner_img li").hide().stop(true, true).eq(icon - 1).fadeIn("slow");
    }, function () {
        // imgtime = setInterval(crossfade, 3000);
        index = $(this).text() > 4 ? 1 : parseInt($(this).text()) + 1;
        time = setTimeout("showimg(" + index + ")", 3000);
    });


});

