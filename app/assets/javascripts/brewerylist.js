$(document).ready(function () {
    var BREWERIES = {};

    BREWERIES.show = function(){
        $("#breweriestable tr:gt(0)").remove();

        var table = $("#breweriestable");

        $.each(BREWERIES.list, function (index, brewery) {
            table.append('<tr>'
            +'<td>'+brewery['name']+'</td>'
            +'<td>'+brewery['founded']['name']+'</td>'
            +'<td>'+brewery['beerscount']['name']+'</td>'
            +'</tr>');
        });
    };

    BREWERIES.sort_by_name = function(){
        BREWERIES.list.sort( function(a,b){
            return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
        });
    };

    BREWERIES.sort_by_founded = function(){
        BREWERIES.list.sort( function(a,b){
            return a.founded.localeCompare(b.founded);
        });
    };

    BREWERIES.sort_by_beerscount = function(){
        BREWERIES.list.sort( function(a,b){
            return a.beers.count.localeCompare(b.beers.count);
        });
    };

    $(document).ready(function () {
        $("#name").click(function (e) {
            BEERS.sort_by_name();
            BEERS.show();
            e.preventDefault();
        });

        $("#year").click(function (e) {
            BEERS.sort_by_founded();
            BEERS.show();
            e.preventDefault();
        });

        $("#beerscount").click(function (e) {
            BEERS.sort_by_beerscount();
            BEERS.show();
            e.preventDefault();
        });

        if ($("brewerytable").length>0 ) {
            $.getJSON('breweries.json', function (beers) {
                BEERS.list = beers;
                BEERS.sort_by_name();
                BEERS.show();
            });
        }

    });
});