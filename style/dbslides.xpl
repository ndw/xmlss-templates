<p:pipeline version='1.0' xmlns:p="http://www.w3.org/ns/xproc">
<p:serialization port="result" method="xhtml"/>

<p:xinclude/>

<p:xslt>
  <p:input port="stylesheet">
    <p:document href="dbslides.xsl"/>
  </p:input>
</p:xslt>

</p:pipeline>
