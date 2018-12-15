package com.infinity.info;

import java.sql.*;

import com.infinity.dbconn.DBConn;

public class SpRegist
{
  private SpinfoBean spinfo;
  DBConn rst=new DBConn();

  public void setSpinfo(SpinfoBean spinfo)
  {
    this.spinfo=spinfo;
  }

  public void regist() throws Exception
  {
    String sql="insert into tb_brand values(?,?,?,?,?,?,?,?,?,?,?)";
    String str="select max(id) as maxint from tb_brand";
    ResultSet rs=DBConn.getResult(str);
    String newmax=null;
    while(rs.next())
    {
      String max = rs.getString("maxint"); //��������ֶ�
      if(max==null){
    	  newmax = "SP0";
      }else{
      String maxi = max.substring(2, max.length()); //��ȡ���ַ���
      newmax = "SP" + String.valueOf(Integer.parseInt(maxi) + 1);
      }
    }
    try
    {
      PreparedStatement pstmt = rst.getPreparedStatement(sql);
      pstmt.setString(1, newmax);
      pstmt.setString(2, spinfo.getSpname());
      pstmt.setString(3, spinfo.getJc());
      pstmt.setString(4, spinfo.getCd());
      pstmt.setString(5, spinfo.getDw());
      pstmt.setString(6, spinfo.getGg());
      pstmt.setString(7, spinfo.getBz());
      pstmt.setString(8, spinfo.getPh());
      pstmt.setString(9, spinfo.getPzwh());
      pstmt.setString(10, spinfo.getGysname());
      pstmt.setString(11, spinfo.getMemo());
      pstmt.executeUpdate();
    }
    catch (Exception e) {
      e.printStackTrace();
      throw e;
    }
  }
}
