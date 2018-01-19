<?xml version="1.0" encoding="UTF-8"?>
<sld:UserStyle xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
  <sld:Name>Brandcompartiment</sld:Name>
  <sld:Title>Brandcompartiment</sld:Title>
  <sld:Abstract>Lijnstijlen voor brandcompartimenten</sld:Abstract>
  <sld:FeatureTypeStyle>
    <sld:Name>Brandcompartiment</sld:Name>
    <sld:Title>Brandcompartiment</sld:Title>
    <sld:Abstract>Lijnstijlen voor brandcompartimenten</sld:Abstract>
    <sld:FeatureTypeName>Feature</sld:FeatureTypeName>
    <sld:SemanticTypeIdentifier>generic:geometry</sld:SemanticTypeIdentifier>
    <sld:Rule>
      <sld:Name>30 minuten brandwerende scheiding</sld:Name>
      <sld:Title>30 minuten brandwerende scheiding</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>30 minuten</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MaxScaleDenominator>10000</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">
            <ogc:PropertyName>color1</ogc:PropertyName>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-width">
            <ogc:Literal><ogc:PropertyName>thickness</ogc:PropertyName></ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dasharray"><ogc:PropertyName>pattern</ogc:PropertyName></sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>60 minuten brandwerende scheiding</sld:Name>
      <sld:Title>60 minuten brandwerende scheiding</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>60 minuten</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MaxScaleDenominator>10000</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">
            <ogc:PropertyName>color1</ogc:PropertyName>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-width">
            <ogc:Literal><ogc:PropertyName>thickness</ogc:PropertyName></ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dasharray"><ogc:PropertyName>pattern</ogc:PropertyName></sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>>60 minuten brandwerende scheiding</sld:Name>
      <sld:Title>>60 minuten brandwerende scheiding</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>>60 minuten</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MaxScaleDenominator>10000</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">
            <ogc:PropertyName>color1</ogc:PropertyName>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-width">
            <ogc:Literal><ogc:PropertyName>thickness</ogc:PropertyName></ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dasharray"><ogc:PropertyName>pattern</ogc:PropertyName></sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
    <sld:Rule>
      <sld:Name>Rookwerende scheiding</sld:Name>
      <sld:Title>Rookwerende scheiding</sld:Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Rookwerend</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <sld:MaxScaleDenominator>10000</sld:MaxScaleDenominator>
      <sld:LineSymbolizer>
        <sld:Stroke>
          <sld:CssParameter name="stroke">
            <ogc:PropertyName>color1</ogc:PropertyName>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-width">
            <ogc:Literal><ogc:PropertyName>thickness</ogc:PropertyName></ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </sld:CssParameter>
          <sld:CssParameter name="stroke-dasharray"><ogc:PropertyName>pattern</ogc:PropertyName></sld:CssParameter>
        </sld:Stroke>
      </sld:LineSymbolizer>
    </sld:Rule>
  </sld:FeatureTypeStyle>
</sld:UserStyle>