Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794564538;
	b=txBPGwhJJD0z2W9wE5fkojysUKIj7Fixq8Nn4ev3yyKsmN5C6KokA1ANQwkHdT1hquxf
	 iabs7BAGgFtxDmZu16VJdOS5b0eIS3I4db6qprmNAKTnlR6CH8ttOGdN33y0XjYSdWaoC
	 igPmzSAwlNYBkIbspl3xB6gRic9X5Uztz4Pp/Yn6UzxJ1dnMTmPrhPYnFYyAJrRLJF7Tm
	 jj1Mo3IAFpbGJ/gRjAHBTKP5MWNHWhWpNIvLz8cwf1sZ0IHJxfYdFXsJ+sVM6mPRH+Qul
	 vXlIngnvKz+4A5sd7R235bYbWoTRFm8TdgV/pJgRypZ0D3bSfEp43D1syCTxej2G3cA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564538;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=o7hxRptin9eWkiSjFoFQglr2jYjE3UKmc3oKp6qJ2cjzHQylQe5w42SD1eunawFKY3Hf
	 UkR+UjMvPWMGX2rv1tA5ZkVQtbcc6bYgxV/c6hSkVgfz3Hi1WTcsNUWFPI7636oigXUaT
	 WTer2yNDkl5yv4IaJ7SrprVoqxoOOR9J8WmwnWFw2Gqf3TbtWhtZ+o3Jgdz48jW7bt/vC
	 lEezPEkNfaFr32Ycl45jnpoK8gcfGHYU2oSxq+rsTSYu+zWKoH0RmmPyk9Qdq9YsFEGm4
	 fv6or/EdQ8fFQF1rP2zzOFvouuuewb8JVOckZ+xRogDgwExTH1wBfNFtk8WU2STaGVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VUrmcipC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A9D606B11B;
	Fri, 13 Nov 2026 10:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4A9D606B11B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=VUrmcipC
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 73147201FBC;
	Fri, 13 Nov 2026 11:08:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=VUrmcipCJ4cJXbjvgbWZ5RUn4DIbaBK1NqBLODK0Q06KG4Zaa8bFn6/m/tDUxaIR84bJhC
	2fEsIJnqKJawFqaApZgsfsXk/DfjWnjmJaPeKHwI178nrsuwdXLFzVTmENngRFyAMZ2kHC
	gnswKONBExfx9RYD6MTwxnuVYIFG43Y+XGwvba24gr3/SikEca/UJW7KB+RZHQJa6SL5p0
	uhbkuHz0qH+bUlELiQ/lks6pI7rXAAVybCMSX8T+V/tikMT3ooRW6b5WxusWVgdCNwD6E0
	V2pl8+bNG3xkQfy94NkNnGvVjzaS0M2f237Js8fZXqLrSD379U/Rit9vyKFxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794564534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BbCbmfH5aNDggTnY/TvXrUyuqRCt7S41aYnKGjFfLzE=;
	b=WS+8WdI3HtRfbVI3bhaojcnMzyJNYyTRNjIXh/Z3+/Od8xbUaChFnXvbkDu2LlJPhzYffG
	g4Db7axFaVcXaneFsdYlWB7RMQA7ubCxFP0Iefd9sweJBFn5m5HkVeTOkWo+NBsekHfQfW
	O6xGdsZNEoO85JYU1A9rJGS2IARm0rxKYzKG3GsNEj/VRaaSsc7LNoyXl3LiOyBoiu2dBB
	rCaPM1/nj8hKsK1B88GY9Iq4qXvJ97aFsvvO0AKLH4hPqQlmBInVuP/c1UHtKJUAb+o8om
	c5DBeUSwRDwMD0g7gD9qqf7vuxnZPiD2nMS3WiA7iG/Q0lwVNUWBTN5XgIXJNQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794564534; a=rsa-sha256;
	cv=none;
	b=b1+qKkLdJt53RCDlLZb8D2rP3CHSVUN4WdLe3kFnHs+01ByJNqnyb72nC6QRSQw04RLSkv
	kFVS7NvCCQ3KE9J8SXJF92L5ZKvQZStO1cZDGDjne1GOvNYHB0iLrM7OxWydmNDs2Pstmw
	n4MQ8KKjtG6W2kGXRmOQTnx8WRhZl5nc5NLmqS5zZsO+P+UuzrcJ2GEeJ5mLs/2KayC7dH
	hEwYSWGYDh9zstZKB5uuYsEU8JeahhhJSQ8phqwVI1G/ZhkEU6eBxEJVR0Us2TPirPfTOn
	kqTQG6aCJ3KU+JJK8c+S7uyB03oADxYnK7wUKrpvDLLkKchxGL92N83VAFJCuA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xRoDG-003ySF-1C;
	Fri, 13 Nov 2026 11:08:54 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 1C0BF5EA84D;
	Fri, 13 Nov 2026 10:08:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 13 Nov 2026 11:08:38 +0100
Subject: [PATCH can-next v6 1/6] can: gs_usb: gs_make_candev(): check
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
Message-Id: <20261113-gs_usb-fixes-v6-1-0c039e1bfd74@pengutronix.de>
References: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
In-Reply-To: <20261113-gs_usb-fixes-v6-0-0c039e1bfd74@pengutronix.de>
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
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj69nBdSm6QfLNZ05MdpUt0VnotKlg/sXni+dNr434eq
 uA8Nk3fpaOUhUGMi0FWTJFl6Y8TigKBDqW9LxMmwcxhZQIZwsDFKQATmabC8Fdi0szJoYyFnmem
 Gr3+l/KsUySImZ3rnroJr4fVB/NPD90Z/meccgyy23f7W1Kx5p8ThqUXNk/4pcpxMH9docjdUu5
 N8/gA
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

