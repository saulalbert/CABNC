<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                version="1.0">

  <xsl:output method="text" encoding="utf-8" />

  <xsl:template match="teiHeader"/>

  <xsl:template match="text|stext">
    <xsl:apply-templates/>
  </xsl:template>

</xsl:stylesheet>
<!-- This stylesheet removes all the tagging and metadata from a BNC
text. It contains two templates, one to match any teiHeader element
found, and one which will match either a text or an stext element. The
first template is empty: its effect is therefore to do nothing. The
second template specifies that when a text or stext element is found,
their contents should be processed with any available templates. Since
no other template is specified by this stylesheet, the default action
is taken. By default an XSLT processor simply discards markup and
outputs the text content of every element found. The text content will
be output as plain text, using the UTF-8 encoding scheme for
Unicode. -->

