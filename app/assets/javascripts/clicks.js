$(document).ready(function () {
    $('#new_click').on('ajax:success', function (e, data, status, xhr) {
        $("#result").fadeIn();
        $("#result").fadeOut();
    }).on('ajax:error', function (e, xhr, status, error) {
        $("#result").fadeOut();
    });

    $(window).bind('resize', function () {
        plot.replot({resetAxes: true});
    });
});

function plotGraph(clicks, message) {
    plot = $.jqplot('chart', [clicks], {
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
}

var monthNames = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"];

function getClickStat(m, min, max) {
    if (m < min || m > max) return;

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
            plotGraph(click_stat, "Click Statistic for " + monthNames[m - 1] + ", 2015");
        },
        error: function () {
            $('#result').html('An Error has occurred');
        }
    });
}


