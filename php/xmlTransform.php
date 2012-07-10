<?php

class xmlTransform {

    var $xml;
    var $xsl;
    var $procssr;
    var $output;
    
    function __construct($newBlock, $newFormat) {

        $this->xml = new DomDocument;
        $this->xsl = new DomDocument;
        $this->procssr = new XsltProcessor();
    
        $this->xml->load($newBlock);
        $this->xsl->load($newFormat);
        
        // import the XSL styelsheet into the XSLT process
        $this->procssr->importStylesheet($this->xsl);
    }
    
    function setParameters($state, $country) {
    
        $this->procssr->setParameter('', 'state', $state);
        $this->procssr->setParameter('', 'country', $country);
    
    }
    
    // transform the XML into HTML using the XSL file
    function transform() {
    
        $this->output = $this->procssr->transformToXML($this->xml);
        return $this->output;
    }
    
    function getTransform() {
        return $this->output;
    }
    
}

?>