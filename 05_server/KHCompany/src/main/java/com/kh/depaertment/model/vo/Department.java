package com.kh.depaertment.model.vo;

public class Department {
	private String empName;
	private String deptId;
	private String deptTitle;
	private String locationId;
	private String nationalName;
	
	public Department() {
		super();
	}

	public Department(String empName, String deptId, String deptTitle, String locationId, String nationalName) {
		super();
		this.empName = empName;
		this.deptId = deptId;
		this.deptTitle = deptTitle;
		this.locationId = locationId;
		this.nationalName = nationalName;
	}



	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public String getDeptTitle() {
		return deptTitle;
	}

	public void setDeptTitle(String deptTitle) {
		this.deptTitle = deptTitle;
	}

	public String getLocationId() {
		return locationId;
	}

	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}

	@Override
	public String toString() {
		return "Department [empName=" + empName + ", deptId=" + deptId + ", deptTitle=" + deptTitle + ", locationId="
				+ locationId + ", nationalName=" + nationalName + "]";
	}

	
}
