Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792578482;
	b=Xine15loRKlI2HFTc2y88H+Tn7Q80fFH3izGZzLYUOLcrQISmbeVnyY1bSVIiMZALUV4
	 gQqTawr6ILtbyn3C+MDrfgDds1YXdjclZ0K3w3Ry+A22qQmvcTnby2Y/cpuTkYqDGhI+h
	 n7ziME1L/pmkCR3XlexAHcw1/4x2aTaojEsM6AgGxcvrnObOOnbrKQjpjvHhYnK0hxuok
	 Hw43h9rbwopnrOvNXt+xKN1CvZXDSBVdhgQ8dXcavQOqzct+RZT2Zf+YbxCa3LGuY03o5
	 99TwuKF13yaWZ/0zhooTm+4RrhFSnxAnZUf9atwE+vUM/gIs0N0GwXFRrL3oNYoW5zw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792578482;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=jfXua56i6l4AylDrThjMnSCsYgxNpW4UA09W/02fwD0ytsDicJJFiHhMWcMxq8SutPhE
	 jo4kkdGI5JQzfdSVsflfug+B/hyZ6/Cc6w8VSEHlILkM0LMs03c9XN2OBRa5oueYfkoaw
	 KnNlTsmC3GAGalRtlb0AhDSLkMwRYUwhNklZmQfZjfQc7GyRS+9Rb8D15v3Aa8SK+EmCs
	 KHrCSOoPy3KVCum8CJ++EDuaTZBGs5OMHVMh1Ivm0pE/g4m8IDBYL4LduTmWYPiNhiusN
	 dMapbH5r9VrXu/SRFyRrH6KwWIHPyAV6ihcHs9V6UGajPudM/1u6A1uekQu5xl9mxng==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VrgGVDpB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43B606A31F;
	Wed, 21 Oct 2026 10:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B43B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VrgGVDpB
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 5C01D20291F;
	Wed, 21 Oct 2026 12:27:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=VrgGVDpBG7PyjPQ10GL9MmsYsWx6fFBo/fFm9psCfe6o2/Y7a8eag8fR1psjM2O9cuPIbv
	3DcY/4JflO2cheaek5C6yULRiUWZB7aut2j1ChhLAzJxnDB42U4KMMLWZ3Nc8yq7Ea7K4B
	il/Z0g+K7auZoYYlIcVRQV76/0qAKDu4vkwb0h9VC6kvgtb7jCWZLLWP5meq3Fg0h8vI01
	x4ZwW7etGhBZqbha0IhgG9GaIhAo1xZMqsqioXZM8uQUECd1u35gL58RHMtmXl8SgJvAym
	ecPgVZs3QffYjVGo2JjT8NnzYuBQjmQg9rtmsg3N9mqgy6vPsULB/ZLJqMlKOA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792578479; a=rsa-sha256;
	cv=none;
	b=diFGl3siyPO+IR5j0oJupw+lRxuwYFWv3sSPmvP6+pd85hQmaf66olBRHo7sJZtt9JqquO
	haB7rJRLoc4lQiSggqoKZ8jHUqeHzaLimWQKB+0uu4L4ehdu4R9bElZ0vmsQr7OxeHPAZR
	NVIMeyqXzSjj7N9htaD5c5ee3es/BqjisVQmleMC+3rwzjNhaZeuF43bwt3ZpPDr58M0E+
	YyoV01y9m0WwSsMmailS4/jqVQ/C2ZuwtH9es+jnnaeXT46UwnNfTI9ay9ESoWEEHrh6wS
	Cdd64YPSii3NO+LO9nFplSC22LteTHCzKLOrizGKC0KRd49xYCLUr68DPL2Rdg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792578479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=EjdW1gHyfapl8qJfM+LfozAEyzLJ4bo164DCeU26JFjyccNn8js7n+Y9BQSHNXFAwOcOWG
	uu7sFlQfp0JaKC8gEE0rZ5w1vFeVHcbRDFGi3g/Zl4zxvvprj2KD25TPO6JmRy/HWNXYeA
	N9OYfoqKXdWztxwcgUhzA7irlMel8q9pb0IpzWpStXhOJwZPajZp24ymE733nz7UWtR0Qr
	95TrrjE069pFEzf2F5SRSjc3Eeun0xSHP3a5BqZM4R4ZLrsSElTuC6viqTGZT+WQDxlbqh
	TQ3bvEbHO9O/UMaP3ZBr+d+c/G/SxneT3O6yEe0hVoXkcPzW8lxkoccAyTAMcg==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xJTY7-000Xjh-0p;
	Wed, 21 Oct 2026 12:27:59 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 04C515CAFDA;
	Wed, 21 Oct 2026 10:27:59 +0000 (UTC)
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
Date: Wed, 21 Oct 2026 12:24:34 +0200
Message-ID: <20261021102756.1900679-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261021102756.1900679-1-mkl@pengutronix.de>
References: <20261021102756.1900679-1-mkl@pengutronix.de>
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

