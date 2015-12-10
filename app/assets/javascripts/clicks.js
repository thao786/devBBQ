$(document).ready(function () {
    $('#new_click').on('ajax:success', function (e, data, status, xhr) {
        $("#result").fadeIn();
    }).on('ajax:error', function (e, xhr, status, error) {
        $("#result").fadeOut();
    });

    $('#mybtn').click(function (e, data, status, xhr) {
        $("#result").fadeIn();
        $("#result").fadeOut();
    });

});

function plotGraph(clicks, message) {
    $("#myright").show();
    $("#myleft").show();

    var plot3 = $.jqplot('chart', [clicks], {
        title: message,
        seriesDefaults: {renderer: $.jqplot.BarRenderer},
        series: [
            {
                pointLabels: {
                    show: true,
                    labels: clicks
                }
            }],
        axes: {
            xaxis: {renderer: $.jqplot.CategoryAxisRenderer},
            yaxis: {padMax: 1.3}
        }
    });

    if (month == max)
        $("#myright").hide();
    if (month == min)
        $("#myleft").hide();
}


var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];

function getClickStat(m) {
    if (m < min || m > max) return;
    month = m;

    $.ajax({
        url: "/clicks/" + m,
        type: "GET",
        dataType: "json",
        data: "12",
        complete: function () {
        },
        success: function (data, textStatus, xhr) {
            var array = '[' + data.toString() + ']';
            var click_stat = JSON.parse(array);

            $('#chart').html('');
            plotGraph(click_stat, "Click Statistic for " + monthNames[m - 1]);
        },
        error: function () {
            $('#result').html('An Error has occurred');
        }
    });
}