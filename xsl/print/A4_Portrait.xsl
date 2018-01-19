<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.1"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:fo="http://www.w3.org/1999/XSL/Format" exclude-result-prefixes="fo">

    <xsl:import href="legend.xsl"/>

    <xsl:output method="xml" version="1.0" omit-xml-declaration="no" indent="yes"/>

    <xsl:include href="calc.xsl"/>
    <xsl:include href="styles.xsl"/>

    <xsl:param name="versionParam" select="'1.0'"/>

    <xsl:variable name="map-width-px" select="'370'"/>
    <xsl:variable name="map-height-px" select="'658'"/>

    <!-- See legend.xsl (does not currently affect size of other elements!) -->
    <xsl:variable name="legend-width-cm" select="5.6"/>
    <!-- See legend.xsl ('none', 'before', 'right') -->
    <xsl:variable name="legend-labels-pos" select="'before'"/>
    <xsl:variable name="legend-scale-images-same-ratio" select="true()"/>
 
    <!-- formatter -->
    <xsl:decimal-format name="MyFormat" decimal-separator="." grouping-separator=","
                        infinity="INFINITY" minus-sign="-" NaN="Not a Number" percent="%" per-mille="m"
                        zero-digit="0" digit="#" pattern-separator=";" />

    <!-- master set -->
    <xsl:template name="layout-master-set">
        <fo:layout-master-set>  
            <fo:simple-page-master master-name="dbk_page" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="10mm" margin-left="10mm" margin-right="10mm">
                <fo:region-body region-name="body"></fo:region-body>
            </fo:simple-page-master>
            
            <fo:simple-page-master master-name="a4-staand" page-height="297mm" page-width="210mm" margin-top="10mm" margin-bottom="10mm" margin-left="10mm" margin-right="10mm">
                <fo:region-body region-name="body" margin-bottom="10mm" margin-top="25mm"/>
                <fo:region-before region-name="before" extent="0mm"/>
                <fo:region-after region-name="after" extent="15mm"/>
            </fo:simple-page-master>
                                
        </fo:layout-master-set>
    </xsl:template>

    <xsl:template match="info">
        <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:xlink="http://www.w3.org/1999/xlink">
            <xsl:call-template name="layout-master-set"/>
            
            <fo:page-sequence master-reference="dbk_page"> 
                <fo:flow flow-name="body">
                    <xsl:call-template name="dbk_titleBk"></xsl:call-template>
                    <xsl:call-template name="dbk_verblijf"></xsl:call-template>
                    <xsl:call-template name="dbk_dangerSymbols"></xsl:call-template> 
                </fo:flow>
            </fo:page-sequence>
            
            <fo:page-sequence master-reference="a4-staand">
                
                <fo:static-content flow-name="before">
                      
                    <fo:list-block provisional-label-separation="5mm" provisional-distance-between-starts="132mm">
                        <fo:list-item>
                            <fo:list-item-label end-indent="label-end()">
                                <fo:block xsl:use-attribute-sets="title-font">
                                    <xsl:value-of select="title"/>
                                </fo:block>
                                <fo:block xsl:use-attribute-sets="default-font">
                                    <xsl:value-of select="subtitle"/>
                                </fo:block>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                <xsl:call-template name="logo-block"/>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block> 
                </fo:static-content>

                <fo:static-content flow-name="after">
                    <fo:block-container overflow="hidden">
                        <xsl:call-template name="disclaimer-block"/>
                    </fo:block-container>
                </fo:static-content>
               
                <fo:flow flow-name="body">               
                    <fo:list-block provisional-label-separation="5mm" provisional-distance-between-starts="60mm">
                        <fo:list-item wrap-option="no-wrap">
                            <fo:list-item-label end-indent="label-end()">
                                                            
                                <xsl:call-template name="info-block"/>
                            </fo:list-item-label>
                            <fo:list-item-body start-indent="body-start()">
                                                            
                                <xsl:call-template name="map-block"/>
                            </fo:list-item-body>
                        </fo:list-item>
                    </fo:list-block> 
  
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>


    <xsl:template name="info-block">
        <fo:block xsl:use-attribute-sets="default-font">
            <fo:block>
                <xsl:call-template name="windrose">
                    <xsl:with-param name="angle" select="angle"/>
                    <xsl:with-param name="top" select="'0cm'"/>
                    <xsl:with-param name="left" select="'4.0cm'"/>		
                </xsl:call-template>   
            </fo:block>
            <!-- create scalebar -->
            <fo:block margin-top="5mm">
                <xsl:text>schaal</xsl:text>
            </fo:block>

            <fo:block>
                <xsl:call-template name="calc-scale">
                    <xsl:with-param name="m-width">
                        <xsl:call-template name="calc-bbox-width-m-corrected">
                            <xsl:with-param name="bbox" select="bbox"/>
                        </xsl:call-template>
                    </xsl:with-param>
                    <xsl:with-param name="px-width" select="$map-width-px"/>
                </xsl:call-template>
            </fo:block>
        </fo:block>
		 
        <fo:block xsl:use-attribute-sets="header-font">
            <xsl:text>legenda</xsl:text>
        </fo:block>
        <xsl:call-template name="legend" />
	   
        <!-- overzichtskaart
        <xsl:call-template name="overview-block">
                        <xsl:with-param name="width" select="'112'" />
                        <xsl:with-param name="height" select="'80'" />
                        <xsl:with-param name="width" select="'112px'" />
                        <xsl:with-param name="height" select="'80px'" />
        </xsl:call-template>
        -->
    </xsl:template>

    <!-- kaartje -->
    <xsl:template name="map-block">
        <xsl:variable name="bbox-corrected">
            <xsl:call-template name="correct-bbox">
                <xsl:with-param name="bbox" select="bbox" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="px-ratio" select="format-number($map-height-px div $map-width-px,'0.##','MyFormat')" />
        <xsl:variable name="map-height-px-corrected" select="quality"/>
        <xsl:variable name="map-width-px-corrected" select="format-number(quality div $px-ratio,'0','MyFormat')"/>
        <xsl:variable name="map">
            <xsl:value-of select="imageUrl"/>
            <xsl:text>&amp;width=</xsl:text>
            <xsl:value-of select="$map-width-px-corrected"/>
            <xsl:text>&amp;height=</xsl:text>
            <xsl:value-of select="$map-height-px-corrected"/>
            <xsl:text>&amp;bbox=</xsl:text>
            <xsl:value-of select="$bbox-corrected"/>
        </xsl:variable>

        <fo:block>
            <fo:external-graphic src="{$map}" content-height="scale-to-fit" content-width="scale-to-fit" scaling="uniform" width="{$map-width-px}" height="{$map-height-px}" xsl:use-attribute-sets="simple-border"/>
        </fo:block>
    </xsl:template>

    <xsl:template name="disclaimer-block">
        <fo:block xsl:use-attribute-sets="disclaimer-font">
            <fo:block>
                <xsl:value-of select="remark"/>
            </fo:block>
            <fo:block>
                <xsl:if test="username"> 
                    <xsl:text>Auteur: </xsl:text>                    
                    <xsl:value-of select="username"/>
                    <xsl:text> - </xsl:text>
                </xsl:if>
                <xsl:text>Datum: </xsl:text>
                <xsl:value-of select="date"/>
                <xsl:text> - </xsl:text>
                <xsl:text>Aan deze kaart kunnen geen rechten worden ontleend.</xsl:text>
            </fo:block>
        </fo:block>
    </xsl:template>

    <xsl:template name="logo-block">
        <fo:block>
            <fo:external-graphic src="url('logo.png')" width="155px" height="55px"/>
        </fo:block>
    </xsl:template>
    
    <xsl:template name="dbk_titleBk">
        <xsl:variable name="printDate">
            <xsl:choose>
                <xsl:when test="date='null'">-</xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="date"></xsl:value-of>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:for-each select="extra/info[@classname='viewer.components.safetymapsFlamingo']/root">
            <fo:block-container width="9.25cm" height="10.84cm" top="0cm" left="0cm" xsl:use-attribute-sets="column-block-border">
                <fo:block margin-top="0.1cm" margin-left="0.1cm" xsl:use-attribute-sets="title-font">Digitale bereikbaarheidskaart</fo:block>
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <xsl:choose>
                        <xsl:when test="adres_id='null'">-</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="adres_id"></xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">Datum afdruk:
                    <xsl:value-of select="$printDate"></xsl:value-of>
                </fo:block>
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <xsl:choose>
                        <xsl:when test="formele_naam='null'">-</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="formele_naam"></xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <fo:inline font-style="oblique">
                        <xsl:choose>
                            <xsl:when test="informele_naam='null'">-</xsl:when>
                            <xsl:otherwise>
                                <xsl:value-of select="informele_naam"></xsl:value-of>
                            </xsl:otherwise>
                        </xsl:choose>
                    </fo:inline>
                </fo:block>
                <!-- Algemeen.-->
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="title-font">Algemeen</fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">BHV:
                    <xsl:choose>
                        <xsl:when test="bhv_aanwezig">
                            <xsl:choose>
                                <xsl:when test="bhv_aanwezig='true'">BHV aanwezig</xsl:when>
                                <xsl:otherwise>Geen BHV aanwezig</xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>Geen BHV aanwezig</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">Gebouwconstructie:
                    <xsl:choose>
                        <xsl:when test="gebouwconstructie">
                            <xsl:choose>
                                <xsl:when test="gebouwconstructie='null'">-</xsl:when>
                                <xsl:when test="gebouwconstructie=''">-</xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="gebouwconstructie"></xsl:value-of>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">OMS nummer:
                    <xsl:choose>
                        <xsl:when test="oms_nummer">
                            <xsl:choose>
                                <xsl:when test="oms_nummer='null'">-</xsl:when>
                                <xsl:when test="oms_nummer=''">-</xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="oms_nummer"></xsl:value-of>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">Gebruik:
                    <xsl:choose>
                        <xsl:when test="gebruikstype">
                            <xsl:choose>
                                <xsl:when test="gebruikstype='null'">-</xsl:when>
                                <xsl:when test="gebruikstype=''">-</xsl:when>
                                <xsl:otherwise>
                                    <xsl:value-of select="gebruikstype"></xsl:value-of>
                                </xsl:otherwise>
                            </xsl:choose>
                        </xsl:when>
                        <xsl:otherwise>-</xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <!-- Gebouwinformatie.-->
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="title-font">Gebouwinformatie</fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">Bouwlaag:
                    <xsl:choose>
                        <xsl:when test="bouwlaag='null'">-</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="bouwlaag"></xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <fo:block margin-top="0cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">Hoogste bouwlaag:
                    <xsl:choose>
                        <xsl:when test="bouwlaag_max='null'">-</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="bouwlaag_max"></xsl:value-of>
                        </xsl:otherwise>
                    </xsl:choose>
                </fo:block>
                <!-- Adres.-->
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="title-font">Adres</fo:block>
                <fo:block margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <xsl:value-of select="straatnaam"></xsl:value-of>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="huisnummer"></xsl:value-of>
                    <xsl:value-of select="adres/huisletter"></xsl:value-of>
                    <xsl:text>&#160;</xsl:text>
                    <xsl:value-of select="adres/huisnummertoevoeging"></xsl:value-of>
                </fo:block>
                <fo:block margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <xsl:value-of select="postcode"></xsl:value-of>
                    <xsl:value-of select="plaats"></xsl:value-of>
                </fo:block>
                <!-- Contact.-->
                <fo:block margin-top="0.2cm" margin-left="0.1cm" xsl:use-attribute-sets="title-font">Contact</fo:block>
                <fo:block margin-top="0.05cm" margin-left="0.1cm" xsl:use-attribute-sets="default-font">
                    <fo:table table-layout="fixed" width="5.95cm">
                        <fo:table-column column-width="1.785cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="2.38cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="1.785cm"></fo:table-column>
                        <fo:table-body>
                            <!-- Header.-->
                            <fo:table-row>
                                <fo:table-cell margin-left="0.05cm">
                                    <fo:block>
                     
                                        Functie
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm">
                                    <fo:block>Naam</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm">
                                    <fo:block>Telefoonnr.</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <!-- Body.-->
                            <xsl:choose>
                                <xsl:when test="contacten">
                                    <xsl:for-each select="contacten">
                                        <fo:table-row border-width="thin" border-top-style="solid">
                                            <fo:table-cell margin-left="0.05cm">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="functie='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="functie"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="naam='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="naam"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="telefoonnummer='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="telefoonnummer"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <fo:table-row border-width="thin" border-top-style="solid">
                                        <fo:table-cell margin-left="0.05cm">
                                            <fo:block>-</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell margin-left="0.05cm">
                                            <fo:block>-</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell margin-left="0.05cm">
                                            <fo:block>-</fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:otherwise>
                            </xsl:choose>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block-container>
        </xsl:for-each>
    </xsl:template>
  
    <xsl:template name="dbk_verblijf">
        <xsl:for-each select="extra/info[@classname='viewer.components.safetymapsFlamingo']/root">
            <fo:block-container width="9.25cm" height="10.84cm" top="0cm" left="9.35cm" xsl:use-attribute-sets="column-block-border">
                <fo:block margin-top="0.2cm" margin-left="0.2cm" xsl:use-attribute-sets="title-font">Verblijf</fo:block>
                <fo:block margin-top="0.2cm" margin-left="0.2cm" xsl:use-attribute-sets="default-font">
                    <fo:table table-layout="fixed" width="8.85cm">
                        <fo:table-column column-width="1.946cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="1.327cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="1.15cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="1.15cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="0.796cm" border-width="thin" border-right-style="solid"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-column column-width="0.354cm"></fo:table-column>
                        <fo:table-body>
                            <fo:table-row>
                                <fo:table-cell margin-left="0.05cm">
                                    <fo:block>
                     
                                        Groep
                                    </fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>Aantal</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>Van</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>Tot</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>NZR</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>&#160;</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>&#160;</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>&#160;</fo:block>
                                </fo:table-cell>
                                <fo:table-cell margin-left="0.05cm" text-align="center">
                                    <fo:block>Dagen</fo:block>
                                </fo:table-cell>
                            </fo:table-row>
                            <xsl:choose>
                                <xsl:when test="verblijf">
                                    <xsl:for-each select="verblijf">
                                        <fo:table-row border-width="thin" border-top-style="solid">
                                            <fo:table-cell margin-left="0.05cm">
                                                <fo:block> 
                                                    <xsl:choose>
                                                        <xsl:when test="groep='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="groep"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="aantal='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="aantal"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="begintijd='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="begintijd"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="eindtijd='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="eindtijd"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="aantal_nzr='null'">-</xsl:when>
                                                        <xsl:otherwise>
                                                            <xsl:value-of select="aantal_nzr"></xsl:value-of>
                                                        </xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="maandag='true'">m</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="dinsdag='true'">d</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="woensdag='true'">w</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="donderdag='true'">d</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="vrijdag='true'">v</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="zaterdag='true'">z</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                            <fo:table-cell margin-left="0.05cm" text-align="center">
                                                <fo:block>
                                                    <xsl:choose>
                                                        <xsl:when test="zondag='true'">z</xsl:when>
                                                        <xsl:otherwise>-</xsl:otherwise>
                                                    </xsl:choose>
                                                </fo:block>
                                            </fo:table-cell>
                                        </fo:table-row>
                                    </xsl:for-each>
                                </xsl:when>
                            </xsl:choose>
                            <xsl:otherwise>
                                <fo:table-row border-width="thin" border-top-style="solid">
                                    <fo:table-cell margin-left="0.05cm">
                                        <fo:block>
                       
                                            -
                                        </fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell margin-left="0.05cm" text-align="center">
                                        <fo:block>-</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell margin-left="0.05cm" text-align="center">
                                        <fo:block>-</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell margin-left="0.05cm" text-align="center">
                                        <fo:block>-</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell margin-left="0.05cm" text-align="center">
                                        <fo:block>-</fo:block>
                                    </fo:table-cell>
                                    <fo:table-cell margin-left="0.05cm" text-align="center">
                                        <fo:block>-</fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </xsl:otherwise>
                        </fo:table-body>
                    </fo:table>
                </fo:block>
            </fo:block-container>
        </xsl:for-each>
    </xsl:template>
    <xsl:template name="dbk_dangerSymbols">
        <xsl:for-each select="extra/info[@classname='viewer.components.safetymapsFlamingo']/root">
            <fo:block-container width="18.6cm" height="8.129cm" top="19.17cm" left="0cm" xsl:use-attribute-sets="column-block-border">
        <fo:block margin-top="0.1cm" margin-left="0.2cm" xsl:use-attribute-sets="title-font">Gevaarlijke stoffen</fo:block>
        <fo:block margin-top="0.2cm" margin-left="0.2cm" xsl:use-attribute-sets="default-font">
          <fo:table table-layout="fixed" width="18.2cm">
            <fo:table-column column-width="3.021cm" border-width="thin" border-right-style="solid"></fo:table-column>
            <fo:table-column column-width="3.021cm" border-width="thin" border-right-style="solid"></fo:table-column>
            <fo:table-column column-width="3.021cm" border-width="thin" border-right-style="solid"></fo:table-column>
            <fo:table-column column-width="3.021cm" border-width="thin" border-right-style="solid"></fo:table-column>
            <fo:table-column column-width="3.021cm" border-width="thin" border-right-style="solid"></fo:table-column>
            <fo:table-column column-width="3.021cm"></fo:table-column>
            <fo:table-body>
              <!-- Header.-->
              <fo:table-row>
                <fo:table-cell margin-left="0.05cm">
                  <fo:block>
                     
                    Stof
                  </fo:block>
                </fo:table-cell>
                <fo:table-cell margin-left="0.05cm" text-align="center">
                  <fo:block>Gevaarsindicatienr.</fo:block>
                </fo:table-cell>
                <fo:table-cell margin-left="0.05cm" text-align="center">
                  <fo:block>UN nummer</fo:block>
                </fo:table-cell>
                <fo:table-cell margin-left="0.05cm" text-align="center">
                  <fo:block>Hoeveelheid</fo:block>
                </fo:table-cell>
                <fo:table-cell margin-left="0.05cm" text-align="center">
                  <fo:block>Symboolcode</fo:block>
                </fo:table-cell>
                <fo:table-cell margin-left="0.05cm">
                  <fo:block>Informatie</fo:block>
                </fo:table-cell>
              </fo:table-row>
              <!-- Body.-->
              <xsl:choose>
                <xsl:when test="danger_symbols">
                  <xsl:for-each select="danger_symbols">
                    <fo:table-row border-width="thin" border-top-style="solid">
                      <fo:table-cell margin-left="0.05cm">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="naam_stof='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="naam_stof"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                      <fo:table-cell margin-left="0.05cm" text-align="center">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="gevi_code='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="gevi_code"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                      <fo:table-cell margin-left="0.05cm" text-align="center">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="un_nr='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="un_nr"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                      <fo:table-cell margin-left="0.05cm" text-align="center">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="hoeveelheid='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="hoeveelheid"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                      <fo:table-cell margin-left="0.05cm" text-align="center">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="symbol='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="symbol"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                      <fo:table-cell margin-left="0.05cm">
                        <fo:block>
                          <xsl:choose>
                            <xsl:when test="omschrijving='null'">-</xsl:when>
                            <xsl:otherwise>
                              <xsl:value-of select="omschrijving"></xsl:value-of>
                            </xsl:otherwise>
                          </xsl:choose>
                        </fo:block>
                      </fo:table-cell>
                    </fo:table-row>
                  </xsl:for-each>
                </xsl:when>
                <xsl:otherwise>
                  <fo:table-row border-width="thin" border-top-style="solid">
                    <fo:table-cell margin-left="0.05cm">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                    <fo:table-cell margin-left="0.05cm" text-align="center">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                    <fo:table-cell margin-left="0.05cm" text-align="center">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                    <fo:table-cell margin-left="0.05cm" text-align="center">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                    <fo:table-cell margin-left="0.05cm" text-align="center">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                    <fo:table-cell margin-left="0.05cm">
                      <fo:block>-</fo:block>
                    </fo:table-cell>
                  </fo:table-row>
                </xsl:otherwise>
              </xsl:choose>
            </fo:table-body>
          </fo:table>
        </fo:block>
      </fo:block-container>
        </xsl:for-each>
    </xsl:template>

</xsl:stylesheet>
