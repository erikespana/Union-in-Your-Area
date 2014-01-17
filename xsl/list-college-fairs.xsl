<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output indent="yes" method="xml"/>
    
    <!-- Parameters supplied by the PHP script:
        $state      Used to filter the XML file.
        $country    The application does not currently support international events.
    -->
    <xsl:param name="state">NY</xsl:param>
    <xsl:param name="country">US</xsl:param>
    
    <!-- GLOBAL VARIABLES -->
    
    <!-- The total number of <u80admtinst1state> elements matching $state -->
    <xsl:variable name="inst1Count">
        <xsl:value-of select="count(//u80admtravel[contains(u80admtinst1state, $state)])"/>
    </xsl:variable>

    <!-- The total number of <u80admteventstate> elements matching $state  -->
    <xsl:variable name="eventCount">
        <xsl:value-of select="count(//u80admtravel[contains(u80admteventstate, $state)])"/>
    </xsl:variable>

    <!-- Sum the previous calculated totals. -->
    <xsl:variable name="total">
        <xsl:value-of select="$inst1Count + $eventCount"/>
    </xsl:variable>
    
    <xsl:template match="/download">
        <xsl:choose>
            <!-- If there are events in $state.. -->
            <xsl:when test="$total > 0">
                <p>Click on any of the following (all listings are alphabetical):</p>
                <div id="accordion">
                    <!-- ...call the u80admtravel template for matching events..  -->
                    <xsl:apply-templates select="//u80admtravel[contains(u80admtinst1state, $state) or contains(u80admteventstate, $state)]">
                        <!-- ...in alphabetical order. -->
                        <xsl:sort order="ascending" select="u80admtinst1"/>
                        <xsl:sort order="ascending" select="u80admteventfullname"/>
                    </xsl:apply-templates>
                </div>
                
            </xsl:when>
            
            <!-- otherwise display the "No Events" message. -->
            <xsl:otherwise>
                <xsl:call-template name="noevents"/>
            </xsl:otherwise>

        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="u80admtravel">
        <xsl:call-template name="header"/>
        <xsl:call-template name="details"/>
    </xsl:template>
    
    <xsl:template name="header">
        <xsl:variable name="event">
            <xsl:choose>
                <xsl:when test="u80admteventfullname != ''">
                    <xsl:value-of select="u80admteventfullname"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="u80admtinst1"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        
    
        <h3>
            <a href="#" onclick="_gaq.push(['_trackEvent', 'Admissions Travel', 'Click', '{$state}-{$event}']);">
                <xsl:value-of select="$event"/><xsl:if
                    test="substring($event, (string-length($event) - 2) ) = 'Sch'"
                        >ool</xsl:if></a>
        </h3>
                <!--<xsl:value-of select="string-length($event)"/>-->
    </xsl:template>
    
    <xsl:template name="details">
        <div>
            <!-- Display single and multi-day schedule. -->
            <xsl:apply-templates select="u80admtdates"/>
            
            <!-- Display the Address -->
            <p>
                <xsl:choose>
                    <!--If u80admteventfullname is not blank, use the u80admtevent set of fields... -->
                    <xsl:when test="u80admteventfullname != ''">

                        <xsl:if test="u80admteventaddr[1] != ''">
                            <xsl:value-of select="u80admteventaddr[1]"/><br/>
                        </xsl:if>
                        <xsl:if test="u80admteventaddr[2] != ''">
                            <xsl:value-of select="u80admteventaddr[2]"/><br/>
                        </xsl:if>
                        <xsl:value-of select="u80admteventcity"/>,
                        <xsl:value-of select="u80admteventstate"/>
                        <xsl:text> </xsl:text>
                        <xsl:value-of select="u80admteventzip"/>

                    </xsl:when>

                    <!-- Otherwise, use the u80admtinst1 set of fields. -->
                    <xsl:otherwise>

                        <!-- Display city and state for High School Visits -->
                        <xsl:value-of select="u80admtinst1city"/>,
                        <xsl:value-of select="u80admtinst1state"/>
                    </xsl:otherwise>
                </xsl:choose>
            </p>
            
            <!-- Add mailto link if email field contains @ -->
            <xsl:if test="u80admtstaff1 != ''">
                <xsl:if test="contains(u80admtstaff1employee, 'Y')">
                    <p>
                        Admissions counselor:
                        <xsl:value-of select="u80admtstaff1" />,
                        <a href="mailto:{u80admtstaff1email}">
                            <xsl:value-of select="u80admtstaff1email"/>
                        </a>
                    </p>
                </xsl:if>
            </xsl:if>
        </div>
    </xsl:template>

    <xsl:template match="u80admtdates">
        <p>
            <!-- Display start date -->
            <xsl:value-of select="u80admtstartdates"/>,
            <!-- Display start time -->
            <xsl:call-template name="format-time">
                <xsl:with-param name="time">
                    <xsl:value-of select="u80admtstarttimes"/>
                </xsl:with-param>
            </xsl:call-template>
            
            <!-- Display end time if it isn't blank. -->
            <xsl:if test="u80admtendtimes != ''">
                -
                <xsl:call-template name="format-time">
                    <xsl:with-param name="time">
                        <xsl:value-of select="u80admtendtimes"/>
                    </xsl:with-param>
                </xsl:call-template>
            </xsl:if>            
        </p>
    </xsl:template>

    <xsl:template name="format-time">
        <xsl:param name = "time" /> 

        <!-- if time starts with a 0  -->
        <xsl:choose>
            <xsl:when test="substring($time, 1, 1) = '0'">
                <!-- don't display the first character of the start time -->
                <xsl:value-of select="substring($time, 2)"/>
            </xsl:when>
            <xsl:otherwise>
                <!-- display the entire start time  -->
                <xsl:value-of select="$time"/>
            </xsl:otherwise>
        </xsl:choose>
    
    </xsl:template>
    
    <xsl:template name="noevents">
        <p>
            There are no upcoming events scheduled in this region.
        </p>
        <p>
            Please choose one of the following or check back later as an event may be scheduled here at a future date:
        </p>
        
        <ul>
            <li>
                <a href="/admissions/staff/index.php">Locate your Admissions Counselor</a>
            </li>
            <li>
                <a href="/admissions/visit/index.php">Schedule a Campus Visit</a>
            </li>
            <li>
                <a href="/admissions/in-your-area/alumni-interviews/index.php">Schedule an Alumni Interview</a>
            </li>
            <li>
                <a href="/admissions/contact/index.php">Subscribe to our mailing list</a>
            </li>
        </ul>
    </xsl:template>
    
</xsl:stylesheet>