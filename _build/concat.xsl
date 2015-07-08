<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
<xsl:output 
    method="xml"
    indent="yes"/>
    
<!-- Merege all the XML files to create one xml file of all the counties -->
                    
    <xsl:template match="/">
        
        <!-- Root elememt -->
        <xsl:element name="cymru">
            
        <!-- Loop through all the counties -->    
        <xsl:for-each select="document('../xml/county.xml')/cymru/county">
            
            <!-- Call template to get the data from each xml file -->
            <xsl:call-template name="joinXML">
                <!-- Pass the filename as a parameter -->
                <xsl:with-param name="file" select = "@href" />
            </xsl:call-template>
            
        </xsl:for-each>
        <!-- End loop -->
            
        </xsl:element>
        <!-- end of Root element -->
    </xsl:template>
    
    <!-- template to loop through each xml file -->
    <xsl:template name="joinXML" >
        
        <!-- @parm filename -->
        <xsl:param name="file" />
        
        <!-- create a new variable, concat file path and filename -->
        <xsl:variable name="xmlFile" select="concat('../xml/',$file)" />
       
        <!-- copy the contents of the xml -->
        <xsl:copy-of select="document($xmlFile)"></xsl:copy-of>
       
    </xsl:template>
    
</xsl:stylesheet>
