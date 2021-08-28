package com.hr.login.config;

import java.util.List;

import javax.sql.DataSource;

import org.slf4j.Logger;

import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hr.login.model.LoginModel;
import com.hr.login.service.LoginService;

@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter{
	
//	@Autowired
//    private LoginUserDetailsService loginUserDetailsService;
//	
//	@Autowired
//	private LoginAuthenticationProvider loginAuthenticationProvider;
	
	@Override
	protected void configure(HttpSecurity httpSecurity) throws Exception {
		httpSecurity
			.csrf()
				//.ignoringAntMatchers("/contact")
				//.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
				.disable()
				//.and()
		  	.authorizeRequests() // Setting authentic system              
//			    .antMatchers("/login").permitAll() // Pages that allow user to access without authentication
			    .antMatchers("/index").authenticated() // Except above pages, all pages should require basic authorization after authentication
			    .antMatchers("/checkInto").authenticated() // == .antMatchers("/personnel").hasAnyRole("GENERAL", "HR", "ADMIN, "MANAGER)
			    .antMatchers("/").authenticated()
			    .antMatchers("/editPersonalInfo").authenticated()
			    .antMatchers("/personnel").authenticated()
			    .antMatchers("/authorization", "/authorizationSeaching", "/department", "/departmentDetail", "/departmentManagerIdUpdate").hasRole("ADMIN")
			    .antMatchers("/test").permitAll()
			    .antMatchers("/bulletinList","/bulletinDetail","/insertMessage","/bulletinGetMsg").authenticated()
			    .antMatchers("/bulletinManage","/bulletinListMag","/bulletinEventInsert","/insertEventBulletion","/bulletinDetailMsg","/bulletinEditEventPage","/bulletinEdiAnnoPage","/bulletin/EditEventop","/bulletin/EditEvent","/bulletin/DelEventPage","/bulletin/DelAnnoPage","/bulletin/getImage").hasRole("HR")
			    .antMatchers("/Leave/LeaveResult").hasAnyRole("ADMIN", "HR")
			    .antMatchers("/schedule/TableScheduling").hasAnyRole("ADMIN", "HR")
			    
			    .and()
		    .formLogin()
			    .loginPage("/login").permitAll() // Rewrite the default login page
			    .defaultSuccessUrl("/index") //lead to the default when authentication pass but no specific address
	            .failureUrl("/login") // Redirect to login page if authentication
			    .and()
//		    .logout()
//		    	.logoutSuccessUrl("/login").permitAll()
//		    	.and()
		  	.httpBasic();
	}
	
//    @Override
//    public void configure(AuthenticationManagerBuilder auth) throws Exception {
//    	LOG.info("AuthenticationManagerBuilder");
//    	auth.userDetailsService(loginUserDetailsService);
//        auth.authenticationProvider(loginAuthenticationProvider);
//    }
	
//	  @Override 
//	  protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//		  LOG.info("configure");
//		  auth
//		  	.inMemoryAuthentication()
//		  		.withUser("admin").password("12345").authorities("admin")
//		  		.and()
//		  		.withUser("user").password("12345").authorities("read")
//		  		.and()
//		  	.passwordEncoder(NoOpPasswordEncoder.getInstance()); 
//		  auth.userDetailsService(loginUserDetailsService);
//	       auth.authenticationProvider(loginAuthenticationProvider);
//	  }
	  
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
//	@Bean
//	public PasswordEncoder passwordEncoder() {
//		return NoOpPasswordEncoder.getInstance();
//	}
	

}
