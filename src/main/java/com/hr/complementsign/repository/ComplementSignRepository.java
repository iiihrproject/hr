package com.hr.complementsign.repository;

import java.util.List;

import com.hr.complementsign.model.AudittedComplementSign;
import com.hr.complementsign.model.PendingComplementSign;

public interface ComplementSignRepository {

	void saveComplementSign(PendingComplementSign pendingcomplementSign);

	List<PendingComplementSign> findPartComplementSign(String empNo);

	List<PendingComplementSign> findAllComplementSign(Integer mangaerNo);

	void deletePendingComplementSign(PendingComplementSign pendingComplementSign);

	void saveAudittedComplementSign(AudittedComplementSign audittedComplementSign);

	PendingComplementSign findById(int id);


}