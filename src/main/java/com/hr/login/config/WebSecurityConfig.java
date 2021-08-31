package com.hr.login.config;

import org.springframework.context.annotation.Bean;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

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
			.sessionManagement()
				.invalidSessionUrl("/index")
				.and()
			.csrf()
				//.ignoringAntMatchers("/contact")
				//.csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
				.disable()
				//.and()
		  	.authorizeRequests() // Setting authentic system              
//			    .antMatchers("/login").permitAll() // Pages that allow user to access without authentication
			    .antMatchers("/index", "/logout").authenticated() // Except above pages, all pages should require basic authorization after authentication
			    .antMatchers("/checkInto").authenticated() // == .antMatchers("/personnel").hasAnyRole("GENERAL", "HR", "ADMIN, "MANAGER)
			    .antMatchers("/").permitAll()
			    .antMatchers("/updatePassword", "/updateNewPassword").authenticated()
			    .antMatchers("/editPersonalInfo", "/personnel", "/personalInformationUpdate", "/personalInformation", "/personnelAuthorization").authenticated()
			    .antMatchers( "/department", "/departmentDetail", "/departmentManagerNoUpdate", "/addNewDepartment", "/createNewDepartment").hasAnyRole("HR_MANAGER", "HR")
			    .antMatchers("/bulletinList","/bulletinDetail","/insertMessage","/bulletinGetMsg").authenticated()
			    .antMatchers("/bulletinManage","/bulletinListMag","/bulletinEventInsert","/insertEventBulletion","/bulletinDetailMsg","/bulletinEditEventPage","/bulletinEdiAnnoPage","/bulletin/EditEventop","/bulletin/EditEvent","/bulletin/DelEventPage","/bulletin/DelAnnoPage","/bulletin/getImage").hasAnyRole("HR_MANAGER", "HR")
			    .antMatchers("/modifyLoginModel","/searchLoginModel","/modify","/findAuthorities", "/findNewAuthorities").hasAnyRole("HR_MANAGER", "HR")
			    .antMatchers("/addNewPersonnel","/createNewPersonnel","/modify","/findAuthorities", "/findNewAuthorities").hasAnyRole("HR_MANAGER", "HR")
			    .antMatchers("/css/**", "/vendor/**", "/img/**", "/js/**", "/scss/**").permitAll()
			    .anyRequest().hasRole("ADMIN")
			    .and()
		    .formLogin()
			    .loginPage("/login").permitAll() // Rewrite the default login page
			    .defaultSuccessUrl("/index") //lead to the default when authentication pass but no specific address
	            .failureUrl("/login") // Redirect to login page if authentication
			    .and()
//      "/authorization", "/authorizationSeaching", where is the controller
		    .logout()
		    	.logoutSuccessUrl("/login").permitAll()
		    	.and()
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
