Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792624301;
	b=T9qJMtpgWpJmPQ3hG9y4lG/Q7eDoibTImrtkbPgWUHmiIiFo8Mh/qkW4dWivdO4HTGHE
	 n5ruUTEFykDWgoWzsc9tqDY5bAXi+DTe8ya7Dr1RZyzQEK3eKy2BxaMa/7AFLGOAo169P
	 hZiJnEhFrJSybZcv5rqb0ESCWOS9w2WT4npiRfPOUp5mHhe2NNmkLqqbIUqGKEiOxJTVu
	 wtobwQYlBq8ptTLHSeipTKk9WBn+xd9lBD5sOf8hWXDxpioTSM6kosN958tdV8nd8SMy7
	 RTwlqvhNo0nTVP0f8qJHWaN1vkDwy/ATqxwWa5wRhra+PWzzGoKgLRzLHS3xqTT18zg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792624301;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=DOjM2ULyM4oak+DnnYzvwWgbU7XX+jv0LBJS8ZecDst22tZG2UuC7tHkJi3kCTq5W8lg
	 5hTfq2bWeH+Ij07XhK0AwoMylxuQF0EgIgyXVwBUiekbcKnnLl9kn7+hczoSKuKey0UjG
	 HlnyDtdWO53KwF+8/pVF4GTydHxS8yAq2c+p18BAWomQn7PKexoI4ug/pvvDoEQbygeXV
	 /eZ9h4OBXy4fSUcQ3iwwnmYZPPwvjO8GKIcIwYvjSJqdREf8SZCucokVruE62Is/xzLD+
	 uvfVwnQhITYdK1Nhr8s8+dGI9goj9m1cVINjbkxkwXVeUxYcghpsUo66VybwYJuoczQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="TfiS9/0z";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C17606A31D;
	Wed, 21 Oct 2026 23:11:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49C17606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=TfiS9/0z
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id AB336201B9F;
	Thu, 22 Oct 2026 01:11:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=TfiS9/0zVsFwPcWV4hdrfEvtZcXlmst4DQwBOQaglriu22lNRgHG7HaoY1sFJU7N3C+o0T
	6U6NaeStWYgTu7f4s7mv+1QfBqzVMj+tF5Tx1C3/Hd2EUShVKBfV9AoqvIpsq16P0rmK42
	SGEdHmVpmZ4FCRR2LA5r8dvKb2hV3FLmi+rLKYHcOyBtM4FtU87g/Vvqup3c/MdOBrd2IJ
	tA4GOrqsHpBY7LP6dkCkQf7NBTZPmZiCTblJyQ+dhPrZEjw9EVjM3516h0AE8cW2M2SSPn
	df0b3n7DpdlJbrqvECRwDw+457D5CcbRXekJx9ZX+plLUkbRavIBagTFqdiysw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792624294; a=rsa-sha256;
	cv=none;
	b=Svjb5KZQFTQKmRnpjnMdMmUeMPU9IyZGAyASA5Y9XP0wsvE3GfXjdJVPKQzOvbY/ayFBIT
	RcpBqIbWCMt6I6cD7LOVDsw/f6+Jtd1tPiRuJw8Kxonvv/Eb3+k7iwTaZOTbnkpytp0Ro/
	DoDYP10Mupnx7R5pAD+mYmCrYrhLe2YN9OSW9SrxBOiwNoycRbojLh6k+zWclxOMTxgcTO
	vHic8YQh4m2yMOECpK6CcjYFptE8MjFonmd6kCfGXH1MOaDZtUhOo6YpU7D7jrXeJM81W4
	2OoKbcjmZYXIoTfR+2BD4GnhlEn47bWJZ4TZx9TPZH70Ro72e5gFTVHAlMVsHA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792624294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=D7Cp6uuk/9IOTVTuNwOj0LljDAZYEcAxnnlVKqe2cmInwFIsQOa5yl1XDbuVfiGcQ9TinA
	OnsiBIAfD2sPSCBa/sK3PBu5QSQ5mv5AALIgvEdZWBT0LokSmuXXUtiM/rhrMSevBPPeKj
	f4h/OcV2w/qbZapZyHauVkI+UrvkDu9s0QAyNPASFX51Xj3mX4Mlxy698VBBa0HeVsX8uw
	yEoyiqIcwv3EWT2OUxIFOt7bJqT6U7HycY+ryv6uo+JtKQyFpjz+jQydSJ4IBmiyJHqaMK
	9KLTHGBPTsOwJEv8V6BO1hEjpJ77PO082QjMch2hNvbEBSCe2gRr2AIshQEKRw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJfT4-000cWE-1q;
	Thu, 22 Oct 2026 01:11:34 +0200
Received: from blackshift.org (unknown [IPv6:2a03:2260:2009::])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F0FD85D06D8;
	Wed, 21 Oct 2026 23:11:33 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 03/11] can: raw: remove redundant NULL check before netdev_hold()
Date: Thu, 22 Oct 2026 01:07:50 +0200
Message-ID: <20261021231130.2085690-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021231130.2085690-1-mkl@pengutronix.de>
References: <20261021231130.2085690-1-mkl@pengutronix.de>
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sang-Heon Jeon <ekffu200098@gmail.com>

netdev_hold() does nothing if dev is NULL, so the check before the call
is redundant.

So remove it. No functional change.

This is the result of running the Coccinelle script from
scripts/coccinelle/free/ifnulldev_put.cocci after commit f83b8a58695c
("coccinelle: ifnulldev_put: update outdated helper names").

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20260831052031.902699-1-ekffu200098@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 0acd4f6c6dd6..6944ebab3feb 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -529,8 +529,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
 		ro->dev = dev;
-		if (ro->dev)
-			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 	}
 
 out_put_dev:
-- 
2.53.0

