<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Assignmentt.aspx.cs" Inherits="Assignmentt" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8/jquery.min.js">
</script>

    <script>

        function Drop(vs) {
            vs.preventDefault();
        }

        function Drag(vs) {
            vs.dataTransfer.setData("text", vs.target.id);
			var iList="";
        }

        function Drop(vs) {
            vs.preventDefault();
            var data = vs.dataTransfer.getData("text");

            $('#' + vs.target.id + ' ul').append('<li>' + $('#' + data).html() + '</li>');
            $('#' + data).remove();
        }
        $('#drag').click(function () {
            alert(1);
            //$('#ul').animate({
            //    'marginLeft': "-=30px" //moves left
            //});
        });
        function move() {              
            var content = $('[id$=div1]').html();
            $('#div2').html(content);
            $('[id$=div1]').html('');
        }
        function mo() {
            $("#ul").detach().appendTo('#div2');
        }
        $(document).ready(function () {
            $("p").click(function () {
                if ($("p").html() == "Click me.") {
                    $("p").html("Revert");
                    $("#ul").detach().appendTo('#div2');
                }
                else {
                    $("p").html("Click me.");
                    $("#ul").detach().appendTo('#div1');
                }
            });
            $("#drag").click(function () {
                var pos = $("#div1").position();
                alert(pos)
                var div = $("#div1");
                div.animate({ 'left': pos.left }, "slow");
       
            });
        });

       
       
      

</script>

     

    
</head>
<body>
    <form id="form1" runat="server">
        
               <div id="div1" style="height: 400px; width: 500px; border: 1px solid black; float:left; ">
                   <ul id="ul">
                    <li id ="data" draggable="true" ondragstart="Drag(event)"> rakesh</li> 
                    <li  id = "data1" draggable="true" ondragstart="Drag(event)"> suresh</li>
                    <li  id = "data2" draggable="true" ondragstart="Drag(event)""> rajeev  </li> 
                    <li id = "data3" draggable="true" ondragstart="Drag(event)"> john</li>
                    <li id = "data4" draggable="true" ondragstart="Drag(event)"> mark </li> </ul> </div>
                   
       <div id="div2"  ondragleave="Drop(event)" style="height:400px;
         width:500px;border:1px solid black; padding:20px;
         float:right">
           <ul>

           </ul>
       </div>
        <p style="font-size:40px">Click me.</p>
        <input type="button" value="Drag"  id="drag"/>
           </form>
</body>
</html>

 
