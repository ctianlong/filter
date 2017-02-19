package com.ctl.web.authority;

import java.io.IOException;
import java.lang.reflect.Method;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;

	private UserDao userDao = new UserDao();
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String methodName = request.getParameter("method");
		
		try {
			Method method = getClass().getDeclaredMethod(methodName, HttpServletRequest.class, HttpServletResponse.class);
			method.invoke(this, request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	private void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 获取 name
		String name = request.getParameter("name");
		String password = request.getParameter("password");
		
		//2. 调用 UserDao 获取用户信息, 把用户信息放入到 HttpSession 中
		
		if(!userDao.checkUser(name)){
			request.setAttribute("notExist", "1");
			request.getRequestDispatcher("/authority-manager/login.jsp").forward(request, response);
			return;
		}
		
		if(!userDao.checkPassword(name, password)){
			request.setAttribute("passwordWrong", "1");
			request.getRequestDispatcher("/authority-manager/login.jsp").forward(request, response);
			return;
		}
		
		User user = userDao.get(name);
		request.getSession().setAttribute("user", user);
		
		//3. 重定向到 articles.jsp
		response.sendRedirect(request.getContextPath() + "/authority-manager/pictures.jsp");
	}
	
	private void logout(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//1. 获取 HttpSession
		HttpSession session = request.getSession();
		
		if(session.getAttribute("user") == null){
			response.sendRedirect(request.getContextPath() + "/authority-manager/login.jsp");
		}else{
			//2. 使 HttpSession 失效
			session.invalidate();
			//3. 重定向到 /loign.jsp
			response.sendRedirect(request.getContextPath() + "/authority-manager/logout.jsp");
		}
	
	}
	

}
