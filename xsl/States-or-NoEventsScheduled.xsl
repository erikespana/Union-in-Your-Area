<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>

    <!--
        Conditional listing of all US States.
        Expects:
        Feed block - http://www.union.edu/applications/admissions/ADMTRAVEL.XML
        Publish Set - Page is published daily at 3:00am.
        
        1. Check that there are admissions events.
        2. Execute embedded PHP include:
            Load XML array of US state abbreviations and names
            XSLT transform into 3 column list
            
        Future updates:
        
        2)  If u80admtstaff1employee = Y display staff name and email, otherwise hide staff name and email
        
        3)  Display countries using new fields u80admtinst1country and u80admteventcountr to display international events
        
        4)  Add a county page to divide NY into a list of counties using new fields u80admtinst1county and u80admteventcounty
        
        5) Display countries that are in ADMTRAVEL.XML
    -->
    
    <xsl:template match="/download">
 
        <xsl:choose>
            <xsl:when test="count(//u80admtravel) &gt; 0">
                <xsl:comment>#START-CODE
                &lt;?php include 'php/states-3columns.php'; ?&gt;
                #END-CODE</xsl:comment>
            </xsl:when>
            <xsl:otherwise>
                <p>We have no events currently scheduled.</p>
                <p>Please choose one of the following or check back at a future date:
                </p>
                <ul>
                    <li>
                        <a href="/admissions/staff/index">Locate your Admissions Counselor</a>
                    </li>
                    <li>
                        <a href="/admissions/visiting/visit/index">Schedule a Campus Visit</a>
                    </li>
                    <li>
                        <a href="/admissions/visiting/in-your-area/alumni-interviews/index">Schedule an Alumni Interview</a>
                    </li>
                    <li>
                        <a href="/admissions/contact/index">Subscribe to our mailing list</a>
                    </li>
                </ul>
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:template>
</xsl:stylesheet>