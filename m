Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794171225;
	b=elD5F98XRh2JRDrU7Pr30C01OC5TQ3ZWeSQ694N0TpaGBj8V8hxYqMm58AUV01SrZNZP
	 1gdlZHF48eyJcNaizDZGxMUoq+XDHCrs5iDwqaZp4GJWFa39PjfgKGzm9csibYEdTjhBP
	 5MTc/AUSqVkyU5SgyFAkw9LeRb/9Q6Kljhm4GAGP0V32saAmNUgtVu54QdWQNIQPIO5Z4
	 36YAwLwBC7H62R6tY05+p7IJKmK2Kssvp2gl1J5SIH5HJcIW0ZMVXmKwV8hWnOnFHdz1U
	 4b8dZbiASiSmm/Qc5Y3EXJ3K/eProfVZ2+LSDrOuT8givtYT49jzry8Syu9mKB7WPWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794171225;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=bmFFn3/Z2Q1LNsZ1Gf8fLFKZr5NwarA060JG0/FEPaRlehpgm0OlsruREbdJWqEOtNRn
	 eRLZjoIU+QCPhHzjSe8M2wD+lhKxotMwUWDucfRys/r1omCABThIkOELysjvwFHm5j5/k
	 LuCym9XtTS0O0jJ/y2SaV56r6+7UgdGN31tammgtTcNjsmg3V/JFfvTm1ZJg2cXu4xTkw
	 O5fvjgcEKjVGPslwLMd0IF60qVCzgWnsBrOPkPUzJffZTeRV7SGEjDE3LlBvGty/1I67h
	 alz4VVx4obZI1RScrpqdQudrfKgSFA6BxAohOTb1C0DxWscYVTtlQ7oCE7qi84ffDxQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ViiPa5g9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC31E606A322;
	Sun,  8 Nov 2026 20:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC31E606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=ViiPa5g9
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id CA69F2017DE;
	Sun, 08 Nov 2026 21:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=ViiPa5g9Zl+Z/1qzxTig8cO/xbUBZar09NO1aZtQyPmsHOZgXdCAlW5O2SjNdhqjM0IzgY
	0aDm+gv54DKoSjjFv2pyZikCxlRkxUjaVamzgljgcik/ygtajrpNC4LGF68Nxolw3rC19z
	vdphNIFXDc8gLsYLvWMs80nDkrRPiv7q3gn/UJLGNeVlSXwjxEGbO2UOPDnv9c0kvLe8lc
	+spwHNSc/bC2l5sKp3ibkcIncHqaobAIRO/hafE1ydUKviQ2rBnnzG1qM7O8KlhL/Op6Me
	drgrO0XDO3phGxdoBJC47jKWwwxXi0xFfkWZw4Tm+B60fwfs15A4F3gIOxvqKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794171219;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=D4wbRcbyYd4HF+I9xKQidVLJeBQG0detyNsejiS2KktHe34gmVdk45BW/husXdpevIx87U
	lsqMmlkBjrPGfVtzXZAMWd9cr5KU0fI3C2PwJSpQh0yxBCFKc/3kJK5i7XcR7Z8I/32+zB
	NIQxNqT3zWEwGrMYcmEOu/40EFlm32i/Wqt9ZizQOMUD2a3mobisOjlivjL1hXkyJjwV8j
	Op/Fqh9gQkxp+S6vdqmVRxkgLYWfpstGOeUhz1Z8EqQm2ABqZN5F6tOg/Lzfqx0lw13gE6
	mviDxhC28yHy2P9bCDCT7RH5OEKM6p1XvUDVtJGPyKiITckw8N9RRFZTatD2rQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794171219; a=rsa-sha256;
	cv=none;
	b=B/6EhwEpYOqq23XVpsn+cpLqm/dagGPe/6g44vRbQJJ3GfEvYzO2rnZRCmKaNxjHzD7jTO
	cdcmOb9W8AH4N1R5lp/EKIFQnu0zk2tQwmaCOeqplUvjGL+QQGqEsbJtMXB67xzQ1yJSpt
	afvaIsS4TOTrkhwJwIkGf1+n2yrjYtXCeUSSzJKNduerpa+ZCW6ijW82l5GzTpS2QA46Jz
	kJID/QyANLTj7O6yosO5Mwycq+SHkBHXYITalpeENtBJoxKf3OouVgZO1saQFMI5dHOhDC
	8JRK9Z96pvhuojBt3M1yQe7p50VXvXcsW7KWkEjUYH+bC3u8PuNOtFEAzNbR+Q==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xQ9tT-003EmI-2B;
	Sun, 08 Nov 2026 21:53:39 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 557065E3E71;
	Sun, 08 Nov 2026 20:47:37 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sun, 08 Nov 2026 21:47:22 +0100
Subject: [PATCH can-next v5 1/6] can: gs_usb: gs_make_candev(): check
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
Message-Id: <20261108-gs_usb-fixes-v5-1-d52dd4940d46@pengutronix.de>
References: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
In-Reply-To: <20261108-gs_usb-fixes-v5-0-d52dd4940d46@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=1348; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=zffLvP7VZcrRejT0K14UlY3vr8E2G4rnUUezo58AWlg=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6cP/RfE2u8k+as/9HbVlm7iU9J+LJJKOP5jdinvN9i
 zOakr3yaEcpC4MYF4OsmCLL0h8nFAUCHUp7XyZMgpnDygQyhIGLUwAmckSRkeGr/wszSTnuzWc4
 q3RkQ3s/sv9hVfNfkcsae81KaZtdgCTD/8ry9YsfSv3ry5dbpv2H77Rm7VnxPdV8knv+vrbv0bW
 qYQcA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

From: Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>

gs_make_candev() ignores the return value of can_rx_offload_add_manual().
In an upcoming series can_rx_offload will be improved and
can_rx_offload_add_manual() can fail, leaving offload->skb_irq_queue ==
NULL.

Check the return value and exit via the existing free_candev() on error
path.

Fixes: 24bc41b45583 ("can: gs_usb: convert to NAPI/rx-offload to avoid OoO reception")
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

