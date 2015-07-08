<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="xs"
    version="1.0">
<xsl:output indent="yes" />  
<!--
   Stylesheet to conver the original XML into a format that PHP can parse       
-->
       <xsl:template match="/">
           
           <xsl:element name="cymru">
               <xsl:element name="id"><xsl:value-of select="'cymru'"/></xsl:element>

                <xsl:for-each select="/cymru/county">
                       <xsl:element name="county">
                           <xsl:element name="id"><xsl:value-of select="@id"/></xsl:element>
                           
                           <xsl:for-each select="name">
                               <xsl:element name="name">
                                   <xsl:element name="lang"><xsl:value-of select="@lang"/></xsl:element>
                                   <xsl:element name="_text"><xsl:value-of select="."/></xsl:element>                       
                               </xsl:element>                   
                           </xsl:for-each>

                           <xsl:element name="population">
                               <xsl:element name="href"><xsl:value-of select="population/@href" /></xsl:element>
                               <xsl:element name="_text"><xsl:value-of select="population" /></xsl:element>
                           </xsl:element>
                           
                           <xsl:for-each select="about">
                               <xsl:element name="about">
                                   <xsl:element name="lang"><xsl:value-of select="@lang" /></xsl:element>
                                   <xsl:element name="href"><xsl:value-of select="@href" /></xsl:element>
                                   <xsl:element name="_text"><xsl:value-of select="." /></xsl:element>
                               </xsl:element>
                           </xsl:for-each>
                           
                           <xsl:element name="poscodes">
                               <xsl:for-each select="postcodes/postcode">
                                   <xsl:element name="postcode">
                                       <xsl:value-of select="." />
                                   </xsl:element>
                               </xsl:for-each>
                           </xsl:element>
                           
                           <xsl:element name="towns">
                               <xsl:for-each select="towns/town">
                                   <xsl:element name="town">
                                       
                                       <xsl:element name="id"><xsl:value-of select="@id" /></xsl:element>
                                       
                                       <xsl:element name="name"><xsl:value-of select="name" /></xsl:element>
                                       
                                       <xsl:if test="lat != ''">
                                           <xsl:element name="lat"><xsl:value-of select="lat" /></xsl:element>
                                       </xsl:if>
                                       
                                       <xsl:if test="lon != ''">
                                           <xsl:element name="lon"><xsl:value-of select="lon" /></xsl:element>
                                       </xsl:if>
                                       
                                       <xsl:for-each select="wikipedia">
                                           <xsl:if test=". != ''">
                                               <xsl:element name="wikipedia">                                   
                                                   <xsl:element name="lang"><xsl:value-of select="@lang" /></xsl:element>
                                                   <xsl:element name="href"><xsl:value-of select="@href" /></xsl:element>
                                                   <xsl:element name="_text"><xsl:value-of select="." /></xsl:element>                                   
                                               </xsl:element>
                                           </xsl:if>
                                       </xsl:for-each>
                                       
                                   </xsl:element>
                               </xsl:for-each>
                           </xsl:element>
                           
                       </xsl:element>
                </xsl:for-each>
               
           </xsl:element>
       </xsl:template>
    
</xsl:stylesheet>
