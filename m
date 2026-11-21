Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795300585;
	b=kZwBiE3uLZER2sedzyw7P4OFQACrTv9w5eMZn2PkyZQ1POk6WIMUe/T3NXl2ojJVizvq
	 D8Onbadlpcv4d5P9yChA1av5mFpivNrqWflsWMre1aeew8OTCXHqUNOZe3pi84Nsb/TzS
	 9WHhJwfnN7Wd5ekj+MqkBuXzB7TGplYZHJuwPe+RwP4hcMAjg08aqw/SZjksK16wyBK8r
	 LES254Vw7hu/f7PH51DA4ihB4PfAptUYzv592xSfdnSXU7cIpkZyrG1vEGxD34djDJWFX
	 P5rbfOuoKGoCXCa4rwHyjKB266F/iw+QsFXLtZRIw8jgdCT8zik4s4xJfEFalxWlYPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795300585;
	h=DMARC-Filter:Received:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=xPvrXgnrqH2wNT04ezI1WMYaFePrPN5Yk1k+fYDWMUI=;
	b=3uCTv6BOVXBzyp6XZOykzeBlF7eFCeVp0/1lRy4yLNPgVpImQMPnDVjkS1fX/14Kk2J9
	 hgAYSgjaSiCHsZS2eGfUpuvX8YQe8GPFOv3fGyN5WsUn8LA8TBXcW1zX7siIaTHB7wmUu
	 XPblPnDv6NNMjhPGsaU5f3utfzKRTo9uh/bD8LSoj09M214ZM7FHjtwggze6RojjuzPRe
	 W1vNTJFRdjCzBwibOQOV3LngpAEpGLSxZgwIm5ofrUyPlBc74z3wKYexNwVrI5H4Gg5Vk
	 H6Jp677YtpKfXMnnUpO+6pbhcGaoR2ePAZfxbyJ6pbPqoCIZB4ZdiUoihi6Ehcb2Fgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F5l7dpii;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7AB606A334
	for <linux-can@vger.kernel.org>; Sat, 21 Nov 2026 22:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D7AB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=F5l7dpii
Received: from hardanger.blackshift.org (p20030102af17cb00849b19770537dbc5.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:849b:1977:537:dbc5])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D3A9C205B34;
	Sat, 21 Nov 2026 23:36:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPvrXgnrqH2wNT04ezI1WMYaFePrPN5Yk1k+fYDWMUI=;
	b=F5l7dpii1/r/OTvvYfzaMS0RhsS0LgYji8mEaJyK/Hp6C18sEsNwhZfuS5eQYMZ6Tf/xRb
	m3jQoz98ANtAIIQkrE0YQuUjjk8hBvnH8frEKCQZdDy+rggTTYABnKL6LprOqdjnbDgLaw
	/97BQgtXV8qPftOVXBXFVPrjMDnMB6/bWbzSVye7m/fnZk/m9n3qkRu9By7Ujyp6Dn34rf
	F+OIeyYfC0LVnq4iI+/dwlOYh83kOfdXqdD+XuO4YliNSeQMMZuoaPhuCA9k3L5gh202fP
	KergLeEyi5bIvxPcxHoYkZKgaEyj9MxYx8CWVU6SbrfxrXLd/DDTIqR9LT/7PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795300581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xPvrXgnrqH2wNT04ezI1WMYaFePrPN5Yk1k+fYDWMUI=;
	b=XECT6yOojlKn1TDbfOV5Ow7QoP1gKHdiL1e/V2mWXOO7usVCpeK+G7LR+AdPmKKsoQq2mn
	YaJ13dz+Qq7BwhmY7ZneeWj8R/NtQqdOm1pM9CRl9w2enjdLwMLvQIk50doOBjDaxCbxgz
	JLMFSgyYRN0Y1VEK1Zp4iNNKqol9bHbXZXxsFrzg0mDcfy2M4XczX+VGf3v+0aNZk4HpcU
	qH9+gPvCJZRN3sI9alFLasaW3dweYSNZd8Tgkx5WA2ejdaEjIZQ266NjDvKaon8WKxm6ZJ
	0NHzX6IOUdJDl8+R1VVnCeudNwuF3NP0OH3VHsKtQXjV8s4xludNmmffNWAWHQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795300581; a=rsa-sha256;
	cv=none;
	b=gEzheyZbICpoLCquL6CEXdfBpmzVNwFHWjXuO6uoYK6MPz3j9HIl8+SCm4T26lLLea03Ul
	52minodXow0YOR4vn2PvpogtXiw1cAZqTUsnLoMwaJd6GsavVGPC++3Jiaz6JFHi/6nHFl
	ERpeneElpfvNgXVNUsbCnGyk9b0lP433/Tmm2cCCXdqQN+VHXw5zbpiEO7Lc2BWNqzcVna
	2bwL79gvFYIUSZzZBc+fPdXFbUC0+cdoFSLokztwJoo9kMeTDDz/2hLmsqj+dOXHXBlNlX
	Uvv0KtSn3oQLOfVIxPItkjIFy/XLht90M7qg2k90ycQmXKqlMgq+mbYXXgutTA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 21 Nov 2026 23:36:08 +0100
Subject: [PATCH can-next v9 10/13] can: gs_usb: gs_usb_get_gs_can(): report
 channel number out of range error
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
Message-Id: <20261121-gs_usb-fixes-v9-10-db121d488945@pengutronix.de>
References: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
In-Reply-To: <20261121-gs_usb-fixes-v9-0-db121d488945@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Peter Fink <pfink@christ-es.de>, 
 Eric Evenchick <eric@evenchick.com>, 
 Maximilian Schneider <max@schneidersoft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-1b309
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=V8b0JpXtoiNMWRcJgIY5r7glGqg9yPUif1pzpEbZHL0=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshmkrm37lHcGd3bW5IVme+aXfy5tTD9w3zHaD7N84rLH
 3tfrn6S0FHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJlLEw/K+ddJxl69FE09Rt
 /iqnRG6eyovO+9m0dOrPZ1aGOmseVWYx/E/w84pnLRd4nci9YcPpjVy7Z7V3LU8L2uGWEfNmg8m
 xTh4A
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

If the USB device sends an invalid channel, the device should not be
silently detached; instead, the display an error message before detaching.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/usb/gs_usb.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index c392cf65d8a6..aca4f4fdc796 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -668,6 +668,9 @@ gs_usb_get_gs_can(const struct gs_usb *parent,
 
 	/* device reports out of range channel id */
 	if (header->channel >= parent->channel_cnt) {
+		dev_err_ratelimited(&parent->udev->dev,
+				    "channel number out of range (channel=%u, channel_cnt=%u)\n",
+				    header->channel, parent->channel_cnt);
 		*fatal = true;
 
 		return NULL;

-- 
2.53.0

