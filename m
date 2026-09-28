Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7D502573;
	Mon, 28 Sep 2026 19:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624011; cv=pass; b=OGrzdfo0QOglIUYhoj7jvXlH8vWV8kZi95cskspUsAEcAhY6Duq0dSWzjJYEcPU5GJwM90hIfUb8ng7gp9MAc/DT6SryhFQKpstxl9Fs9sVJypqBqe2uTnGRJuNQEfdjkRXXLFv/Yvhy4olMBy+Avs0w2s063/Jr2zVbanJaw18=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624011; c=relaxed/simple;
	bh=lskkQ2y6TVuLZagtt1NwF+1X3Jrat5Q7k/6SFd5rCok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBtljOZTie1yuuAu59sFLbjaYNronT2Pfbzmke/mdObjfQQBNpjgKn7Z8D7HAA2L6OwR8mEX25tDBigI77y7INoLISeEQP7XtPWGnZegQpMHegXqy6AqrSeyrKRdAIy2KX6OLd9PgI3VW4FhPPaf5NAI7+oDOFcLW8NjFJR6TZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=DpZLdqKE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="DpZLdqKE"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 8589720228B;
	Mon, 28 Sep 2026 21:33:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkFrMeI1K/9jtFaRQaSdoClE0EYXTjbrelviheLU/kk=;
	b=DpZLdqKEgqfsGsSvA3xPlQ/1ucue1U7UbbozElgUS0728VSVXGFAKseQHMGn4NbpLU72gB
	+dbfWN6oBifVUGMQrJSZQDAobosui1NkClQSe+Q8DsIw9/Sbj3yIfvItZc/qG+0bu/X9Mv
	k5jCD241DnahoCXXQH59KOM1Xjl7Robf6S9BCLlZtX/v0YUH9TSxwIZzxABhFLsIT8RYAv
	R2zwi1NdUYomsrzn3ACqhR6LspB6IkG/YmHJBb6Ew3JMIEtl2AzSSO5D48nN+TmX1IPsA1
	7dmU72MMCBe5PoPNWN1ZbX1CwweaUzpWACV41DnBksPVCcf7cwgVd2L4ud2FCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkFrMeI1K/9jtFaRQaSdoClE0EYXTjbrelviheLU/kk=;
	b=Hf+n6W1K90+i5/JRh+DQnrU98as/yEh/fW8qvkJyIVLX6ZSANBYx2sajVRLNRaQNTqe4JG
	Nang4h4zGtMlV/Hio5T600dMmXLl8MlYOF3j5ISekKqrhyY87DKhniqzEjZsQ6PKchJZUW
	9BTDULLAx6Cst38Q4BAExZvopqnO3UW1FiPC70EYxpMPGUECDxbeyFDgo/GcXnfTCiGQvH
	ch999AA5xYVMvPAYgJ+/1JA8wkKd5dXb57d6LxaRgaTodIa9iV9toKvCrr/Gs2pL8roOFy
	97d1BJQypWvEq6dCTl7ywk5vpNKjyShkhRDocuvP3Dk8tzzZWzvHe5NbdhQGOA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623996; a=rsa-sha256;
	cv=none;
	b=BqmRrS6G4XGZhhV+7XAunY2yEGDtzlunwTmSnDWKEMl2FXZo96WEmZsrLhRpX3YBXS7RUb
	CBEv6C6LsL8+lXE1f4dttcDxWtYvR7VET33NpEr53ZT9PHnOWwj5BLTkJtQOVeGHir2Htg
	DRO6oyGCsls4ib7PWlcjSXOKqzitvc/2GmKTiMKtFGWj4cgna2/dd64aDOIqstV3I6i+Ro
	a8urGNVNEQNuTZ0fFnHCcs7APBX79nKUlDFoQSFjeTWRX9BLKWJ3NyRdvqzaBYjmLSYJiy
	iTmZKkLgdp8ZRW5wOHD358pm9INQO5lS1WRiCWBimQDTbk6XhIjq+avpLwPzPw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6C-003H6S-1A;
	Mon, 28 Sep 2026 21:33:16 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 19D025B1556;
	Mon, 28 Sep 2026 19:33:16 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Jiale Yao <yaojiale02@163.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 15/22] can: mcp251xfd: mcp251xfd_probe(): reject devices without match data
Date: Mon, 28 Sep 2026 20:45:22 +0200
Message-ID: <20260928193312.553632-16-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
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

