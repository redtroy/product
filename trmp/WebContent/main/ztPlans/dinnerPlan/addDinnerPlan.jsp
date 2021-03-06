<%@ page language="java" contentType="text/html; charset=GBK"
    pageEncoding="GBK"%>
<%@include file="/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=GBK" />
<script type="text/javascript" src="<%=request.getContextPath() %>/js/common.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jquery/jquery.js"></script>
<link href="<%=request.getContextPath()%>/css/treeAndAllCss.css" rel="stylesheet" type="text/css" />
<script src="<%=request.getContextPath()%>/js/dataXML/prototype.js"></script>
<script src="<%=request.getContextPath()%>/js/dataXML/linkage.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/datepicker/WdatePicker.js"></script>
<title>餐厅计划</title>
<script type="text/javascript">
//输入只能为数字
function checkNum(){
	if(!(event.keyCode==46)&&!(event.keyCode==8)&&!(event.keyCode==37)&&!(event.keyCode==39))
		  if(!((event.keyCode>=48&&event.keyCode<=57)||(event.keyCode>=96&&event.keyCode<=105)))
		    event.returnValue=false;
}

function checkNum1(obj)
{   
	//先把非数字的都替换掉，除了数字和.
	obj.value = obj.value.replace(/[^\d.]/g,"");
	//必须保证第一个为数字而不是.
	obj.value = obj.value.replace(/^\./g,"");
	//保证只有出现一个.而没有多个.
	obj.value = obj.value.replace(/\.{2,}/g,".");
	//保证.只出现一次，而不能出现两次以上
	obj.value = obj.value.replace(".","$#$").replace(/\./g,"").replace("$#$",".");
}
	
	function addDinner(){
		var d=jQuery(".select-dinner").size();
		var num=jQuery(".select-dinner").size();
		if(jQuery("#city"+(num-1)).val()==""){
			alert("请填写完整后再添加");
			return false;
				}
		jQuery("#dinnerDiv").append('<table class="datas select-dinner" width="98%" id="dinner'+num+'"><tr>'+
		'<td colspan="4"><span>餐厅计划</span>&nbsp&nbsp&nbsp<span class="showPointer" onclick="addDinner()">添加</span>&nbsp&nbsp&nbsp <span class="showPointer" onclick="delTab(\'dinner'+num+'\')">删除</span></td></tr>'+
		 '<tr><td colspan="4">餐厅名称：'+
		'<select name="TA_ZT_JHCT/SF['+num+']" id="pro'+num+'" USEDATA="dataSrc'+d+'" SUBCLASS="1"></select>'+
		'<select name="TA_ZT_JHCT/CITYID['+num+']" id="city'+num+'" USEDATA="dataSrc'+d+'" SUBCLASS="2"></select>'+
		'<select name="TA_ZT_JHCT/CT['+num+']" id="ct'+num+'" USEDATA="dataSrc'+d+'" SUBCLASS="3"></select>'+
		'&nbsp;用餐日期:<input type="text" name="TA_ZT_JHCT/YCRQ['+num+']" onFocus="WdatePicker({isShowClear:false,readOnly:true});"/>'+
		'</td></tr>'+
		'<tr  class="none" ><td class="dinnerInfo"><table class="datas" style="text-align: center">'+
		'<tr id="first-tr"><td >早/正 </td><td >价格</td><td >餐数</td><td >人数</td></tr>'+
		'<tr><td>早餐</td><td><input name="TA_ZT_JHCT/ZCJG['+num+']" class="bf_jg" onkeydown="checkNum1(this)" onchange="sumPrice()" /></td>'+
		'<td><input name="TA_ZT_JHCT/ZCCS['+num+']" class="bf_cs" onkeydown="checkNum()" onchange="sumPrice()" /></td>'+
		'<td><input name="TA_ZT_JHCT/ZCRS['+num+']" class="bf_rs" onkeydown="checkNum1(this)" onchange="sumPrice()" />人</td'+
		'</tr><tr><td>正餐</td><td><input name="TA_ZT_JHCT/ZHCJG['+num+']" class="dn_jg"  onkeydown="checkNum1(this)" onchange="sumPrice()" /> </td>'+
		'<td><input name="TA_ZT_JHCT/ZHCCS['+num+']" class="dn_cs"  onkeydown="checkNum()" onchange="sumPrice()" /></td>'+
		'<td><input name="TA_ZT_JHCT/ZHCRS['+num+']" class="dn_rs"  onkeydown="checkNum1(this)" onchange="sumPrice()" />人</td>'+
		'</tr><tr  > <td align="right" colspan="5">'+
		'<font color="red">签单小计：</font><input name="TA_ZT_JHCT/QDXJJE['+num+']" type="text" class="qdxj" value="0" onkeydown="checkNum1(this)"  onchange="sumPrice()"/>/元&nbsp;&nbsp;&nbsp;'+
		'<font color="red">现付小计：</font><input name="TA_ZT_JHCT/XFXJJE['+num+']" type="text" readonly="readonly" class="xfxj" value="0"/>/元&nbsp;&nbsp;&nbsp;'+
		'<font color="red">共计：</font>   <input name="TA_ZT_JHCT/HJ['+num+']" type="text"   readonly="readonly" class="gj" value="0"/>/元'+
		'</td></tr></table></td></tr></table>');
		var linkage = new Linkage("dataSrc"+d, "<%=request.getContextPath()%>/main/data/Dinning-Roomz.xml");
		linkage.init();
		d+=1;

};

function delTab(tab){
	var num=jQuery(".select-dinner").size()-1;
	if(num>0){
		jQuery("#"+tab).remove();
	}
	sumPrice();
}
//delTab(\'dinner'+num+'\')

var hzs=jQuery(".hzszj").val(); //酒店含早餐数
var ts=jQuery(".tszj").val(); //旅游总天数
function sumPrice(){

	jQuery("#dinnerDiv table").each(function(i){
		var bf_jg=jQuery("input.bf_jg:eq("+i+")").val();
		var bf_cs=jQuery("input.bf_cs:eq("+i+")").val();
		var bf_rs=jQuery("input.bf_rs:eq("+i+")").val();
		var dn_jg=jQuery("input.dn_jg:eq("+i+")").val();
		var dn_cs=jQuery("input.dn_cs:eq("+i+")").val();
		var dn_rs=jQuery("input.dn_rs:eq("+i+")").val();
		var tmp=0;
		if((bf_cs-hzs)>0){
			tmp=parseFloat(bf_jg*(bf_cs-hzs)*bf_rs+dn_jg*dn_cs*dn_rs);
		}else{
			tmp=parseFloat(bf_jg*bf_cs*bf_rs+dn_jg*dn_cs*dn_rs);
		}
		var tmp=0;

		if(""==bf_cs){
			jQuery("input.bf_cs:eq("+i+")").val(0);
		}
		if(""==dn_cs){
			jQuery("input.dn_cs:eq("+i+")").val(0);
		}
		if(""==bf_jg){
			jQuery("input.bf_jg:eq("+i+")").val(0);
		}
		if(""==bf_rs){
			jQuery("input.bf_rs:eq("+i+")").val(0);
		}
		if(""==dn_jg){
			jQuery("input.dn_jg:eq("+i+")").val(0);
		}
		if(""==dn_rs){
			jQuery("input.dn_rs:eq("+i+")").val(0);
		}
		
		tmp=parseFloat(bf_jg*bf_cs*bf_rs+dn_jg*dn_cs*dn_rs);
		
		jQuery("input.gj:eq("+i+")").val(tmp);
		var qdxj=jQuery("input.qdxj:eq("+i+")").val();
		if(qdxj>tmp){
			jQuery("input.qdxj:eq("+i+")").val(tmp);
			qdxj=tmp;
			}
		jQuery("input.xfxj:eq("+i+")").val(tmp-qdxj);
		
		var qdzj=0;
		var xfzj=0;
		jQuery(".qdxj").each(function(j){
				var qdxj=this.value;
				var xfxj=jQuery(".xfxj:eq("+j+")").val();
				qdzj+=parseFloat(qdxj);
				xfzj+=parseFloat(xfxj);
			});
		jQuery("#qdzj").val(qdzj);
		jQuery("#xfzj").val(xfzj);
		jQuery("#zj").val(qdzj+xfzj);
		
	});
	
}

function p_editDinner(){	
	var num=jQuery(".select-dinner").size();
	if(jQuery("#city"+(num-1)).val()==""){
		alert("请把信息填写完整");
		return false;
	}
	
	var bftmp=0;
	jQuery(".bf_cs").each(function(i){
		var bf=jQuery(".bf_cs:eq("+i+")").val();
		bftmp+=parseFloat(bf);
	});
	if((parseFloat(bftmp)+parseFloat(hzs)-parseFloat(ts))>0){
		alert("早餐数超出");
		return false;
	}
	
	document.p_dinnerplan_form.action="ztAddDinnerPlan.?";
	document.p_dinnerplan_form.submit();
	reload();
}

function reload(){
	parent.parent.location.reload(); 
	parent.parent.GB_hide(); 
}
</script>
</head>

<body>
<form name="p_dinnerplan_form" method="post">
<input type="hidden" value="<%=rd.getStringByDI("jhHzs","hzs",0)%>" class="hzszj" />
<input type="hidden" value="<%=rd.getStringByDI("TA_ZT_GROUPs","DAYS",0)%>" class="tszj" />
<div id="lable"><span >餐厅计划</span>
			<%
				String hzs=rd.getStringByDI("jhHzs","hzs",0);
				String ts=rd.getStringByDI("TA_ZT_GROUPs","DAYS",0);
				if("".equals(hzs)){hzs="0";}
				if(0<Integer.parseInt(hzs)){
			%>
			(<span style="color:red; font-weight:100;text-decoration:underline" class="showPointer" title="修改酒店计划信息">
			 <a style="color:red;" href="<%=request.getContextPath()%>/main/ztPlans/hotelPlan/ztReturnInitUpdateHotelPlan.?TA_ZT_GROUP/ID=<%=rd.getStringByDI("dinnerPlanList","TID",0) %>&TA_ZT_JHHOTEL/TID=<%=rd.getString("TID") %>&TA_TDJDXXZJB_ZT/TID=<%=rd.getString("TID") %>&TID=<%=rd.getString("TID") %>&DAYS=<%=ts%>">酒店已含早餐<%=hzs %>餐(总天数<%=ts %>)  点击查看详情</a></span>)
			<%} %>
</div>
<input type="hidden" name="TA_ZT_JHCT/TID[0]" value="<%=rd.getString("TID")%>">
<div id="bm-table">
<div id="dinnerDiv">
		<table class="datas select-dinner" width="98%" id="dinner0">
		  <tr>
			<td colspan="4"><span>餐厅计划</span>
			&nbsp;&nbsp;&nbsp;<span class="showPointer" onclick="addDinner()">添加</span></td>
		  </tr>
		  <tr>
			<td colspan="4">
		
				餐厅名称：
			  <select name="TA_ZT_JHCT/SF[0]" id="pro0" USEDATA="dataSrc0" SUBCLASS="1"></select>
			  <select name="TA_ZT_JHCT/CITYID[0]" id="city0" USEDATA="dataSrc0" SUBCLASS="2"></select>
			  <select name="TA_ZT_JHCT/CT[0]" id="ct0" USEDATA="dataSrc0" SUBCLASS="3"></select>
			  &nbsp;用餐日期:
			  <input type="text" name="TA_ZT_JHCT/YCRQ[0]" onFocus="WdatePicker({isShowClear:false,readOnly:true});"/>
			</td>
		
		  </tr>
		  <tr  class="none" >
		  <td class="dinnerInfo">
		  			<table class="datas" style="text-align: center">
					<tr id="first-tr">
						<td >早/正 </td>
						<td >价格</td>
						<td >餐数</td>
						<td >人数</td>
					</tr>
					<tr>
						<td>早餐</td>
						<td><input name="TA_ZT_JHCT/ZCJG[0]" class="bf_jg" onkeydown="checkNum1(this)" onchange="sumPrice()" value="0"/></td>
						<td><input name="TA_ZT_JHCT/ZCCS[0]" class="bf_cs" onkeydown="checkNum()" onchange="sumPrice()" value="0" /></td>
						<td><input name="TA_ZT_JHCT/ZCRS[0]" class="bf_rs" onkeydown="checkNum1(this)" onchange="sumPrice()" value="0" />人</td>
		
					</tr>
					<tr>
						<td>正餐</td>
						<td><input name="TA_ZT_JHCT/ZHCJG[0]" class="dn_jg"  onkeydown="checkNum1(this)" onchange="sumPrice()" value="0" /> </td>
						<td><input name="TA_ZT_JHCT/ZHCCS[0]" class="dn_cs"  onkeydown="checkNum()" onchange="sumPrice()" value="0" /></td>
						<td><input name="TA_ZT_JHCT/ZHCRS[0]" class="dn_rs"  onkeydown="checkNum1(this)" onchange="sumPrice()" value="0" />人</td>
					</tr>
		
					<tr  > 
						<td align="right" colspan="5">
						<font color="red">签单小计：</font><input name="TA_ZT_JHCT/QDXJJE[0]" type="text" class="qdxj" value="0" onkeydown="checkNum1(this)" onchange="sumPrice()"/>/元&nbsp;&nbsp;&nbsp;
						<font color="red">现付小计：</font><input name="TA_ZT_JHCT/XFXJJE[0]" type="text" readonly="readonly" class="xfxj" value="0"/>/元&nbsp;&nbsp;&nbsp;
						<font color="red">共计：</font>   <input name="TA_ZT_JHCT/HJ[0]" type="text"   readonly="readonly" class="gj" value="0"/>/元
						</td>
					</tr>
					</table>
					</td>
					</tr>
		</table>
</div> 

<table class="datas" style="margin-top: 3px;">
  <tr>
	<td><span>费用合计</span></td>
  </tr>
  <tr>

	<td align="right">
	  <font color="red">签单金额总计：</font>
	  <input type="text" name="TA_TDJDXXZJB_ZT/QDCTZJ" id="qdzj" readonly="readonly" value="0" class="smallInput1"/>/元&nbsp;&nbsp;&nbsp; 
	  <font color="red">现付金额总计：</font>
	  <input type="text" name="TA_TDJDXXZJB_ZT/XFCTZJ" id="xfzj" readonly="readonly" value="0"  class="smallInput1"/>/元&nbsp;&nbsp;&nbsp; 
	  <font color="red">总计：</font>
	  <input type="text" name="TA_TDJDXXZJB_ZT/CTZJ" id="zj" readonly="readonly" value="0" class="smallInput1" />/元</td>

  </tr>
</table>
</div>
<div align="center" id="last-sub">
	<input type="hidden" name="TA_ZT_JHCT/JHZT" value="Y"/>
	<input type="hidden" name="TA_ZT_JHCT/ZDR" value="<%=sd.getString("userno") %>"/>
	<input type="button" id="button" value="提交" onclick="p_editDinner();"/>
	<input type="button" id="button" value="关闭" onclick="javascript:window.parent.parent.GB_hide();"/>
</div>
</form>
</body>
</html>
<script type="text/javascript">
	var linkage = new Linkage("dataSrc0", "<%=request.getContextPath()%>/main/data/Dinning-Roomz.xml");
	linkage.init();
</script>
