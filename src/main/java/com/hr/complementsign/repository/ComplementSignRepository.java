package com.hr.complementsign.repository;

import java.util.List;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;

public interface ComplementSignRepository {

	void saveComplementSign(PendingComplementSign pendingcomplementSign);

	List<PendingComplementSign> findPartPendingComplementSign(String empNo);

	List<PendingComplementSign> findAllComplementSign(Integer managerNo);

	void deletePendingComplementSign(PendingComplementSign pendingComplementSign);

	void saveAudittedComplementSign(AudittedComplementSign audittedComplementSign);

	PendingComplementSign findById(int id);

	List<AudittedComplementSign> findPartAudittedComplementSign(String empNo);

	List<PendingComplementSign> findPendingComplementSign(String empNo);

	List<AudittedComplementSign> findAudittedComplementSign(String empNo);


}