<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    version="2.0">
    <xsl:output encoding="UTF-8" indent="yes" method="xml"/>
    <xsl:strip-space elements="*"/>
    
    <xsl:param name="lf" select="/*/text"/>
    <xsl:param name="datasep" select="'|'"/>
    <xsl:param name="notext" select="/*"/>
    
    <xsl:template match="itemContainer">
           <root>
                <xsl:apply-templates select="item"/>
           </root>  
    </xsl:template>
    <xsl:template match="item">
        <row>
            <omeka_identifier-1--omeka_identifier_value>
               <xsl:value-of select="@itemId"/>
            </omeka_identifier-1--omeka_identifier_value>
            <relatedItem_project>
               <xsl:value-of select="OmekaCollection"/>
            </relatedItem_project>
            <projectURL>&#160;</projectURL>
            <_digital_object_type.string_key>&#160;</_digital_object_type.string_key>
            <_parent_digital_objects-1.identifier>&#160;</_parent_digital_objects-1.identifier>
            <_project.string_key>&#160;</_project.string_key>
            <xsl:apply-templates select="ItemType"/>
            <xsl:apply-templates select="OriginalFileLoadedIntoOmeka"/>
            <xsl:apply-templates select="ItemInContext"/>
            <xsl:apply-templates select="DublinCore"/>
            <xsl:apply-templates select="MODS"/>
            <xsl:apply-templates select="AdditionalItemMetadata"/>
        </row>
    </xsl:template>
    
    <xsl:template match="ItemType">
        <type_of_resource-1--type_of_resource_value>
            <xsl:value-of select="."/>
            <xsl:for-each select="text">
                <note-3--note_value>
                    <xsl:value-of select="."/>
                </note-3--note_value>
                <note-3--note_type>original_format</note-3--note_type>
            </xsl:for-each>
        </type_of_resource-1--type_of_resource_value>
    </xsl:template>
    
    <xsl:template match="OriginalFileLoadedIntoOmeka">
        <note-2--note_value>
        <xsl:if test="position() gt 1">
            <xsl:value-of select="$lf"/>
        </xsl:if>
        <xsl:for-each-group select="*" group-adjacent="node-name(.)">
            <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
        </xsl:for-each-group>
        </note-2--note_value>
        <note-2--note_type>filename</note-2--note_type>
    </xsl:template>
    
    <xsl:template match="ItemInContext">
        <object_in_context_url-1--object_in_context_url_value>
            <xsl:value-of select="."/>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </object_in_context_url-1--object_in_context_url_value>
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
        <xsl:apply-templates select="Source"/>
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
            <title-1--title_non_sort_portion>&#160;</title-1--title_non_sort_portion>
            <title-1--title_sort_portion>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </title-1--title_sort_portion> 
            <partName>&#160;</partName>
            <_identifiers-1>&#160;</_identifiers-1>
    </xsl:template>
    
    <xsl:template match="Subject">
        <subject_topic-1--subject_topic_term.value>
            <xsl:if test="position() gt 1">
                <xsl:value-of select="$lf"/>
            </xsl:if>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </subject_topic-1--subject_topic_term.value>
        <subject_topic-1--subject_topic_term.authority>&#160;</subject_topic-1--subject_topic_term.authority> 
        <subject_topic-1--subject_topic_term.uri>&#160;</subject_topic-1--subject_topic_term.uri> 
        <subject_name-1--subject_name_term.value>&#160;</subject_name-1--subject_name_term.value> 
        <subject_name-1--subject_name_term.name_type>&#160;</subject_name-1--subject_name_term.name_type> 
        <subject_name-1--subject_name_term.authority>&#160;</subject_name-1--subject_name_term.authority> 
        <subject_name-1--subject_name_term.uri>&#160;</subject_name-1--subject_name_term.uri>
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_street-1.subject_hierarchical_geographic_street_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_street-1.subject_hierarchical_geographic_street_value> 
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_borough_text_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_borough_text_value>
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_city_text_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_city_text_value> 
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_state_text_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_state_text_value>
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_province_text_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_province_text_value>
        <subject_hierarchical_geographic-1--subject_hierarchical_geographic_county_text_value>&#160;</subject_hierarchical_geographic-1--subject_hierarchical_geographic_county_text_value>
        <subject_title-1--subject_title_term.value>&#160;</subject_title-1--subject_title_term.value>
        <subject_title-1--subject_title_term.authority>&#160;</subject_title-1--subject_title_term.authority>
        <subject_title-1--subject_title_term.uri>&#160;</subject_title-1--subject_title_term.uri>              
    </xsl:template>   
            
    <xsl:template match="Description">
            <abstract-1--abstract_value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </abstract-1--abstract_value> 
    </xsl:template>
    
    <xsl:template match="Creator">
        <name-1--name_term.value>
            <xsl:if test="position() gt 1">
                <xsl:value-of select="$lf"/>
            </xsl:if>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </name-1--name_term.value>
        <name-1--name_term.name_type>&#160;</name-1--name_term.name_type>
        <name-1--name_term.authority>&#160;</name-1--name_term.authority>
        <name-1--name_term.uri>&#160;</name-1--name_term.uri>
        <name-1--name_role-1.name_role_term.value>&#160;</name-1--name_role-1.name_role_term.value>
        <name-1--name_role-1.name_role_term.authority>&#160;</name-1--name_role-1.name_role_term.authority>
        <name-1--name_role-1.name_role_term.uri>&#160;</name-1--name_role-1.name_role_term.uri>
    </xsl:template>
    
    <!-- Source skipped according to mapping 1/7/2015 -->
    
    <xsl:template match="Publisher">
        <xsl:for-each select="text">
            <publisher-1--publisher_value>
                <xsl:value-of select="."/>
            </publisher-1--publisher_value> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Date">
            <date_created_textual-1--date_created_textual_value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </date_created_textual-1--date_created_textual_value> 
    </xsl:template>
    
    <xsl:template match="Contributor">
        <name-2--name_term.value>
            <xsl:if test="position() gt 1">
                <xsl:value-of select="$lf"/>
            </xsl:if>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </name-2--name_term.value>
            <name-2--name_term.name_type>&#160;</name-2--name_term.name_type>
            <name-2--name_term.authority>&#160;</name-2--name_term.authority>
            <name-2--name_term.uri>&#160;</name-2--name_term.uri>
            <name-2--name_role-1.name_role_term.value>&#160;</name-2--name_role-1.name_role_term.value>
            <name-2--name_role-1.name_role_term.authority>&#160;</name-2--name_role-1.name_role_term.authority>
            <name-2--name_role-1.name_role_term.uri>&#160;</name-2--name_role-1.name_role_term.uri>
    </xsl:template>
    
    <xsl:template match="Rights">
        <xsl:for-each select="text">
            <use_and_reproduction-1--use_and_reproduction_value>
                <xsl:value-of select="."/>
            </use_and_reproduction-1--use_and_reproduction_value> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Relation">
        <xsl:for-each select="text">
            <note-6--note_value>
                <xsl:value-of select="."/>
            </note-6--note_value>
            <note-6--note_type>related_item</note-6--note_type>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Format">
        <form-1--form_term.value>
            <xsl:if test="position() gt 1">
                <xsl:value-of select="$lf"/>
            </xsl:if>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </form-1--form_term.value>
            <form-1--form_term.authority>&#160;</form-1--form_term.authority>
            <form-1--form_term.uri>&#160;</form-1--form_term.uri>
    </xsl:template>
    
    <xsl:template match="Language">
            <language-1--language_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </language-1--language_term.value>
            <language-1--language_term.authority>iso639-2</language-1--language_term.authority>
            <language-1--language_term.uri>&#160;</language-1--language_term.uri>
    </xsl:template>
    
    <xsl:template match="Type">
            <genre-1--genre_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </genre-1--genre_term.value>
            <genre-1--genre_term.authority>fast</genre-1--genre_term.authority>
            <genre-1--genre_term.uri>&#160;</genre-1--genre_term.uri>
    </xsl:template>
    
    <xsl:template match="Identifier">
        <xsl:for-each select="text">
            <clio_identifier-1--clio_identifier_value>
                <xsl:value-of select="."/>
            </clio_identifier-1--clio_identifier_value> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Coverage">
            <subject_topic-2--subject_topic_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </subject_topic-2--subject_topic_term.value>
            <subject_topic-2--subject_topic_term.authority>fast</subject_topic-2--subject_topic_term.authority> 
            <subject_topic-2--subject_topic_term.uri>&#160;</subject_topic-2--subject_topic_term.uri>
    </xsl:template>
    
    <xsl:template match="Source">
        <xsl:for-each select="text">
            <note-7--note_value>
                <xsl:value-of select="."/>
            </note-7--note_value>
            <note-7--note_type>original</note-7--note_type>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="KeyDate">
        <xsl:for-each select="text">
            <date_created-1--date_created_start_value>
                <xsl:value-of select="substring-before(., ' ')"/>
            </date_created-1--date_created_start_value> 
            <date_created-1--date_created_end_value>
                <xsl:value-of select="substring-after(., ' ')"/>
            </date_created-1--date_created_end_value>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="TypeofDate">
        <xsl:for-each select="text">
            <date_created-1--date_created_type>
                <xsl:value-of select="."/>
            </date_created-1--date_created_type> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PublicationPlace">
            <place_of_origin-1--place_of_origin_value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </place_of_origin-1--place_of_origin_value> 
    </xsl:template>
    
    <xsl:template match="PublicationDate">
        <xsl:for-each select="text">
            <date_created_textual-2--date_created_textual_value>
                <xsl:value-of select="."/>
            </date_created_textual-2--date_created_textual_value> 
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="PlaceofOrigin">
            <place_of_origin-2--place_of_origin_value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </place_of_origin-2--place_of_origin_value> 
         <!-- Currently no mapping for place authority and uri  -->
    </xsl:template>
    
    <xsl:template match="FormGenre">
            <form-2--form_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </form-2--form_term.value>
            <form-2--form_term.authority></form-2--form_term.authority>
            <form-2--form_term.uri>&#160;</form-2--form_term.uri>
    </xsl:template>
    
    <xsl:template match="PhysicalDescription">
            <extent-1--extent_value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </extent-1--extent_value>
    </xsl:template>
    
    <xsl:template match="RepositoryName">
        <xsl:for-each select="text">
            <location-1--location_term.value>
                <xsl:value-of select="."/>
            </location-1--location_term.value>
        </xsl:for-each>
            <location-1--location_term.code>&#160;</location-1--location_term.code>
            <location-1--location_term.authority>local</location-1--location_term.authority>
            <location-1--location_term.uri>&#160;</location-1--location_term.uri>
    </xsl:template>
    
    <xsl:template match="Subrepository">
        <xsl:for-each select="text">
            <location-1--location_sublocation>
                <xsl:value-of select="."/>
            </location-1--location_sublocation>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="ShelfLocation">
        <xsl:for-each select="text">
            <location-1--location_shelf_location-1.location_shelf_location_free_text>
                <xsl:value-of select="."/>
            </location-1--location_shelf_location-1.location_shelf_location_free_text>
            <location-1--location_shelf_location-1.location_shelf_location_box_number>&#160;</location-1--location_shelf_location-1.location_shelf_location_box_number>
            <location-1--location_shelf_location-1.location_shelf_location_folder_number>&#160;</location-1--location_shelf_location-1.location_shelf_location_folder_number>      
        </xsl:for-each>
        <note-5--note_value>&#160;</note-5--note_value>
        <note-5--note_type>holdings</note-5--note_type>
    </xsl:template>
    
    <xsl:template match="Notes">
        <note-1--note_value>
            <xsl:if test="position() gt 1">
                <xsl:value-of select="$lf"/>
            </xsl:if>
            <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
            </xsl:for-each-group>
        </note-1--note_value>
        <note-1--note_type>&#160;</note-1--note_type>
    </xsl:template>
    
    <xsl:template match="DigitalOrigin">
        <xsl:variable name="digor" select="text"/>
        <xsl:choose>
            <xsl:when test="matches($digor, 'rd')">
                <digital_origin-1--digital_origin_value>reformatted digital</digital_origin-1--digital_origin_value>
            </xsl:when>
            <xsl:when test="matches($digor, 'Reformatted Digital')">
                <digital_origin-1--digital_origin_value>reformatted digital</digital_origin-1--digital_origin_value>
            </xsl:when>
            <xsl:otherwise>
            <digital_origin-1--digital_origin_value>
                <xsl:value-of select="."/>
            </digital_origin-1--digital_origin_value>
            </xsl:otherwise>
        </xsl:choose>  
    </xsl:template>
    
    <xsl:template match="Collection">
        <xsl:for-each select="text">
            <collection-1--collection_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </collection-1--collection_term.value>
            <collection-1--collection_term.uri>&#160;</collection-1--collection_term.uri>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="SpatialCoverage">
        <xsl:for-each select="text">
            <subject_geographic-1--subject_geographic_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </subject_geographic-1--subject_geographic_term.value>
            <subject_geographic-1--subject_geographic_term.authority>&#160;</subject_geographic-1--subject_geographic_term.authority>
            <subject_geographic-1--subject_geographic_term.uri>&#160;</subject_geographic-1--subject_geographic_term.uri>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="RightsHolder">
        <xsl:for-each select="text">
            <collection-2--collection_term.value>
                <xsl:value-of select="."/>
            </collection-2--collection_term.value>
            <collection-2--collection_term.uri>&#160;</collection-2--collection_term.uri>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Provenance">
        <xsl:for-each select="text">
            <note-4--note_value>
                <xsl:value-of select="."/>
            </note-4--note_value>
            <note-4--note_type>ownership</note-4--note_type>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="Citation">
        <xsl:for-each select="text">
            <collection-3--collection_term.value>
                <xsl:value-of select="."/>
            </collection-3--collection_term.value>
        </xsl:for-each>
    </xsl:template>
    
    <xsl:template match="TemporalCoverage">
        <xsl:for-each select="text">
            <subject_temporal-1--subject_temporal_term.value>
                <xsl:if test="position() gt 1">
                    <xsl:value-of select="$lf"/>
                </xsl:if>
                <xsl:for-each-group select="*" group-adjacent="node-name(.)">
                    <xsl:value-of select="current-group()/descendant-or-self::*[not(*)]" separator="{$datasep}"/>
                </xsl:for-each-group>
            </subject_temporal-1--subject_temporal_term.value>
            <subject_temporal-1--subject_temporal_term.authority>&#160;</subject_temporal-1--subject_temporal_term.authority>
            <subject_temporal-1--subject_temporal_term.uri>&#160;</subject_temporal-1--subject_temporal_term.uri>
        </xsl:for-each>
    </xsl:template>
</xsl:stylesheet>