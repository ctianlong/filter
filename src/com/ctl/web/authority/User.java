package com.ctl.web.authority;

import java.util.List;

public class User {
	
	private String username;
	private String password;
	private List<Authority> authorities;
	
	public User() {
	}

	public User(String name, List<Authority> authorities) {
		super();
		this.username = name;
		this.authorities = authorities;
	}

	public User(String username, String password, List<Authority> authorities) {
		super();
		this.username = username;
		this.password = password;
		this.authorities = authorities;
	}

	public List<Authority> getAuthorities() {
		return authorities;
	}

	public void setAuthorities(List<Authority> authorities) {
		this.authorities = authorities;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
