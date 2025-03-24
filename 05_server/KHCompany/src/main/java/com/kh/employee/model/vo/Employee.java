package com.kh.employee.model.vo;

public class Employee {
	private int empId; // 사원번호
	private String empName;	// 사원명
	private String empNo; // 주민번호
	private String email; // 이메일
	private String phone; //전화번호
	
	private String dept; //부서정보(부서코드 또는 부서명)
	private String job; //직급정보(직급코드 또는 직급명)
	
	private int salary; // 월급
	private double bonus; // 보너스
	
	private String manager; //사수정보(사수번호 또는 사수명)
	private String hireDate; //입사일
	private String entDate; //퇴사일
	
	private char entYn; //'Y' 또는 'N'
	
	public Employee() {
		super();
	}
	
	
	public Employee(int empId, String empName, String dept, String job, String hireDate) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.dept = dept;
		this.job = job;
		this.hireDate = hireDate;
	}


	public Employee(int empId, String empName, String empNo, String email, String phone, String dept, String job,
			int salary, double bonus, String manager, String hireDate, String entDate, char entYn) {
		super();
		this.empId = empId;
		this.empName = empName;
		this.empNo = empNo;
		this.email = email;
		this.phone = phone;
		this.dept = dept;
		this.job = job;
		this.salary = salary;
		this.bonus = bonus;
		this.manager = manager;
		this.hireDate = hireDate;
		this.entDate = entDate;
		this.entYn = entYn;
	}


	public int getEmpId() {
		return empId;
	}

	public void setEmpId(int empId) {
		this.empId = empId;
	}

	public String getEmpName() {
		return empName;
	}

	public void setEmpName(String empName) {
		this.empName = empName;
	}

	public String getEmpNo() {
		return empNo;
	}

	public void setEmpNo(String empNo) {
		this.empNo = empNo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getJob() {
		return job;
	}

	public void setJob(String job) {
		this.job = job;
	}

	public int getSalary() {
		return salary;
	}

	public void setSalary(int salary) {
		this.salary = salary;
	}

	public double getBonus() {
		return bonus;
	}

	public void setBonus(double bonus) {
		this.bonus = bonus;
	}

	public String getManager() {
		return manager;
	}

	public void setManager(String manager) {
		this.manager = manager;
	}

	public String getHireDate() {
		return hireDate;
	}

	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}

	public String getEntDate() {
		return entDate;
	}

	public void setEntDate(String entDate) {
		this.entDate = entDate;
	}

	public char getEntYn() {
		return entYn;
	}

	public void setEntYn(char entYn) {
		this.entYn = entYn;
	}


	@Override
	public String toString() {
		return "Employee [empId=" + empId + ", empName=" + empName + ", empNo=" + empNo + ", email=" + email
				+ ", phone=" + phone + ", dept=" + dept + ", job=" + job + ", salary=" + salary + ", bonus=" + bonus
				+ ", manager=" + manager + ", hireDate=" + hireDate + ", entDate=" + entDate + ", entYn=" + entYn + "]";
	}

}

