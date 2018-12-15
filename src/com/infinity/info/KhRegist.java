package com.infinity.info;

import com.infinity.info.KhinfoBean;
import com.infinity.dbconn.DBConn;
import java.sql.*;

/**!
 * �ͻ��ǼǼ�������Ϣ
 * 2017/12/25/23:45
 * @author Cris_Jay
 *
 */
public class KhRegist {
	private KhinfoBean khinfo;
	DBConn rst = new DBConn();

	public void setKhinfo(KhinfoBean khinfo) {
		this.khinfo = khinfo;
	}

	public void regist() throws Exception {
		String reg = "insert into tb_customer values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
		 String str = "select max(ID) as maxint from tb_customer";
		    ResultSet rs = DBConn.getResult(str);
			String newmax = null;
			while(rs.next()){
				String max = rs.getString("maxint");
				//��ֹû�м�¼ʱ�����쳣
				if (max == null){
					newmax = "0";
				}else{
					newmax = String.valueOf(Integer.parseInt(max) +1);
				}
			}
		try {
			PreparedStatement pstmt = rst.getPreparedStatement(reg);
			// ����һ��Ԥ������䣬Ȼ���������ǵĲ���
		    pstmt.setString(1,newmax);
			pstmt.setString(2, khinfo.getKhqc());
			pstmt.setString(3, khinfo.getKhjc());
			pstmt.setString(4, khinfo.getKhdz());
			pstmt.setString(5, khinfo.getKhyb());
			pstmt.setString(6, khinfo.getKhdh());
			pstmt.setString(7, khinfo.getKhcz());
			pstmt.setString(8, khinfo.getKhlxr());
			pstmt.setString(9, khinfo.getKhlxrdh());
			pstmt.setString(10, khinfo.getKhyx());
			pstmt.setString(11, khinfo.getKhkhyh());
			pstmt.setString(12, khinfo.getKhyhzh());
			pstmt.setString(13, khinfo.getKhhydj());
			// ִ�и��²���
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
