package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BbsDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public BbsDAO() {
		System.out.printf("DAO START!!!!!!!!!!");
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getDate() { //현재 시간을 가져
		
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			if ( rs.next()) {
				return rs.getString(1); // 현재 날짜를 그대로 반환할 수 있게..
			} 
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return "";
	}
	
	
	public int getNext() { 
		
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			if ( rs.next()) {
				return rs.getInt(1) + 1; // 그다음 게시글의 번호
			} 
			
			return 1; // 첫 번째 게시글인 경우
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		
		String SQL = "INSERT INTO BBS VALUES (?, ?, ?, ?, ?, ?) ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, getNext());
			pstmt.setString(2, bbsTitle);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
		
	}
	
}
