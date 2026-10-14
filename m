Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF9B4A9D7D;
	Wed, 14 Oct 2026 23:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792020914; cv=pass; b=IHS2RBYzhggeHzXu5kjrgsX1M7RMRQI3Yx6zTg/5lfnHNMJyKkriz5EDSfbsGbbY9w6eEk9AoR1VWP4GIBmIFADG0djrofLGH7Wy0VKygRtJS0jiT0MgX/Gi9+MuRfdGkJdI3f6Qivq9YBQH8/IX6vL+1aIPgGQyP1Ozd6ir/YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792020914; c=relaxed/simple;
	bh=CVFxnJ02jwymdPMQwk+xw3F/T3wz5YBnUf0w/zi1MZY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=WgSuKdIrc0c+tNptIPbhjypRxIQDi+pRkZFOhvBt0eBhI51WGwu6OdWCp+xYvub+kaPfrbPCFNgM0YnL2HG9A/SxHPDGTW0mr6Vt5czdkqe4JNxIl0iQjR65K+/RACao7D8Mie+5DFOiT8ipEzZ17Qtkzdsvtxaysr6T47WKKgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=S+wrclbK; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="S+wrclbK"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3A581200467;
	Thu, 15 Oct 2026 01:35:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792020905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le2v/6LvFNoIS421Kbu3Jmegn3QlSN3ejpkP9UT1Frk=;
	b=S+wrclbK8i3/sCzo3C+U2P/B40Fj40PVxRs5FS7oM2CGsgQdU/SktKTB/9i5KPzEKaW1Mm
	8IWi9zSTRZ/fzdByZ/AMTEBmkYZ2BmAMSCoclQTyUTE/NPoESIKGy7u1rQahZwONSG5WSd
	RC2swmLJxitpp0fx0W/QRcKpNMGGDGEmJvF1cAFtIw19KesgKqYHXV5Q2f7KWbbASSsucN
	v3G7oWJQZ7EjvaPXjqjl9gBLIbCXBbqwEnv1usNIT+Oa3ylggKCk4P1AWodLm9vQptqRK2
	URFLJkWxwTSkdY+iEuqm9isEDmcZVcB4u20dqMAAjSVelA3lHnmXi94wLkKE4A==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792020905; a=rsa-sha256;
	cv=none;
	b=MwjNJDE6J3yfdYWyVZpb4RESwE2eV2M2gwiQG6kp84DbeJST+PaukloV/COWQxv7KWaTzX
	XYb2GTmrPQEcsLxHidAwyYxvDqasgu0cg635uhxT2SE+4Z4n18JEAU+WMOjOZ6vgp6Ksqb
	+ErHlNO6euwT/lDF2X+dnzlkyNUbbwhVuwAU02iTf8qHxEwnZW9uqEeeyR/zCf66Gf91hN
	XM8wKmODHe3pCb+vXgIzFsvw3vfaVhIL8MBIlS/53CFEHHcJ732vS9S35MFyaU4lHzj48f
	A4FndFbUkeeoIijbduldzgzseublb7tuKfrxklNs+xId9/U+B3atVrEGFzMz1Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792020905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=le2v/6LvFNoIS421Kbu3Jmegn3QlSN3ejpkP9UT1Frk=;
	b=M3SCMqJ13PxDLtlu775/h5/aVfDvWYeWVlyeBOdrn2kw8y2PgKyVlZ+S7RqGf48mj+jvGj
	NQY5tPeq0QbFf50HxZWjD12DLdtf6oDh7zzjSVp1/w7lLc0sH0nV6ZgJou4evmAKrk+kfv
	5XhCfKqKsci8aHNLnD322+G82mPE8gtHyEhXTNfO1CLUFRI5BFgXkhgIUvVcf39Rp4wuom
	wSSBtSYxoUOhzRjRyFXgbk8EdJ/2VaQi1vdSMa1jEVmREkMIH/WuuD/1Jjit/qsOpOK5JK
	odNyh44eAbiMRE9IhRJDu/RNV1P7jTZDUOdZpBu9Xwl6e/SM68TULEZf4j3ZrA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH8Uz-005vzr-0H;
	Thu, 15 Oct 2026 01:35:05 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C98CB5C4630;
	Wed, 14 Oct 2026 23:35:04 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>, 
 robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <179201917676.775430.5843829530079631298.b4-review@b4>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
 <179201917676.775430.5843829530079631298.b4-review@b4>
Date: Thu, 15 Oct 2026 01:35:01 +0200
Message-Id: <179202090159.780853.10870039511123644469.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=252; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=CVFxnJ02jwymdPMQwk+xw3F/T3wz5YBnUf0w/zi1MZY=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6ILhUQPylq+zywjjP85EvdvJ9arov5/PkwL4cx9ikN
 TNWfeO82VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ7O1lZDg2NW5GXJzl+9h9
 7Aenh3spnHz5csX7yldXPA4ULF10PV+dkWHjneuPNj/Z9Ymj+LvJ5H861YaSi/6f+9Zd78f6dX6
 50CdOAA==
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-15 01:06 +0200, Marc Kleine-Budde wrote:
> Is this patch still relevant?

Ah, it's part of v4:

https://patch.msgid.link/20260706224548.100451-1-alexander.hoelzl@gmx.net

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
