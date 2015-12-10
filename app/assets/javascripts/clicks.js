$(document).ready(function () {
    $('#new_click').on('ajax:success', function (e, data, status, xhr) {
        $('#result').text(data);
    }).on('ajax:error', function (e, xhr, status, error) {
        $('#reportalert').text('Failed.');
    });
});

function plotGraph(clicks, message){
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
}