package cmt;

public class Cmt {
	
	private int cmtID;
	private String cmtContent;
	private String userID;
	private String cmtDate;
	private int cmtAvailable;
	private int bbsID;
	
	
	public int getBbsID() {
		return bbsID;
	}
	public void setBbsID(int bbsID) {
		this.bbsID = bbsID;
	}
	public int getCmtID() {
		return cmtID;
	}
	public void setCmtID(int cmtID) {
		this.cmtID = cmtID;
	}
	public String getCmtContent() {
		return cmtContent;
	}
	public void setCmtContent(String cmtContent) {
		this.cmtContent = cmtContent;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getCmtDate() {
		return cmtDate;
	}
	public void setCmtDate(String cmtDate) {
		this.cmtDate = cmtDate;
	}
	public int getCmtAvailable() {
		return cmtAvailable;
	}
	public void setCmtAvailable(int cmtAvailable) {
		this.cmtAvailable = cmtAvailable;
	}

	


}
