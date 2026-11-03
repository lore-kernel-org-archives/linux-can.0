Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793738612;
	b=1gUNO0haMHGy403PO2XgZ8X7iaDJ+clzDcmHNDh0z7A+oW0eWh5xsQa1VJz1nTVCW032
	 4953LUrwt3pbieGWcZHU+qTrgnh9Ie01WHNVpH9q1Qe8vEnUEclvslRnOOOAFZFzIUoDe
	 l4yA+1obpT2hyBzMjDHWkjus5UMko93Pua2pGU9K+F1Cn1P5FMnniT1ktIfWlLfPmnSZl
	 K0yziYkWmagVtCDqfkjVU5cvtf+7SQGN6TzN6gyDc1KFOL4MBJp3nHVz2j0euYg/9Unj1
	 ag2w0wMFaWggH5bjD24rmT7DNxEuZACghh0jnVBOUyhoGeJZkc4kOfjuwuRmI5FzzgA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738612;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=89MNX7pzGmipW+4xzUj6u1IbnH36Pt0TeMxWCwBAvIw=;
	b=33ZoLfsGeXP3vTxVhR8k3/gB3Soh71yjAvdBpxEbOyxRlgqtqMpF/mjd/6CltcoYVe5l
	 SmiS52MBc6xHCSmJgqCNqxNwpj5hdQw4E892LLgnFgD822xxfpN3eZ47vawO2Y/Y8+ovF
	 22fANpcZq5J2R3kznkSpUdT8+Swfm4LbLbymSG+YjB909N9xQQVgsI7eqpIT+/H8TtoPV
	 JuJqH9zoTBOa7LRXlts3Gn0vpoDX1MECHi50SCEXiHW1EzmGhfJgU5Y8IZM1BbGYT9mXN
	 6xgwNywJIvAIygwAXNkWRIB6fhz/QdGqto1q1e/u/m2bIEhtN1sgAkOGZ28jZD/b3Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BaZ5NLHV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68B6606D80E;
	Tue,  3 Nov 2026 20:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D68B6606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=BaZ5NLHV
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4FF9A202BA5;
	Tue, 03 Nov 2026 21:43:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89MNX7pzGmipW+4xzUj6u1IbnH36Pt0TeMxWCwBAvIw=;
	b=BaZ5NLHV/nzrBkJaTszmPi227Bn7M6Rp702U1DXxnsmAid+PoCOAFTJwgTPRQNm0qNTZ3D
	mHTpUIWlFPXOwPgUXp4MgDab6JiaYOjBvXRIlyTyKtdIbB7lovL6sof4d2ayFlNZagM4ev
	rujqKNtzAewsFwiwgRf05/w5KdPtpEd6p9jh0b6mGQScQDKkJhrFtsd8NqtMpjWojZpd04
	QSVxDX2a3vJmIh+ZNtS65+JBiAH8LV9FCoSQ7yhSemPZgv/KbW/ffFHOYS1A9RCX6cVuEx
	6o23BYyALQgeaZfUKuzHWC5QHnsoYunBUne6qp7kybP+4t1PcyQa0O+IY6mxRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1793738606;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=89MNX7pzGmipW+4xzUj6u1IbnH36Pt0TeMxWCwBAvIw=;
	b=c9zmO5r013UpNEudxMfKuHnev4FSaMf9Uw3lvqdT1fzG3U7+G+VBPbCmiSTzj1WV9PDVgR
	wq7U37jTYyFae24zZS59lyZZ0o5S8VBOFqN6bGpZwrUUQoETee4Ej5yfj9c6SS/qZokZFG
	YKE2uxD0P19dQnrYw1CxuHRI+XG0K1WZcPFZsh0Gx+7WW9i0CGdbua4dS+rd9+vs+twF2/
	fUYB2BdAn/CLPIqGl5esbfkCPG8tFM87YaIBY7YrCA11lUaxqLeILdWLeTCKwJqUzWmKXD
	1dPkhhRnx5wMIpeU9MblOqB7AFoCILgAFNg132Mj7HgPt3D3Ww0FVXzBdWT95w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1793738606; a=rsa-sha256;
	cv=none;
	b=aFt38XBVN4CdSREZ0oJnHiB9a3v7nniDcBCO2zTfMGDpsmNy6x2v4LpIOMBdp/Nl4v2BSn
	oTcJ2x0oWs5mujOpn3A/bCMvpJqmuoSe6nOVldHfpWiAGEQWufcxFfKlTC2wkAKljs9O6X
	oApGbTU0H0z0eZmqs3taZFBRlzpxOFVH0cuDSk4JAQ6EKw2qLJGnJRR19h38xPZCslJhkN
	CnCYsXk/hvsJEnfYm9ju7b6YD1yhz8cK25aPIWvhowMHfmCM6wLs/BBaJtaXhQY2wCPpbO
	Db1Gt2xBhAMJ/AIM0ZQNXEzcZiS7pLy1wXIWSNucy4F2NmyOCnN1UbIuGqPynw==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xOLLq-002V93-0e;
	Tue, 03 Nov 2026 21:43:26 +0100
Received: from blackshift.org (unknown [IPv6:2a00:20:73c1:227f:2cd5:5d72:938f:f03c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id F37DA5DDED9;
	Tue, 03 Nov 2026 20:43:24 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>,
	Vincent Mailhol <mailhol@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 14/15] can: dev: can_tdc_fill_info(): don't read automatic TDCV if interface is down
Date: Tue,  3 Nov 2026 21:30:35 +0100
Message-ID: <20261103204305.3211144-15-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103204305.3211144-1-mkl@pengutronix.de>
References: <20261103204305.3211144-1-mkl@pengutronix.de>
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

From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

The automatic TDCV readback calls into the driver via do_get_auto_tdcv().
Some drivers, such as xcan_get_auto_tdcv(), read controller registers
without taking a runtime PM reference, so calling this while the
interface is down can touch registers whose clocks are gated.

Gate do_get_auto_tdcv() on netif_running() in can_tdc_fill_info() and
adjust can_tdc_get_size() and can_data_bittiming_get_size() so that only
the automatic TDCV size is skipped when the interface is down. The other
TDC parameters are still reported, as they are meaningful while the
interface is down.

This is a defensive hardening based on code inspection; the automatic
TDCV path has not been triggered on hardware.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Reviewed-by: Vincent Mailhol <mailhol@kernel.org>
Fixes: e8060f08cd69 ("can: netlink: add can_priv::do_get_auto_tdcv() to retrieve tdcv from device")
Link: https://patch.msgid.link/20261027065012.191348-2-chunyuzhiqiang@yinhe.ht
[mkl: fix open parenthesis alignment]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index b958c04d53db..081dfddda000 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -720,7 +720,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
+static size_t can_tdc_get_size(const struct net_device *dev,
+			       struct data_bittiming_params *dbt_params,
 			       u32 tdc_flags)
 {
 	bool tdc_manual = tdc_flags & CAN_CTRLMODE_TDC_MANUAL_MASK;
@@ -742,7 +743,8 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	}
 
 	if (tdc_flags) {
-		if (tdc_manual || dbt_params->do_get_auto_tdcv)
+		if (tdc_manual ||
+		    (dbt_params->do_get_auto_tdcv && netif_running(dev)))
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
 		if (dbt_params->tdc_const->tdcf_max)
@@ -752,7 +754,8 @@ static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
 	return size;
 }
 
-static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_params,
+static size_t can_data_bittiming_get_size(const struct net_device *dev,
+					  struct data_bittiming_params *dbt_params,
 					  u32 tdc_flags)
 {
 	size_t size = 0;
@@ -764,7 +767,7 @@ static size_t can_data_bittiming_get_size(struct data_bittiming_params *dbt_para
 	if (dbt_params->data_bitrate_const)		/* IFLA_CAN_{,XL}_DATA_BITRATE_CONST */
 		size += nla_total_size(sizeof(*dbt_params->data_bitrate_const) *
 				       dbt_params->data_bitrate_const_cnt);
-	size += can_tdc_get_size(dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
+	size += can_tdc_get_size(dev, dbt_params, tdc_flags);/* IFLA_CAN_{,XL}_TDC */
 
 	return size;
 }
@@ -825,10 +828,10 @@ static size_t can_get_size(const struct net_device *dev)
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
-	size += can_data_bittiming_get_size(&priv->fd,
+	size += can_data_bittiming_get_size(dev, &priv->fd,
 					    priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 
-	size += can_data_bittiming_get_size(&priv->xl,
+	size += can_data_bittiming_get_size(dev, &priv->xl,
 					    priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
 	size += can_pwm_get_size(priv->xl.pwm_const,		/* IFLA_CAN_XL_PWM */
 				 priv->ctrlmode & CAN_CTRLMODE_XL_TMS);
@@ -910,7 +913,7 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev,
 		if (tdc_manual) {
 			tdcv = tdc->tdcv;
 			err = 0;
-		} else if (dbt_params->do_get_auto_tdcv) {
+		} else if (dbt_params->do_get_auto_tdcv && netif_running(dev)) {
 			err = dbt_params->do_get_auto_tdcv(dev, &tdcv);
 		}
 		if (!err && nla_put_u32(skb, IFLA_CAN_TDC_TDCV, tdcv))
-- 
2.53.0

