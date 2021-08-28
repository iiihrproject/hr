package com.hr.login.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.hr.login.model.LoginModel;
import com.hr.login.model.SecurityLogin;
import com.hr.login.repository.LoginRepository;
import com.hr.login.service.LoginService;

@Service
public class LoginUserDetailsService implements UserDetailsService {
	
	
	@Autowired
	private LoginService loginService;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		LoginModel loginModel = loginService.getLoginModelByEmpNo(username);
		if (loginModel == null) {
			throw new UsernameNotFoundException("User details not found for the user : " + username);
		}
		return new SecurityLogin(loginModel);
	}

}
