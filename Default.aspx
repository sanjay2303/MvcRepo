<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js"></script>
    <script>
        $(function () {
            $("#draggable").draggable({
                revert: function (dropped) {
                    var dropped = dropped && dropped[0].id == "droppable";
                    if (!dropped) alert("I'm reverting!");
                    return !dropped;
                }
            }).each(function () {
                var top = $(this).position().top;
                var left = $(this).position().left;
                $(this).data('orgTop', top);
                $(this).data('orgLeft', left);
            });

            $("#droppable").droppable({
                activeClass: 'ui-state-hover',
                hoverClass: 'ui-state-active',
                drop: function (event, ui) {
                    $(this).addClass('ui-state-highlight').find('p').html('Dropped!');
                },
                out: function (event, ui) {
                    // doesn't work but something like this
                    ui.draggable.mouseup(function () {
                        var top = ui.draggable.data('orgTop');
                        var left = ui.draggable.data('orgLeft');
                        ui.position = { top: top, left: left };
                    });
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id="origin">
    <div id="draggable" class="ui-widget-content">
        <p>I revert when I'm not dropped</p>
    </div>
</div>
<div id="droppable" class="ui-widget-header">
    <p>Drop me here</p>
</div>
    </form>
</body>
</html>
