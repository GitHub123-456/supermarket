package com.infinity.dbconn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

	/**
	 * ���ݿ����Ӳ���
	 * @author INFINITY GROUP
	 *
	 */
	public class DBConn {
		public static Connection conn = null;
		/**
		 * ʵ�����ݿ���ɾ�Ĳ�
		 */
			private static final String driverName="com.microsoft.sqlserver.jdbc.SQLServerDriver";
			private static final String URL      = "jdbc:sqlserver://127.0.0.1:1433;DatabaseName=db_shopping";
			private static final String USERNAME = "sa";
			private static final String PASSWORD = "sa";
			
			public  static Connection getConn(String dbDriver,String dbUrl,String us,String pw){
		       try {
		          Class.forName(dbDriver);
		          conn = DriverManager.getConnection(dbUrl,us,pw);
		     } catch (ClassNotFoundException  e) {
		         e.printStackTrace();
		     }catch(SQLException e1){
		         e1.printStackTrace();
		     }
		     return conn;
			}
		/**
		 * ���ڻ��ִ��SQL����ResultSet����
		 */
		public static ResultSet getResult(String sql) {
			try {
				Connection conn=getConn(driverName, URL, USERNAME, PASSWORD);
				Statement stmt = conn.createStatement();
				ResultSet rs = stmt.executeQuery(sql);
				return rs;
			} catch (Exception e) {
			}
			return null;
		}

		/**
		 * ����ִ��SQL���û�з���ֵ
		 */
		public void doExecute(String sql) {
			try {
				Statement stmt = conn.createStatement();
				stmt.executeQuery(sql);
			} catch (Exception e) {
			}
		}

		/**
		 * ���ڻ��ִ��SQL����PreparedStatement(Ԥ����)����
		 */
		public PreparedStatement getPreparedStatement(String sql) {
			try {
				PreparedStatement pstmt = conn.prepareStatement(sql);
				return pstmt;
			} catch (Exception e) {
			}
			return null;
		}

	}



