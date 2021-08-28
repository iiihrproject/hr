package com.hr.overtime.service.bean;

import java.util.List;

public class PublicReponse {

	private Integer currentPage = null;
	
	private Integer totalPage = null;
	
	private List result = null;

	public Integer getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}

	public Integer getTotalPage() {
		return totalPage;
	}

	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}
	
}
