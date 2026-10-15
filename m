Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6F038399D;
	Thu, 15 Oct 2026 01:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029233; cv=pass; b=L6xPIaj20lZ7oxjruqsFztRGFm/wDIgPsUm3Tnh8bDE3HwNEQkmOCSGXYRtKyOK04twaRdYIEit/t9uvPAdSiTneIriuDQiRoirv+B7LqQBSK7NcFHK3j6Rxnt4ky9r4vnOToZDVHt97rQpalCPAtJ66bVIMHnerVHZbsURGSdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029233; c=relaxed/simple;
	bh=L4b77WGngEL/FWpF9iRAHfE9+k/sNz06Qmqdpp6bneI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pTj6HWyWoLbf9RNQRaY7b4aJ4+Vm1vpye2RIpzmEL43rV0H+xLDRv7LzhIF7YiSohFF4wi4T7RfYuOLOTZxBlbSleJPraf3dSSkYcVnxkEBN7G4yA75HL0YZHLbGu9Pm1kYaLsvIyR8fFV+oh1yKz9qs2arD3Quup/LBFMPVk9U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=F5/8lLdt; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="F5/8lLdt"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D22A12027DB;
	Thu, 15 Oct 2026 03:53:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=F5/8lLdtYG2V1F9lOkYGFBfJ5gOVDMi2pCvSCuGH81PWwfYvmMdqN8m8HTTzw+lgsOXb5w
	UrtmseUavxYXo4DS4ibbGHAgr+B3+OrbDE2qiHk6IHLUlH8fWhNEsxS/utUJBS4+nF4kJa
	YILEr3asrBWKPSrwKrFmCvEWCHTZ8SRTCh7MS7kdyj4QEiwHhugVi9CSY9L7uosgGXV/S+
	qWmySVXCWCUzLAWjsDlIc7EU/qv6W3iDe7eVCivcLLC8TbmzUAjwf80TPgf4nG2qBb4FVt
	5+maVaAnADR0fpCCzaeQaigD+n7pyo0xbUeqDGAtI7b6TEDZY7CHFdJH3dt21w==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029220; a=rsa-sha256;
	cv=none;
	b=cdwd6/jZff19xGujFQUJTxaiyxYP+B6mZRtsVIuxRIrH3OIeM69FHsbPDkxFvvFyswxHEa
	Bj0fGpylFwf1OBHF28sjMBPN9Cmri6zN7ctivB+duQ26VixTripE8ofjF+z7FnVYLoWaMM
	kH7sXqDrF8sIzt1emvO6u4TpvbO+UdZ4lEt3eO5xhXLI+3b8FRGrm5/8QxsqVKn2iSmDJ+
	mrPmllJFQrLJDS8FCnKvKSZesv/cu1xc851VJ6bHQXc8umXO1wvTsUpVlH5iRypAvFEblG
	TMrAJf1MQLJWaVN/pRfHvLTQxlQjocob0ZjqdDv3+atFnGm27wFgV9xcA1uOpQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4HNy9wJpg90Hhz9sk2AWur8gvwMQKYnAUoHhj+Xys8=;
	b=GzL8ZJ1QU+ZYVNULIGt1+Ht8P9/ieF02RkKFC0C+sQ52yyWtHcLDLieUtKI+WcDMjbrjEu
	MDGSQdbMMAoaMfeg/TqWdvyKL+iBY6gddYrhFa66/aVbmarrULmSdWTe3cc4fl3InHnHKU
	NuX99xDwirhKqX7O5GBFmLI+MdMXOdFiCqf6CqBpu5C9CZbaGCFXaqiC8qFa+RD3G3KWNh
	Z2OzIiN0fAA3TNJ1b8MZooYYe45NbVE2OpjcpsS0jJKmigKfYCEF9ax1RUA/BljHOfg2/O
	k8MJXv4sJRVHnwEoFrsPSUihcL8K52XK6C5ICch3Ssr5iYcajbweoS2Hi8wkwA==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf6-005wqe-2R;
	Thu, 15 Oct 2026 03:53:40 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 7F6EE5C4784;
	Thu, 15 Oct 2026 01:53:40 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 17/37] can: rcar_canfd: Add support for Renesas RZ/G3S
Date: Thu, 15 Oct 2026 03:40:15 +0200
Message-ID: <20261015015336.816543-18-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Add support for Renesas RZ/G3S

The Renesas RZ/G3S CAN-FD controller is largely compatible with the
variant found on the Renesas RZ/G3E. The main differences are:
- the RZ/G3S provides 16 AFL pages
- the RZ/G3S supports only two channels
- the RZ/G3S supports only CAN-FD operation and does not implement the
  bits used to select between classical CAN-only and CAN FD-only modes.
- the RZ/G3S includes an internal divider that allows the peripheral
  clock to be used as the CAN FD clock source.

Add support for the Renesas RZ/G3S.

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://patch.msgid.link/20260902141544.565763-6-claudiu.beznea+renesas@tuxon.dev
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rcar/rcar_canfd.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index ac5d5959d8e4..74c3c3f20991 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -661,6 +661,26 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.fixed_canfd = 0,
 };
 
+static const struct rcar_canfd_hw_info r9a08g045_hw_info = {
+	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
+	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
+	.tdc_const = &rcar_canfd_gen4_tdc_const,
+	.regs = &rcar_gen4_regs,
+	.sh = &rcar_gen4_shift_data,
+	.rnc_field_width = 16,
+	.max_aflpn = 15,
+	.max_cftml = 31,
+	.max_channels = 2,
+	.postdiv = 2,
+	.shared_global_irqs = 0,
+	.multi_channel_irqs = 1,
+	.ch_interface_mode = 1,
+	.shared_can_regs = 1,
+	.external_clk = 1,
+	.fcan_pclk = 1,
+	.fixed_canfd = 1,
+};
+
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.nom_bittiming = &rcar_canfd_gen4_nom_bittiming_const,
 	.data_bittiming = &rcar_canfd_gen4_data_bittiming_const,
@@ -2383,6 +2403,7 @@ static DEFINE_SIMPLE_DEV_PM_OPS(rcar_canfd_pm_ops, rcar_canfd_suspend,
 
 static const __maybe_unused struct of_device_id rcar_canfd_of_table[] = {
 	{ .compatible = "renesas,r8a779a0-canfd", .data = &rcar_gen4_hw_info },
+	{ .compatible = "renesas,r9a08g045-canfd", .data = &r9a08g045_hw_info },
 	{ .compatible = "renesas,r9a09g047-canfd", .data = &r9a09g047_hw_info },
 	{ .compatible = "renesas,r9a09g077-canfd", .data = &r9a09g077_hw_info },
 	{ .compatible = "renesas,rcar-gen3-canfd", .data = &rcar_gen3_hw_info },
-- 
2.53.0

