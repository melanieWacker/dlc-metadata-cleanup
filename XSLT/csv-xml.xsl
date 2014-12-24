<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:fn="fn" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    version="2.0" exclude-result-prefixes="xs fn">
    
    <xsl:output indent="yes" encoding="US-ASCII" />
    
    <!-- ******* Fill in the path to CSV file here first! ******* -->
    <xsl:param name="pathToCSV" select="'file:///Users/brighid/GitHub/dlc-metadata-cleanup/VarsityShow/VarsityShow_cleanedmetadata.csv'" />
    
    <xsl:function name="fn:getTokens" as="xs:string+">
        <xsl:param name="str" as="xs:string" />
        <xsl:analyze-string select="concat($str, ',')" regex='(("[^"]*")+|[^,]*),'>
            <xsl:matching-substring>
                <xsl:sequence select='replace(regex-group(1), "^""|""$|("")""", "$1")' />
            </xsl:matching-substring>
        </xsl:analyze-string>
    </xsl:function>
    
    <xsl:template match="/" name="main">
        <xsl:choose>
            <xsl:when test="unparsed-text-available($pathToCSV)">
                <xsl:variable name="csv" select="unparsed-text($pathToCSV)" />
                <xsl:variable name="lines" select="tokenize($csv, '\n')" as="xs:string+" />
                <xsl:variable name="elemNames" select="fn:getTokens(replace($lines[1], ' \d|_\d', ''))" as="xs:string+" />
                <root>
                    <xsl:for-each select="$lines[position() &gt; 1]">
                        <row>
                            <xsl:variable name="lineItems" select="fn:getTokens(.)" as="xs:string+" />
                            <xsl:for-each select="$elemNames">
                                <xsl:variable name="pos" select="position()" />
                                <xsl:if test="$lineItems[$pos] != ''">
                                    <xsl:element name="{translate(., ' ', '_')}">
                                        <xsl:value-of select="$lineItems[$pos]" />
                                    </xsl:element>
                                </xsl:if>
                            </xsl:for-each>
                        </row>
                    </xsl:for-each>
                </root>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>Cannot locate : </xsl:text><xsl:value-of select="$pathToCSV" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>