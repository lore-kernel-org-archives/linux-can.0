Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794661041;
	b=Sva6dGDVjCq6swR92oHIjxdAPS1Ena6kuSdZ3VVdJS1I2k8+boMs6yqihULcbHpssg/v
	 JjmpJHky7FYhNO9ueYp44uP5ZTjYr0S8RsdkptxKH/oKBxFBMQzppbQixNaGMgkmr9LqW
	 fyR2rUUia029tWC6FSa3ejxBX9b3EnbK9Z9LCr1paSivZhB7WQ1hROoL3OItDBLSCtNiQ
	 pEl1PBXG8ieHE1vL3ylic8FRWqDxX7o3yhf9i0wyCgBI7uLNhmXXBtbdPx7d8Y8ZYd7Cl
	 7qIHsUb4TkF0QkPpj22CsrvEDcPZEcWzICJYImIcdQdNl+oC9B6aWkCVDz0r7VGXwOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794661041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=uW99tuBC9pY1r0T5+MwQlm7tY050uH2xDmx08AmNINo=;
	b=TchUwVl+ny13hwmCR7DrCvzwvBcPzJ084kevNcwVw+IXm5ELqdxZwPF6TA2hgzeZt3Mw
	 kXpwdjYq5ieVxNW8X4rAIC65XoGJVsqQlrsQC2DujUuWXlja+Z4cHA96X9V406vWWOKbE
	 xae6APsNM5rEWqsnrbZ0jbGPPF++wWxQqXHPIbuHgQf04b780uQn+pv7aabnHxXE1bJ2O
	 GXx3E+lzAPnvDAIKOB3GufGta/fJu6yNXk/nlw7EXX9hkz8hc+yriH6zyE0BjSxHpBqdp
	 UldFXZbMf7McPQUvxaMDBkmizLa0I1f1qA5dcDjy7+S9zb/1uuh2Q0YkYy3lvnkexWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UV1myAGl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FFD606A32D;
	Sat, 14 Nov 2026 12:57:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7FFD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=UV1myAGl
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id DE51A201F48;
	Sat, 14 Nov 2026 13:57:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW99tuBC9pY1r0T5+MwQlm7tY050uH2xDmx08AmNINo=;
	b=UV1myAGls64kC/1gk2E8DKvUQUYW4gVTmyo3yL848SH4BqBRNE1Cr1ceXZ31eCetxF9ktH
	FLnZZ9aB7u/XSpjOI74na++qA8bIhQxMgPResfRKKymLz+gQ4XWgf1c+XTGiIoj1A2+9Cp
	02jsAc/4TtXBKOPBWyNPKldyTywY1X3oP+5pDzvHmKPt5kyD4M/a86G+kP2FrXjPbnJW73
	w13fa0xJtY91UAGsUlyh1B11Qz6GSWKGBOs2UZSN6tqktop6kEGhKlJjF7OYFXaZnjIEZy
	K+gNCsZpf37rQ7eamMi2+rQWl/nBqlBPZl9Bu9ulLX3keTlzAM3OSBrw4S97lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794661037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uW99tuBC9pY1r0T5+MwQlm7tY050uH2xDmx08AmNINo=;
	b=QSIfQId7PdpnwHDoQ4/NBMrS6+qa9UmBF63kdHc83qK9/f1mNqzi9Mq3E432tSgNwtud4M
	DRwTweHJ6NCchvl5zmx7UGBYEtPf9slSiJj8wjdSRzggN26aOPFPDAIbSs1KzedEHj7bCo
	0NjMGgD/zsshGwk3nx+JFY7jJJWel3qdIa+orptTQTLnufQjxh9/hKq4++5S4QWPCyfJJv
	3O9TnHd+fIfsAJpYZo0WLC7ID7RRiLnKGWowtkKPsjHTlSUbcNOiuLyhfsdDu2OjDRusV/
	R2FQCDuGnY+vua2K7QSjwU/GttOQddm/3hB8QYFEaaq5Dy2KVEEQn/qyb2Y4sQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794661037; a=rsa-sha256;
	cv=none;
	b=LpUFzWqOeFKKMZBiGr72WwWcl8engMxMEh9rWbYK5GsyzLCFh34mBkHaFUvOIhCGJA+8bp
	aSC2sfXcbS+fZFRyyT5Ss/wcVtzLWtlxRp5MdvZVW0hxVLE4AXB367GAvLYKN+Tcs0Kmjz
	7CggBAOGsmgLWYdbBZd4c7p+lXkM3qV4b4P/co4uue19TTs60s2BuTkVd/cjaGMpViPocj
	yzfcThKnCpmhLEjPe/ybFy2F0zPKV4PgMrl/92MjVSb1XJaxgCn58zuakUtJ6sg8azm5WO
	DdAlHzddBu9HZqwqXlYrKQ1feY3+8LBJzSUAsBDfiDj5xvS3QIOgtnkuGyy3jA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSDJl-0048pV-2M;
	Sat, 14 Nov 2026 13:57:17 +0100
Received: from hardanger.blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 8C09C5EB9AC;
	Sat, 14 Nov 2026 12:56:23 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Sat, 14 Nov 2026 13:56:16 +0100
Subject: [PATCH can 3/4] can: xilinx_can: xcan_probe(): reject devices
 without match data
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
Message-Id: <20261114-fix-device_get_match_data-v1-3-2d82025e9646@pengutronix.de>
References: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
In-Reply-To: <20261114-fix-device_get_match_data-v1-0-2d82025e9646@pengutronix.de>
To: Vincent Mailhol <mailhol@kernel.org>, Rob Herring <robh@kernel.org>, 
 Harini T <harini.t@amd.com>, Michal Simek <michal.simek@amd.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-renesas-soc@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.17-dev-d7211
X-Developer-Signature: v=1; a=openpgp-sha256; l=926; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=dWt0D8IrQWwkpvNRr+k3iy72V3O92Quc/0wWqZmR0IA=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYsj6EVXy5/JZ5zc/m/Q/lYaFfp6vMOP7ybm3vi8/Vrtiv
 +F54TvH/naUsDCIcTHIiimyLP1xQlEg0KG092XCJJg5rEwgQxi4OAVgIhfzGP57Rk/d1TF55hnb
 rcbck/qfljkdiixJn/iNZcUzMYfXQguuMXwvu1LBU9Jw7Vw5V9JN6+LjmarRrM8uiFV/z3fb+0h
 5NjMA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54

A device bound through driver_override need not match an entry in
of_match_table. In that case device_get_match_data() returns NULL, but
xcan_probe() dereferences the result.

Reject devices without match data before continuing probe.

Fixes: 5e6c3454b405 ("net: can: Use device_get_match_data()")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/xilinx_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f22820b8..bbe6f9662cac 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1895,6 +1895,8 @@ static int xcan_probe(struct platform_device *pdev)
 	}
 
 	devtype = device_get_match_data(&pdev->dev);
+	if (!devtype)
+		return -ENODEV;
 
 	hw_tx_max_property = devtype->flags & XCAN_FLAG_TX_MAILBOXES ?
 			     "tx-mailbox-count" : "tx-fifo-depth";

-- 
2.53.0

