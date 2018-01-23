<?xml version="1.0" encoding="ISO-8859-1"?>
<StyledLayerDescriptor version="1.0.0" xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc"
xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:gml="http://www.opengis.net/gml"
xsi:schemaLocation="http://www.opengis.net/sld http://schemas.opengis.net/sld/1.0.0/StyledLayerDescriptor.xsd">
  <NamedLayer>
    <Name>symbols</Name>
    <UserStyle>
      <Name>symbols</Name>
      <Title>DBK Preparatieve voorzieningen</Title>
      <Abstract>Symbolen uit de assets/symbols bibliotheek voor preparatieve voorzieningen</Abstract>
      <FeatureTypeStyle>
        <Rule>
          <MaxScaleDenominator>1100</MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" xlink:href="assets/symbols/${symbol}.png"/>
                <Format>image/png</Format>
              </ExternalGraphic>
              <Size>20</Size>
              <Rotation>
                <ogc:Literal>-</ogc:Literal>
                <ogc:PropertyName>rotation</ogc:PropertyName>
              </Rotation>
            </Graphic>
          </PointSymbolizer>
        </Rule>
      </FeatureTypeStyle>
    </UserStyle>
  </NamedLayer>
</StyledLayerDescriptor>