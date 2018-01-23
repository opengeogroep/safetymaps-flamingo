<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>customPolygon</Name>
    <UserStyle>
      <Name>customPolygon</Name>
      <Title>customPolygon</Title>
      <Abstract></Abstract>
      <FeatureTypeStyle>
        <Rule>
          <Title>customPolygon</Title>
          <MinScaleDenominator>500</MinScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill"><ogc:PropertyName>color</ogc:PropertyName></CssParameter>
              <CssParameter name="fill-opacity"><ogc:PropertyName>opacity</ogc:PropertyName></CssParameter>
            </Fill>
           <Stroke>
           <CssParameter name="stroke"><ogc:PropertyName>color</ogc:PropertyName></CssParameter>
           <CssParameter name="stroke-width">1</CssParameter>
           <CssParameter name="stroke-opacity">0.7</CssParameter>
         </Stroke>
          </PolygonSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>