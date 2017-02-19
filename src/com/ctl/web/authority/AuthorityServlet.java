package com.ctl.web.authority;

import java.io.IOException;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("*.do")
public class AuthorityServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private UserDao userDao = new UserDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String servletPath = request.getServletPath();
		
		String methodName = servletPath.substring(1, servletPath.length() - 3);
		try {
			Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void get(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		
		if(!userDao.checkUser(username)){
			request.setAttribute("notExist", "1");
		} else {
			request.setAttribute("user", userDao.get(username));			
		}
		request.setAttribute("queryOne", "1");
		request.setAttribute("authorities", userDao.getAuthorities());
		request.getRequestDispatcher("/authority-manager/authority-manager.jsp").forward(request, response);
	}
	
	private void update(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String[] authorityUrls = request.getParameterValues("authority");
		List<Authority> authorities = userDao.getAuthorities(authorityUrls);
		String password = request.getParameter("password");
		
		userDao.update(username, password, authorities);
		//response.sendRedirect(request.getContextPath() + "/authority-manager/authority-manager.jsp");
		
		//username = new String(username.getBytes("UTF-8"),"iso-8859-1");
		//response.sendRedirect(request.getContextPath() + "/get.do?username=" + username);
		
		request.setAttribute("updateOK", "1");
		request.getRequestDispatcher("/get.do").forward(request, response);
		
		//this.get(request, response);
	}
	
	private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		String[] authorityUrls = request.getParameterValues("authority");
		List<Authority> authorities = userDao.getAuthorities(authorityUrls);
		String password = request.getParameter("password");
		
		userDao.add(username, password, authorities);
		//response.sendRedirect(request.getContextPath() + "/authority-manager/authority-manager.jsp");
		
		request.setAttribute("addOK", "1");
		request.getRequestDispatcher("/get.do").forward(request, response);
	}
	
	private void delete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("username");
		
		userDao.delete(username);
		request.setAttribute("deleteOK", "1");
		request.getRequestDispatcher("/authority-manager/authority-manager.jsp").forward(request, response);
	}
	
	private void getAll(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Set<String> usernameList = userDao.getList();
		
		request.setAttribute("usernameList", usernameList);
		request.setAttribute("queryAll", "1");
		request.getRequestDispatcher("/authority-manager/authority-manager.jsp").forward(request, response);
	}

}
