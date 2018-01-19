<?xml version="1.0" encoding="UTF-8"?>
<UserStyle xmlns="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
  <Name>Hulplijn</Name>
  <Title>Hulplijnen</Title>
  <Abstract>Hulplijnen om labels te koppelen aan weergave</Abstract>
  <FeatureTypeStyle>
    <Rule>
      <Name>Pijl</Name>
      <Title>Pijl</Title>
      <Abstract>A 1 pixel wide blue line</Abstract>
      <ogc:Filter> 
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Arrow</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#040404</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-opacity">
            <ogc:Literal>0.8</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>0.8</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <PointSymbolizer>
        <Geometry>
          <ogc:Function name="endPoint">
            <ogc:PropertyName>line</ogc:PropertyName>
          </ogc:Function>
        </Geometry>
        <Graphic>
          <Mark>
            <WellKnownName>shape://carrow</WellKnownName>
            <Fill>
              <CssParameter name="fill">#040404</CssParameter>
            </Fill>
            
            <Stroke>
              <CssParameter name="stroke-width">1</CssParameter>
              <CssParameter name="stroke">#040404</CssParameter>
            </Stroke>
          </Mark>
          <Size>14</Size>
          <Rotation>
            <ogc:Function name="endAngle">
              <ogc:PropertyName>line</ogc:PropertyName>
            </ogc:Function>
          </Rotation>
        </Graphic>
      </PointSymbolizer>
    </Rule>
    
    <Rule>
      <Name>Hek</Name>
      <Title>Hek</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Fence</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#000000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>5</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>1.0 20.0</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#000000</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Gewone hulplijn</Name>
      <Title>Gewone hulplijn</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Line</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#000000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Gebroken lijn</Name>
      <Title>Gebroken lijn</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Broken</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#000000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>1</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dashoffset">
            <ogc:Literal>0</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">4.0 4.0 </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Hitte contour</Name>
      <Title>Hitte contour</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>HEAT</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF0000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linecap">
            <ogc:Literal>butt</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-linejoin">
            <ogc:Literal>miter</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-opacity">
            <ogc:Literal>1</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Kabel</Name>
      <Title>Kabel</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Cable</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke-width">
            <ogc:Literal>4</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FFFF00</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>12.0 12.0</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Leiding</Name>
      <Title>Leiding</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Conduit</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF00FF</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>10</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>1.0 20.0</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF00FF</ogc:Literal>
          </CssParameter>
          
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Slagboom</Name>
      <Title>Slagboom</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Bbarrier</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF0000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>4</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FFFFFF</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>12.0 12.0</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Afsluitbaar hek</Name>
      <Title>Afsluitbaar hek</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Gate</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke-width">
            <ogc:Literal>7</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FFFFFF</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>3</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#000000</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>1.0 25.0</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>12</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
    <Rule>
      <Name>Kabel</Name>
      <Title>Kabel</Title>
      <ogc:Filter>
        <ogc:PropertyIsEqualTo>
          <ogc:PropertyName>code</ogc:PropertyName>
          <ogc:Literal>Fence_O</ogc:Literal>
        </ogc:PropertyIsEqualTo>
      </ogc:Filter>
      <MaxScaleDenominator>10000</MaxScaleDenominator>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF9900</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>10</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-dasharray">
            <ogc:Literal>1.0 20.0</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
      <LineSymbolizer>
        <Stroke>
          <CssParameter name="stroke">
            <ogc:Literal>#FF9900</ogc:Literal>
          </CssParameter>
          <CssParameter name="stroke-width">
            <ogc:Literal>2</ogc:Literal>
          </CssParameter>
        </Stroke>
      </LineSymbolizer>
    </Rule>
  </FeatureTypeStyle>
</UserStyle>