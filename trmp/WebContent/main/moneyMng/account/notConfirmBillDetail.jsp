<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@include file="/common.jsp" %>

<div >
	<table style="width:100%">
		<tr id="first-tr">
				<td align="center" width="20%">Ӫҵ������</td>
				<td align="center" width="11%">������</td>
				<td align="center" width="9%">�ο�����</td>
				<td align="center" width="35%">�۸�����  - ����  - ���� - �ϼ�</td>
				<td align="center" width="25%">����</td>
		</tr>
<%
int yRows = rd.getTableRowsCount("rsCwdzYkorderInfo");
for(int i = 0; i < yRows; i++){
	String DDH = rd.getStringByDI("rsCwdzYkorderInfo", "ID", i);
%>

		<tr>
			<td align="center"><%=rd.getStringByDI("rsCwdzYkorderInfo", "cmpny_name", i) %></td>
			<td align="center"><%=rd.getStringByDI("rsCwdzYkorderInfo", "ID", i) %></td>
			<td align="center"><%=rd.getStringByDI("rsCwdzYkorderInfo", "visitor_nm", i) %></td>
			<td align="center">
				<div>
					<%
					int pRows = rd.getTableRowsCount("rsCwdzPriceInfo");
					for(int j = 0; j < pRows; j++){
						String orderId = rd.getStringByDI("rsCwdzPriceInfo", "orderId", j);
						String personCount = rd.getStringByDI("rsCwdzPriceInfo", "person_count", j);
						if(orderId.equals(DDH)){
						%>
						
							<%=rd.getStringByDI("rsCwdzPriceInfo", "dmsm1", j) %>-
							<%=personCount %>��-
							<font color="red"><%=rd.getStringByDI("rsCwdzPriceInfo", "price_th", j) %></font>Ԫ-
							<font color="red"><%=rd.getStringByDI("rsCwdzPriceInfo", "hj", j) %></font>Ԫ<br>
							
						<%
						}
					}
					%>
				</div>
			</td>
			<td align="center">
         		<input type="button" value="�ύ" onclick="submitBill('<%=DDH %>');" />
			</td>
		</tr>
	
<%}%>
	</table>
</div>