Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B51457E45;
	Fri,  9 Oct 2026 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553415; cv=pass; b=dj+wWSOV329NcYTQCKaIICTJ2MxqfufeGsRJsMbSj0WXYcsPgFKDlM1OlS4o5ufVRpXelN3mF0zs/JeUQXbUW7+VKAhi2JTW0Masq5zq5rIx6s8R4NDAt6jd0BJ821WBWn2vLGmkab+NFaC1PyeQ8062ynJa1b8elytCjpLur3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553415; c=relaxed/simple;
	bh=icwttVp/gpJ9Ow/0dJ5cGcW3oVQP3H8pD+33rsf3U90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXqqZGEyfS+0WzdppelHWCwzF7Rl+zboz5Suz7rX4vxHdBMyaVFy3bwiz8GbK1+Rll6q0i23SIVew+bHUdUc/AoJbPzdVcBiz/jSr4THX+RIHu60qKVvy15Tmy4N0X8W5xi3lpjQiiQlMS2k9s7ncRGaIfECsXg7qn9luvhibNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=TGb+D/Gy; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="TGb+D/Gy"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id F0B872025FD;
	Fri, 09 Oct 2026 15:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=TGb+D/Gy1ZGJWfN3rOOMa34ief9B8XN0Gm47Ns+sipLoUVcOcZe7wMqbtpvxv6ghMZucGL
	S3Zq5V//knPlOsbi28eyc2zTnnmFMPc8WfU+4WIrXJIq3t8yuhdNnD5cfNhQuKUmm8hXO5
	PYSeH0n/v2JqbCF89hBy8Bu5sh9bwCP2V/nDGt8aPpfyxL7i+q9UvqPcLiUlTLYqTowdaH
	raSt4Z9tOnMEeaejGMDp4DqAO4nbD8vBbYMgMSfDvRZrajqUoPhsiCfByh1EX+2IDwinrI
	wPeBBlFI4bXdIwP61hTO1F9hZ32ZfaN3QEphnJLhK+PrQQsJvlTntSlWZ9l2bA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553411; a=rsa-sha256;
	cv=none;
	b=AxyRehFQzALvsKr2gBBHBVTr1HuBBtwS3R0VkDYpPcv2NMgETRII0d47r0RTv7Fbmrf/pi
	jv8f9EO/RW+4w+B4wnBT1Xif2TgBC+4l10MTDRY9IrtnQV61EjU56ABM5k4JU0wfu1Suj1
	ISA4DRBoatTHhJqLTl+McWbEBFvF0lfZpocx8A/NyC7mkhO2Lby61vc1PVGeWww5U9874t
	MtXN/M5ni30T/YrNF0jnmS7Ou8sl9d9/xcNxR61AKh/iLoAvy3SzfLhZGTKm+2a/mmUn2Q
	osTo7CeacCXdo7oTy/6KnK1QsUK4oKhe0HuDZMKvQlFmMjo3jaGowSsVDpn1jg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GuuCj5FgUwZxYjIYXBjDzyPTNHukyGNgbaxYgigr4OE=;
	b=EaeB4aW7eWrIyUn+WP542mD7FoQgGeeIzcSmrRvoM9Y6Tc1JchcNpScjqEE0gWP6WhQ7Eu
	iTKtnaaYwPpaOhCEFe+NFGA1XW2I/57WjHbkVUzJIA5aX/npHkh4AinCVmiDRTJOee2oZa
	fh0li09dAuJ+TLHPkbPjvEslhsibNGFRWqLNE9yBwTgqiNmP8ulR9neJ4R3wM633mqAOlR
	PbFVh3b2TYoLQl962CQFOkZnv2F/SB6UqSoJrNkb3+K3gdjZUbraIY8+WhDE6e6jNinB7M
	29rCxm8vHQ7lFrYTkpIgvsPW4ZuxLUWOPPQ7hSDIFojErK18Jgfm88/7PGrkWQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsl-0053Rc-2s;
	Fri, 09 Oct 2026 15:43:31 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 792955BD89D;
	Fri, 09 Oct 2026 13:43:31 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/37] can: raw: remove redundant NULL check before netdev_hold()
Date: Fri,  9 Oct 2026 15:27:34 +0200
Message-ID: <20261009134323.64064-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
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

