Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E2941A91B;
	Tue, 29 Sep 2026 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716047; cv=pass; b=kvsHh3WUnH1iVg6eED9mr7q/8kKkoblDAVxsnFOJN13qGz2NZvhjQEL/xM8pQWPvpUMHQlgGHGUHkajze6TWUAd6PGjN2NJlt5sHe2tWP4KouiBR3LKqR9QoaWwVqqv55vQkx23b52TRKpbxyghnryN+tL0vEicGJMmnCFuC0dg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716047; c=relaxed/simple;
	bh=lskkQ2y6TVuLZagtt1NwF+1X3Jrat5Q7k/6SFd5rCok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SCCDAgmd9+iYCIbFZ8RNYtQ9deB8UCZALfsemn3D/EmhbN7IjIhhJVDBxKt/5h9rphaiEALhS7a8i6THCDgP4XIz1haSmfW1nSNuK5xPU/1kCxKEe/n7MW0bfoZaWf7XVfqVljiSaL56Hl1xR/sbfj6AIc0hY3E1LjpF2aucnk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=f6921EvD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="f6921EvD"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D0B8A2017D1;
	Tue, 29 Sep 2026 23:07:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkFrMeI1K/9jtFaRQaSdoClE0EYXTjbrelviheLU/kk=;
	b=f6921EvD7VEzeyIdifZTNsDFtpSJOtGbAVGUxIxEEXnHV24JU9Di5F0sW4+tGSf/5ez+zn
	b2HpCki2QAoFYobeQvqo7KKoDox4fCY1vUdKIU7iuVm0WtWhS/ZVV1PDKUnfB3kIuMKwzf
	nx6zwo5tOuPzZivMN+g9jW3FrtIBYZlsXu231IciK1/4jHnDpj0zu5nq0hgad/x/4fhEQV
	iwptgcW2SIb1fAs7i+a3BNakkPOeRfXMutg9N1VZ+LzpIOPn+kn+wJWOKTXedU+2df/FYa
	rsH6b3bQ2lx7YAAHuNbxoP5j2Pl5QM4kwPyrf1tYAtwwt3ZKRmsJrdoAbyfavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790716023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkFrMeI1K/9jtFaRQaSdoClE0EYXTjbrelviheLU/kk=;
	b=GYrGniBWQtl0jBEC5DcxU65mdpGwFia9bXSaL3ZDSz8+S/aQtgb6zDQYT+ZDLLYrKCHFNk
	l4bxyy4KjHy28p32M3tVIypr3Paf8TBuyDxEBdaq/q4UgS2ELNFvHKYwlM3jMvPAU8ZUYt
	6vEwlu3pE81nzEyEqiIkf5MlI7N3Nsh3Or/JrzSO8BfvZrrb4pOQGx2FKsmyQLpj/vgi49
	WpIAnLzAZDGuCc1mvitU7lsBjhcjPreoWCGzI57Q0uU4JXqaVBCcDQBaIAgKglZ2oaLrST
	cJ4XWWuQaGwwFda+53RSLJRl/Vq3dYsZhc5Fn+WwOjhMqDNqzJ4zgOAOoeR+qA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790716023; a=rsa-sha256;
	cv=none;
	b=L3QMWtzLCV16AIJC2cNZwXFe/kBhhAIcah90/TWBy4bQ2H28wmYwGei5gexvyv3yDNDGX2
	aLdoPNPRU3yliHe7LKBtD4Q5itm8Z/q4+Fe+JXvrcUw+G1X7iuJLylIBlQLkPAvn7rihC0
	HU2GTjazmcVt4sXrJeTGYTnao/gT54D4m+Ovpflio1A5798VvPKXgCVJRsUMnMTVe13YNh
	VvvnGM2/bvl2BqZKUZ1+i5PbHsqRvUBD4+tAa6SsHMn2Sc9YwIvEjenGqnCXZkh+cQcj1Z
	+N3BIJh8EsQxb2tGoPo3tavhfFl+uW+PbSHpgEg9ygPuwzIL12xWDQPlGTJO2Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBf2V-003S3r-2C;
	Tue, 29 Sep 2026 23:07:03 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 6E2825B4CD9;
	Tue, 29 Sep 2026 21:07:03 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jiale Yao <yaojiale02@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 09/16] can: mcp251xfd: mcp251xfd_probe(): reject devices without match data
Date: Tue, 29 Sep 2026 22:43:59 +0200
Message-ID: <20260929210700.1183036-10-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929210700.1183036-1-mkl@pengutronix.de>
References: <20260929210700.1183036-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiale Yao <yaojiale02@163.com>

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL, but
mcp251xfd_probe() dereferences the result while copying the device type
data.

Reject devices without match data before continuing probe.

Fixes: 9cdae370c4ec ("can: mcp251xfd: simplify with spi_get_device_match_data()")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Link: https://patch.msgid.link/20260925133716.2230252-1-yaojiale02@163.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..8759bc05bd8f 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2213,6 +2213,7 @@ MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
 static int mcp251xfd_probe(struct spi_device *spi)
 {
+	const struct mcp251xfd_devtype_data *devtype_data;
 	struct net_device *ndev;
 	struct mcp251xfd_priv *priv;
 	struct gpio_desc *rx_int;
@@ -2222,6 +2223,10 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	u32 freq = 0;
 	int err;
 
+	devtype_data = spi_get_device_match_data(spi);
+	if (!devtype_data)
+		return -ENODATA;
+
 	if (!spi->irq)
 		return dev_err_probe(&spi->dev, -ENXIO,
 				     "No IRQ specified (maybe node \"interrupts-extended\" in DT missing)!\n");
@@ -2307,7 +2312,7 @@ static int mcp251xfd_probe(struct spi_device *spi)
 	priv->reg_vdd = reg_vdd;
 	priv->reg_xceiver = reg_xceiver;
 	priv->xstbyen = device_property_present(&spi->dev, "microchip,xstbyen");
-	priv->devtype_data = *(struct mcp251xfd_devtype_data *)spi_get_device_match_data(spi);
+	priv->devtype_data = *devtype_data;
 
 	/* Errata Reference:
 	 * mcp2517fd: DS80000792C 5., mcp2518fd: DS80000789E 4.,
-- 
2.53.0

