Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794669477;
	b=IuXg+onytnAixTyOe/WHNdq18b9qOf7TxNFBWnmxSh+I/iyzAEsHhwk6dzsmRBBfWg5/
	 nKm7QK4eeE+n+zrDmpGAtxwjtBIDKq7GnaxWJu2dy6Ka82YN1MYABiL/TW4U11elUcNou
	 iXI0oxdHZIYbSO2QtSDhVNDVIR4KO3COTXOM5iuDlmJBg01Vj7zsJ49HI8siecb8dfSTj
	 YgM+89v31ADABraO3b5Z3KlZA0KWrc3W9trdx66sJw/8Cgox5QB+uyt1EEWPQ6FAk3vgb
	 aa+NIRYmC+VzKt/vMR5beTUJejo/wZy83zwYrgDCq9zuNGFuMALBnDS4IKqqX8JcUVw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669477;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=KIfS6YG9ABPqsnekw12mEnIlzB+FVBDlGpf+hBw1hoKyHB6nwQsj38S3OR4rdjFEBJ2o
	 ufELp/3rgQiS6LhI/sEsUIuk6TxDqldXriFvrkOlZeDtDrHNZOu18i4ZAXFaYkWdST2MH
	 BSIe6H8gyu3ivNsgZFQsTtypep6g9mDogm6YW69Oh/kW7nehkHFd1IpD8HKiZoApEfB33
	 zqXiRdS6+Z7TVoGB8Qm0AbPXdaLVHRRjf0J1nPXy0fGCsk/Mk/NbVydoaXOYJ8wjl/9Z1
	 UXvfb/l0wlBA9JMRgwO4Q67V2skKa9deShUzPSgPlhR2BQGNVOY3meJlwvncZ1q1dKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gYbNRuD9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90418606A331;
	Sat, 14 Nov 2026 15:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90418606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=gYbNRuD9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4DFD82022D4;
	Sat, 14 Nov 2026 16:17:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=gYbNRuD95/7q+wlxNnPP7ZR23LkSxF33SJ0R8ctrzcBgoQxCBQf6aAPHsKnkV0ufwPmAwe
	l3AxOPRxWNRPcbQXzWDWIWndE/95TUMbGZWwQAVMKZfzNkhYyjyzsLZygA/vAVqcyyZWbW
	F1/l6QUmbSfdZGtwlKjqSZILvexYlO/XCgfJCozqQiJj8lmLZMR5XP4/C6Ha27i7eEtRvE
	CdYwslwYBeyXt20mryNk6VTrNhqNRYocLtJucjx1akAvYRAY7Dv6y3abg6DNsgJdfvn45j
	FAzieuhnQ2r0Ztf1KZJ34bVmY9ufFJmN/0TNg0fPoiHIIwLAiLdc1aCnlXBsJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794669474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTNNffNGrezd2iT3OgWcAGNlhXiNqaOanyiqoANbC80=;
	b=E3aAbuq0oyobSD2mSSgs2ZIDaigNrfqY8FpQbcuf/pTiM5G+fTstRHZI7FJMPiWe8W5Ysq
	CwctenLlLFtQzROUuXgFUXGPPC9DDEk2EiJ5ihnRjIAj5Jyg+NJWNvAtfEvue93O8b69XE
	t7TwGW3YnG62PMrZppT3CVHPXOfg8ESLK9EyobpqZAavnZn/1f6Ex0jDXuk888MVM+OjX8
	srlRscEUOgAOERrlaHa8NV6ir1oByS/GegnC41zEpeO0dZy/YXe+e1xxyoMR4IMrJGdAw7
	ws4xBAojLBRNQjDfSX/4OAPi9Kp0SK5JWvyRtQMuhYISWo7Kmj91IzxOpiCucA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794669474; a=rsa-sha256;
	cv=none;
	b=gynzhQFcirNcLGRSFrLMT0nZl9ijPjX3YlKkSNp8rDUWt0+nW4l856XpbO8ujz3TRVO6iP
	/xOVVBRl7EJrW/qj62Yd/4eoklzJhq3b4/fZmlav40PuK2rwXTPN9axwBASU1Vl3ej9R7O
	67X28SGqnnjtJjUSDI+moYJf6/odX9PAFO/F/SlKH0no3URB9DjWNo3KVLWNpxOmbz/gSW
	ufZyotJxdz3lTLZZ3zXhNNQDGAoqeSUjbwUHtgF9hfqBF/+O7Seuyt6/3IS3PGq7NMKHLs
	99MndjLqWCMCOSZKgNRLOFALgPFgMXPKKap+gpfjsyfmGhOsfE/WpW2uJCDrkA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSFVq-0049oC-0b;
	Sat, 14 Nov 2026 16:17:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id E13DC5EBB2F;
	Sat, 14 Nov 2026 15:17:53 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 16:17:40 +0100
Subject: [PATCH can-next v7 1/6] can: gs_usb: gs_make_candev(): check
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
Message-Id: <20261114-gs_usb-fixes-v7-1-58b6341b1c08@pengutronix.de>
References: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
In-Reply-To: <20261114-gs_usb-fixes-v7-0-58b6341b1c08@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=HrJ42yGVaRq800QIonNvQZfBfXcR2a54KKUkfxyenH8=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6UT2rKUC1b9lMezYGg3/L5hjYXv263TfepfyJcrd2z
 eIz018v7ihlYRDjYpAVU2RZ+uOEokCgQ2nvy4RJMHNYmUCGMHBxCsBErMMZGball3/y/8Q09a2G
 ZWe99PWVUgoHr1z2mT57tnT2sox5Z1Yx/HeXXDhrkc3/vtuJU+Suvw0ycPT9PUF66Wur/9rbTq3
 5+oYRAA==
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
index 3b9b2f104d86..cac4ce323a1d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1487,7 +1487,10 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 		dev->can.fd.data_bittiming_const = &dev->data_bt_const;
 	}
 
-	can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	rc = can_rx_offload_add_manual(netdev, &dev->offload, GS_NAPI_WEIGHT);
+	if (rc)
+		goto out_free_candev;
+
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	rc = register_candev(dev->netdev);

-- 
2.53.0

