package com.zzb.zo.entity;

import javax.persistence.Embeddable;
import java.util.List;

@Embeddable
public class CashList {
	private List<FinanceCashDetails> cashList;

	public List<FinanceCashDetails> getCashList() {
		return cashList;
	}

	public void setCashList(List<FinanceCashDetails> cashList) {
		this.cashList = cashList;
	}
}
