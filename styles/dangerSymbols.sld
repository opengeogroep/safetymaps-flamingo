<sld:UserStyle xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
  <sld:Name>Gevaarlijke stoffen</sld:Name>
  <sld:Title>EU-GHS symbolen</sld:Title>
  <sld:Abstract>Gevaarlijke stoffen gediferentieerd naar EU-GHS classificatie</sld:Abstract>
       <FeatureTypeStyle>
        <Rule>
          <MaxScaleDenominator>1100</MaxScaleDenominator>
          <PointSymbolizer>
            <Graphic>
              <ExternalGraphic>
                <OnlineResource xmlns:xlink="http://www.w3.org/1999/xlink" xlink:type="simple" xlink:href="assets/danger_symbols/${symbol}.png"/>
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
</sld:UserStyle>