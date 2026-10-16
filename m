Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856C238E8CB;
	Fri, 16 Oct 2026 09:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792142722; cv=pass; b=ku3XeUq93dPpl1fFr3Evdth7ssDNcEpdKb+okYs8IvAHy12N2+yBa2Ut646zpYUxOUQ+qxXrSGeSQwu9gnTbA7/kdCGNf/lMzFrFnfIifotY5vUxOpEmwxZocvvu/Nt5QhmykWUey24FOEgSBojmKkV0/ujG9cJ4KA4cDStRE9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792142722; c=relaxed/simple;
	bh=KexnCeRpOAQE9180IYk1FKXNgLIajXRfkiUVfeZljtk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=ZYB0/qQMCMy3nwUOB9Gx36w3V2Iuhv7dlLWlMj6i541eEPE1Dy52yNckOw3g+uG70YOWCgiAPmbt4huXXSSsJf9w2yl+89Vyvjr1TXnbvzDrn/NvwJLUymvjmt0m3F+6iyvTsffDH5klP1zEBvMVGts7U2TN4sWc6i86bl9Fdx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=S9TqQSmC; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="S9TqQSmC"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3AFE9202012;
	Fri, 16 Oct 2026 11:25:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792142717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZYSsCUvqBl6KyD65mCxhuofq3aWnyIb6liMgBcsMZw=;
	b=S9TqQSmCoJ5BzwDeAf7lMVvHe4T1EabvWVsqaKZ3JEVUkXtKU1M5orN16PaXu2XMRuvDXn
	qZEA+0Rm/8uAlNnpvnHd/UsrUKj1CGx9bOGBWwrnW5QjLoBIaLgr3smx3mMT4wZ8bq3032
	+dIf4J2M9Js/1uG9ycIzCRLmlkSh6S+IxoyrtmGs7tA0L7DYxoaGTkyNZvOJ7Gm61wUi8c
	GuLYs2ILRlGtEYwxdDQWmc8kxYeRxdkhdFOyoViL4GJFy1fpY7axU1B8aDUDqT6sdtAFa9
	rMpiRMZKnfgb+LtLJ+9GKYldAtvJ2YRz5uM1jkEvdmLW1hkRbvqTq8eNcaizdA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792142717; a=rsa-sha256;
	cv=none;
	b=A4uw/a1JsEJOooIBqz8lu6GFW59cI4PWemXvWo/dB/+7piJuYMerqAzQno9Gtan9wzzGrx
	sAWxiQzjJTN50OtFFxnI0Yb+YyRb8RZ22RtmXc8EP0oYBKP94KjKTukJAhN7mioQESxrgd
	9L55nJRRPvDhYe5xwr3JdGXw3NhoSt1NQVoJDv2bAc3PdTg2v7DtrXtlN6C/04Tk0Awqdh
	4Vv7vnLbyd2ki9ArwodzjyDxpGY7+sudH1ngpUegrZ20GTfv1rBbgUPUV8qO/uJaw09sLw
	lXd9ONLX0tovMg52EZkn4lx8zr6UANDMWtGmeO3BMVyn1VmNUhkZ3iIXORhNXw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792142717;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZYSsCUvqBl6KyD65mCxhuofq3aWnyIb6liMgBcsMZw=;
	b=CszAY7n23kQ+7Oc2IwUzVkvRQfAdvaPk6t4Mp922E+0zxJHAYUJnVH47diZ/3UNvwgIkrX
	s98F8KuvxR9kJIZY55TCpOkT7mDXZVrVD0cOM66RHs40veYUluYV2k0PTZxPwUm4HRjlrE
	Dw8CdOtybSnLivmCaTXSBq8RUfmE63p7ubBY8qQOtn+ZiHbqLBCpNIhJe2QIAxdkWq27x7
	9Z/b0B20uunPZtlmmIeD8Ps8lsBLHRQ0fRsoxLvPo1Zm4y8H5qoTqEgKGWr3oUIg9mZNZU
	+l/VeiivlEmzyjxuMX9ZI2yAHq5Wc0EAP5bHQUJ6PaCXn5KFSg6eU/VrxdG6rg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHeBh-006AAh-0M;
	Fri, 16 Oct 2026 11:25:17 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id CC7D85C5EDA;
	Fri, 16 Oct 2026 09:25:16 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 04/37] can: proc: reset pkg_stats atomics
 individually
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de, netdev@vger.kernel.org, davem@davemloft.net, 
 kuba@kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, 
 socketcan@hartkopp.net, kurt.van.dijck@eia.be
In-Reply-To: <179211822321.434549.9771966136026807937@kernel.org>
References: <20261015015336.816543-5-mkl@pengutronix.de>
 <179211822321.434549.9771966136026807937@kernel.org>
Date: Fri, 16 Oct 2026 11:25:13 +0200
Message-Id: <179214271380.1225518.13670821676227816602.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=764; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=KexnCeRpOAQE9180IYk1FKXNgLIajXRfkiUVfeZljtk=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6+LbK76Ns2C2bg/4fjLZySzV3XFywSOpa8TZl9a7OC
 bUlxw74dJSyMIhxMciKKbIs/XFCUSDQobT3ZcIkmDmsTCBDGLg4BWAie9IZGb4K3ev90ny3UM/8
 4dqlZi7bGIUv6c2bJLvzn2DBdRmlzDUM/92Wi/28eI/tr7DzaYeauXGK8TPvxjw85mYzeZXCQcs
 X9TwA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-16 02:37 +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 · High: 0 · Medium: 1 (3) · Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
>
> - [Medium] can: dropped statistics updates due to unprotected
>   atomic_long_set()

The found issue should be fixed.

Marc

bt-bot: cr

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
