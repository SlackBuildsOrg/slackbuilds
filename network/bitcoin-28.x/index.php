<?php
//$referer = $_SERVER["HTTP_REFERER"];;
//if (!empty($referer) & !eregi("glennmcc.org", $referer))
//header("location: http://glennmcc.org/");

date_default_timezone_set('US/Eastern');

$folder_array=array();
$file_array=array();
$dir = '.';
if ($handle = opendir($dir))
{
 while (false !== ($file = readdir($handle)))
 {
  if ($file != "." && $file != ".." && $file != ".htaccess" && $file != ".htpasswd" && $file != "dirlist.php" && $file != "index.php")
 {
   if (is_dir("$dir/$file"))
    $folder_array[] = $file;
   else
    $file_array[] = $file;
  }
 }
 closedir($handle);
}
//global $path;
echo"
<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\" \"http://www.w3.org/TR/html4/strict.dtd\">
<html>
<head>
<title>Arachne DOS web Browser (also for Linux)</title>
<link rel=\"shortcut icon\" href=\"/favicon.ico\">
<style type=\"text/css\">
<!--
A:link  { text-decoration: none; color: #00f}
A:hover { text-decoration: none; color: #f00}
body { background-color: #ccc; text-decoration: none; color: #333;
       background-image: url(/images/paper.gif); }
.darkbar { background-color: #555; }
.lightbar { background-color: #777; }
.font { font-weight: bold; font-size: 60px; color: #000; }
hr { color: #343434; background-color: #343434;
    border: 0px; width: 90%; height: 3px; }
img { border: 0; }
-->
</style>
<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">
<meta name=\"robots\" content=\"noindex, nofollow, none\">
</head> 
<body> 
";
if ($file_array)
{
 echo"<p>
 <b>Files in this directory</b><hr>\n
 <table cellspacing=\"0\" cellpadding=\"0\" width=\"99%\">\n
 <tr><td><big><big>&nbsp;File Name<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Last Modified&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;File Size\n";
 sort ($file_array);
 foreach ($file_array as $file)
 {
$filesize = filesize($file);
$filetime = date("m/d/y | H:i", filemtime($file));
 echo "<tr><td><big><big><a href=\"$dir/$file\">$file</a><td> -- $filetime -- $filesize bytes\n";
 }
echo"</table><hr>";
}

if ($folder_array)
{
echo"<p><b>subdirs under this directory</b><hr>\n
<table cellspacing=\"0\" cellpadding=\"0\" width=\"99%\">\n
<tr><td><big><big>";
 sort ($folder_array);
 foreach ($folder_array as $file)
 {
$filetime = date("m/d/y", filemtime($file));
 echo "<tr><td><big><big><a href=\"$file/\">$file/</a><td> -- $filetime\n";
if($file =="mik")
echo"<td><big><big> Some Linux applications ported to DOS";
 }
echo"</table><hr>";
}

echo"
</body></html>";

?>