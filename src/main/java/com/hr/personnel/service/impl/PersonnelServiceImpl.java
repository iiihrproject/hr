package com.hr.personnel.service.impl;

import javax.persistence.TransactionRequiredException;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hr.personnel.model.Personnel;
import com.hr.personnel.repository.PersonnelRepository;
import com.hr.personnel.service.PersonnelService;

@Service
@Transactional
public class PersonnelServiceImpl implements PersonnelService {
	
	
	@Autowired
	PersonnelRepository personnelRepository;

	@Override
	public Personnel loadPersonalInfoByPk(Integer pk) {
		return personnelRepository.loadPersonalInfoByPk(pk);
	}

	@Override
	public boolean personalInformationUpdate(Personnel personnel) {
		/**
		 * Check if there is null in the any column of input personnel.
		 * If there is, do not override the current data in database.
		 */
		
		Personnel currentPersonnel = personnelRepository.loadPersonalInfoByPk(personnel.getEmpId());
		String phoneNumber = personnel.getPhoneNumber();
		String email = personnel.getEmail();
		String address = personnel.getAddress();
		
		if(phoneNumber == "") {
			personnel.setPhoneNumber(currentPersonnel.getPhoneNumber());
		}
		
		if(email == "") {
			personnel.setEmail(currentPersonnel.getEmail());
		}
		
		if(address == "") {
			personnel.setAddress(currentPersonnel.getAddress());
		}
		
		/**
		 * Update the personnel info and double check if it's updated
		 */
		personnelRepository.personalInformationUpdate(personnel);
		try {
			Personnel newPersonnel = personnelRepository.loadPersonalInfoByPk(personnel.getEmpId());
			if(currentPersonnel.equals(newPersonnel)) {
				return true;
			}
		}
		catch(TransactionRequiredException tre) {
			tre.printStackTrace();
			return false;
		}
		return true;
	}
	
	
}
