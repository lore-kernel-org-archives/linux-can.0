Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794994339;
	b=Jw7kv4VG5A041YRVDMQ7zjVYV1iNvorZ3fC9gDfiX+cdqx17QPLIFOIz/f+x3owveYP1
	 HNPmJn2RTMLzQZMhBSLz/ezdDH5O6DG283dZCNIbfe4rrJKwF+Gh6Xke1p+7T2u7vZ+Yo
	 R2JHXMGGsgwp8+dETz5StGORXxcIG2G6NbKlgEvhyvl21yt0FRKIb2OTsU/vrSofNShTh
	 yuRXzfMPeVnwGYkxQDBBDcT4xoMGEGy+pXOKhUu2/jXSvbz0fTw+BAycVnTdkifLJeSn/
	 hn06rA623yCTJAGql9cw1EsoIIEG8M/VpHv4DsNjsOUBVJfQCXUEUtfht4UAqvqWtcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=MyA0IR+SEFhMx2ym0GAjrEkPRJ4VwU/Zx+qgrevGyasY8KYdS0ZHjbldjJkj0igSmSJm
	 WnsJtYfvQHqkB2IGUkUcxD/XVIFV/gMuJLDb2NaKaXYiRImIeuBkJ20wv+Y0OAAqQ9LEd
	 uCGvSKX2hAXzL3scBRUZu48hoR8w/QHOdCeXdZhb0vPCIJk1qTXQFWwB3bl9xX8YGuAJW
	 rd2ge53iY0HlaQR2DJQNNIssARvwb6zMJ4RfZfnBZmn74kljaseT1ZdiiMQyU6XCJbaHd
	 h2JI/A9HCSZZOK581GFxg25zKPxyVp6Iu1PwrJXFDDKYbqZxHjhPcO7sPLd4hknbZyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=czVTIC1Y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92DD606A897;
	Wed, 18 Nov 2026 09:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92DD606A897
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=czVTIC1Y
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5BB97205AB1;
	Wed, 18 Nov 2026 10:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=czVTIC1YBud8XM+zGHn+0jPAE4bfn/LB5rCAh+21A03N3OCNyyRXn5PyM9SQHnW44lgXi6
	nXgYgLCa8M/0VuTE9sMjc6o7HMwMuXVDqAkCCaJowz2cftVhWlP7bumSB4beoG475czPmc
	jYmjjAVR0W93omy/y7JMU3fdgZySSEbAJTiyi3u7v4M5w3hGELBwy+IW8/RmzPTpT54BpF
	ivvHX8/Flpk/txAvLvOf4GI2qjc/QUYR+QpxUHNSskXuHvBNzigchw1EoDqKjjz6QXFj8V
	4OyVgT3+66qgrVUXQOUrFdwvtXV/NCI8WUrRS12+E72dK76J6N3OrM28zd0+gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794994334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AxBnwBXyhJqtp8fKEcfhDoTvv+Vuw/5BcEJ5lx660bo=;
	b=GoH8WHW8y/fhHVcfhknGGLoXwKG7XRIdsOQh5BxiQvi0YjGFNJFlQ6yZq/mOEddilp1X28
	KIdH+H0lCAvGyoXycmJGyi5duhSa5K4LJvW9FPcq0hoj1hI9h869x3z3054BWXQkLg4qAY
	ZVjtXZMLtaVw9jSWbanU54T/JWCsw0Xki2AKv4tZgbqSuyMeCk8AkgduPUh+xPwRKzR8aD
	NTHV+1Dukr6AdjmcnHfYMp9rTO8dbgqT04aqLqu1QZXedNtA1IFt/5TX2S/pohcMJgbnLQ
	gyxYocj0ClcEMTUMvMOt/DWyTPqpunJ+4tf5alziVOiNDB8xV2Y32ttIxMrH0g==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794994334; a=rsa-sha256;
	cv=none;
	b=cVNyyqZUGXjSY72hUyEO4/nzQ4oXzIr/OSSHFx02zbt4bOHRU+dXzUfRj8oOTr4p/pYvuV
	ZC6eU1XKusdxPIKjGcgUMZoZYViH6ib2d8V3PrCiEQIMBd1l9aKfMX3enOjudgbDXDeXAI
	zuadT5UnbDFNnKRCdVd/ok68sfsCb5z+HU0ADojw2fEOPuaSlVaQ4hvwfO1d+Ms0iHA24y
	Fz56HFZ8idOzjZDBLEmbTUlUmuiS5miUpdEUQJzHvEt+38dcgUsWqoJ7mh07sjwjEgun5o
	Ek8livmSFcdVMvk89FhqbQmDqdM+XPKDV/vzkvcogTofmpWUj4wrvpHPC2AWiw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTc1V-000KI4-2I;
	Wed, 18 Nov 2026 10:32:14 +0100
Received: from blackshift.org (unknown [185.109.152.103])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 862E25EDC87;
	Wed, 18 Nov 2026 09:30:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/12] can: raw: remove redundant NULL check before netdev_hold()
Date: Wed, 18 Nov 2026 10:11:35 +0100
Message-ID: <20261118092955.1283165-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118092955.1283165-1-mkl@pengutronix.de>
References: <20261118092955.1283165-1-mkl@pengutronix.de>
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

