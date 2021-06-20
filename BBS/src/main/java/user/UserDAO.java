package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
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
	
	public int login(String userID, String userPassword) {
		System.out.printf("DAO login START!!!!!!!!!!");
		String SQL = "SELECT userPassword From USER WHERE userID = ?";
		try {
			System.out.printf("DAO login SUCCESS!!!!!!!!!!");
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPassword)) {
					System.out.printf("login success!!!!!!!!!!");
					return 1; // 로그인 성공~
				} else {
					System.out.printf("password wrong!!!!!!!!!!");
					return 0; // 님 비번 틀림
				}
			} 
			return -1; // ID 없음
		} catch (Exception e) {
			System.out.printf("ERROR!!!!!!!!!!");
			e.printStackTrace();
		}
		return -2; // DB 오류
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO USER VALUES (?, ?, ?, ?, ?)";
		try {
			System.out.printf("\n DAO JOIN SUCCESS!!!!!!!!!!\n");
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			
			return pstmt.executeUpdate(); // insert 문장 ? 채운값 결과값 리턴 해당 부분이 성공하면 0 이상의 결과값 리턴 
		} catch (Exception e) {
			System.out.printf("\n DAO JOIN ERROR!!!!!!!!!!");
			e.printStackTrace();
		}
		return -1; // join 실패 
	}
	
}
