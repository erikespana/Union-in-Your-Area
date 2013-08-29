<?php

$domain = "http://www.union.edu";
$path   = $domain . "/admissions/in-your-area";

// Description: Generates HTML for CONTENTCOPY region in Cascade
include_once "xmlTransform.php";

$contentCopy = "<p>Click on your region to see the high schools and college fairs our Admissions counselors are visiting.</p><p><a href=\"region.php?st=international\">International</a></p>";

$xml = "http://www.union.edu/admissions/in-your-area/config.xml";

$xsl = "/www/union/admissions/in-your-area/xsl/states-3column.xsl";

$content = new xmlTransform($xml, $xsl);

if ( $content->transform() ) {

    $contentCopy .= $content->getTransform();
    echo $contentCopy;

} else {
  trigger_error('XSL transformation failed.', E_USER_ERROR);  
}

?>
