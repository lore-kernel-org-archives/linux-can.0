Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B522F1FEA
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 03:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578868; cv=none; b=Q2x8QyIFpRMNuBtGBuNx3zQfjm1Mj67fhRZmGAjsigmLA0J++qKaJs7Tpfhu/D25XhBzDzaiXWSxlXtPffBHjIRRRBE62DP+/bi2mt31CScBN2inmrIwehyj52Ki5PI0WCao5QRS0803qnuy5xkKule4MTJSI4JMY6A6hC6spT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578868; c=relaxed/simple;
	bh=JTS9jzSzmwrNKK4GONHKNSpuShRFEl61SD4nI3NPkjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4CYuzjAr5mlNmFzQOcxMzRzQfFXE0TOxYtDZzeMhJC3adfBHfSo8zkoukp8Rup7+NvGNTYZMwaLe1Uo5UkjZ06D5uhROGvUe72yB7z7ByJf/lNCTvPTqugTUsmRM0t5Z4OZKJIYAgN6ZvUMKB95/+6WWy8TfqT6AWqJ3UA96KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LOoq44HT; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LOoq44HT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ej
	87C8QEfq0kmjNw3b5CfhZpIDPUP+zYDRZZCxV1kAI=; b=LOoq44HTPBJq38oLfy
	oD3jKeHngExbXHWTGrwXa4PBDfp65FJsfizEcVoYEX0gvU/NWgW1zDRU+A3niwsP
	6PwQLtSoDscP6LKzK2tigesfDNgPG5WXQy/HUyBcHcY61IoX8hmTYM3sxaQ1p3j5
	CH3b0NMtnghDiVkFcEOeYEg3g=
Received: from rlk.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD319lKvDBq7apADw--.36791S3;
	Tue, 16 Jun 2026 11:00:39 +0800 (CST)
From: guoqi0226 <guoqi0226@163.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Thomas Kopp <thomas.kopp@microchip.com>,
	linux-can@vger.kernel.org,
	guoqi0226 <guoqi0226@163.com>
Subject: [PATCH 2/2] can: mcp251xfd: Add ACPI device ID table for MCP251XFD
Date: Tue, 16 Jun 2026 11:00:19 +0800
Message-Id: <20260616030019.35845-2-guoqi0226@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260616030019.35845-1-guoqi0226@163.com>
References: <20260616030019.35845-1-guoqi0226@163.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD319lKvDBq7apADw--.36791S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tw45tF18urWUJF4kCw48Zwb_yoW8XF1kpF
	4DtF1qyrWUWF4UWw4rC3WUZa4Yg34DAryIgrWYka42qryfJw1DZrs293W5Ars5JFW5GF13
	Zr93JryDG398u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziloGdUUUUU=
X-CM-SenderInfo: 5jxr1xaqsslqqrwthudrp/xtbC4hjrVGowvFhJxQAA33

This patch adds an ACPI match table for the MCP251XFD CAN controller,
enabling driver binding on ACPI-enumerated SPI platforms.

Signed-off-by: guoqi0226 <guoqi0226@163.com>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index 92a86083c896..3fc6e82abe4e 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -20,6 +20,7 @@
 #include <linux/module.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
+#include <linux/acpi.h>
 
 #include "mcp251xfd.h"
 
@@ -2212,6 +2213,14 @@ static const struct spi_device_id mcp251xfd_id_table[] = {
 };
 MODULE_DEVICE_TABLE(spi, mcp251xfd_id_table);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id mcp251xfd_acpi_match[] = {
+	{ "MCP251XFD", (kernel_ulong_t)&mcp251xfd_devtype_data_mcp251xfd},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, mcp251xfd_acpi_match);
+#endif
+
 static int mcp251xfd_probe(struct spi_device *spi)
 {
 	struct net_device *ndev;
@@ -2442,6 +2451,7 @@ static struct spi_driver mcp251xfd_driver = {
 		.name = DEVICE_NAME,
 		.pm = &mcp251xfd_pm_ops,
 		.of_match_table = mcp251xfd_of_match,
+		.acpi_match_table = ACPI_PTR(mcp251xfd_acpi_match),
 	},
 	.probe = mcp251xfd_probe,
 	.remove = mcp251xfd_remove,
-- 
2.25.1

