<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
<body>
  <h2>My CD Collection</h2>
  <table border="1">
    <tr bgcolor="#9acd32">
      <th style="text-align:left">Name</th>
      <th style="text-align:left">Genre</th>
      <th style="text-align:left">Place</th>
    </tr>
    <xsl:for-each select="document/ad">

 
        <xsl:choose>
          <xsl:when test = "band/genre = 'pop'">
          <tr bgcolor = "green">
            <td><xsl:value-of select="band/name"/></td>
            <td><xsl:value-of select="band/genre"/></td>
            <td><xsl:value-of select="place/venue"/></td>
          </tr></xsl:when>
          <xsl:when test = "band/genre = 'Classical'">
          <tr bgcolor = "yellow">
            <td><xsl:value-of select="band/name"/></td>
            <td><xsl:value-of select="band/genre"/></td>
            <td><xsl:value-of select="place/venue"/></td>
          </tr>
          </xsl:when>
          <xsl:when test = "band/genre = 'Instrumental'">
          <tr bgcolor = "blue">
            <td><xsl:value-of select="band/name"/></td>
            <td><xsl:value-of select="band/genre"/></td>
            <td><xsl:value-of select="place/venue"/></td>
          </tr>
          </xsl:when>
        </xsl:choose>
        
   

      
    </xsl:for-each>  
  </table>
<h2>concerts 2.0</h2>
        <table border="1">
      <tr >
        <th>Bandname</th>
        <th>Genre</th>
        <th>place</th>
      </tr>
      <xsl:for-each select="document/ad">
      <xsl:sort select="band/genre"/>
      <xsl:if test="ticket/price &lt; 100 and place/address='mangalore' and shows/month='april'">
      <tr bgcolor="#FF0000">
        <td><xsl:value-of select="band/name" /></td>
        <td><xsl:value-of select="band/genre" /></td>
        <td><xsl:value-of select="place" /></td>
      </tr>
         </xsl:if>
      <xsl:if test="ticket/discount != ''">
      <tr bgcolor="#CFB53B">
        <td><xsl:value-of select="band/name" /></td>
        <td><xsl:value-of select="band/genre" /></td>
        <td><xsl:value-of select="place" /></td>
      </tr>
         </xsl:if>
      </xsl:for-each>
    </table>

</body>
</html>
</xsl:template>
</xsl:stylesheet>
