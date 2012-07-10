[system-view:internal]
<div align="center">Dynamic content is placed here.</div>
<div align="center">Please do not modify anything below.</div>
[/system-view:internal] [system-view:external] <!--#START-CODE


<?php
	//	Description: 	Generates HTML for CONTENTCOPY region in Cascade
$errorMsg = "<p>Please press the Back button and click on a state to see the high schools and college fairs our Admissions counselors are visiting this fall.</p>\n";

include_once "php/xmlTransform.php";

// parse the URL parameters using the HTTP Request variable ($_REQUEST)
// page contains the name of the previous screen displayed to determine which screen to display next

if ( isset($_REQUEST['st']) ) {
	
	$xml = "http://www.union.edu/applications/admissions/ADMTRAVEL.XML";
	$xsl = "xsl/datatel-transform.xsl";
	$xmlRegion = new xmlTransform($xml, $xsl);
	$xmlRegion->setParameters($_REQUEST['st'], $_REQUEST['cntry']);
	
	if ( $xmlRegion->transform() ) {
		?>
		<script>
			$(function() {
				$( "#accordion" ).accordion({ header: 'h3' });
				$( "#accordion" ).accordion({ collapsible: true, active: false });
				
			});
		</script>
		<?php
		echo $xmlRegion->getTransform();
			
	} else {
		trigger_error( $errorMsg , E_USER_ERROR);
	}
	
} else {
	echo $errorMsg;
}

?>
#END-CODE-->[/system-view:external]