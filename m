Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D8431D72E;
	Wed, 14 Oct 2026 23:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792019191; cv=pass; b=kkfXSgD5vMRTprGGBAXCwnBuZ0dOhjrM4fRAy2MrsUmJc4MTu2ji6YI2SBl2clgfSX5TD8ZS27ANXSaX/kA1LeWmfhofXJHrPZNiWvLwsP7Zi3m98vtjG1+pxSbQsUs1ndk6Hl3aBOw1JFj/UhhUgwAXXBTyEVQiIO+MdxJZUF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792019191; c=relaxed/simple;
	bh=lRxS/eU3e4qofT2WEfYIcH2wRWBeQ5u2OQTlkET6g9w=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=p1I0EB27oX6xaJtAMH58gf4e23UE1DyhGSxpfjggpnlm/W/xnv84ctWtf+4vJPZPN9tYJsELSCqjCfxqWkiGPee37KtKvDSQRholATNZ/OJayGY3l0bna5dB6oKpzdhBQMQFda7L+rGLFh3VznK1U+qai2sAjrvfzNScwF/KSt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=T72NYxd1; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="T72NYxd1"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 7B2C9201B55;
	Thu, 15 Oct 2026 01:06:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792019182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0NEiKKtgYk0iCowkOwKxw3zmIX+91ojaodL4YZnzWE=;
	b=T72NYxd12x78YCuXQWt6Oc1xKiXuN6N7HYFeh4zjb+8GlEfN4UKqWfpCMp4SzpC8TcDcyW
	/Y+iMFafSxPvIuq0uxMTxe+IGGty34SZ+9O2s/vi5YtxVcYcGCsPbzuFr3S6qCTsm+nUv5
	hDxBNQw0ZCpxrtC545/xAe+iFv6ENybdQ/mhngUet6fFLbV12kBYB/9+JNstshGAv9iQWe
	Da2cIb0hi02a9xMK5eZdUjESjwEuAtZemjPoLtdctxspYYYh70g7poC9IQGjtO7EqtSnFP
	p9W1MISweOhCRSGaG7gcYleAuGNIMWHy9AVRf5mE/nDcPlnDYXYH7/vRfpTXPQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792019182; a=rsa-sha256;
	cv=none;
	b=aTFLO4Bn+qI9KDOCOdJubIbsZBquf1lG+qQK1aLF+mz5D8x56qBA5+T40xho/rblQ3CciQ
	NGAtp/8MBJfWl7tLTk/gJS/AIp08w5bNZ+X7ztfHPTctT1UCaIuoRWXQnpABJJI00WV+LL
	LNjkeF6gzx26819QL6L3bRfRmZe2ruVnDE5nUBkanX/OWZUdnPjavsh9vWCLf4ePfX6zqy
	8uNKm8o/3oaAT9cqqyxcKiD6HHv7rsnHubHjCntzYZhyPv6PMXFTANB1j3W6gGFs/k02Sm
	YxUrjcoQ2oRj7YfFzAcCfhy8tG4NQEwyC+7L0L4TvQSUgKk/HWtjDF59VtJIYQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792019182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S0NEiKKtgYk0iCowkOwKxw3zmIX+91ojaodL4YZnzWE=;
	b=OSc7R8HtD2rn9GBsUiJ7dgrHiuBQbseExVI8RYBTo8j13/FKUYUXhPm6IZDKru9KzeTOPZ
	CGis4HHNKQZ3pBNEL25143Je4kV4XTd3EZg67zZzQ4iW66HGMSP4YuLNhagR3rdJIcF1iH
	MZ3Qx1Uc1jxRpiRL3DyUrVTRC3QnhID6mDlWN51JzTyCsoxHnI7mnoF2NYASDSZlED437D
	nhPwTmQIOrq8EiX/O6gtaecdOQGkd+A8Y8vQoQ6eJrum7d4IHWC27YJ8UFS5vd0jDbnRIy
	hbChF12RtnrqjtlrU4CTnB3L7MevffOp75slGI0aETHdtGcMOmrXybeJXjRAUw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xH83C-005vtC-1J;
	Thu, 15 Oct 2026 01:06:22 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 226E65C4625;
	Wed, 14 Oct 2026 23:06:22 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] can: j1939: fix wrong rx timeout for CTS hold messages
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: =?utf-8?q?Alexander_H=C3=B6lzl?= <alexander.hoelzl@gmx.net>
Cc: robin@protonic.nl, o.rempel@pengutronix.de, kernel@pengutronix.de, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
References: <20260421153152.87772-3-alexander.hoelzl@gmx.net>
Date: Thu, 15 Oct 2026 01:06:16 +0200
Message-Id: <179201917676.775430.5843829530079631298.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=789; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=lRxS/eU3e4qofT2WEfYIcH2wRWBeQ5u2OQTlkET6g9w=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6wPXa1jQuQPPPIR33bfFOPWLJpQ0yuYYVC68UPN4vf
 uTnhLi6jlIWBjEuBlkxRZalP04oCgQ6lPa+TJgEM4eVCWQIAxenAExEqouRoWtL/KeqiUHt3Zdm
 K8QcenD48upP7E8qY5qqnO/udmhM82FkWKvCuf0Mh/u8+VKtKT8jL9wo/ZDW9jf51IEr8QExKUt
 WMQAA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> In J1939 segmented transport, a CTS message with data byte 2 set to zero is interpreted as a hold message.
> This instructs the transmitter of the segmented message to hold the connection open but to delay sending.
> According to the J1939-21 standard, section 5.10.2.4 the timeout T4 after which an held open session is invalidated is
> 1050 ms, not 550 as implemented currently.
> The 550 ms are problematic if a device uses hold messages and assumes it can wait for more than 550 ms before it has
> to resend the hold message.
>
> This patch changes the T4 timeout used in the implementation from 550 ms to 1050.
>
> Signed-off-by: Alexander Hölzl <alexander.hoelzl@gmx.net>

Is this patch still relevant?

regards,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
