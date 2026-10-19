Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792429730;
	b=KIlMXliOO77sM8zS3OUTtti1ZrZl5XUlsWO+CMHsdfPScbgSJXhOZ3Q4oI4fiPI/enYe
	 6QCeG5d7agYL7YnGympY8eVEURqf9iln+J3AX7bGlrdylpQUnGMo9nKFsBno1VZvQrbpJ
	 d/0obHb3RbP+sPbJwiL/ujYJkA3l18AF8vZvdOQFpOEPxk1CUmjxhJda8gSxa2iOll11x
	 OCS8PuBv37EVDPbO+0OHVIVR85fXE45+ftRCU+sQhSCD7VPurnirzN6IIh1GLbmyRlGOo
	 Z6AFjCeub7240WDyffXWdc//lFm1wtVwZacKnjiugyapMp3fYjkbOEPJD0B34G1Oetg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429730;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=MtGAA/r2XUXXJSVAZOH4V5Vxj46c/3pl4tmuEB0DOHnvkFcckrgAj/gbdTcFLEB+YuU+
	 Q0AdZipAs96f+IAI+0ya7Bo/nu5uWK5peak1nQZ9qV1YGtlVGQq2HaFijA8UeehNjEtkL
	 OYYfzLjk03S87hNZ3StohpRRKt3PstfYAVvD8jcHKRvtl9bAJj8idtyrW/gF8HugPm9BP
	 gJFMvupxE/ca4ApizVHQei3e4yA7630c3eYRvn4wg6Zy5i6ITGulU2KrHjnxJGHlPLH/Y
	 0A8J1Fsrma65WDiUVp3exP/gsbkIa/RQBIH9bL6pwT2myb1Vk0iADhdKYoUDXekNGFg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VfqeZfub;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C05606A320;
	Mon, 19 Oct 2026 17:08:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3C05606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VfqeZfub
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CA575202851;
	Mon, 19 Oct 2026 19:08:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=VfqeZfubM0GiixzuZ37RwjZGmjbcAaoDYHQohEigC45SjDQXt918z6xMIuMdbB/tFX3qnQ
	vi21YMDQKzDLlB0uaV/JCiqRX5gW0oRN3oyV3fED00ZZpJCwc8G6tPxv9Nj69CUsVYBzLL
	d4J4Znd3ailhQ17Ed7i9l2Ra4/ADu/I0wqRn8v0ytAJo42yBZ061GPpueGCrjWUylCclaa
	VGKzoS24Ml/T7zzz57/9DCTFeXabm9KWuz74r6qmg1nrPYGuG40XbiJGht4ZjqST3NjNuQ
	alI1EfzD16vZ9veRrKjUAMMGWfPf9Rcmtt+5msl2d7iKWdbfMXdxstoeQrH2BQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792429716; a=rsa-sha256;
	cv=none;
	b=fzMsvUtymVoaInicq3V26PF5CdN+DNLwO7f3kGBnmo1/JDzCGv8TUcKZ5C+ZcGCc+f9dVh
	NxvqDa6Z1CaOZksN+IzWgWhoUZPB+4KBCvex3n1yBJig6/9+BM09mZP6zsEI+b7O/JA0ee
	wwfekZm+tufJKuzoojpVnp5rHT1qgD0X4rJ9nzLMQ9VFEc+FKe9CzA/yTS2YpkKuaqU1YC
	bsB5DMFMfsFegEl0Klng1AyMfF8myqvPhG+ojWBSBw406EeLhp7RXx8bmqqUwYZ7GPPzto
	8jJb5EilvQb45HU0Ur3GWdnROpd0xQ5boU2H6ecBHldM5rvpAPHxnEKOcBhW3w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792429716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=E4lLDvsNlu30GviVFX0XWW4MOpZEV14vvCC/dF4G7j0yBCDdONC9YIgd/gVHp7qXU+6Qzg
	wsA9+GI4XZlQpl0F7Fvumm4jn/aLh7V8mIDMc5e9VzJ4fMrvy0AAhNfp03TOPBBQRIE/VC
	mIi5hJlTluJHqSYe4fon5nC5K+vabzEK3W30k07/uBQLavSKMuvngbABNAdrJbmq0GS0cY
	VvGVWNX4nKH3tBLhivlYa/Nq6D8L8XVemi3HDdbr3+MN/Fzc49Hcrs65dysHdSC5LgyCwx
	4ghXRNf15DvjMehs2wklgxjOFYyG4lJSbYEUV3UzjZu0DRI1Rkf7Jf83PzPPFA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xIqqi-000FgA-2I;
	Mon, 19 Oct 2026 19:08:36 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6ED0E5C948C;
	Mon, 19 Oct 2026 17:08:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/11] can: raw: remove redundant NULL check before netdev_hold()
Date: Mon, 19 Oct 2026 19:01:07 +0200
Message-ID: <20261019170834.1727150-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019170834.1727150-1-mkl@pengutronix.de>
References: <20261019170834.1727150-1-mkl@pengutronix.de>
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

