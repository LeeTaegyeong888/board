package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	
	public ArrayList<Bbs> getList(int pageNumber) {
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, getNext()- (pageNumber - 1) * 10);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			while (rs.next()) {
				Bbs bbs = new Bbs();
				
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list; 
	}
	
	public int pageTotalNumber() {
		System.out.printf("\n pageTotalNumber START!!!!!!!!!!");
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID"; //bbsID : 게시글 번호
		int count = 1;
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			while(rs.next()) {
				count = rs.getInt(1);
			}
			
			if (count % 10 == 0) {
				count =  count / 10 ;
			} else {
				count =  (count / 10) + 1; 
			}
			System.out.printf("\n count  :: " + count);
			return count;
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; 
	}
	
	public boolean nextPage(int pageNumber) { //page 처리
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ";
		
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
	
	public Bbs getBbs(int bbsID) {
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery(); // 실제로 실행했을때 나오는 결과 가져옴
			if (rs.next()) {
				Bbs bbs = new Bbs();
				
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				
				return bbs;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null; 
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); //실행 준비단계
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();// 실제로 실행했을때 나오는 결과 가져옴
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return -1; // DB 오류
		
	}
}
