Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794311483;
	b=ezZ4dNHIQxIIPDi61+1Sk+H4QaFS1prB4UVuZn8TrB32/XQXLmQlgI6BHPZ/AKiQJ34x
	 kIqAtIL0FQVxBOEQDtvAIeePurXT6/0TjTs+/g7WxTnG03r4uhoeQKp+RuehQRHZtJIip
	 OGSX9BhRN/oAi8sEyPDCmX4e2e3rtD4YQcLmK4q3gXaRrcmQkeaFNZ+5Sri3LcQ/zBkIQ
	 FxLnu3h6/0tw1Kbz1QEM2XMvGbiGn7Eg8cAi79sq1PonQGk8uKXZve/c+7K3VKz2Fi4N7
	 HhvirzcrPILgdPuSOjI0cLK1fPpar7VdaHun1SwrG/yEeOCZOQ4I4sP4SxLU7MD5qHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311483;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ScDNiPt5IBt8aD3ulpbCx01OiSRZrRTLnvHY1qizhWY=;
	b=F/e9020zIj9fvFW2br1Imlf2Qzutqn0nH2h2uuzkRZCLaaWFhrVzEc6Kpg3/lseZDdTq
	 CPSnsvE/WrlGbMbFxzUJNXPm2bJ+hoze6biVmN6PudNV36ri/OxqTPZI7YXmHvCRNIzZN
	 /UK/h+Llo4kvIOVKT3N11Xjy7Hg97UegFxgoavqKujJZMJxiEov88i3PmAGLnVQ6DIgxo
	 PQ2j85av2tFVyj9RZJEtCHqSXuM744aEQCtXb5dDR8ABw4NrlRDIYLzvDWH+/5e22IzlK
	 Udmb0Y4Vtn/aoCwh0BPJ0px5DFsUDTa0zwFL6mKz/RODOBQCpEEgfM7FDxOx/Jmxtcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="I/gMThdA";
	arc=fail smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EEC60A3819;
	Tue, 10 Nov 2026 11:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6EEC60A3819
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=I/gMThdA
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2BC9220282B;
	Tue, 10 Nov 2026 12:51:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScDNiPt5IBt8aD3ulpbCx01OiSRZrRTLnvHY1qizhWY=;
	b=I/gMThdApgx5FNEVQ8pcWlfaV7ojZ9q46orxwvQvPBC1Pd0pWVRthcVaR9sruHaoKZAFM3
	XaZLXfboeLM8XvmGYLL9FcjIVK+LQFSWrpoF3AGSskQC+W8bxuFY9qnD449e7VX3kB4BDU
	zIRRaAXNU4nACyXm2cwDO86Lv4jWax9+NKlrJgfr83z+SdRuC7Sgi0x5e+Zh/aze4QwXO5
	B5P+IGgH5AtFn9ie3jjX42bKViF347zUzcdCuBne5gly37JvsOD+ergYlzcaP8OFKsULEX
	8S3wUf5jN78Vnfpcozvgx5zBdth2lFAkfedfrsfZ4S1/IybPFIuqKLPJ7UrdFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794311477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScDNiPt5IBt8aD3ulpbCx01OiSRZrRTLnvHY1qizhWY=;
	b=EOnBhblJ7B1YpP0aJeX1MXBALabMnHKu/RprEtEzEVGYHZ3wFhaGvOOO/neIM/S83gFcH8
	sEiKMsI2PsoNmG39ziSl8M+aXTRlf6iSYwvg1mHYDQoc4t8oihdG9b//zrKQx8IhdFKNWJ
	pWa7XfDCxPXTL0X0gZFDP1F0gQbnCEKZ55UYgGpeD/6UO+pxFicPiCXWSkiJ4XuaXO8kCM
	S3X/PrApzmr9VMnkBdldWoUn+NIdGyN16osbroeLn9QW9XfCNZC1VLw0MalP4aBwL9maI1
	Jx+4NCDI48e68y/kg0ilCz8/29zWCeI7coqOIg537n5EubRbVEVReYAWuv2gLg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794311477; a=rsa-sha256;
	cv=none;
	b=a2VQcV/973VkgyIJ7EAuflhtL650rQR9JBbglHkQ2psy6mzCNDhgErblJ6Qei4MtpY98yp
	A0nCqZkNurcr3MaoGGY/xCc0zCQL5qyumtX6yxMgvpesVKEze0MHMoDGpapQ1IrvCIh6Xe
	9ixbNsfyrmKFWas+VOyM1NZuRBNDtCMeVAVpILa1gKkzQ/43e4Euxew59IiyeBOH8r5GLA
	zIfok6B0UR4oeA/3PsMDjqNkA4vcEILN7WLarajSaOV8uGeqmbR6TC0W5ZJeh4g0ElgmbE
	m2Dl8rXyMCM/4JU/5+1ujfgGt/H1x3iQCMAZ2x+FSAtAvsRz6Lb07H3lKqFhXQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQkNg-003UEx-3D;
	Tue, 10 Nov 2026 12:51:17 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9A0415E6890;
	Tue, 10 Nov 2026 11:51:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 07/12] can: rcar_canfd: Use DT clock names in the probe message
Date: Tue, 10 Nov 2026 12:41:30 +0100
Message-ID: <20261110115112.3807247-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115112.3807247-1-mkl@pengutronix.de>
References: <20261110115112.3807247-1-mkl@pengutronix.de>
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

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Print the DT binding clock names when reporting the selected clock at the
end of probe. These names are part of the DT ABI, so they are stable and
match what users see in the device tree.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20261019121356.2421761-3-claudiu.beznea@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index bb2d03b75142..4f5cdfa8211d 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -2312,7 +2312,7 @@ static int rcar_canfd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpriv);
 	dev_info(dev, "global operational state (%s clk, %s mode)\n",
-		 gpriv->extclk ? "ext" : "canfd",
+		 gpriv->extclk ? "can_clk" : (info->fcan_pclk ? "fck" : "canfd"),
 		 gpriv->fdmode ? (gpriv->fd_only_mode ? "fd-only" : "fd") : "classical");
 	return 0;
 
-- 
2.53.0

