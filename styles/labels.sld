<sld:UserStyle xmlns="http://www.opengis.net/sld" xmlns:sld="http://www.opengis.net/sld" xmlns:ogc="http://www.opengis.net/ogc" xmlns:gml="http://www.opengis.net/gml">
  <sld:Name>point</sld:Name>
  <sld:Title>Default point</sld:Title>
  <sld:Abstract>A sample style that just prints out a 6px wide red square</sld:Abstract>
  <sld:FeatureTypeStyle>
    <sld:Name>name</sld:Name>
    <sld:Title>title</sld:Title>
    <sld:Abstract>abstract</sld:Abstract>
    <sld:FeatureTypeName>Feature</sld:FeatureTypeName>
    <sld:SemanticTypeIdentifier>generic:geometry</sld:SemanticTypeIdentifier>
    <sld:Rule>
      <sld:Name>textObject</sld:Name>
      <ogc:Filter>
       <ogc:Not>
         <ogc:PropertyIsNull>
           <ogc:PropertyName>text</ogc:PropertyName>
         </ogc:PropertyIsNull>
       </ogc:Not>
      </ogc:Filter>
      <sld:MaxScaleDenominator>10000</sld:MaxScaleDenominator>
      <sld:TextSymbolizer>
        <sld:Label>
          <ogc:PropertyName>text</ogc:PropertyName>
        </sld:Label>
        <sld:Font>
          <sld:CssParameter name="font-family">
            <ogc:Literal>DejaVu Sans</ogc:Literal>
          </sld:CssParameter>
          <!-- <sld:CssParameter name="font-size">
           <ogc:Function name="parseInt">
              <ogc:PropertyName>LabelSize</ogc:PropertyName>
            </ogc:Function>
          </sld:CssParameter>-->
        </sld:Font>
        <sld:LabelPlacement>
          <sld:PointPlacement>
            <sld:AnchorPoint>
              <sld:AnchorPointX>
                <ogc:Literal>0.5</ogc:Literal>
              </sld:AnchorPointX>
              <sld:AnchorPointY>
                <ogc:Literal>0.5</ogc:Literal>
              </sld:AnchorPointY>
            </sld:AnchorPoint>
            <Rotation>
              <ogc:Sub>
                <ogc:Literal>0.0</ogc:Literal>
                <ogc:PropertyName>rotation</ogc:PropertyName>
              </ogc:Sub>
            </Rotation>
          </sld:PointPlacement>

        </sld:LabelPlacement>
        <sld:Halo>
          <sld:Radius>
            <ogc:Literal>1</ogc:Literal>
          </sld:Radius>
          <sld:Fill>
            <sld:CssParameter name="fill">
              <ogc:Literal>#ffffff</ogc:Literal>
            </sld:CssParameter>
            <sld:CssParameter name="fill-opacity">
              <ogc:Literal>1.0</ogc:Literal>
            </sld:CssParameter>
          </sld:Fill>
        </sld:Halo>
        <!--<Fill>
              <CssParameter name="fill">#000000</CssParameter>
            </Fill>-->
            <!--<Graphic>
              <Mark>
                <WellKnownName>square</WellKnownName>
                <Fill>
                  <CssParameter name="fill">#cccccc</CssParameter>
                </Fill>
                <Stroke>
                  <CssParameter name="stroke">#000000</CssParameter>
                </Stroke>
              </Mark>
              <Size>8</Size>
            </Graphic>-->
            <!--<VendorOption name="graphic-resize">stretch</VendorOption>
            <VendorOption name="graphic-margin">4 4 4 4</VendorOption>-->
      </sld:TextSymbolizer>
    </sld:Rule>
  </sld:FeatureTypeStyle>
</sld:UserStyle>