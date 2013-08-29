[system-view:internal]
<div align="center">Dynamic content is placed here.</div>
<div align="center">Please do not modify anything below.</div>
[/system-view:internal] [system-view:external] <!--#START-CODE
<?php
//	Generates HTML for CONTENTCOPY region in Cascade
	
include_once "php/xmlTransform.php";

?>
<?php
if ( isset($_REQUEST['st']) ) {
         
        if ( isset($_REQUEST['cntry']) ) {
           $cntry = $_REQUEST['cntry'];
        } else {
           $cntry = '';
        }

	$xml = "config.xml";
	$xsl = "xsl/abbrev-to-state.xsl";
	$content = new xmlTransform($xml, $xsl);
	$content->setParameters($_REQUEST['st'], $cntry);

	if ( $_REQUEST['st'] == 'international' ) {
                ?>Union Around the World<?
	} else if ( $content->transform() ) {
		$stateXML = $content->getTransform();
		$state = str_replace('<?xml version="1.0"?>', '', $stateXML );
		?>Union in <?php
		echo $state;
		?><?php
	} // if
	
} // if
?>
#END-CODE-->[/system-view:external]
