package com.hr.login.config;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;

@Configuration
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
    private UserDetailsService userDetailsService;
	
	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		logger.info("Login security");
		httpSecurity
		  	.authorizeRequests() // Setting authentic system              
//			    .antMatchers("/login").permitAll() // Pages that allow user to access without authentication
//			    .antMatchers("/index").authenticated()// Except above pages, all pages should require basic authorization after authentication
			    .anyRequest().permitAll()
			    .and()
		    .formLogin()
			    .loginPage("/login").permitAll() // Rewrite the default login page
			    .defaultSuccessUrl("/index") //lead to the default when authentication pass but no specific address
	            .failureUrl("/login").permitAll() // Redirect to login page if authentication
			    .and()
		    .logout()
		    	.logoutSuccessUrl("/login").permitAll()
		    	.and()
		  	.httpBasic();
	 }
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
