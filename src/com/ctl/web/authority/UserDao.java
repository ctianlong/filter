package com.ctl.web.authority;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class UserDao {
	
	private static Map<String, User> users = new HashMap<>();
	
	private static List<Authority> authorities = new ArrayList<>();
	
	static{
		authorities.add(new Authority("图片1", "/authority-manager/picture-1.jsp"));
		authorities.add(new Authority("图片2", "/authority-manager/picture-2.jsp"));
		authorities.add(new Authority("图片3", "/authority-manager/picture-3.jsp"));
		authorities.add(new Authority("图片4", "/authority-manager/picture-4.jsp"));
		
		User user1 = new User("管理员", "123456", authorities);
		users.put("管理员", user1);
		
		user1 = new User("游客", "123456", authorities.subList(0, 2));
		users.put("游客", user1);
	}
	
	public User get(String username){
		return users.get(username);
	}
	
	public void update(String username, String password, List<Authority> authorities){
		users.get(username).setPassword(password);
		users.get(username).setAuthorities(authorities);
	}
	
	public List<Authority> getAuthorities() {
		return authorities;
	}

	public List<Authority> getAuthorities(String[] authorityUrls) {
		List<Authority> authorities2 = new ArrayList<>();
		
		if(authorityUrls != null){
			for(Authority authority: authorities){
				for(String url: authorityUrls){
					if(url.equals(authority.getUrl())){
						authorities2.add(authority);
					}
				}
			}
		}
		return authorities2;
	}

	public void add(String username, String password, List<Authority> authorities2) {
		User user = new User(username, password, authorities2);
		users.put(username, user);
	}

	public boolean checkPassword(String username, String password) {
		return password.equals(users.get(username).getPassword());
	}
	
	public boolean checkUser(String username) {
		return users.containsKey(username);
	}

	public void delete(String username) {
		users.remove(username);
	}
	
	public Set<String> getList() {
		return users.keySet();
	}

}
