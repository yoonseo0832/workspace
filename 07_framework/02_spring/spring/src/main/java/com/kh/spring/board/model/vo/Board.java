package com.kh.spring.board.model.vo;

import java.sql.Date;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.Setter;
@Data
@NoArgsConstructor
public class Board {
	private int boardNo;
	private String boardTitle;
	private String boardWriter;
	private String boardContent;
	private String originName;
	private String changeName;
	private int count;
	private Date createDate;
	private String status;
}
