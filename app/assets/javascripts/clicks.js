$(document).ready(function () {
    $('#new_click').on('ajax:success', function (e, data, status, xhr) {
        $("#result").fadeIn();
        $("#result").fadeOut();
    }).on('ajax:error', function (e, xhr, status, error) {
        $("#result").fadeOut();
    });
});

function plotGraph(clicks, message) {
    $("#prev").css('opacity', '1');
    $("#next").css('opacity', '1');

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
            xaxis: {
                renderer: $.jqplot.CategoryAxisRenderer,
                tickOptions: {
                    formatString: "%d"
                }
            },
            yaxis: {
                padMax: 1.3,
                tickOptions: {
                    formatString: "%d"
                }
            }
        }
    });

    if (month == max)
        $("#next").css('color', '#617EA7');

    if (month == min)
        $("#prev").css('color', '#617EA7');
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