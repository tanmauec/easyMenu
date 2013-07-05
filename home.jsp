<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page import="com.controller.*"%>


<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
<script type="text/javascript" src="js/jquery-1.9.1.js"></script>
<script type="text/javascript" src="js/jquery-ui.js"></script>
<script type="text/javascript" src="js/jquery.project.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<script type="text/javascript" src="js/jsapi.js"></script>
<script>
google.load('visualization', '1.0', {'packages':['corechart']});
</script>
<link type="text/css" rel="stylesheet" href="css/jquery-ui.css">
<link type="text/css" rel="stylesheet" href="css/style.css">

</head>

<body>

	<div id="project">
		<div id="header" style="position: fixed;">
		


		</div>

		<ul class='tabs'>
			<li><a href='#tab1'>Project Team</a>
			</li>
			<li><a href='#tab2'>Team members</a>
			</li>
			<li><a href='#tab3'>Reporting</a>
			</li>
		</ul>

		<div id='tab1'>

			<div id="panel" style="0px;">
				<h2 style="text-align: center;">Create a new Team</h2>
				<form id="frm"  style="margin-top: -40px;"
					method="get">

					<p>
						<label><span><strong>Team name</strong>
						</span><input id="name" name="name" title="Can't be null value"
							type="text" autocomplete="off" value="" />
						</label>
					</p>
					<p>
						<label><span><strong>Account name</strong>
						</span><input id="account" name="account" title="Can't be null value"
						autocomplete="off"	type="text" value="" />
						</label><br />
					</p>
					<p>
						<label><span><strong>Project code</strong>
						</span><input id="projectcode" name="projectcode"
						autocomplete="off"	title="Can't be null value" type="text" value="" />
						</label><br />
					</p>
					<p>
						<label><span><strong>Start Date</strong>
						</span><input id="date" name="date" 
							autocomplete="off" title="Can't be null value" type="text" value="" />
						</label><br />
					</p>
					<p>
						<label><span><strong>Team size</strong>
						</span><input id="size" name="size" title="Should be greater than zero"
							type="text" autocomplete="off" value="" />
						</label><br />
					</p>
					<p>
						<label><span><strong>DM</strong>
						</span><input id="dm" name="dm" title="Can't be null value" type="text"
							autocomplete="off" value="" />
						</label><br />
					</p>
					<p>
						<label><span><strong>Location</strong>
						</span><input id="location" name="location" title="Can't be null value"
							autocomplete="off" type="text" value="" />
						</label><br />
					</p>

						<input type="button" id="submit"
							style="position: relative; margin: auto;" class="styled-button"
							value="Submit" />
						<input type="button" id="nupdate"
							style="position: relative; margin: auto;" class="styled-button"
							value="Update" />
							<input type="button" id="reset"
							style="position: relative; margin: auto;" class="styled-button"
							onclick="reset()" value="Reset" />
				</form>
				<a id="aname1" title="Team name field empty"></a> <a id="aname2"
					title="Team name duplicate"></a> <a id="aaccount"
					title="Account name field empty"></a> <a id="aprojectcode"
					title="Project code field empty"></a> <a id="adate"
					title="Date field empty"></a> <a id="asize1"
					title="Team size field empty"></a> <a id="asize2"
					title="PLease enter a postive numeric value"></a> <a id="adm"
					title="DM field empty"></a> <a id="alocation"
					title="Location field empty"></a>
			</div>


<div id="buttons">
			<div class="panel_button" style="display: visible; float: left;">
				<button class="styled-button">Create Team</button>
			</div>

            <div id="doodle" style="display: visible; float: left;">
				<button class="styled-button">View Teams</button>
			</div>
             
</div>             

			<!-- team info in tabular format -->



<div id="teamtable">
					<div class="head-row" >
						
							<div class="head-col">Team name</div>
							<div class="head-col">Account name</div>
							<div class="head-col">Project code</div>
							<div class="head-col">Start date</div>
							<div class="head-col">Team size</div>
							<div class="head-col">DM</div>
							<div class="head-col">Location</div>
                     </div>
<div id="teambody">

</div>
</div>
</div>

		<div id='tab2'>

			<!-- create a auto-suggestion box 
first load all team names in 
page by sql then assign to javascript variable then call  autocomplete feature
-->
			<!-- create a table to show members of the table selected -->
			<!-- creating a table using divs-->

			<label style="float: left;" for="tags"><span><strong>Choose
						a Team</strong>
			</span> <input style="margin-left: 20px;" type="text" name="tags" id="tags" />

				<button id="showtable" class="styled-button" style="float: left;">View
					Table</button>
				<button id="addmember" class="styled-button" style="float: left;">Add
					member</button> </label>

			<form  id="teamfrm" name="teamdetails" style="margin-top: 40px;"
				method="get">

				<p>
					<label><span><strong>Employee Id</strong>
					</span><input id="eid" name="eid" title="Can't be null value" type="text"
						autocomplete="off" value=""/>
						
					</label>
				</p>
				<p>
					<label><span><strong>Employee name</strong>
					</span><input id="ename" name="ename" title="Can't be null value"
						type="text" autocomplete="off" value="" />
					</label><br />
				</p>
				<p>
					<label><span><strong>Employee Email</strong>
					</span><input id="email" name="email" autocomplete="off"
						title="Please enter a valid email address" type="text" value="" />
					</label><br />
				</p>
				<p>
					<label><span><strong>Role</strong>
					</span><input id="role" name="role" id="datepicker"
						title="Can't be null value" type="text" autocomplete="off" value="" />
					</label><br />
				</p>
				<p>
					<label><span><strong>Experience</strong>
					</span><input id="experience" name="experience"
						title="In case a fresher please enter zero" type="text" autocomplete="off" value="" />
					</label><br />
				</p>
				<p>
					<label><span><strong>Technology</strong>
					</span> <input id="tech" name="tech" title="Can't be null value"
						type="text" autocomplete="off" value="" />
					</label><br />
				</p>

				<input type="button" id="esubmit"
					style="position: relative; margin: auto;" class="styled-button"
					value="Submit" /> 
					
							<input type="button" id="update"
							style="position: relative; margin: auto;" class="styled-button"
							value="Update" />
					<input type="button" id="ereset"
					style="position: relative; margin: auto;" class="styled-button"
					onclick="reset()" value="Reset" />

			</form>



			<div id="members" class="div-table" style="clear:both;">
				<div class="head_row">

					<div class="head-col">Id</div>
					<div class="head-col">Name</div>
					<div class="head-col">Email</div>
					<div class="head-col">Role</div>
					<div class="head-col">Experience</div>
					<div class="head-col">Technology</div>

				</div>
             <div id ="membersbody">
<!-- contents gets added dynamically -->
             </div>
			</div>










            <a id="nomembers" title="Team has no members"></a>
	        <a id="reply" title="Entry has been updated"></a>
			<a id="aeid" title="Name field cannot be emplty"></a> <a id="aename"
				title="Name field cannot be emplty"></a> <a id="aemail"
				title="Name field cannot be emplty"></a> <a id="arole"
				title="Name field cannot be emplty"></a> <a id="aexperience"
				title="Name field cannot be emplty"></a> <a id="atech"
				title="Name field cannot be emplty"></a>


<!-- TAB 2 ENDS HERE -->
		</div>
		
		<div id='tab3'>

<!-- to create a pie chart get all data first -->
<div id="testbuttons">
<button id = "pieview" onclick=viewbydm()>View Teams By DM</button>
<button id = "barview" onclick=viewbyloc()>View Teams By Location</button>
</div>

<div id="charts">
<div id="pie">
<div id="piechart_div"></div>
<div id="closepie"><button class="closebutton" onclick="$('#piechart_div').hide();$('#closepie').hide()">Close</button></div>
</div>
<div id="bar">
<div id="barchart_div"></div>
<div id="closebar"><button class="closebutton" onclick="$('#barchart_div').hide();$('#closebar').hide()">Close</button></div>
</div>
</div>

			<!-- TAB 3 ENDS HERE -->
		</div>

		<script>
			$(document).ready(
					function() {

                        $('#panel').hide();
						$('#logout').hide();
						$('#loginform').hide();
						$('#addmember').hide();
						$('#teamfrm').hide();
						$('#members').hide();
						$('#showtable').hide();
	                    $('#nupdate').hide();
	                    $('#reset').hide();
						$('#closepie').hide();
						$('#closebar').hide();
						editnamejquery();
						delnamejquery();
						var teamnames = new Array();
						<c:forEach var="m" items="${teams}">
						var team = "<c:out value="${m.teamname}"/>";
						teamnames.push(team);
						</c:forEach>

						$('#tags').autocomplete({
							source : teamnames,
							select : function() {
                              
								$('#showtable').show();
								
								$('#addmember').show();
							}
						});
				// initialise tooltip for member form
				
				
				      $('#aeid').tooltip({
				    	  
				    	  position: {
				    		  of : '#eid',
				    		  my : "left+120 top-8",
							  at : "left top"
						    }
				    	});
				
                           $('#aename').tooltip({
				    	  
				    	  position: {
				    		  of : '#ename',
				    		  my : "left+120 top-8",
							  at : "left top"
						    }
				    	});
				
                           $('#aemail').tooltip({
     				    	  
     				    	  position: {
     				    		  of : '#email',
     				    		  my : "left+120 top-8",
     							  at : "left top"
     						    }
     				    	});

                           $('#arole').tooltip({
     				    	  
     				    	  position: {
     				    		  of : '#role',
     				    		  my : "left+120 top-8",
     							  at : "left top"
     						    }
     				    	});
                           
                           $('#aexperience').tooltip({
     				    	  
     				    	  position: {
     				    		  of : '#experience',
     				    		  my : "left+120 top-8",
     							  at : "left top"
     						    }
     				    	});
     				
                           $('#atech').tooltip({
     				    	  
     				    	  position: {
     				    		  of : '#tech',
     				    		  my : "left+120 top-8",
     							  at : "left top"
     						    }
     				    	});
     				
                           
					$("#aname1").tooltip({
							position : {
								of : '#name',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#aname2").tooltip({
							position : {
								of : '#name',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#aaccount").tooltip({
							position : {
								of : '#account',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#aprojectcode").tooltip({
							position : {
								of : '#projectcode',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#adate").tooltip({
							position : {
								of : '#date',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#asize1").tooltip({
							position : {
								of : '#size',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#asize2").tooltip({
							position : {
								of : '#size',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#adm").tooltip({
							position : {
								of : '#dm',
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$("#alocation").tooltip({
							position : {
								of : '#location',
								my : "left+120 top-8",
								at : "left top"
							}
						
						
						
						});
				
						
						
						
						
						
$('#doodle').click(function(){
	
	$.ajax({
		url : 'home',
		data : "&loadtable=" + "anything",
		dataType:'json',
		success : function(json) {
		alert("thoda");
// reload the table

$.each(json,function(m,n){

var row = $('<div class="table-row"></div>').appendTo('#teambody');
var coltext  = '<div class="col">'+n.teamname
+'</div><div class="col">'+n.accname
+'</div><div class="col">'+n.projectcode
+'</div><div class="col">'+n.date
+'</div><div class="col">'+n.size
+'</div><div class="col">'+n.dm
+'</div><div class="col">'+n.loc + 
+'</div><div class="col"><button class="editnamebutton">+"Edit"+</button>' 
+'</div><div class="col"><button class="delnamebutton">+"Delete"+</button>' ;
row.html(coltext);            
});     
editnamejquery();
delnamejquery();

alert("done");
},
       error: function()
       {
    	   alert("error");
       }

});
	
});	
	
	
						
$('#showtable').on('click',function(){
var tablename = $('#tags').serialize();

$.ajax({
	method:"GET",
	url:'home', 
	data: tablename + "&showtable="+"valuesdoesn't matter",
	dataType: 'json',
	success: function(data){
		  $('#membersbody div.table-col').remove();
		if(data.length==0){ $('#nomembers').tooltip({disabled:false}); $('#nomembers').tooltip('open');return;}
    $('#nomembers').tooltip({disabled:true});
		  $('#membersbody div.table-col').remove();
		$.each(data,function(m,m){
       var row=$('<div class="table-row"></div>').appendTo("#membersbody");
       var coltext = '<div class="table-col">'+ m.id
                     +'</div><div class="table-col">'+ m.name+'</div><div class="table-col">'+ m.email
                     + '</div><div class="table-col">'+ m.role+'</div><div class="table-col">'+ m.experience
                     +'</div><div class="table-col">'+ m.tech +'</div>'
                     +'<div class="table-col"><button  class="editbutton"  >'+ "Edit"+ '</button></div>'
					 +'<div class="table-col"><button class="delbutton" >' + "Delete" +'</button></div></div>' ;
       row.html(coltext);
	
	
		});
		
		
	$('#members').show();
	$('#showtable').hide();

	editjquery();
    deljquery();
	},
	error: function(){
		alert("nihua");
		
	}

});

});

      $('#addmember').on('click', function() {
           					$('#teamfrm').slideToggle();
                            $('#update').hide();
						});

      
                       $('div.hide_button').hide();

                       
						$('div.panel_button').click(function() {
						
					
						//	$("#teamtable").toggle("fold",500);
						//$('#panel').toggle("drop",500);
							$('div.panel_button').hide();
							
						$('#panel').slideToggle(1000);
						$('div.hide_button').show();

						});

						$('#project').tabs();

					$("#submit").on('click',function() {
									if (validateForm()) {
                               var formdata = $('#frm').serialize();
                     // to add  a team
										$.ajax({
											url : 'home',
											data : formdata + "&addteam=" + "anything",
											dataType:'json',
											success : function(json) {
												alert("thoda");
                    // reload the table
                    $('#teambody div.table-row').remove();
            
               $.each(json,function(m,n){
            	   
            	   var row = $('<div class="table-row"></div>').appendTo('#teambody');
            	   
            	  var coltext  = '<div class="col">'+n.teamname
            	                  +'</div><div class="col">'+n.accname
            	                  +'</div><div class="col">'+n.projectcode
            	                  +'</div><div class="col">'+n.date
            	                  +'</div><div class="col">'+n.size
            	                  +'</div><div class="col">'+n.dm
            	                  +'</div><div class="col">'+n.loc + 
            	                  +'</div><div class="col"><button class="editnamebutton">+"Edit"+</button>' 
            	                  +'</div><div class="col"><button class="delnamebutton">+"Delete"+</button>' ;
            	      row.html(coltext);            
            	});     
            editnamejquery();
            delnamejquery();
               
               $('#panel').slideToggle();
               $('div.panel_button').show();
				$('div.modify').show();

				alert("done");
              },
                                           error: function()
                                           {
                                        	   alert("error");
                                           }

										});

										
										// if stmt ends here
									}

									return false;

								});
						
$('#nupdate').click(
		function(e) {
			if (validateForm()) {

                alert("validated");
				var formdata = $('#frm').serialize();

				
				$.ajax({
                  url : 'home',
                  data : formdata +"&updateteam=" + "kuchbhi",
                  dataType:'json',
                  success : function(data) {
                  // show the members updated

$('#teamtable div.table-row').remove();
$('#teamtable').hide();
                 $.each(data,function(m,m){
             var row=$('<div class="table-row"></div>').appendTo("#teamtable");
             var coltext = '<div class="table-col">'+ m.name
+'</div><div class="table-col">'+ m.account+'</div><div class="table-col">'+ m.projectcode
+ '</div><div class="table-col">'+ m.date+'</div><div class="table-col">'+ m.size
+'</div><div class="table-col">'+ m.dm +'</div><div class="table-row">'+m.location
+'</div><div class="table-col"><button class="editbutton" >'+ "Edit"+ '</button></div>'
+'<div class="table-col"><button class="delbutton">' + "Delete" +'</button></div></div>' ;
row.html(coltext);
});

$('#teamtable').show();
$('#frm').hide();
editnamejquery();
delnamejquery();
},

error: function(){
alert("nihua");

}});
						
				// if stmt ends here
}

			return false;

		});
					
					

						$("#update").click(
								function(e) {
									if (validateeform()) {

                                        alert("validated");
										var formdata = $('#teamfrm').serialize();
                                        var tagsvalue = $('#tags').val();
	$.ajax({
	url : 'home',
	data : formdata +"&tags="+ tagsvalue + "&memupdate=" + "kuchbhi",
	dataType:'json',
	success : function(data) {
    // show the members updated
	
    $('#membersbody div.table-row').remove();
   	$('#members').hide();
    $.each(data,function(m,m){
       var row=$('<div class="table-row"></div>').appendTo("#membersbody");
       var coltext = '<div class="table-col">'+ m.id
                     +'</div><div class="table-col">'+ m.name+'</div><div class="table-col">'+ m.email
                     + '</div><div class="table-col">'+ m.role+'</div><div class="table-col">'+ m.experience
                     +'</div><div class="table-col">'+ m.tech +'</div>'
                     +'<div class="table-col"><button class="editbutton" >'+ "Edit"+ '</button></div>'
					 +'<div class="table-col"><button class="delbutton">' + "Delete" +'</button></div></div>' ;
       row.html(coltext);
		});
		
	$('#members').show();
	$('#teamfrm').hide();
	editjquery();
	deljquery();
	},
	
	error: function(){
		alert("nihua");

	}});
												
										// if stmt ends here
	}

									return false;

								});
						
						
						$('#esubmit').click(function() {
// adding a member
							if (validateMembers()) {
								var formdata = $('#teamfrm').serialize();
								var tagsvalue = $('#tags').val();

								$.ajax({

									url : 'home',
									data : formdata + "&tags=" + tagsvalue,
									cache : false,
									success : function(data){
// reload table
										$('#membersbody div.table-row').remove();
									   	$('#members').hide();
									    $.each(data,function(m,m){
									       var row=$('<div class="table-row"></div>').appendTo("#membersbody");
									       var coltext = '<div class="table-col">'+ m.id
									                     +'</div><div class="table-col">'+ m.name+'</div><div class="table-col">'+ m.email
									                     + '</div><div class="table-col">'+ m.role+'</div><div class="table-col">'+ m.experience
									                     +'</div><div class="table-col">'+ m.tech +'</div>'
									                     +'<div class="table-col"><button class="editbutton" >'+ "Edit"+ '</button></div>'
														 +'<div class="table-col"><button class="delbutton">' + "Delete" +'</button></div></div>' ;
									       row.html(coltext);
											});
											
										$('#members').show();
										$('#reply').tooltip('open');
										$('#teamfrm').hide();
										editjquery();
										deljquery();

									},
									error: function(){alert("error");}

								});

								$('#teamfrm').hide();
							}

							else
								return false;
						});

						$(document).tooltip({
							position : {
								my : "left+120 top-8",
								at : "left top"
							}
						});
						$('input:text').tooltip({
							position : {
								my : "left+120 top-8",
								at : "left top"
							}
						}).on("click", function() {
							$(this).tooltip({
								disabled : true
							});
						});

						// .on("focusout",function(){$(this).tooltip({disabled:false})})		
						//$('input:text').tooltip({disabled:true});
						$('#date').datepicker();

					});

			function validateMembers() {
				
				$('input:text').tooltip({
					disabled : true
				});

				    if($('#eid').val() == "") {
			        $('#aeid').tooltip('open');
					$('#eid').on('click', function() {
					$('#aeid').tooltip('close');
					});
					return false;
				} else {
					// check if duplicate id not present	
				
		
				
					var flag = 0;
					var tablen = $('#tags').serialize();
			  var id = $('#eid').val();
				$.ajax({
				url : 'home',
				data : tablen + "&id="+ id + '&duplicate='+"exists",
				dataType : 'json',
				success: function(data){
					if(data!=null){
					flag=1;
					}
				
				},
				
				error: function(){
				}
				
				});
				
				if(flag==1){alert('aaja');return false;}
				
				}

				return true;
			
			}

			
			function validateForm() {

				$('input:text').tooltip({
					disabled : true
				});

				if ($('#name').val() == "") {

					$('#aname1').tooltip('open');
					$('#name').on('click', function() {
						$('#aname1').tooltip('close');

					});

					return false;
				} else {
					// check if duplicate team name exists
				}

				if ($('#account').val() == "") {

					$('#aaccount').tooltip('open');
					$('#account').on('click', function() {
					$('#aaccount').tooltip('close');
					});

					return false;
				}

				if ($('#projectcode').val() == "") {
					$('#aprojectcode').tooltip('open');
					$('#projectcode').on('click', function() {
						$('#aprojectcode').tooltip('close');
					});
					return false;
				}

				if ($('#date').val() == "") {
					$('#adate').tooltip('open');
					$('#date').on('click', function() {
						$('#adate').tooltip('close');
					});
					return false;
				}

				if ($('#size').val() == "") {
					$('#asize1').tooltip('open');
					$('#size').on('click', function() {
						$('#asize1').tooltip('close');
					});
					return false;
				} else {
					var text = $('#size').val();
					if (!$.isNumeric(text)) {
						$('#asize2').tooltip('open');
						$('#size').on('click', function() {
							$('#asize2').tooltip('close');
						});
						return false;
					} else {
						if ($('#size').val() <= 0) {
							$('#asize2').tooltip('open');
							$('#size').on('click', function() {
								$('#asize2').tooltip('close');
							});
							return false;
						}
					}

				}

				if ($('#dm').val() == "") {
					$('#adm').tooltip('open');
					$('#dm').on('click', function() {
						$('#adm').tooltip('close');
					});
					return false;
				}

				if ($('#location').val() == "") {
					$('#alocation').tooltip('open');
					$('#location').on('click', function() {
						$('#alocation').tooltip('close');
					});
					return false;
				}

				return true;
			}

			function reset() {
				$('#frm input:text').val("");
			}

	function viewbyloc()
	{
			var row=[];
			$.ajax({
			    url : 'home',
			    data : '&byloc=' + "nothing",
			    dataType: 'json',
			    success: function(data){
	$.each(data,function(key,value){
		row.push([value.loc,value.number]);
	});

	drawBarChart(row);

			    },
			    error:function(){alert("locerror");}
			    });
		
		
	}
			
			
	function viewbydm(){
	
		var row=[];
		$.ajax({
		    url : 'home',
		    data : '&bydm=' + "nothing",
		    dataType: 'json',
		    success: function(data){
$.each(data,function(key,value){
	row.push([value.dm,value.noofpersons]);
});

drawPieChart(row);

 },
		    error:function(){alert("dmerror");}
		    });
	}			
	
	function drawBarChart(rows)
	{
		
	    // Create the data table.
	    //get data via json
     
	 var data = new google.visualization.DataTable();
	 data.addColumn('string','Location');
	 data.addColumn('number','No. of Teams');
	 data.addRows(rows);
	 
	    // Set chart options
	    var options = {'title':'Teams based in Different Locations',
	                   'width':400,
	                   'height':300};

	    // Instantiate and draw our chart, passing in some options.
	    var chart = new google.visualization.BarChart(document.getElementById('barchart_div'));
	    chart.draw(data, options);
	
	}
	
	function drawPieChart(rows){
		
	    // Create the data table.
	    //get data via json
     
	 var data = new google.visualization.DataTable();
	 data.addColumn('string','DM');
	 data.addColumn('number','No. of Persons');
	 data.addRows(rows);
	 
	    // Set chart options
	    var options = {'title':'Teams under Delivery Manager',
	                   'width':400,
	                   'height':300};

	    // Instantiate and draw our chart, passing in some options.
	    var chart = new google.visualization.PieChart(document.getElementById('piechart_div'));
	    chart.draw(data, options);
	}

	function editnamejquery()
	{
    	$('.editnamebutton').click(function(){
    		alert("edit name");
    		var i=1;
    		var dom = $(this).parent().parent().children('div.col');
            dom.each(
    		function(){
         
    			if(i<=7){
    			
    				var text = $(this).html();
  
    				if(i==1){
                $('#name').val(text);
    		        }
    				
    				if(i==2){
    		              // $('#ename').val(text);
    		              document.getElementById('account').value = text;        
    		         
    				}	
    				if(i==3){
    			           //$('#email').val(text);
    		               document.getElementById('projectcode').value = text;       
    				}
    						
    				if(i==4){
    		               //$('#role').val(text);
    		               document.getElementById('date').value = text;        
    				}
    				if(i==5){
    		               //$('#experien').val(text);
    			    document.getElementById('size').value=text;        
    				}
    				if(i==6){
    		               //$('#tech').val(text);
    					document.getElementById('dm').value=text;        
    				}
    				if(i==7){
    					document.getElementById('location').value=text;
    				}
    		
    		
    			   i=i+1;	
    			}
     	
    	}); 
    // form populated with default values

    // popup the form
    $('#panel').slideToggle();
    $('div.panel_button').hide();
    $('#submit').hide();
    $('#nupdate').show();
    $('#reset').show();
    	});
    	
		
		
		
	}
	
	function editjquery()
    {
    	$('.editbutton').click(function(){
    		
    		var i=1;
    		var dom = $(this).parent().parent().children('div.table-col');
            dom.each(
    		function(){
         
    			if(i<=6){
    			
    				var text = $(this).html();
    		
    		 if(i==1){
                $('#eid').val(text);
    		        }
    				
    				if(i==2){
    		              // $('#ename').val(text);
    		              document.getElementById('ename').value = text;        
    		         
    				}	
    				if(i==3){
    			           //$('#email').val(text);
    		               document.getElementById('email').value = text;       
    				}
    						
    				if(i==4){
    		               //$('#role').val(text);
    		               document.getElementById('role').value = text;        
    				}
    				if(i==5){
    		               //$('#experien').val(text);
    			    document.getElementById('experience').value=text;        
    				}
    				if(i==6){
    		               //$('#tech').val(text);
    					document.getElementById('tech').value=text;        
    				}
    	
    			   i=i+1;	
    			}
     	
    	}); 
    // form populated with default values

    // popup the form

    $('#teamfrm').show();
    $('#esubmit').hide();
    $('#update').show();

    	});
    	
    }

	function delnamejquery(){
		
		$('.delnamebutton').click(function(){
			
		var dom = $(this).parent().parent().children('div.col:first');
        
		var del = dom.html();
		//alert(del);
		
		$.ajax({
        
		url: 'home',
        data : "&ndel=" + del ,
        dataType: 'json',
        success : function(data){
        	// remove all matching elements

        	$('#teamtable').hide();
        	$('#teamtable div.table-row').remove();  
        	$.each(data,function(m,n){
        	       var row=$('<div></div>').appendTo("#teamtable");
        	       var coltext = '<div class="col">'+ n.name
        	                     +'</div><div class="col">'+ n.account+'</div><div class="col">'+ n.projectcode
        	                     + '</div><div class="col">'+ n.date+'</div><div class="col">'+ n.size
        	                     +'</div><div class="col">'+ n.dm +'</div><div class="col">'+n.location
        	                     +'</div><div class="col"><button class="editnamebutton">'+ "Edit"+ '</button></div>'
        						 +'<div class="col"><button class="delnamebutton">' + "Delete" +'</button></div></div>' ;
        	       row.html(coltext);
        			});
       $('#teamtable').show();
       editnamejquery();
       delnamejquery();
        },
        
        error: function(){
        	alert("not deleted");
        }
        
        });
		
	});
		
	}
	
	
	
	
	
	
	function deljquery()
	{
		$('.delbutton').click(function(){
			
		var dom = $(this).parent().parent().children('div.table-col:first');
        
		var del = dom.html();
		//alert(del);
		var tagsvalue = $('#tags').val();
		
		$.ajax({
        
			url: 'home',
        data : "&del=" + del + "&tags=" + tagsvalue,
        success : function(data){
        	// remove all matching elements


            $('#members').hide();
        	 $('#membersbody div.table-row').remove();  
        	$.each(data,function(m,m){
        	       var row=$('<div class="table-row"></div>').appendTo("#membersbody");
        	       var coltext = '<div class="table-col">'+ m.id
        	                     +'</div><div class="table-col">'+ m.name+'</div><div class="table-col">'+ m.email
        	                     + '</div><div class="table-col">'+ m.role+'</div><div class="table-col">'+ m.experience
        	                     +'</div><div class="table-col">'+ m.tech +'</div>'
        	                     +'<div class="table-col"><button class="editbutton">'+ "Edit"+ '</button></div>'
        						 +'<div class="table-col"><button class="delbutton">' + "Delete" +'</button></div></div>' ;
        	       row.html(coltext);
        			});
        			//alert("deleted");
       $('#members').show();
       editjquery();
       deljquery();
        },
        
        error: function(){
        	alert("not deleted");
        }
        
        });
		
	});
}
	
	</script>
</div>
</body>
</html>
