package Comment;

import java.sql.Timestamp;

public class CommentBean {
	String id;
	String content;
	int likecount;
	private Timestamp date;
	int num;
	int pnumber;
	
	//getter setter
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getLikecount() {
		return likecount;
	}
	public void setLikecount(int likecount) {
		this.likecount = likecount;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getPnumber() {
		return pnumber;
	}
	public void setPnumber(int pnum) {
		this.pnumber = pnum;
	}
	
	
	
}
