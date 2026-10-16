Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2831326A;
	Fri, 16 Oct 2026 08:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139176; cv=pass; b=jpONNW5jK33TICA2j9oWLHDbpaaPM6wQ70+1ULK1fo0BtEMKa4/YDfr4M4twE+bZ5/Ld13LPA43X54C90nuJR5/MP763vJ4Uq9mL9G6jDu9qbm2L/cyeS4YPYoUhPP3drsG8FL15Hk4GokynEr1YTeSnaLKz9pGnfeax8JUW4AM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139176; c=relaxed/simple;
	bh=uBi4KCZR9BjxTpBL1OMvFzCzmq18LtaxZNaptSiCy7o=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=H0CsYYzzy9a/JZrdKmXkAY1prcVhHnVOZa+qK9SLAFln1oQDBL4OZyjo/kLTSKaWOV2tL8b1X7hjiQd/Usz+iF4Fn9qvU5HEAxH80wrNkJct0MK7HCa1nLKQ+F+srLInLpBzdR7OJuXdbYXyOS7w71nhZDDnOLdGbwlbMR5hftk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=CcgZenUp; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="CcgZenUp"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 92D312007F9;
	Fri, 16 Oct 2026 10:26:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792139170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQk/1kZZ4REXjlsI2Bo1jff3ZJHZBK3W1gDNVH/5k8A=;
	b=CcgZenUpg84nYoyPQRC9oVVbWJbT7n0dccUAtwIiJZt/lqnfBLDtxOqkEtijvsz3c21O1C
	1LlvXGje2O441mt25ydbMvId9eE4b+p58d259nrczpZk1VbxfrPcFAZf+Yp9FtDtz0iHNz
	SvmaLWMcZL/ogZ8AVNZJsRWjYrJskLY26xMp/FZeB7jQHRI8eQDXEujov7mPNZJ0L7qrTM
	2y3vBlJ2QFz0H67eZQiL1QoX7/yg5brjOhrGSCRGTjU61LdbYNtTNnT3f9ig5QKU2NQWm2
	5ZJv/06oyYKJmhrAwjRy0JYlY3B/qDqPCSYJcmzBeD/z7rzct6xbwvfpWFg6jQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792139170; a=rsa-sha256;
	cv=none;
	b=ThYj9rOsZqfsG3HQkHfmwfrAqlhSPvBu5S9cwYwIxZwg9gDfHC7v1VPV4xSsBlT+zgjb71
	lD3Z2oUuEh6iDgM39ZKc6DS95bDWORc8ph/cNXgC4NXlijsHKH8E7gXpZbe0USdtYvki4r
	/bBC8g2QZZ/Aw60okuvjz0cghNYReCTgHr/ekxYXiqL/QR+x86LWE3qTeh+wWmqlDj09F+
	OUcgJW8z+qTMq/krh48rUJhlfonptJldMiSBBY1C9P8+Zt04JtFSd8OVCBD9ktdzVCi+md
	6ZxkEsLEI8aIcziNgFGhW+a3btT6m7Bl13CPZ6Iy4O83it07YW3Xzv6+Wzx02Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792139170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vQk/1kZZ4REXjlsI2Bo1jff3ZJHZBK3W1gDNVH/5k8A=;
	b=Qep33NcrDwK0H2swIDSHLdJNAojdXX+1dmdCUx8PKfm5U8mzeEwkeB8sy7w4kanRYXNucM
	oIhj8uu19+1HVYTCW/gPoHP9hY4hfKSPWW8SggdHZ0AJmnOpvZsAUuKlNQuD4Ev7+M9rT7
	nEx5AxI5w/ccqKyGE234oN2aSmmEDHewiNMQDUE6nWhNuhGym+qvcUwxUpgUPLG9pCkZRD
	GjbUmF1qVv3SDHpout60SVURyadLYQQveeM5sM+UTgnKKVRoK6zPiMOOvOrkB0sjxwiZGV
	YZCD1RnfwPYYK98bLcAPsvK9CfRXOF/ETYEMAlgXbcDUIqi7rjWTXj9HmCqsoQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHdGU-0069lk-1Z;
	Fri, 16 Oct 2026 10:26:10 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id D64BF5C5DEB;
	Fri, 16 Oct 2026 08:25:18 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net-next 01/37] can: dev: can_dropped_invalid_skb: drop
 CAN XL frames on non-CAN XL devices
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev-bot+sinfo@kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org, 
 davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org, 
 kernel@pengutronix.de, Vincent Mailhol <mailhol@kernel.org>, 
 stable@kernel.org
In-Reply-To: <179202944723.408196.14576860852925761610@kernel.org>
References: <20261015015336.816543-1-mkl@pengutronix.de>
 <20261015015336.816543-2-mkl@pengutronix.de>
 <179202944723.408196.14576860852925761610@kernel.org>
Date: Fri, 16 Oct 2026 10:25:15 +0200
Message-Id: <179213911553.1225518.14596051956324247810.b4-reply@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=635; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uBi4KCZR9BjxTpBL1OMvFzCzmq18LtaxZNaptSiCy7o=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6eD+77q/Yr+2c/3zjLm0xWHJz9Ts/48mN2bcUHX4E5
 t0POxDC21HKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ2HowMvxNuTtRcGZYqpqm
 +6mnr5O/mAalWLv7p1x5r/QrTfLArzaG/8VXuzRX/pAymVrxN599esfqizt+/J6v8/btoby2/De
 zZDkB
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

On 2026-10-15 01:57 +0000, netdev-bot+sinfo@kernel.org wrote:
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

This is a pull-request of collected patches for the CAN subsystem. It
includes new features as we as fixes for issues found by bots, code
analysis, but that is stated in the individual patch description.

Thanks,
Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
