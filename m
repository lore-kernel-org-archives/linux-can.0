Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EDC1A6839;
	Fri, 25 Sep 2026 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790343489; cv=none; b=K2zwAHw+fyf5FICBeMd9BVOWzpm4Wc7bvDiQhPaINDZzxfQBe1b1MF/AwGXW/4H7nEKvQwxVJVgf5gzfMpfVZ3H0HpIsos8eqFKLcGY2ZH+21H4ge75aBDXUfWkSkY9ovbI2rHC/uA+/OH5Cs4vzDeovjsuglDuvb6ywR7do+RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790343489; c=relaxed/simple;
	bh=kXk9Y5VHyVCstAfyO0KQFXnz5f1FtFEqK7KG2IpTMH4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uFLDC12BRXNzGpQkyL74PDkA7457XuWRo6nXbephBN1Vrzm5UHmbgrul+2o1zIzu5YVDX18Gh6wqQ42K2C/DgdPAXhhfkumM9W5JwPUI8qBnszby352yTOMKC8eLKz8KYC/KPnnnqgXhE8b7tLNtynART+KLQDPBpBDLLmnRgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U8FkyaQD; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U8FkyaQD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CR
	5fqHk7Iq5GRJ9oTKnu4mPu533o6KVouLhweUftaOM=; b=U8FkyaQD2vw85TMO5b
	tClKw7XCjYODVLwVNrgGjb8T9JD0BcR7PeN2CjlQT+i95fHv/80l4K3aiovz4chY
	sI/XYbsS+FIlmjHCursPUnrLKBjZQfCCstzzB51hFMKUSr0H7hmMOzdFvB5pjLk2
	5+OLB708G9B7g3rclPVLALNOE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDX3zsiebZqjnwMAw--.17259S2;
	Fri, 25 Sep 2026 21:37:39 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] can: mcp251xfd: reject devices without match data
Date: Fri, 25 Sep 2026 21:37:16 +0800
Message-Id: <20260925133716.2230252-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDX3zsiebZqjnwMAw--.17259S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uFW8Ww45CryrCryrWw4kZwb_yoW8Cw17pF
	4DGFyqyrWDJF47Gws8Ca4DZ34Y9w4qyw18WFZ0k34jgr1fA34UArWI9F15Aa1ktFW5GF13
	Jrn3Xr1kWa47W3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEPrcwUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgOu6Gq2eSNdkAAA3A

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but mcp251xfd_probe() dereferences the result while copying the device
type data.

Reject devices without match data before continuing probe.

Fixes: 9cdae370c4ec ("can: mcp251xfd: simplify with spi_get_device_match_data()")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
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
2.34.1

