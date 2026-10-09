Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0044E13EA;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553423; cv=pass; b=Fr9EU68qHyMN4NSfTwox8MJ0C+afZOR6oTvNf0QBz4xZDgmXeM3qXZiJbVYwReAtaEUdZGzvscPkOkP6K/qje/XIsY+si5ilGanXaRHsEwhmmRtO0wp1cWdxcInWSJgKNNv7U8eudd9nAK1X1NCkCJXc7bKwPU9uwDby6crTFWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553423; c=relaxed/simple;
	bh=O9a6x6RZdsTMo4G4BsCYAJxP1ck94iOgIkQMX8BUiBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmS9xsy6SjZzJLPYAVdxysu0v9TbeJHPQgZ6cp+0UD/cEjNzo3z9axo1tQE0bkz1Le4fixA0JblJBElRdHRC0UCd/7PsP4UWmGSN4Jyc0+GShaBWzdDpUScLpoTtikL+Gs0+nmyHQbN7GGV+gUD1lWW02jluDji1AtX1iUdcV2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=ZwbDK/qW; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="ZwbDK/qW"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id A36B3202631;
	Fri, 09 Oct 2026 15:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05M8jv3aCDUblug2dvJEFFtEW76sFU7hQZdrSMrInpI=;
	b=ZwbDK/qWwauWPZM4hJMprEx5Pq4MK8Z+bwoXEL5PMqFJRets/tovbhcHJJLDDFGwi9ou//
	jIHCkrwMY5IgN2L0wxAgoc+nfBTixGoHO8Z5pdz5mNsTOjbaeKSlnS5JfnsEAUPXdh4In+
	jFhpko3l30Ov3Q1Mj/w3wdtzG+bCCTGEDyHGqpmK0Rj6dtyetQSDuzQOmIe3bZ7NMjENSH
	QxYkAVQXVYoDhSN/VkaQmDUnWB2ghCHf551rpFUNDqC/wEyWjagGlwZ++2jVKi/3mBIJ2X
	JwxYYGInOVIFIff/2S9QqcBo4C0GpuLaIAUUvbZK7i8gQZFGR4fsBJl1I+IlEg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553417; a=rsa-sha256;
	cv=none;
	b=UdQR5hlbfyDSNrTBKax4rAJIbCACqSfkVb8vK06vML1EJlPd/DBahnueiJDOf3Nb2bgZYJ
	vgRuJWZznzEnYmCNPGxDkj782tGyVYL5DhTfYhwSi2Cuic3gfsVJuTGoa9VxEHMGMjd7Qb
	6cEepc9OTETG1dohr1Kpn5/a4XavOcqXBxK9aAHq7eLznydPwWZutB5xmgLR5ychk+g7Ul
	8LpApbDzb2Idw0GIs3h1zngDSzhj78DM9bhc0vftZOar0FldtdWtPAEgqVS4pnkfFBnn3i
	Y6fOSuHmrCtl5hBMYlEgIxBZqnx+MTJvFjFEuP+zZMZf9KBDsyLUn0W7GqjuTg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=05M8jv3aCDUblug2dvJEFFtEW76sFU7hQZdrSMrInpI=;
	b=cjdBFGDfeLUGVZZiHhWTZSiMMPgeLpcFqDCLrXxijGyZrPnoVR6aSLj//fSPJQEf0fWawv
	DWBXd27PIhMYgeduY/J8FeRQV2w5GTSruQAcCdfF+IroODDX6ZD3MGUlY2WgtQQBqXDpXL
	XGMGGFpY4NrXN1Zm3Yaxtm1qIrXZi0OBojhmayvyI9o5PELCUvBY7S/AC5QVryV4l1Mb9C
	Jg4W8Cic8Fx4Ds0GHP7za3HjW7ppLpBl/wOVWZXMTnj2gnTdB17eQH/I1BXE7PQJHhw8u8
	b+EtsOSUvNqMCne1DmL/Vo+0eXKJdMcHSaxMweaTmZKQjyrgsleInW8ud9aKzw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAsr-0053Sq-1p;
	Fri, 09 Oct 2026 15:43:37 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 2D9CB5BD8CE;
	Fri, 09 Oct 2026 13:43:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Quchaosheng <quchaosheng000406@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 21/37] can: grcan: update the binding file reference in the driver comment
Date: Fri,  9 Oct 2026 15:27:53 +0200
Message-ID: <20261009134323.64064-22-mkl@pengutronix.de>
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

From: Quchaosheng <quchaosheng000406@163.com>

grcan.txt is replaced by aeroflexgaisler,grcan.yaml. Point the comment at
the new file. No functional change.

Assisted-by: LLM
Signed-off-by: Quchaosheng <quchaosheng000406@163.com>
Link: https://patch.msgid.link/20260929073703.2748220-3-quchaosheng000406@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/grcan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/grcan.c b/drivers/net/can/grcan.c
index ce12fa6df56d..1b4944d1d06d 100644
--- a/drivers/net/can/grcan.c
+++ b/drivers/net/can/grcan.c
@@ -10,8 +10,8 @@
  * Full documentation of the GRCAN core can be found here:
  * http://www.gaisler.com/products/grlib/grip.pdf
  *
- * See "Documentation/devicetree/bindings/net/can/grcan.txt" for information on
- * open firmware properties.
+ * See "Documentation/devicetree/bindings/net/can/aeroflexgaisler,grcan.yaml"
+ * for information on open firmware properties.
  *
  * See "Documentation/ABI/testing/sysfs-class-net-grcan" for information on the
  * sysfs interface.
-- 
2.53.0

