package com.hr.complementsign.service;

import java.util.List;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;

public interface ComplementSignService {

	List<PendingComplementSign> findPartPendingComplementSign(String empNo);

	void saveComplementSign(PendingComplementSign pendingComplementSign);

	List<PendingComplementSign> findAllComplementSign(Integer mangaerNo);

	void saveAudittedComplementSign(PendingComplementSign pendingComplementSign, String type);

	void deletePendingComplementSign(PendingComplementSign pendingComplementSign);

	PendingComplementSign findById(int id);

	List<AudittedComplementSign> findPartAudittedComplementSign(String empNo);

	void updateCheckSystemTime(PendingComplementSign pendingComplementSign,String type) throws Exception;

	List<PendingComplementSign> findPendingComplementSign(String empNo);

	List<AudittedComplementSign> findAudittedComplementSign(String empNo);

}