Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795373340;
	b=fTG6sOKcFg3cU4QkJD+e7SOUJTRN4gg1TpWPNPZOl5pWwJ6M8RnfZreSuW82WLl6U2sA
	 KsX9jxLywFJFhYfM6z1imZgrXjaFAc54Kpia0h06BFCAoA0RH9NF5dXLiWouCTYauKjjR
	 PXMnoa3f4kDSwRR8LlitRdIuPtmQbppvN3hx5Tqbsbfv6lqGAYhpnIGn++MbT/OV3tXty
	 D52yE+dCLsjzE1BIfIwKJ7gS+wwItaMIHK4RpZgDxpgzcpbq+Epz5F3m/P+XgqAOAYBWm
	 YWH8jIZCbolUf4n/N/P8+wX3p0peoUoyTtfIQ0NTWfNH1s3TX54xgRg5YwoPR+k1D9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373340;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=H1qqYU0/IXm1ZnpUgNcbDj+Y80Tg9ZgumhIc4o97lGisSbA02N7SY+xpiem0XVH461IF
	 sv6tYvPB+yYJs72BjMwDC+f7CX0dej5qDIHCbulSkn/i+Uxe3wkcoGQCqNb7oXYIg6lfr
	 6tbnXG2GSQdpaJTj1F29ZaQLq7WV7iy8fzmUtDkEAcbi7uRosO2Wm/zTal+UkmEw+CXcm
	 sP+vyL4cG3WvOauAUS1RDgNJMT57s9WGyc/wqoGSpWZFTFwKrrdMl/xm+3KRt4DfvHAyk
	 kglF6qwP0DwtK/em1mKf54hFXRF7K1N3qo/2j1BwaggbmOEGIXIcMXtDdBssa1tjSAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=W3bQbsXI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C762E606A689
	for <linux-can@vger.kernel.org>; Sun, 22 Nov 2026 18:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C762E606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=W3bQbsXI
Received: from hardanger.blackshift.org (p20030102af17cb0015d71b554e0d6387.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:15d7:1b55:4e0d:6387])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 34F04205B34;
	Sun, 22 Nov 2026 19:48:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=W3bQbsXIwDdPdVYE2PZtPeK6VxRYWQDv4F1wYneMMnyJwxIY7nXIOCXuc+4xKiKmSJGGgF
	1hq8hzyTEU5QDswhYkBRbLgZldUFGRFWAZ2FqItlaSlC7s981Doy/BMGqOiuiv66UXxm9m
	Oq9AjJ+uxHyYbemmmC9LSjdngCNHW4x+yvV315TnqaJ5sPVffHCfT15khoJVjuCkK32i1b
	e8X1IXAI3pOEopqVVK8atH+BQl558++EIYtSF3elBY89MT2s2ZXaPQThDl1XZJcNt3mkxg
	fQR218fEj69TxqG6idYNZwgyWse+bFVdLKkdYH6vYmyANxXB4dIxnt0gusCN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795373330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XbAJxXya4D9OJ1XIUrXGfWjYjYgdR8PzPTNuCUUq210=;
	b=BWoKoNT0SvaaYsfGXMPw7ghK8nA78HKEVc64gGNO1F/KPWdyK8DemJlzMRZ5Ca2dNutRec
	w8Mbp/j7ZsbsLpXeFimtdLqdNemFnP5Ggn879vy+uFiH4RKsyjICzMHj7CvEHh7FffpaDP
	EA9jXU/8dQ6SeN60vacKj8vk2IWaWYnIDcQnvzo7rx4xeeRqzBNzWohq+NtktRzoGPcC+a
	koyhRrujoYS2or7n9/8E1L/90Rl20jOud/1bqcLXsvMir43MneDCZNyCetFjHVRti/MEE0
	nc4QN7mhgV6SZVsKL354/2o+MP2UktjYVuknIgImb/8yd4VeKeir+pMzNPtVnA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795373330; a=rsa-sha256;
	cv=none;
	b=epUtxqw35/5A11m/Y/8m4gP5JhxfD2OA5TOo3kO3BB9Ml9eRbLhMUgTg37zg76uyEqKC6G
	ZwmQxJjIyVanmtAwO4nzhMkP5mYEjr24T5/VxVazlxJZ0c4uI3onMrKhApUiB9LRQP5QTd
	a8TXO3d3yV59flpiQSmmzOy1hkHyvay1JjVQXMsYgw9qN5MemkA12bac57hXnb1LdyE8Dt
	tO8vPv7pe8gLs3eKsNtfumUWPuRr2GTyt5NdIHDnmvhBvJUS9Dj6m9kCmn61Rv4vvGv1/P
	xkhOiPNZCbep+poCgGkm/4pVmypc09YiHiLuzVZETYTYF5nZ8K4e5u4VzGNndw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 22 Nov 2026 19:48:31 +0100
Subject: [PATCH can-next v10 07/14] can: gs_usb: gs_make_candev(): check
 can_rx_offload_add_manual() return value
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Post: <mailto:linux-can@vger.kernel.org>
List-Help: <mailto:linux-can+help@vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-can+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-gs_usb-fixes-v10-7-7c165c35d04a@pengutronix.de>
References: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
In-Reply-To: <20261122-gs_usb-fixes-v10-0-7c165c35d04a@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=umwuiygkz+GlsP+TXLbZeiVlj3Vb5MSZo7ti7igGEY8=;
 b=kA0DAAoWzDpk+q6ZrdIByyZiAGsDOQeg/XYcEJVWN4H0MmuRABFRRGOmsxwjTfhW89fv84hNR
 Yh1BAAWCgAdFiEEpfjIIRBRQHWN6WCSzDpk+q6ZrdIFAmsDOQcACgkQzDpk+q6ZrdK1aQD/ZF5e
 28l/vFI7eY1M5lwfqj8BOHiOsykOu1JU86OcBSEA+gNeZjfbGy69yGdVfU00ESzBJU+zNT2OvIr
 4vKTtk5QD
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

gs_make_candev() ignores the return value of can_rx_offload_add_manual().
In an upcoming series can_rx_offload will be improved and
can_rx_offload_add_manual() can fail.

Check the return value and exit via the existing free_candev() on error
path.

Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
Link: https://patch.msgid.link/20260907104942.17089-4-ciprianmarian.costea@oss.nxp.com
[mkl: update patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ab82dc07f3f5..308daa2645ad 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1553,7 +1553,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	if (rc)
+		goto out_free_candev;
+
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	return dev;

-- 
2.53.0

