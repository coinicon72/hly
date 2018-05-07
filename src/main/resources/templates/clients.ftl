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
 </Styles>
 <Worksheet ss:Name="客户">
  <Table ss:ExpandedColumnCount="12" ss:ExpandedRowCount="${clients?size + 1}" x:FullColumns="1"
   x:FullRows="1" ss:DefaultColumnWidth="54" ss:DefaultRowHeight="13.5">
   <Column ss:Width="39"/>
   <Column ss:Index="3" ss:Width="76.5"/>
   <Column ss:Width="83.25"/>
   <Column ss:Width="103.5"/>
   <Column ss:Width="57"/>
   <Column ss:Index="8" ss:Width="69.75"/>
   <Row>
    <Cell><Data ss:Type="String">序号</Data></Cell>
    <Cell><Data ss:Type="String">合同号</Data></Cell>
    <Cell><Data ss:Type="String">名称</Data></Cell>
    <Cell><Data ss:Type="String">全名</Data></Cell>
    <Cell><Data ss:Type="String">类型</Data></Cell>
    <Cell><Data ss:Type="String">结算政策</Data></Cell>
    <Cell><Data ss:Type="String">邮编</Data></Cell>
    <Cell><Data ss:Type="String">地址</Data></Cell>
    <Cell><Data ss:Type="String">发货地址</Data></Cell>
    <Cell><Data ss:Type="String">联系人</Data></Cell>
    <Cell><Data ss:Type="String">联系电话</Data></Cell>
    <Cell><Data ss:Type="String">备注</Data></Cell>
   </Row>
   <#list clients as client>
     <Row>
      <Cell><Data ss:Type="String">${client.id!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.contract_no!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.name!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.full_name!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.type.name!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.settlement_policy!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.post_code!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.address!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.delivery_address!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.contact!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.phone!}</Data></Cell>
      <Cell><Data ss:Type="String">${client.comment!}</Data></Cell>
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
</Workbook>
