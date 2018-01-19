<?xml version="1.0" encoding="UTF-8"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
  xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>PandGeometrie</Name>
    <UserStyle>
      <Name>PandGeometrie</Name>
      <Title>PandGeometrie</Title>
      <Abstract></Abstract>
      <FeatureTypeStyle>
        <Rule>
          <Title>PandGeometrie - BRT</Title>
          <MinScaleDenominator>500</MinScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#66FF66</CssParameter>
              <CssParameter name="fill-opacity">0.2</CssParameter>
            </Fill>
           <Stroke>
           <CssParameter name="stroke">#66FF66</CssParameter>
           <CssParameter name="stroke-width">1</CssParameter>
           <CssParameter name="stroke-opacity">0.7</CssParameter>
         </Stroke>
          </PolygonSymbolizer>
        </Rule>
        <Rule>
          <Title>PandGeometrie - Luchtfoto</Title>
          <MinScaleDenominator>0</MinScaleDenominator>
          <MaxScaleDenominator>500</MaxScaleDenominator>
          <PolygonSymbolizer>
            <Fill>
              <CssParameter name="fill">#66FF66</CssParameter>
              <CssParameter name="fill-opacity">0.1</CssParameter>
            </Fill>
            <Stroke>
           <CssParameter name="stroke">#66FF66</CssParameter>
           <CssParameter name="stroke-width">0.7</CssParameter>
         </Stroke>
          </PolygonSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>