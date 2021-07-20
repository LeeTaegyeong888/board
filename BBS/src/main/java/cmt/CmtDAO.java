package cmt;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class CmtDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public CmtDAO() {
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
	
	public String getDate() { //현재 시간을 가져옴
		
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
		
		String SQL = "SELECT cmtID FROM CMT ORDER BY cmtID DESC";
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
	
	public int write(String userID, String cmtContent, int bbsID) {
		String SQL = "INSERT INTO CMT VALUES (?, ?, ?, ?, ?, ?) ";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, getNext());
			pstmt.setString(2, cmtContent);
			pstmt.setString(3, userID);
			pstmt.setString(4, getDate());
			pstmt.setInt(5, 1);
			pstmt.setInt(6, bbsID);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
		
	}
	
	public ArrayList<Cmt> getList(int bbsID) {
		String SQL = "SELECT * FROM CMT WHERE cmtAvailable = 1 AND bbsID = ? ORDER BY cmtID ASC";
		ArrayList<Cmt> list = new ArrayList<Cmt>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			while (rs.next()) {
				Cmt cmt = new Cmt();
				
				cmt.setCmtID(rs.getInt(1));
				cmt.setCmtContent(rs.getString(2));
				cmt.setUserID(rs.getString(3));
				cmt.setCmtDate(rs.getString(4));
				cmt.setCmtAvailable(rs.getInt(5));
				cmt.setBbsID(rs.getInt(6));
				list.add(cmt);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; 
	}
	
	public boolean nextPage(int pageNumber) { //page 처리
		String SQL = "SELECT * FROM CMT WHERE cmtID < ? AND cmtAvailable = 1 ";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, getNext()- (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			if (rs.next()) {
				return true;
			} else {
				return false;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return false; 
	}
	
	public Cmt getCmt(int bbsID) {
		String SQL = "SELECT * FROM CMT WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			if (rs.next()) {
				Cmt cmt = new Cmt();
				
				cmt.setCmtID(rs.getInt(1));
				cmt.setCmtContent(rs.getString(2));
				cmt.setUserID(rs.getString(3));
				cmt.setCmtDate(rs.getString(4));
				cmt.setCmtAvailable(rs.getInt(5));
				cmt.setBbsID(rs.getInt(6));
				
				return cmt;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null; 
	}
	
	public int updateCmt(int cmtID, String cmtContent, int bbsID) {
		String SQL = "UPDATE CMT SET bbsID = ?, cmtContent = ? WHERE cmtID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, bbsID);
			pstmt.setString(2, cmtContent);
			pstmt.setInt(2, cmtID);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
	}
	
	public int deleteCmt(int cmtID, int bbsID) {
		String SQL = "UPDATE CMT SET cmtAvailable = 0 WHERE cmtID = ? AND bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, cmtID);
			pstmt.setInt(2, bbsID);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
		
	}
	

}
