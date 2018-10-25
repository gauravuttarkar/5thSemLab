<?php
function loadFile($xml, $xsl)
{
$xmlDoc = new DOMDocument();
$xmlDoc->load($xml);

$xslDoc = new DOMDocument();
$xslDoc->load($xsl);

$proc = new XSLTProcessor();
$proc->importStyleSheet($xslDoc);
echo $proc->transformToXML($xmlDoc);
}

function updateFile($xml)
{
$xmlLoad = simplexml_load_file($xml);
$postKeys = array_keys($_POST);

foreach($xmlLoad->children() as $x)
{
  foreach($_POST as $key=>$value)
  {
    if($key == $x->attributes())
    {
      $x->value = $value;
    }
  }
}

$xmlLoad->asXML($xml);
loadFile($xml,"x1.xsl");
}

if($_POST["btn_sub"] == "")
{
  loadFile("a1.xml", "x.xsl");
}
else
{
  updateFile("a1.xml");
}
?>