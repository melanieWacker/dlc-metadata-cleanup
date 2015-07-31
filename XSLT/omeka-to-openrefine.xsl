<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:template match="itemContainer">
        <root>
            <xsl:apply-templates select="item"/>
        </root>
    </xsl:template>
    
    <xsl:template match="item">
        <row>
            <identifier_omeka>
                <xsl:value-of select="@itemId"/>
            </identifier_omeka>
            <relatedItem_project>
                <xsl:value-of select="OmekaCollection"/>
            </relatedItem_project>
            <projectURL></projectURL>
            <xsl:apply-templates select="ItemType"/>
            <xsl:apply-templates select="OriginalFileLoadedIntoOmeka"/>
            <xsl:apply-templates select="ItemInContext"/>
            <xsl:apply-templates select="DublinCore"/>
            <xsl:apply-templates select="MODS"/>
            <xsl:apply-templates select="AdditionalItemMetadata"/>
        </row>
    </xsl:template>
    
    <xsl:template match="ItemType">
        <typeOfResource>
            <xsl:value-of select="."/>
        </typeOfResource>
        <xsl:for-each select="text">
            <form_originalFormat>
                <xsl:value-of select="."/>
            </form_originalFormat> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="OriginalFileLoadedIntoOmeka">
        <xsl:for-each select="text">
            <note_filename>
                <xsl:value-of select="." />
            </note_filename>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ItemInContext">
        <location_url_ObjectInContext>
            <xsl:value-of select="."/>
        </location_url_ObjectInContext>
    </xsl:template>
    
    <xsl:template match="DublinCore">
        <xsl:apply-templates select="Title"/>
        <xsl:apply-templates select="Subject"/>
        <xsl:apply-templates select="Description"/>
        <xsl:apply-templates select="Creator"/>
        <xsl:apply-templates select="Publisher"/>
        <xsl:apply-templates select="Date"/>
        <xsl:apply-templates select="Contributor"/>
        <xsl:apply-templates select="Rights"/>
        <xsl:apply-templates select="Relation"/>
        <xsl:apply-templates select="Format"/>
        <xsl:apply-templates select="Language"/>
        <xsl:apply-templates select="Type"/>
        <xsl:apply-templates select="Identifier"/>
        <xsl:apply-templates select="Coverage"/>
    </xsl:template>
    
    <xsl:template match="MODS">
        <xsl:apply-templates select="KeyDate"/>
        <xsl:apply-templates select="TypeofDate"/>
        <xsl:apply-templates select="PublicationPlace"/>
        <xsl:apply-templates select="PublicationDate"/>
        <xsl:apply-templates select="PlaceofOrigin"/>
        <xsl:apply-templates select="FormGenre"/>
        <xsl:apply-templates select="PhysicalDescription"/>
        <xsl:apply-templates select="RepositoryName"/>
        <xsl:apply-templates select="Subrepository"/>
        <xsl:apply-templates select="ShelfLocation"/>
        <xsl:apply-templates select="Notes"/>
        <xsl:apply-templates select="LanguageofCataloging"/>
        <xsl:apply-templates select="DigitalOrigin"/>
        <xsl:apply-templates select="Collection"/>
    </xsl:template>
    
    <xsl:template match="AdditionalItemMetadata">
        <xsl:apply-templates select="SpatialCoverage"/>
        <xsl:apply-templates select="RightsHolder"/>
        <xsl:apply-templates select="Provenance"/>
        <xsl:apply-templates select="Citation"/>
        <xsl:apply-templates select="TemporalCoverage"/>
    </xsl:template>
    
    <xsl:template match="Title">
        <xsl:for-each select="text">
            <title_nonSort></title_nonSort>
            <title>
                <xsl:value-of select="."/>
            </title> 
            <partName></partName>
            <identifier_title></identifier_title>
            <title2_type>Delete if not applicable</title2_type>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Subject">
        <xsl:for-each select="text">
            <subject_topic>
                <xsl:value-of select="."/>
            </subject_topic> 
            <subject_topic_authority></subject_topic_authority> 
            <subject_topic_authority_identifier></subject_topic_authority_identifier> 
        </xsl:for-each>
        <subject_name></subject_name> 
        <subject_name_authority></subject_name_authority> 
        <subject_name_authority_identifier></subject_name_authority_identifier> 
        <subject_geographic></subject_geographic> 
        <subject_geographic_authority></subject_geographic_authority> 
        <subject_geographic_authority_identifier></subject_geographic_authority_identifier>
        <subject_geographic_hierarchial_street></subject_geographic_hierarchial_street> 
        <subject_geographic_hierarchial_borough></subject_geographic_hierarchial_borough>
        <subject_geographic_hierarchial_city></subject_geographic_hierarchial_city> 
        <subject_geographic_hierarchial_state></subject_geographic_hierarchial_state>
        <subject_geographic_hierarchial_province></subject_geographic_hierarchial_province>
        <subject_geographic_hierarchial_country></subject_geographic_hierarchial_country>
        <subject_title></subject_title>
        <subject_title_authority></subject_title_authority>
        <subject_title_authority_identifier></subject_title_authority_identifier>
    </xsl:template>
    
    <xsl:template match="Description">
        <xsl:for-each select="text">
            <abstract>
                <xsl:value-of select="."/>
            </abstract> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Creator">
        <xsl:for-each select="text">
            <name>
                <xsl:value-of select="."/>
            </name> 
            <name_authority></name_authority>
            <name_authority_identifier></name_authority_identifier>
            <name_role></name_role>
            <name_role_authority></name_role_authority>
            <name_role_type></name_role_type>
            <name_role_authority_identifier></name_role_authority_identifier>
            <name_type></name_type>
        </xsl:for-each>
    </xsl:template>
    
    <!-- Source skipped according to mapping 1/7/2015 -->
    
    <xsl:template match="Publisher">
        <xsl:for-each select="text">
            <publisher>
                <xsl:value-of select="."/>
            </publisher> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Date">
        <xsl:for-each select="text">
            <dateCreated>
                <xsl:value-of select="."/>
            </dateCreated> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Contributor">
        <xsl:for-each select="text">
            <name>
                <xsl:value-of select="."/>
            </name> 
            <name_authority></name_authority>
            <name_authority_identifier></name_authority_identifier>
            <name_role></name_role>
            <name_role_authority></name_role_authority>
            <name_role_type></name_role_type>
            <name_role_authority_identifier></name_role_authority_identifier>
            <name_type></name_type>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Rights">
        <xsl:for-each select="text">
            <accessCondition>
                <xsl:value-of select="."/>
            </accessCondition> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Relation">
        <xsl:for-each select="text">
            <note_relatedItem>
                <xsl:value-of select="."/>
            </note_relatedItem> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Format">
        <xsl:for-each select="text">
            <form>
                <xsl:value-of select="."/>
            </form> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Language">
        <xsl:for-each select="text">
            <language>
                <xsl:value-of select="."/>
            </language> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Type">
        <xsl:for-each select="text">
            <genre>
                <xsl:value-of select="."/>
            </genre> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Identifier">
        <xsl:for-each select="text">
            <identifier_clio>
                <xsl:value-of select="."/>
            </identifier_clio> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Coverage">
        <xsl:for-each select="text">
            <subject_topic>
                <xsl:value-of select="."/>
            </subject_topic> 
            <subject_topic_authority></subject_topic_authority> 
            <subject_topic_authority_identifier></subject_topic_authority_identifier> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="KeyDate">
        <xsl:for-each select="text">
            <keyDate_start>
                <xsl:value-of select="substring-before(., ' ')"/>
            </keyDate_start> 
            <keyDate_end>
                <xsl:value-of select="substring-after(., ' ')"/>
            </keyDate_end>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="TypeofDate">
        <xsl:for-each select="text">
            <dateQualifier>
                <xsl:value-of select="."/>
            </dateQualifier> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PublicationPlace">
        <xsl:for-each select="text">
            <place>
                <xsl:value-of select="."/>
            </place> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PublicationDate">
        <xsl:for-each select="text">
            <dateCreated>
                <xsl:value-of select="."/>
            </dateCreated> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PlaceofOrigin">
        <xsl:for-each select="text">
            <place>
                <xsl:value-of select="."/>
            </place> 
            <place_authority></place_authority>
            <place_authority_identifier></place_authority_identifier>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="FormGenre">
        <xsl:for-each select="text">
            <form>
                <xsl:value-of select="."/>
            </form> 
            <form_authority></form_authority>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PhysicalDescription">
        <xsl:for-each select="text">
            <extent>
                <xsl:value-of select="."/>
            </extent>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="RepositoryName">
        <xsl:for-each select="text">
            <physicalLocation_text>
                <xsl:value-of select="."/>
            </physicalLocation_text>
            <physicalLocation>Enter code here</physicalLocation>
            <physicalLocation_authority></physicalLocation_authority>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Subrepository">
        <xsl:for-each select="text">
            <sublocation>
                <xsl:value-of select="."/>
            </sublocation>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ShelfLocation">
        <xsl:for-each select="text">
            <shelfLocator>
                <xsl:value-of select="."/>
            </shelfLocator>
        </xsl:for-each>
        <note_holdings></note_holdings>
    </xsl:template>
    
    <xsl:template match="Notes">
        <xsl:for-each select="text">
            <note>
                <xsl:value-of select="."/>
            </note>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="LanguageofCataloging">
        <languageOfCataloging>eng</languageOfCataloging>
    </xsl:template>
    
    <xsl:template match="DigitalOrigin">
        <xsl:for-each select="text">
            <digitalOrigin>
                <xsl:value-of select="."/>
            </digitalOrigin>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Collection">
        <xsl:for-each select="text">
            <relatedItem_collection>
                <xsl:value-of select="."/>
            </relatedItem_collection>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="SpatialCoverage">
        <xsl:for-each select="text">
            <subject_topic>
                <xsl:value-of select="."/>
            </subject_topic>
            <subject_topic_authority></subject_topic_authority>
            <subject_topic_authority_identifier></subject_topic_authority_identifier>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="RightsHolder">
        <xsl:for-each select="text">
            <relatedItem_collection>
                <xsl:value-of select="."/>
            </relatedItem_collection>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Provenance">
        <xsl:for-each select="text">
            <note_ownership>
                <xsl:value-of select="."/>
            </note_ownership>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Citation">
        <xsl:for-each select="text">
            <relatedItem_collection>
                <xsl:value-of select="."/>
            </relatedItem_collection>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="TemporalCoverage">
        <xsl:for-each select="text">
            <subject_temporal>
                <xsl:value-of select="."/>
            </subject_temporal>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>