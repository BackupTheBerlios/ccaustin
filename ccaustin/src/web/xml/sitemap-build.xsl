<?xml version="1.0" encoding="UTF-8"?>
<!--	
	Sitemap-build
	
	Generates an ant build script from the sitemap for generating the html web site
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="xml" indent="yes"/>
	<xsl:template match="/">
		<xsl:comment>=====================================================================</xsl:comment>
		<xsl:comment>Build File for ANT (http://jakarta.apache.org/ant)</xsl:comment>
		<xsl:comment>NOTE: This file has been automatically-generated. DO NOT EDIT THIS FILE DIRECTLY.</xsl:comment>
		<xsl:comment>=====================================================================</xsl:comment>
		<project name="autogen-build" default="web" basedir=".">
			<xsl:apply-templates select="website"/>
		</project>
	</xsl:template>
	
	<xsl:template match="website">
		<target name="web">
			<xsl:attribute name="depends">
				<xsl:for-each select="section">
					<xsl:text>web-</xsl:text><xsl:value-of select="@name"/>
					<xsl:if test="position() != last()"><xsl:text>,</xsl:text></xsl:if>
				</xsl:for-each>
			</xsl:attribute>
		</target>
			
			<xsl:apply-templates select="section"/>
	</xsl:template>
	
	<xsl:template match="section">
		<target>
			<xsl:attribute name="name">web-<xsl:value-of select="@name"/></xsl:attribute>
			<xsl:apply-templates select="page"/>
			<xsl:apply-templates select="pageset"/>
		</target>
	</xsl:template>
	
	<xsl:template match="page">
		<style force="yes">
			<xsl:attribute name="style"><xsl:text>${src.xml.dir}</xsl:text><xsl:value-of select="../@basedir"/><xsl:value-of select="@style"/></xsl:attribute>
			<xsl:choose>
				<xsl:when test="@tempin != ''">
					<xsl:attribute name="in"><xsl:text>${build.tmpgen.dir}</xsl:text><xsl:value-of select="../@basedir"/><xsl:value-of select="@tempin"/></xsl:attribute>
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="in"><xsl:text>${src.xml.dir}</xsl:text><xsl:value-of select="../@basedir"/><xsl:value-of select="@datafile"/></xsl:attribute>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:choose>
				<xsl:when test="@tempout != ''">
					<xsl:attribute name="out"><xsl:text>${build.tmpgen.dir}</xsl:text><xsl:value-of select="@tempout"/></xsl:attribute><!-- we don't assume that the basedir is where we want this one -->
				</xsl:when>
				<xsl:otherwise>
					<xsl:attribute name="out"><xsl:text>${build.web.dir}</xsl:text><xsl:value-of select="@html"/></xsl:attribute><!-- we don't assume that the basedir is where we want this one -->
				</xsl:otherwise>
			</xsl:choose>
		</style>
	</xsl:template>

	<!-- TODO: Determine how/if the pageset tag allows the pages to be listed on a consolidated sitemap page.... right now, they are not indiv listed and titled -->
	<xsl:template match="pageset">
		<style force="yes">
			<xsl:attribute name="style"><xsl:text>${src.xml.dir}</xsl:text><xsl:value-of select="../@basedir"/><xsl:value-of select="@style"/></xsl:attribute>
			<xsl:attribute name="basedir"><xsl:text>${src.xml.dir}</xsl:text><xsl:value-of select="../@basedir"/></xsl:attribute>
			<xsl:attribute name="destdir"><xsl:text>${build.web.dir}</xsl:text><xsl:value-of select="@out"/></xsl:attribute><!-- we don't assume that the basedir is where we want this one -->
			<xsl:attribute name="includes"><xsl:value-of select="@match"/></xsl:attribute>
		</style>
	</xsl:template>
</xsl:stylesheet>
