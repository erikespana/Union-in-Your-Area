<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>

    <xsl:template match="/download">
        <p>
            <b>Total events: </b>
            <xsl:value-of select="count(//u80admtravel)"/>
        </p>

        <p>
            <b>Types: HSV </b>
            (<xsl:value-of select="count(//u80admtravel[(u80admteventtype = 'HSV')])"/>),
            <b>CF </b>
            (<xsl:value-of select="count(//u80admtravel[(u80admteventtype = 'CF')])"/>),
            <b>NCF </b>
            (<xsl:value-of select="count(//u80admtravel[(u80admteventtype = 'NCF')])"/>) and
            <b>7GS </b>
            (<xsl:value-of select="count(//u80admtravel[(u80admteventtype = '7GS')])"/>)
        </p>

        <h2>Dates and Times</h2>

        <p><b>Number of Events...</b></p>
        <p>
            <b>with Start Dates: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtstartdates != ''])"/>
        </p>

        <p>
            <b>with Start Dates and Start Times: </b>
            <xsl:value-of select="count(//u80admtdates[ (u80admtstartdates != '') and (u80admtstarttimes != '')])"/>
        </p>

        <p>
            <b>with End Dates: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtenddates != ''])"/>
        </p>
        
        <p>
            <b>where End Date is not blank and Start Date = End Date: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtenddates != ''][u80admtstartdates = u80admtenddates])"/>
        </p>

        <p>
            <b>with End Times: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtendtimes != ''])"/>
        </p>


        <p>
            <b>with End Times but no End Dates: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtendtimes != ''][u80admtenddates = ''])"/>
        </p>


        <p>
            <b>with End Times and End Dates: </b>
            <xsl:value-of select="count(//u80admtdates[u80admtendtimes != ''][u80admtenddates != ''])"/>
        </p>
        
        <p>
            <b>Number of "u80admtdates" elements: </b>
            <xsl:value-of select="count(//u80admtdates)"/>
        </p>

        <p>
            <b>College Fairs: </b>
            <xsl:value-of select="count(//u80admtravel[(u80admteventtype = 'CF') or (u80admteventtype = 'NCF')])"/>
        </p>
        
        <h2>All <!--CF/NCF/7GS--> Events</h2>
    	<p>
            <b>Fullname (u80admteventfullname) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventfullname = ''])"/>
        </p>

        <p>
            <b>Address 1 (u80admteventaddr[1]) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventaddr[1] = ''])"/>
        </p>

        <p>
            <b>Address 2 (u80admteventaddr[2]) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventaddr[2] = ''])"/>
        </p>

        <p>
            <b>City (u80admteventcity) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventcity = ''])"/>
        </p>

        <p>
            <b>State (u80admteventstate) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventstate = ''])"/>
        </p>

        <p>
            <b>Zip (u80admteventzip) missing: </b>
            <xsl:value-of select="count(//u80admtravel[u80admteventzip = ''])"/>
        </p>
    </xsl:template>
  
</xsl:stylesheet>