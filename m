Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795126295;
	b=HGY9PQZ8tFdqpPXqbGugejOJ7MkMgWHiVOrn9eF8saWQXKznJw3GrDqmNUGMy6sWN1oy
	 2IEvqsIrUmGQSxjVW5dDgWTHncVrRLWRtKJNudfUyoyGHNocbXu/6HOW6+1YRNOX36cPu
	 snZBMwe41Dh24qPvfoQN23zbZPnFoalMzUZVIODKXV0wjmGsxqekMWZAa0Zuyf/tTZtLT
	 6jHb76lMkxX6nj2RqvkGSUEkHQ/6Ghhjw8D6OFXJlZcmjy5O+84My6v6WvWbJqDPTxA7x
	 30KkQ6J5YjLM1dFtiSbUSWokKDjA03/toEuUD/j4grGu7tl+J2Uu6dH6hXqwi0YjmqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795126295;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=o3jdZBMlrdhIyOxjwfdXJGXrkoVhMSDDEpMx7ONz3zIbF2PnB4p4r7LoIltdQu4YpAzN
	 UuKp31uPhy8Leu1yCbYgPzTEgnH1Wnk+l8ggJElVtEIGhMPYENi+nMWQhZwAGjUwCn+g4
	 gFejHXn9zJmornkQ6OwB8dnXewqOPErFiWhnJVAxSeHWnTj4Vgun9143DSZU58nSI7K8l
	 FYXrW+Z/2n28ij2trLHx7es7qXfBXm4QqdOK/b1l726NhCFQCYMv5yLdWIv1gHyeJfKst
	 iWZG0JNu/HTDShKWYJRVu8OG8lMEp/H8cKNf93yD3zhEU8S6hPq47OPjApObDdjMRmA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RnwffWc3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D3A606A325;
	Thu, 19 Nov 2026 22:11:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36D3A606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=RnwffWc3
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2191D205B33;
	Thu, 19 Nov 2026 23:11:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=RnwffWc3JxowA5GeKs61cpj/MSfm74er8rDAMolw3y783ZyG55YpKRgUzD8BWzl+n7FSCi
	P0k665BL5D+4rpVlbKdjU5Voy7IdUDZz4I/0znnL1mCjMLsLNCleB2kxVAM9mSlKVHwnSs
	KfCqc2zXOQ6FOUqrBybtBWomvKLKYqmrVZ3Wx+tiXCYZdwvfUrIPJGb+DFmh1RGfHNYFTB
	mqU8+rJA8oor8Rvq/VATEJTf+Cm3lxhLcwwzpS7QOrfhbcChtFi6VhLsY0/rqNW94HBi2A
	QBczaVDTk0Ar5ojdyrLUPRfp/PxqPafwBEgQA8WO7/zK2lCUqmWFz+9tXZ7+tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795126288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=KgdJj8l534MrRiODB4SIVnETlx7MpbNPSLdGo8hFJ4jgpUQyh43cwqBbCrpt/UEX1WzwAJ
	AKX1lWwd9ronzxNd3OerK8IDLezYDxMokNhffyEhdC6qWhE8fSMILgSIOsjCtad/YbZoUz
	Q5WoiGOnjSCYsHUiP5AIaIWwqvc9aKXAuKbJIXcHEP6gVgIZUhIHAWZA1BdmEjTtW0R3rj
	C+AiYs4XqG72lm0PyAJYXH9XaaCqlL3GUjUUPyhgW2U6/I6O88Kid+q6Q7F13/F6a09Y/3
	r0TKNSzD2v0o81y7biV7z+9mr+/Wzp9ZfzsjezDKck6cklqf7N48FkhSJX57IQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795126288; a=rsa-sha256;
	cv=none;
	b=acF0yM1lgxClnAD10d6KRebcZImfO9QaaydrxI507KaFsddgCXiGsIYyvAqExgpTKsxHTz
	LjEZ9o0LpkJ/05bQOb0ucbivSBYUlhHInURGJ3l9UqxzRjqQ4O+BlMhV6qDW+OZng5maVg
	0OpytPOkz5txJDg2Xdl7fIEzCHRGmxygSR8RrMXZ/xwbL5MQf6OBUaYB8d1AvCu8+doxMF
	MncMzQRyjhOj4uBF941G2naN0sJtfOBHVQuERScHqyX82eC/gccJIyQaRg6ZY49s0k8PIw
	hp9D7CHKgvSt5sMyH7Lv4TkWMWSmn29qkgABMzDzXjKpmgt+0aYUoEK6qKpcHw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xUALn-000Z63-1Z;
	Thu, 19 Nov 2026 23:11:28 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id A0E5E5F0995;
	Thu, 19 Nov 2026 22:11:27 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/13] can: raw: remove redundant NULL check before netdev_hold()
Date: Thu, 19 Nov 2026 22:58:38 +0100
Message-ID: <20261119220936.155728-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119220936.155728-1-mkl@pengutronix.de>
References: <20261119220936.155728-1-mkl@pengutronix.de>
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
[mkl: ported to recent net-next/main]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index f14270b56f52..66e41bf9db3e 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -558,8 +558,7 @@ static int raw_bind(struct socket *sock, struct sockaddr_unsized *uaddr, int len
 		ro->bound = 1;
 		/* bind() ok -> hold a reference for new ro->dev */
 		WRITE_ONCE(ro->dev, dev);
-		if (ro->dev)
-			netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
+		netdev_hold(ro->dev, &ro->dev_tracker, GFP_KERNEL);
 
 		if (dev) {
 			/* Either raw_notify() sees ro->dev on NETDEV_DOWN or
-- 
2.53.0

