<?php
$url = "http://localhost/testapi/emp/read.php";

//  Initiate curl
$ch = curl_init();
// Set the url
curl_setopt($ch, CURLOPT_URL,$url);

// If value 1 give me header information
curl_setopt($ch,CURLOPT_HEADER, 0);

// Each data transform connection rebuild don`t get data in cach
curl_setopt($ch,CURLOPT_FRESH_CONNECT, 1);

// Will return the response, if false it print the response
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

// Execute
$result=curl_exec($ch);
// Closing
curl_close($ch);

// var_dump(json_decode($result, true));

$data = json_decode($result, true);
print_r($data);


///Deocde Json
$data = json_decode($result,true);
//Count
$total=count($data);

$Str='<h1>Total : '.$total.'';
echo $Str;
//You Can Also Make In Table:
echo "<table border=1><tr>";
?>

<td>Name</td>
<td>Skills</td>
<td>Address</td>
<?php
echo "</tr><tr>";
foreach ($data as $key => $value)
{
	echo '  <td><font  face="calibri"color="red">'.$value['name'].'   </font></td><td><font  face="calibri"color="blue">'.$value['skills'].'   </font></td><td><font  face="calibri"color="green">'.$value['address'].'   </font></tr><tr>'."<br>";

}
echo "</tr></table>";