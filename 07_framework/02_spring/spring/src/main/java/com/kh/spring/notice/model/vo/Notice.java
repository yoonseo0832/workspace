package com.kh.spring.notice.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@NoArgsConstructor					
@Setter	
@ToString
// @Getter|@Setter|@ToString	 => 합쳐진 어노테이션
public class Notice {
	private int noticeNo;
	private String noticeTitle;
	private String noticeWriter;
	private String noticeContent;
	private Date createDate;
	public int getNoticeNo() {
		return noticeNo;
	}
	public String getNoticeTitle() {
		return noticeTitle;
	}
	public String getNoticeWriter() {
		return noticeWriter;
	}
	public String getNoticeContent() {
		return noticeContent;
	}
	public Date getCreateDate() {
		return createDate;
	}
	
	
}
