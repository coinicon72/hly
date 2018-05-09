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
  <Created>2018-05-05T05:58:41Z</Created>
  <LastSaved>2018-05-05T06:06:21Z</LastSaved>
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
  <Style ss:ID="s74">
   <Interior ss:Color="#DDEBF7" ss:Pattern="Solid"/>
  </Style>
 </Styles>
 <Worksheet ss:Name="订单总览">
  <Table ss:ExpandedColumnCount="9" ss:ExpandedRowCount="${orders?size + 1}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="39"/>
   <Column ss:Index="3" ss:Width="76.5"/>
   <Column ss:Width="83.25"/>
   <Column ss:Width="103.5"/>
   <Column ss:Width="57"/>
   <Column ss:Index="8" ss:Width="69.75"/>
   <Row>
    <Cell><Data ss:Type="String">序号</Data></Cell>
    <Cell><Data ss:Type="String">订单编号</Data></Cell>
    <Cell><Data ss:Type="String">客户</Data></Cell>
    <Cell><Data ss:Type="String">下单时间</Data></Cell>
    <Cell><Data ss:Type="String">发货时间</Data></Cell>
    <Cell><Data ss:Type="String">总额</Data></Cell>
    <Cell><Data ss:Type="String">是否含税</Data></Cell>
    <Cell><Data ss:Type="String">状态</Data></Cell>
    <Cell><Data ss:Type="String">备注</Data></Cell>
   </Row>
   <#list orders as order>
     <Row>
      <Cell><Data ss:Type="String">${order.id!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.no!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.client.name!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.orderDate?string["yyyy-MM-dd"]}</Data></Cell>
      <Cell><Data ss:Type="String">${order.deliveryDate?string["yyyy-MM-dd"]}</Data></Cell>
      <Cell><Data ss:Type="Number">${order.value!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.tax?string('是', '')}</Data></Cell>
      <Cell><Data ss:Type="String"><#compress>
        <#switch order.status>
          <#case 0>
            已签订
            <#break>
          <#case 1>
            执行中
            <#break>
          <#case 2>
            已完成
            <#break>
          <#case 3>
            取消
            <#break>
        </#switch>
        </#compress></Data></Cell>
      <Cell><Data ss:Type="String">${order.comment!}</Data></Cell>
     </Row>
   </#list>
  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Selected/>
   <FreezePanes/>
   <FrozenNoSplit/>
   <SplitHorizontal>1</SplitHorizontal>
   <TopRowBottomPane>1</TopRowBottomPane>
   <ActivePane>2</ActivePane>
   <Panes>
    <Pane>
     <Number>3</Number>
    </Pane>
    <Pane>
     <Number>2</Number>
     <ActiveRow>0</ActiveRow>
     <ActiveCol>8</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>

 <#list orders as order>
 <Worksheet ss:Name="${order.no!}">
  <Table ss:ExpandedColumnCount="8" ss:ExpandedRowCount="${order.items?size + 4}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="63"/>
   <Column ss:Index="3" ss:Width="57" ss:Span="1"/>
   <Column ss:Index="5" ss:Width="31.5"/>
   <Column ss:Index="7" ss:Width="42.75"/>
   <Column ss:Width="31.5"/>
   <Row>
    <Cell ss:StyleID="s74"><Data ss:Type="String">订单编号</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">客户</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">下单时间</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">发货时间</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">总额</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">是否含税</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">状态</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">备注</Data></Cell>
   </Row>
   <Row>
      <Cell><Data ss:Type="String">${order.no!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.client.name!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.orderDate?string["yyyy-MM-dd"]}</Data></Cell>
      <Cell><Data ss:Type="String">${order.deliveryDate?string["yyyy-MM-dd"]}</Data></Cell>
      <Cell><Data ss:Type="Number">${order.value!}</Data></Cell>
      <Cell><Data ss:Type="String">${order.tax?string('是', '')}</Data></Cell>
      <Cell><Data ss:Type="String"><#compress>
        <#switch order.status>
          <#case 0>
            已签订
            <#break>
          <#case 1>
            执行中
            <#break>
          <#case 2>
            已完成
            <#break>
          <#case 3>
            取消
            <#break>
        </#switch>
        </#compress></Data></Cell>
      <Cell><Data ss:Type="String">${order.comment!}</Data></Cell>
   </Row>
   <Row ss:Index="4">
    <Cell ss:StyleID="s74"><Data ss:Type="String">产品编号</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">产品颜色</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">附着材质</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">数量</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">单价</Data></Cell>
    <Cell ss:StyleID="s74"><Data ss:Type="String">小计</Data></Cell>
   </Row>

   <#list order.items as item>
   <Row>
    <Cell><Data ss:Type="String">${item.product.code!}</Data></Cell>
    <Cell><Data ss:Type="String">${item.product.color!}</Data></Cell>
    <Cell><Data ss:Type="String">${item.product.base!}</Data></Cell>
    <Cell><Data ss:Type="Number">${item.quantity}</Data></Cell>
    <Cell><Data ss:Type="Number">${item.price}</Data></Cell>
    <Cell><Data ss:Type="Number">${(item.quantity * item.price)?string["0.##"]}</Data></Cell>
   </Row>
   </#list>

  </Table>
  <WorksheetOptions xmlns="urn:schemas-microsoft-com:office:excel">
   <PageSetup>
    <Header x:Margin="0.3"/>
    <Footer x:Margin="0.3"/>
    <PageMargins x:Bottom="0.75" x:Left="0.7" x:Right="0.7" x:Top="0.75"/>
   </PageSetup>
   <Selected/>
   <Panes>
    <Pane>
     <Number>3</Number>
     <ActiveRow>8</ActiveRow>
     <ActiveCol>5</ActiveCol>
    </Pane>
   </Panes>
   <ProtectObjects>False</ProtectObjects>
   <ProtectScenarios>False</ProtectScenarios>
  </WorksheetOptions>
 </Worksheet>
</#list>
</Workbook>
