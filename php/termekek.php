<div id='menu'>
<?php 
$almenu=0;

echo("");
?>
</div>
<div>
<?php
echo("ide meg a termekek");

if (isset ( $_GET ["almenu"] )=="konyvek") {
	echo("Select * from konyvek order by szerzo");
}
echo ($_GET ["menu"] . ".php");
?>		
</div>
