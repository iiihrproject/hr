package com.hr.leave.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "ListSetting")
public class ListBean {
	@Id
	@Column(name = "code")
	private String code;
	@Column(name = "category")
	private String category;
	@Column(name = "desc_zh")
	private String desc_zh;

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("ListBean [category=");
		builder.append(category);
		builder.append(", code=");
		builder.append(code);
		builder.append(", desc_zh=");
		builder.append(desc_zh);
		builder.append("]");
		return builder.toString();
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getDesc_zh() {
		return desc_zh;
	}

	public void setDesc_zh(String desc_zh) {
		this.desc_zh = desc_zh;
	}

	public ListBean() {
	}

	public ListBean(String category, String code, String desc_zh) {
		super();
		this.category = category;
		this.code = code;
		this.desc_zh = desc_zh;
	}

}
