package model.vo;

public class Member {
	private int userNo;
	private String name;
	private String userId;
	private String address;
	
	public Member() {}

	public Member(int userNo, String name, String userId, String address) {
		super();
		this.userNo = userNo;
		this.name = name;
		this.userId = userId;
		this.address = address;
	}

	public int getUserNo() {
		return userNo;
	}

	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "Member [userNo=" + userNo + ", name=" + name + ", userId=" + userId + ", address=" + address + "]";
	}
}
