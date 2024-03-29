<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns:fo="http://www.w3.org/1999/XSL/Format"
        xmlns:v="https://vize1500">
  <!--
  File: channels-fo.xsl
  Created by: Viktor Zetterstöm (vize1500)
  Course: DT074G, Mittuniversitetet

  This file uses channel.xml to generate a pdf with the information it contains.
  -->


  <xsl:output indent="yes"/>
  <xsl:strip-space elements="*"/>

  <xsl:template match="/">
    <fo:root>
      <fo:layout-master-set>
        <fo:simple-page-master master-name="my-page" page-width="8.5in" page-height="11in">
          <fo:region-body margin="2in" margin-top="1in" margin-bottom="1in"/>
        </fo:simple-page-master>
      </fo:layout-master-set>
      <fo:page-sequence master-reference="my-page">
        <fo:flow flow-name="xsl-region-body">
          <!-- Header with title and then channel templates -->
          <xsl:apply-templates select="/v:tv-guide/v:tv-guide-title" />

          <!-- Each channel is presented through a table -->
          <xsl:apply-templates select="/v:tv-guide/v:channel" />
        </fo:flow>
      </fo:page-sequence>
    </fo:root>
  </xsl:template>

  <!-- Attribute set for title -->
  <xsl:attribute-set name="title-attr">
    <xsl:attribute name="font-size">30px</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <!-- Attribute set for date -->
  <xsl:attribute-set name="date-attr">
    <xsl:attribute name="font-size">20px</xsl:attribute>
    <xsl:attribute name="text-align">center</xsl:attribute>
  </xsl:attribute-set>

  <!-- Attribute set for table -->
  <xsl:attribute-set name="table-attr">
    <xsl:attribute name="border">solid</xsl:attribute>
    <xsl:attribute name="font-size">9px</xsl:attribute>
  </xsl:attribute-set>

  <!-- Grey color attribute -->
  <xsl:attribute-set name="gray-attr">
    <xsl:attribute name="background-color">#cacaca</xsl:attribute>
  </xsl:attribute-set>



  <!-- TV-guide title template -->
  <xsl:template match="v:tv-guide-title">
    <fo:block xsl:use-attribute-sets="title-attr"><xsl:value-of select="." /></fo:block>

    <!-- Date -->
    <fo:block xsl:use-attribute-sets="date-attr">
      <xsl:value-of select="substring((//@start)[1], 1, 4)" /> -
      <xsl:value-of select="substring((//@start)[1], 5, 2)" /> -
      <xsl:value-of select="substring((//@start)[1], 7, 2)" />
    </fo:block>
  </xsl:template>

  <!-- Channel table -->
  <xsl:template match="v:channel">
    <fo:table break-after="page">
      <fo:table-column width="20mm"/>
      <fo:table-column width="10mm"/>

      <!-- Table header -->
      <fo:table-header>
        <fo:table-row xsl:use-attribute-sets="table-attr gray-attr">
          <fo:table-cell number-columns-spanned="2">
            <fo:block text-align="center">
              <fo:external-graphic height="1.00in"  content-width="1.00in">
                <xsl:attribute name="src"><xsl:value-of select="v:logo-path" /></xsl:attribute>
              </fo:external-graphic>
            </fo:block>
          </fo:table-cell>
        </fo:table-row>
      </fo:table-header>

      <!-- Table body -->
      <fo:table-body>
        <xsl:apply-templates select="v:programme" />
      </fo:table-body>
    </fo:table>
  </xsl:template>

  <xsl:template match="v:programme">
    <fo:table-row>
      <!-- Programme name -->
      <fo:table-cell xsl:use-attribute-sets="table-attr">
        <fo:block>
          <xsl:value-of select="v:title" />
        </fo:block>
      </fo:table-cell>

      <!-- Programme time -->
      <fo:table-cell xsl:use-attribute-sets="table-attr">
        <fo:block>
          <xsl:value-of select="substring(@start, 9, 2)" />:<xsl:value-of select="substring(@start, 11, 2)" />
        </fo:block>
      </fo:table-cell>
    </fo:table-row>
  </xsl:template>

</xsl:stylesheet>