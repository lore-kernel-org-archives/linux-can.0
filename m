Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E69D40BCB2
	for <linux-can@vger.kernel.org>; Fri, 16 Oct 2026 11:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792151770; cv=pass; b=St++LIp/aoy9foe1F2DnA9LYdWJKWPlEo2m43zqPcyVgV32OCYxl9nt2h+xCpO44DxKFjWGcFTya7b0h76ybpMLW4wGpfomffZ64kyj1l9gWzAFrY8l+rdpHkx6PjOnPEAvqGfoDh9cDExRuuBWutRFwlACmT3jZ4biwi0/6Y4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792151770; c=relaxed/simple;
	bh=LRG6nVwX3EBwvmRQaRjfy1GbV5I/waGcsOpFrOliKcg=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=UaeA8Es9ikqcx6JMrs4gNSwVigJN5IPvZJdOqEBcAsitLRnKP26+XMbcRlMfCREyUNMTuYF8RV+ZyS30BR0LDQI09sev8BFsMZN0zCWZ85l+AnRmxiTdbB+61tFm76MOpnsf4QlyU01mIM7dnmlDCQKxSf1loWBG14nFb2q7aB8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=Kf3buP7t; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="Kf3buP7t"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 215BA2005A6;
	Fri, 16 Oct 2026 13:56:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792151765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FncZgRUiN+O7w/nWIm6qbgTqrkk7gLeAe2cGQkckrXo=;
	b=Kf3buP7t6xAqEfEspGH7/mRn3ZfjeH8UKc4bwb1yw4yap7CWmKWjHIV8jkTRres/LDeEBk
	nzihBKE+pQTj75n4Mn9EGJ2tusdFnO1Zu4YgbLyzvD7TBRxC8EfUAMYpPo35smu5G6+rbt
	vTDiPdKpAtp3+gdWvUMqP/08CHraC3RoqyDYD5uXLT3fJW5BBiJcYrPklX4UrYMlVGV/zs
	n+HRJOyqjQRjqXxelSnFSOyb0W2HGw6AToHMltEbPIeB0BNc67zun7gjRWOf+/kcRZaOiW
	HgBJCeR28n8JPEocM9x0x5vmq/5MEsobQqlKHyHMKCnPeYIH0CbDAimdX5HWdA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792151765; a=rsa-sha256;
	cv=none;
	b=Mc8nCpxfMyjI8oZDNs6nzhHkWygg9wxlZYQ+HMdjBia5LSsjQyHUSI8ojQD91ii0lxZM2h
	Qwmure8D6InzYNjyR6IkWWPlr6DuTAF+XTDBaLG0Gu8uFpDhKpTnw7Jlc3EY3O1RQhaHZg
	4jaLwYIj4ws4LzzwOjWY7DpcqALkV1bPbKM3O43Sp7KujjegynsLsQY1eaYcgXCEKwpFQk
	zzbxpfTRZ6esoxMytDoeHBKr/UElnxLFJZiE/xd6FsnQ/E2Tt/YSCGipMAmBVNJ+sWi4lr
	72921WvI6pQYdFPqZupD/s3X8L9RQ9L0ou/OwTA/Bj8o+lOzLkNr2yQFbSCreg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792151765;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FncZgRUiN+O7w/nWIm6qbgTqrkk7gLeAe2cGQkckrXo=;
	b=CcQYiaUx278i9duZ1+z3dguQ0evpFG29fwKXBAHRDOBRAqbGFhWBJ1BMTuvAKkQCfEfiAd
	qrin9RSI3+zs2EC1zWS3TXilJkumRNPMM6CdzJlAAURfncC1w1vYwlFZ80dwVlg4U8Kk4a
	jHP6f45OdKFmPtSiEzhzl8VWkwAGJ4dT2zwiVxunf7BbEp66JtPDBb2P6YVDwYmA80PhEW
	JMA4MBJCGMMm2XOPnxJ/c9iqb8ZYYqg4Jn7jjO1Cm/BG+pdvFlkOvo/egio976LNYKtbOB
	U5u3srhIrqgTduD2K7BCoWPPalzhqCaqhxjdWb9/SYdLOky66nx/xkW52TEnAQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHgXd-006B5k-01;
	Fri, 16 Oct 2026 13:56:05 +0200
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id B5D055C6125;
	Fri, 16 Oct 2026 11:56:04 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH can-next v2] can: replace ARPHRD_CAN type checks with
 can_get_ml_priv()
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, stable@kernel.org, 
 Oleksij Rempel <o.rempel@pengutronix.de>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
In-Reply-To: <20261016093525.327367-1-socketcan@hartkopp.net>
References: <20261016093525.327367-1-socketcan@hartkopp.net>
Date: Fri, 16 Oct 2026 13:55:54 +0200
Message-Id: <179215175423.1281414.11369167443665043648.b4-review@b4>
X-Mailer: b4 0.17-dev-6be7c
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=LRG6nVwX3EBwvmRQaRjfy1GbV5I/waGcsOpFrOliKcg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsi6JHChbcEdJk2ZpOLFjDyb+AL2HG2bGSkuGHbre0xzW
 8Kdf9eCOkpZGMS4GGTFFFmW/jihKBDoUNr7MmESzBxWJpAhDFycAjARSR6G/8WL66cc3q29os6M
 U0oqpvrm8/UZehuPHgkIbLYQ1fiUJMzIcFKPxb25+ODCcOnN/5OtS7UKSt4+uhQpcHO2SuAvl43
 p3AA=
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

> Commit 4e096a18867a ("net: introduce CAN specific pointer in the struct
> net_device") introduced an explicit way to assign the midlayer private
> pointer (dev->ml_priv) to named users like ML_PRIV_CAN. A valid pointer
> returned by can_get_ml_priv() therefore identifies a real CAN device.
>
> The referenced commit only converted the j1939 and proc code to this
> check, while the other parts of the CAN subsystem still rely on
> dev->type == ARPHRD_CAN.
>
> The TUNSETLINK ioctl allows a down TUN/TAP device to set its hardware
> type to ARPHRD_CAN while dev->ml_priv remains NULL. Such a repurposed
> netdevice passes the ARPHRD_CAN checks in the CAN subsystem, which can
> lead to a NULL pointer dereference of the CAN specific ml_priv. This
> only requires owning a TUN/TAP device or CAP_NET_ADMIN in an
> unprivileged user namespace.
>
> can_rx_register() already rejects such a device since commit 8aa59e355949
> ("can: af_can: prevent NULL pointer dereference in can_rx_register()"),
> but can_rx_unregister() only checks dev->type and dereferences the NULL
> ml_priv in can_dev_rcv_lists_find().
>
> This path is reachable via isotp: isotp_bind() only checked for
> ARPHRD_CAN and ignored the -ENODEV from can_rx_register(), so the socket
> was marked as bound to the TUN device. A later isotp_release() or
> NETDEV_UNREGISTER notification then crashes in can_rx_unregister().

Let's hope the bots will be happy :)

Marc

-- 
Marc Kleine-Budde <mkl@pengutronix.de>
