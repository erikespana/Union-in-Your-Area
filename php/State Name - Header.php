[system-view:internal]
<h1>Union in [State]</h1>
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
                ?><h1>Union Around the World</h1><?
	} else if ( $content->transform() ) {
		$stateXML = $content->getTransform();
		$state = str_replace('<?xml version="1.0"?>', '', $stateXML );
		?><h1>Union in <?php
		echo $state;
		?></h1><?php
	} // if
	
} // if
?>
#END-CODE-->[/system-view:external]
