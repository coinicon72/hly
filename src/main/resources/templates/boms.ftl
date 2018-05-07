<?xml version="1.0"?>
<?mso-application progid="Excel.Sheet"?>
<Workbook xmlns="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:o="urn:schemas-microsoft-com:office:office"
 xmlns:x="urn:schemas-microsoft-com:office:excel"
 xmlns:ss="urn:schemas-microsoft-com:office:spreadsheet"
 xmlns:html="http://www.w3.org/TR/REC-html40">
 <DocumentProperties xmlns="urn:schemas-microsoft-com:office:office">
  <Author>Chun Cao</Author>
  <LastAuthor>Chun Cao</LastAuthor>
  <LastPrinted>2018-05-07T14:22:47Z</LastPrinted>
  <Created>2018-05-07T14:07:08Z</Created>
  <Company>Microsoft</Company>
  <Version>15.00</Version>
 </DocumentProperties>
 <OfficeDocumentSettings xmlns="urn:schemas-microsoft-com:office:office">
  <AllowPNG/>
 </OfficeDocumentSettings>
 <ExcelWorkbook xmlns="urn:schemas-microsoft-com:office:excel">
  <WindowHeight>11985</WindowHeight>
  <WindowWidth>25200</WindowWidth>
  <WindowTopX>0</WindowTopX>
  <WindowTopY>0</WindowTopY>
  <ProtectStructure>False</ProtectStructure>
  <ProtectWindows>False</ProtectWindows>
 </ExcelWorkbook>
 <Styles>
  <Style ss:ID="Default" ss:Name="Normal">
   <Alignment ss:Vertical="Center"/>
   <Borders/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="11" ss:Color="#000000"/>
   <Interior/>
   <NumberFormat/>
   <Protection/>
  </Style>
  <Style ss:ID="s62">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
  </Style>
  <Style ss:ID="s65">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s66">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s67">
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s68">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:VerticalText="1"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s69">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
  <Style ss:ID="s83">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Left" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Right" ss:LineStyle="Continuous" ss:Weight="1"/>
    <Border ss:Position="Top" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
   <NumberFormat ss:Format="Short Date"/>
  </Style>
  <Style ss:ID="s86">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center" ss:WrapText="1"/>
   <Font ss:FontName="宋体" x:CharSet="134" ss:Size="16" ss:Color="#000000"/>
  </Style>
  <Style ss:ID="s89">
   <Alignment ss:Horizontal="Center" ss:Vertical="Center"/>
   <Borders>
    <Border ss:Position="Bottom" ss:LineStyle="Continuous" ss:Weight="1"/>
   </Borders>
  </Style>
 </Styles>
 <#list boms as bom>
 <Worksheet ss:Name="${bom.orderItem.order.no} - ${bom.formula.product.code}">
  <Table ss:ExpandedColumnCount="9" ss:ExpandedRowCount="32" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Row ss:AutoFitHeight="0" ss:Height="49.5">
    <Cell ss:MergeAcross="8" ss:StyleID="s86"><Data ss:Type="String">华丽雅粉末科技有限公司&#10;生产物料单</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s67"/>
    <Cell><Data ss:Type="String">生产线</Data></Cell>
    <Cell ss:Index="7"><Data ss:Type="String">订单号No:</Data></Cell>
    <Cell ss:MergeAcross="1" ss:StyleID="s89"><Data ss:Type="String">${bom.orderItem.order.no}</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="10.5"/>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s69"><Data ss:Type="String">客户</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">${bom.orderItem.order.client.name}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">下单日期</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">${bom.orderItem.order.orderDate?date}</Data></Cell>
    <Cell ss:MergeDown="3" ss:StyleID="s68"><Data ss:Type="String">生产条件</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">混合时间</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.mixTime}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">主磨转速</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.mainMillerRpm}</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s69"><Data ss:Type="String">产品型号</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">${bom.formula.product.code}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">出货日期</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">${bom.orderItem.order.deliveryDate?date}</Data></Cell>
    <Cell ss:Index="6" ss:StyleID="s69"><Data ss:Type="String">进料挤温</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.inputTemperature}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">副磨转速</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.secondMillerRpm}</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s69"><Data ss:Type="String">颜色</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">${bom.formula.product.color}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">成品率</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:Index="6" ss:StyleID="s69"><Data ss:Type="String">出料挤温</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.outputTemperature}</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">螺杆转速</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.screwRpm}</Data></Cell>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s69"><Data ss:Type="String">库存</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
    <Cell ss:Index="6" ss:StyleID="s69"><Data ss:Type="String">筛网目数</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="Number">${bom.formula.produceCondition.mesh}</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s69"><Data ss:Type="String">序号</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">材料名称</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">编号</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">数量</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">修改</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">修改</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">修改</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">修改</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">总量</Data></Cell>
   </Row>

   <#list bom.items as item>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s65"><Data ss:Type="Number">${item?index + 1}</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">${item.material.name}</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="String">${item.material.code}</Data></Cell>
    <Cell ss:StyleID="s65"><Data ss:Type="Number">${item.quantity}</Data></Cell>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
   </Row>
   </#list>

   <#list bom.items?size + 1 .. 20 as i>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:StyleID="s65"><Data ss:Type="Number">${i}</Data></Cell>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
    <Cell ss:StyleID="s65"/>
   </Row>
   </#list>

   <Row ss:AutoFitHeight="0" ss:Height="30">
    <Cell ss:MergeDown="1" ss:StyleID="s66"><Data ss:Type="String">检测项目</Data></Cell>
    <Cell ss:StyleID="s69"><Data ss:Type="String">颜色</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">外观</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">光泽</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">硬度</Data></Cell>
    <Cell ss:StyleID="s69"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="30">
    <Cell ss:Index="2" ss:StyleID="s69"><Data ss:Type="String">弯曲</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">正冲</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">反冲</Data></Cell>
    <Cell ss:StyleID="s69"/>
    <Cell ss:StyleID="s69"><Data ss:Type="String">附着力</Data></Cell>
    <Cell ss:StyleID="s69"/>
   </Row>
   <Row ss:AutoFitHeight="0" ss:Height="11.25"/>
   <Row ss:AutoFitHeight="0" ss:Height="21.75">
    <Cell ss:Index="7" ss:StyleID="s62"><Data ss:Type="String">负责人</Data></Cell>
    <Cell ss:StyleID="s67"/>
    <Cell ss:StyleID="s67"/>
   </Row>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Print>
    <ValidPrinterInfo/>
    <PaperSizeIndex>9</PaperSizeIndex>
    <HorizontalResolution>600</HorizontalResolution>
    <VerticalResolution>600</VerticalResolution>
   </Print>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>5</ActiveRow>
     <ActiveCol>8</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
 </#list>
</Workbook>
