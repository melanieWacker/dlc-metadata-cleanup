<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.loc.gov/mods/v3"
        xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd"
        xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    
<!-- Create MODS:Collection to hold all records -->
    <xsl:template match="root">
        <modsCollection xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd">
            <xsl:apply-templates select="row"/>
        </modsCollection>
    </xsl:template>
    
<!-- Create Part/Child and Work/Parent records according to identifier and create MODS separate files/records -->
    <xsl:template match="row">
    <xsl:variable name="filename" select="identifier_title"/>
        <xsl:choose>
            <xsl:when test="matches(identifier_title, '[a-z]{3}$')">
                <mods version="3.5">
                    <xsl:call-template name="aaParentRecord"/>
                </mods>
                <xsl:result-document method="xml" href="{$filename}.xml" encoding="UTF-8" indent="yes">
                    <mods xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
                        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                        xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd" version="3.5">
                        <xsl:call-template name="aaParentRecord"/>
                    </mods>
                </xsl:result-document>
            </xsl:when>
            <xsl:when test="matches(identifier_title, '[a-z]{3}_\d{3}')">
                <mods version="3.5">
                    <xsl:call-template name="aaChildRecord"/>
                </mods>
                <xsl:result-document method="xml" href="{$filename}.xml" encoding="UTF-8" indent="yes">
                    <mods xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
                        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                        xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd" version="3.5">
                        <xsl:call-template name="aaChildRecord"/>
                    </mods>
                </xsl:result-document>
            </xsl:when>
            <xsl:otherwise>
                <mods xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
                    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                    xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd" version="3.5">
                    <xsl:call-template name="aaParentRecord"/>
                </mods>
                <xsl:result-document method="xml" href="{$filename}.xml" encoding="UTF-8" indent="yes">
                    <mods xmlns:xlink="http://www.w3.org/1999/xlink" xmlns="http://www.loc.gov/mods/v3"
                        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                        xsi:schemaLocation="http://www.loc.gov/mods/v3 http://www.loc.gov/standards/mods/v3/mods-3-5.xsd" version="3.5">
                        <xsl:call-template name="aaParentRecord"/>
                    </mods>
                </xsl:result-document>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

<!-- Base Templates -->
<!-- WORK/PARENT Record -->
    <xsl:template name="aaParentRecord">
    <!-- Item/Record Identifiers -->
        <xsl:if test="identifier_omeka">
            <identifier type="omeka">
                <xsl:value-of select="concat('omeka_', identifier_omeka)"/>
            </identifier>
        </xsl:if>
        <xsl:if test="not(contains(identifier_record, '_'))">
            <identifier type="local">
                <xsl:value-of select="identifier_omeka"/>
            </identifier>
        </xsl:if>
        <xsl:if test="identifier_clio">
            <identifier type="CLIO">
                <xsl:value-of select="identifier_clio"/>
            </identifier>
        </xsl:if>
        <identifier type="local">
            <xsl:value-of select="identifier_title" />
        </identifier>
    <!-- Name -->
        <xsl:apply-templates select="name_primary"/>
        <xsl:apply-templates select="name"/>
    <!-- titleInfo -->
        <titleInfo>
            <xsl:if test="title_nonSort">
                <nonSort>
                    <xsl:value-of select="title_nonSort"/>
                </nonSort>
            </xsl:if>
            <title>
                <xsl:value-of select="title"/>
            </title> 
        </titleInfo>
        <xsl:if test="title2">
            <titleInfo>
                <xsl:attribute name="type">
                    <xsl:value-of select="title2_type" />
                </xsl:attribute>
                <title>
                    <xsl:value-of select="title2"/>
                </title>
            </titleInfo>
        </xsl:if>
    <!-- originInfo -->
        <originInfo>
    <!-- Place of Origin -->
                <xsl:apply-templates select="place"/>
    <!-- Publisher -->
            <xsl:for-each select="publisher">
                <publisher>
                    <xsl:value-of select='.'/>
                </publisher>
            </xsl:for-each>
    <!-- Date -->
            <dateCreated>
                <xsl:value-of select="dateCreated"/>
            </dateCreated>
            <xsl:choose>
                <xsl:when test="keyDate-end">
                    <dateCreated encoding="w3cdtf" keyDate="yes" point="start">
                        <xsl:if test="dateQualifier">
                            <xsl:attribute name="qualifier">
                                <xsl:value-of select="dateQualifier"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="keyDate-start"/>
                    </dateCreated>
                    <dateCreated encoding="w3cdtf" keyDate="yes" point="end">
                        <xsl:value-of select="keyDate-end"/>
                    </dateCreated>
                </xsl:when>
                <xsl:otherwise>
                    <dateCreated encoding="w3cdtf" keyDate="yes">
                        <xsl:if test="dateQualifier">
                            <xsl:attribute name="qualifier">
                                <xsl:value-of select="dateQualifier"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="keyDate-start"/>
                    </dateCreated>
                </xsl:otherwise>
            </xsl:choose>
        </originInfo>
    <!-- physicalDescription -->
        <xsl:if test="form_originalFormat | extent | form | physicalNote">
            <physicalDescription>
                <xsl:apply-templates select="form_originalFormat"/>
                <xsl:apply-templates select="extent"/>
                <xsl:apply-templates select="form"/>
                <xsl:apply-templates select="physicalNote" />
            </physicalDescription>
        </xsl:if>
    <!-- Abstract -->
        <xsl:apply-templates select="abstract"/>
    <!-- Language -->  
        <xsl:apply-templates select="language"/>
    <!-- Note -->
        <xsl:apply-templates select="note"/>
        <xsl:apply-templates select="note_ownership"/>
    <!-- Location -->  
        <location>
            <physicalLocation>
                <xsl:if test="repository_authority">
                    <xsl:attribute name="authority">
                        <xsl:value-of select="repository_authority"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="repository"/>
            </physicalLocation>
            <xsl:for-each select="location_url_ObjectInContext">
                <url access="object in context" usage="primary display">
                    <xsl:value-of select="."/>
                </url>
            </xsl:for-each>
            <xsl:if test="location_url_physicalObject">
                <url>
                    <xsl:value-of select="location_url_physicalObject" />
                </url>
            </xsl:if>
            <xsl:if test="sublocation | shelfLocator">
                <holdingSimple>
                    <copyInformation>
                        <xsl:apply-templates select="sublocation"/>
                        <xsl:apply-templates select="shelfLocator"/>
                    </copyInformation>
                </holdingSimple>
            </xsl:if>
        </location>
    <!-- Subject -->  
        <xsl:apply-templates select="subject_topic"/>
        <xsl:apply-templates select="subject_name"/>  
        <xsl:apply-templates select="subject_geographic"/>
        <xsl:call-template name="StreetAddresses"/>
        <xsl:for-each select="subject_temporal">
            <subject>
                <temporal>
                    <xsl:value-of select="."/>
                </temporal>
            </subject>
        </xsl:for-each>
    <!-- relatedItem -->
        <relatedItem type="host" displayLabel="Project">
            <titleInfo>
                <xsl:if test="relatedItem_Project_nonSort">
                    <nonSort><xsl:value-of select="relatedItem_Project_nonSort"/></nonSort>
                </xsl:if>
                <title>
                    <xsl:value-of select="relatedItem_Project"/>
                </title>
            </titleInfo>
            <location>
                <url>
                    <xsl:value-of select="project_URL"/>
                </url>
            </location>
        </relatedItem>
        <xsl:for-each select="relatedItem_collection">
            <relatedItem type="host" displayLabel="Collection">
                <titleInfo>
                    <title>
                        <xsl:value-of select="."/>
                    </title>
                </titleInfo>
            </relatedItem>
        </xsl:for-each>
        <xsl:for-each select="relatedItem_note">
            <relatedItem>
                <note>
                    <xsl:value-of select="."/>
                </note>
            </relatedItem>
        </xsl:for-each>
    <!-- accessCondition -->
        <accessCondition>Columbia University Libraries copyright/permissions information can be found at http://library.columbia.edu/about/policies/copyright-online-collections.html</accessCondition>
    <!-- recordInfo --> 
        <recordInfo>
            <recordIdentifier>
                <xsl:choose>
                    <xsl:when test="identifier_record">
                        <xsl:value-of select="concat(identifier_record, '_descMetadata')"/>
                    </xsl:when>
                    <xsl:when test="identifier_omeka">
                        <xsl:value-of select="concat(identifier_omeka, '_descMetadata')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(identifier_title, '_descMetadata')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </recordIdentifier>
            <recordContentSource authority="marcorg">NNC</recordContentSource>
            <languageOfCataloging>
                <languageTerm type="code" authority="iso639-2b">
                    <xsl:value-of select="language"/>
                </languageTerm>
            </languageOfCataloging>
            <recordOrigin>Created and edited in general conformance to MODS Guideline (Version 3).</recordOrigin>
        </recordInfo>
    </xsl:template>
    
<!-- PART/CHILD RECORD -->
    <xsl:template name="aaChildRecord">
        <!-- Item/Record Identifiers -->
        <xsl:if test="identifier_omeka">
            <identifier type="omeka">
                <xsl:value-of select="concat('omeka_', identifier_omeka)"/>
            </identifier>
        </xsl:if>
        <xsl:if test="not(contains(identifier_record, '_'))">
            <identifier type="local">
                <xsl:value-of select="identifier_omeka"/>
            </identifier>
        </xsl:if>
        <identifier type="local">
            <xsl:value-of select="identifier_title" />
        </identifier>
        <!-- Name -->
        <xsl:apply-templates select="name_primary"/>
        <xsl:apply-templates select="name"/>
        <!-- titleInfo -->
        <titleInfo>
            <xsl:if test="title_nonSort">
                <nonSort>
                    <xsl:value-of select="title_nonSort"/>
                </nonSort>
            </xsl:if>
            <title>
                <xsl:value-of select="title"/>
            </title> 
            <xsl:if test="partName">
                <partName>
                    <xsl:value-of select="partName"/>
                </partName>
            </xsl:if>
        </titleInfo>
        <xsl:if test="title2">
            <titleInfo>
                <xsl:attribute name="type">
                    <xsl:value-of select="title2_type" />
                </xsl:attribute>
                <title>
                    <xsl:value-of select="title2"/>
                </title>
                <xsl:if test="partName2">
                    <partName>
                        <xsl:value-of select="partName2"/>
                    </partName>
                </xsl:if>
            </titleInfo>
        </xsl:if>
        <!-- originInfo -->
        <originInfo>
            <!-- Place of Origin -->
            <xsl:apply-templates select="place"/>
            <!-- Publisher -->
            <xsl:for-each select="publisher">
                <publisher>
                    <xsl:value-of select='.'/>
                </publisher>
            </xsl:for-each>
            <!-- Date -->
            <dateCreated>
                <xsl:value-of select="dateCreated"/>
            </dateCreated>
            <xsl:choose>
                <xsl:when test="keyDate-end">
                    <dateCreated encoding="w3cdtf" keyDate="yes" point="start">
                        <xsl:if test="dateQualifier">
                            <xsl:attribute name="qualifier">
                                <xsl:value-of select="dateQualifier"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="keyDate-start"/>
                    </dateCreated>
                    <dateCreated encoding="w3cdtf" keyDate="yes" point="end">
                        <xsl:value-of select="keyDate-end"/>
                    </dateCreated>
                </xsl:when>
                <xsl:otherwise>
                    <dateCreated encoding="w3cdtf" keyDate="yes">
                        <xsl:if test="dateQualifier">
                            <xsl:attribute name="qualifier">
                                <xsl:value-of select="dateQualifier"/>
                            </xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="keyDate-start"/>
                    </dateCreated>
                </xsl:otherwise>
            </xsl:choose>
        </originInfo>
        <!-- typeOfResource -->
        <xsl:apply-templates select="typeOfResource"/>
        <!-- physicalDescription -->
        <xsl:if test="form_originalFormat | extent | digitalOrigin | form | physicalNote">
            <physicalDescription>
                <xsl:apply-templates select="form_originalFormat"/>
                <xsl:apply-templates select="extent"/>
                <xsl:apply-templates select="digitalOrigin"/>
                <xsl:apply-templates select="form"/>
                <xsl:apply-templates select="physicalNote" />
            </physicalDescription>
        </xsl:if>
        <!-- Abstract -->
        <xsl:apply-templates select="abstract"/>
        <!-- Language -->  
        <xsl:apply-templates select="language"/>
        <!-- Notes -->
        <xsl:apply-templates select="note"/>
        <xsl:apply-templates select="note_ownership"/>
        <xsl:apply-templates select="note_filename"/>
        <!-- Location -->  
        <location>
            <physicalLocation>
                <xsl:if test="physicalLocation_authority">
                    <xsl:attribute name="authority">
                        <xsl:value-of select="physicalLocation_authority"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="physicalLocation"/>
            </physicalLocation>
            <xsl:for-each select="location_url_ObjectInContext">
                <url access="object in context" usage="primary display">
                    <xsl:value-of select="."/>
                </url>
            </xsl:for-each>
            <xsl:if test="location_url_physicalObject">
                <url>
                    <xsl:value-of select="location_url_physicalObject" />
                </url>
            </xsl:if>
            <xsl:if test="sublocation | shelfLocator">
                <holdingSimple>
                    <copyInformation>
                        <xsl:apply-templates select="sublocation"/>
                        <xsl:apply-templates select="shelfLocator"/>
                    </copyInformation>
                </holdingSimple>
            </xsl:if>
        </location>
        <!-- Subject -->  
        <xsl:apply-templates select="subject_topic"/>
        <xsl:apply-templates select="subject_name"/> 
        <xsl:apply-templates select="subject_geographic"/>
        <xsl:call-template name="StreetAddresses"/>
        <xsl:for-each select="subject_temporal">
            <subject>
                <temporal>
                    <xsl:value-of select="."/>
                </temporal>
            </subject>
        </xsl:for-each>
        <!-- relatedItem -->
        <relatedItem type="host" displayLabel="Project">
            <titleInfo>
                <xsl:if test="relatedItem_Project_nonSort">
                    <nonSort><xsl:value-of select="relatedItem_Project_nonSort"/></nonSort>
                </xsl:if>
                <title>
                    <xsl:value-of select="relatedItem_Project"/>
                </title>
            </titleInfo>
            <location>
                <url>
                    <xsl:value-of select="projectURL"/>
                </url>
            </location>
        </relatedItem>
        <xsl:for-each select="relatedItem_collection">
            <relatedItem type="host" displayLabel="Collection">
                <titleInfo>
                    <title>
                        <xsl:value-of select="."/>
                    </title>
                </titleInfo>
            </relatedItem>
        </xsl:for-each>
        <xsl:for-each select="relatedItem_note">
            <relatedItem>
                <note>
                    <xsl:value-of select="."/>
                </note>
            </relatedItem>
        </xsl:for-each>
        <!-- accessCondition -->
        <accessCondition>Columbia University Libraries copyright/permissions information can be found at http://library.columbia.edu/about/policies/copyright-online-collections.html</accessCondition>
        <!-- recordInfo --> 
        <recordInfo>
            <recordIdentifier>
                <xsl:choose>
                    <xsl:when test="identifier_record">
                        <xsl:value-of select="concat(identifier_record, '_descMetadata')"/>
                    </xsl:when>
                    <xsl:when test="identifier_omeka">
                        <xsl:value-of select="concat(identifier_omeka, '_descMetadata')"/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="concat(identifier_title, '_descMetadata')"/>
                    </xsl:otherwise>
                </xsl:choose>
            </recordIdentifier>
            <recordContentSource authority="marcorg">NNC</recordContentSource>
            <languageOfCataloging>
                <languageTerm type="code" authority="iso639-2b">
                    <xsl:value-of select="languageOfCataloging"/>
                </languageTerm>
            </languageOfCataloging>
            <recordOrigin>Created and edited in general conformance to MODS Guideline (Version 3).</recordOrigin>
        </recordInfo>
    </xsl:template>
    
<!-- End BASE Templates -->
<!-- SUBTEMPLATES -->
    <xsl:template match="name_primary">
        <name>
            <xsl:if test="../name_primary_type">
                <xsl:attribute name="type">
                    <xsl:value-of select="../name_primary_type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../name_primary_authority">
                <xsl:attribute name="authority">
                    <xsl:value-of select="../name_primary_authority"/>
                </xsl:attribute> <xsl:attribute name="valueURI">
                    <xsl:value-of select="../name_primary_authority_identifier"/>
                </xsl:attribute>
            </xsl:if>
            <namePart>
                <xsl:value-of select="."/>
            </namePart>
            <xsl:if test="../name_primary_role_code">
                <role>
                    <roleTerm type="code" authority="marcrelator">
                        <xsl:value-of select="../name_primary_role_code"/>                        
                    </roleTerm>
                </role>
            </xsl:if>
            <xsl:if test="../name_primary_role_text">
                <role>
                    <roleTerm type="text" authority="marcrelator">
                        <xsl:value-of select="../name_primary_role_text"/>                        
                    </roleTerm>
                </role>
            </xsl:if>
        </name>
    </xsl:template>
    <xsl:template match="name">
        <name>
            <xsl:if test="../name_type">
                <xsl:attribute name="type">
                    <xsl:value-of select="../name_type"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="../name_authority">
                <xsl:attribute name="authority">
                    <xsl:value-of select="../name_authority"/>
                </xsl:attribute> <xsl:attribute name="valueURI">
                    <xsl:value-of select="../name_authority_identifier"/>
                </xsl:attribute>
            </xsl:if>
            <namePart>
                <xsl:value-of select="."/>
            </namePart>
            <xsl:if test="../role_code">
                <role>
                    <roleTerm type="code" authority="marcrelator">
                        <xsl:value-of select="../role_code"/>                        
                    </roleTerm>
                </role>
            </xsl:if>
            <xsl:if test="../role_text">
                <role>
                    <roleTerm type="text" authority="marcrelator">
                        <xsl:value-of select="../role_text"/>                        
                    </roleTerm>
                </role>
            </xsl:if>
        </name>
    </xsl:template>
    <xsl:template match="place">
        <place>
            <placeTerm type="text">
            <!-- No authority attribute - currently not available in MODS 3.6 - CMH, 10/2014 -->
                <xsl:if test="../place_authority_identifier">
                    <xsl:attribute name="valueURI">
                        <xsl:value-of select="../place_authority_identifier"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:value-of select="."/>
            </placeTerm>
        </place>
    </xsl:template>
    <xsl:template match="typeOfResource">
        <typeOfResource>
            <xsl:value-of select="."/>
        </typeOfResource>
    </xsl:template>
    <xsl:template match="digitalOrigin">
        <digitalOrigin>
            <xsl:value-of select="."/>
        </digitalOrigin>
    </xsl:template>
    <xsl:template match="form_originalFormat">
        <form>
            <xsl:value-of select="replace(., 'Original Format: ', '')"/>
        </form>
    </xsl:template>
    <xsl:template match="form">
        <form>
            <xsl:attribute name="authority">
                <xsl:value-of select="../form_authority"/>
            </xsl:attribute>
            <xsl:value-of select="."/>
        </form>
    </xsl:template>
    <xsl:template match="extent">
            <extent>
                <xsl:value-of select="replace(., 'Physical Dimensions: ', '')"/>
            </extent>
    </xsl:template>
    <xsl:template match="physicalNote">
        <note>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    <xsl:template match="abstract">
            <abstract>
                <xsl:value-of select="."/>
            </abstract>
    </xsl:template>
    <xsl:template match="language">
            <language>
                <languageTerm type="code" authority="iso639-2b">
                    <xsl:value-of select="."/>
                </languageTerm>
            </language>
    </xsl:template>
    <xsl:template match="note">
        <note>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    <xsl:template match="note_ownership">
        <note type="ownership">
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    <xsl:template match="note_filename">
        <note>
            <xsl:value-of select="."/>
        </note>
    </xsl:template>
    <xsl:template match="sublocation">
            <subLocation>
                <xsl:value-of select="."/>
            </subLocation>
    </xsl:template>
    <xsl:template match="shelfLocator">
        <shelfLocator>
            <xsl:value-of select='.'/>
        </shelfLocator>
    </xsl:template>
    <xsl:template match="subject_topic">
        <subject>
            <xsl:if test="../subject_topic_authority">
                <xsl:attribute name="authority">
                    <xsl:value-of select="../subject_topic_authority"/>
                </xsl:attribute>
            </xsl:if> <xsl:if test="../subject_topic_authority_identifier">
                <xsl:attribute name="valueURI">
                    <xsl:value-of select="../subject_topic_authority_identifier"/>
                </xsl:attribute>
            </xsl:if>
            <topic>
                <xsl:value-of select="."/>
            </topic>
        </subject>
    </xsl:template>
    <xsl:template match="subject_name">
        <subject>
            <name>
                <xsl:if test="../subject_name_authority">
                    <xsl:attribute name="authority">
                        <xsl:value-of select="../subject_name_authority"/>
                    </xsl:attribute> <xsl:attribute name="valueURI">
                        <xsl:value-of select="../subject_name_authority_identifier"/>
                    </xsl:attribute>
                </xsl:if>
                <namePart>
                    <xsl:value-of select="."/>
                </namePart>
            </name>
        </subject>
    </xsl:template>
    <xsl:template match="subject_geographic">
        <subject>
            <geographic>
                <xsl:if test="../subject_geographic_authority">
                    <xsl:attribute name="authority">
                        <xsl:value-of select="../subject_geographic_authority"/>
                    </xsl:attribute> <xsl:attribute name="valueURI">
                        <xsl:value-of select="../subject_geographic_authority_identifier"/>
                    </xsl:attribute>
                </xsl:if>
                    <xsl:value-of select="."/>
            </geographic>
        </subject>        
    </xsl:template>
    <xsl:template name="StreetAddresses">
        <xsl:if test="subject_geographic_hierarchical_street">
            <subject>
                <hierarchicalGeographic>
                    <xsl:apply-templates select="subject_geographic_hierarchical_country"/>
                    <xsl:apply-templates select="subject_geographic_hierarchical_province"/>
                    <xsl:apply-templates select="subject_geographic_hierarchical_state"/>
                    <xsl:apply-templates select="subject_geographic_hierarchical_city"/>
                    <xsl:apply-templates select="subject_geographic_hierarchical_borough"/>
                    <xsl:apply-templates select="subject_geographic_hierarchical_street"/>
                </hierarchicalGeographic>
            </subject>
        </xsl:if>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_country">
        <country>
            <xsl:value-of select="."/>
        </country>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_province">
        <province>
            <xsl:value-of select="."/>
        </province>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_state">
        <state>
            <xsl:value-of select="."/>
        </state>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_city">
        <city>
            <xsl:value-of select="."/>
        </city>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_borough">
        <city>
            <xsl:value-of select='concat("Borough: ", .)'/>
        </city>
    </xsl:template>
    <xsl:template match="subject_geographic_hierarchical_street">
        <citySection>
            <xsl:value-of select='concat("Street: ", .)'/>
        </citySection>
    </xsl:template>
</xsl:stylesheet>