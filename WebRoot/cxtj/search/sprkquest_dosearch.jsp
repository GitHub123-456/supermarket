<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.io.*,java.sql.*"%>
<jsp:useBean id="rst" scope="page" class="com.infinity.dbconn.DBConn"/>
<jsp:useBean id="qu" scope="page" class="com.infinity.info.QuestString"/>
<jsp:useBean id="trans" scope="page" class="com.infinity.chinese.ToChinese"/>
<html>
  <title>入库信息查询</title>
  <meta charset="UTF-8">
  <link href="../../CSS/style.css" rel="stylesheet" type="text/css">
  <link rel="stylesheet" href="../../layui/css/layui.css " media="all">
  <link href="../../CSS/bootstrap.min.css" rel="stylesheet" type="text/css"/>
  
  <style>
    	body {
		background-image: url(../../images/blank2.jpg); 
		background-size:cover;  
		margin:0;
		}
		.form-control{
			display:inline-block;
			width:40;
		}
		.input-sm{
			height:20px;
			margin-left:5;
			margin-right:5;
		}
		#td1{
		text-align:right;
		}
  </style>
 	
<body>
<%
   request.setCharacterEncoding("UTF-8");
   String table="tb_ruku",httpFile="sprkquest_dosearch.jsp";
   String date="rkdate";
   String pages=request.getParameter("pages");
   String cif=request.getParameter("cif");
   String ccif=request.getParameter("ccif");
   String qvalue = request.getParameter("qvalue");
   //String qvalue=trans.trans(request.getParameter("qvalue"));
   String andor=request.getParameter("andor");
   String sdate=request.getParameter("sdate");//获得表单中查询起始时间
   String edate=request.getParameter("edate");//获得表单中查询截止时间
   qu.setCcif(ccif);qu.setCif(cif);qu.setQValue(qvalue);
   qu.setAndor(andor); qu.setSdate(sdate); qu.setEdate(edate);
   //String strCount=qu.getCount(table);
   //调用Bean中getDateCount()方法来获得在用户调教的时间段里查询到的记录总数
   String strCount=qu.getDateCount(table,date);
   if(pages==null||pages.equals("null")){
     pages="0";
   }
   qu.setQuerySql(httpFile,pages,strCount);
   //用来获得在表tb_sell中在用户提交的时间段里查询到的记录的结果集
   ResultSet rs=rst.getResult((String)qu.getDateString(table,date));
   int i=0,Page=qu.getCurPage(),pagesize=qu.getPageSize();
   while(rs.next()){
     if(i>(Page-1)*pagesize-1){
%>

<table style="width:97% ;margin-left:10;border-width:2;border-color:#666"  class="table table-bordered">
  <tr>
    <td width="202" height="27" bgcolor="#E9F2F6">入库票号:
      <%=rs.getString("ID")%></td>
    <td width="202" bgcolor="#E9F2F6">商品编号:
      <%=rs.getString("spid")%></td>
    <td width="202" bgcolor="#E9F2F6">商品名称：
      <%=rs.getString("spname")%></td>
  </tr>
  <tr>
    <td width="195" height="27" bgcolor="#E9F2F6">简称:
      <%=rs.getString("jc")%></td>
    <td width="202" bgcolor="#E9F2F6">产地:
      <%=rs.getString("cd")%></td>
    <td width="202" bgcolor="#E9F2F6">规格:
      <%=rs.getString("gg")%></td>
  </tr>
  <tr>
    <td width="202" height="29" bgcolor="#E9F2F6">包装:
      <%=rs.getString("bz")%></td>
    <td width="202" bgcolor="#E9F2F6">单价:
      <%=rs.getString("dj")%></td>
    <td width="202" bgcolor="#E9F2F6">数量:
      <%=rs.getString("sl")%></td>
  </tr>
  <tr>
    <td width="202" height="26" bgcolor="#E9F2F6">金额:
      <%=rs.getString("je")%></td>
    <td width="202" bgcolor="#E9F2F6">供应商全称:
      <%=rs.getString("gysname")%></td>
    <td width="202" bgcolor="#E9F2F6">入库日期:
      <%=rs.getString("rkdate").substring(0,10)%></td>
  </tr>
  <tr>
    <td width="202" bgcolor="#E9F2F6">操作员:
      <%=rs.getString("czy")%></td>
    <td width="202" bgcolor="#E9F2F6">经手人:
      <%=rs.getString("jsr")%></td>
    <td width="202" bgcolor="#E9F2F6">结算方式:
      <%=rs.getString("jsfs")%></td>
  </tr>
  <tr>
  	<td width="202" height="26" bgcolor="#E9F2F6">
    </td>
    <td bgcolor="#E9F2F6">
      </td>
    <td width="202" bgcolor="#E9F2F6" id="td1">
    	 <button class="layui-btn layui-btn-sm layui-btn-normal" name="<%=rs.getString("ID")%>" onClick="DeleteData(this)">
    	 	<i class="layui-icon"></i> 删除
    	 </button>
    </td>
  </tr>
</table>
<br>
<%}i++;}
rs.close();
String str_parameter="&cif="+qu.getCif()+"&ccif="+qu.getCcif()+"&qvalue="+qu.getQValue()+
                     "&andor="+qu.getAndor()+"&sdate="+qu.getSdate()+"&edate="+qu.getEdate();
qu.setStr_parameter(str_parameter);
%>
<%=qu.pageFooter()%>
</body>
</html>

<script src="../../layui/layui.js" charset="utf-8"></script>
<script type="text/javascript">
layui.use(['layer', 'form'], function(){
  var layer = layui.layer
  ,form = layui.form;
  
  form.on('select(rkspname)', function(){
 	 form1.submit();
  });    
});

function DeleteData(input){
    var dataid = input.name;
    var DeleteSql = "delete  from tb_ruku where ID = '"+dataid+"'";
    showcheck(DeleteSql);
    
    //alert(DeleteSql);
}



function showcheck(DeleteSql){
	layer.confirm('确定要删除该条记录吗？', {
  	btn: ['确定','取消'] //按钮
	}, function(){
  		window.location.href='../delete/cxdelete.jsp?DeleteSql='+ DeleteSql; 
	}, function(){
  		
	});
}
</script>

















