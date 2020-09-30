Return-Path: <SRS0=bHV0=DH=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8174C4742F
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B68120848
	for <linux-can@archiver.kernel.org>; Wed, 30 Sep 2020 09:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="M31Kz77Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgI3JP1 (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 30 Sep 2020 05:15:27 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:11368 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgI3JO1 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 30 Sep 2020 05:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1601457266; x=1632993266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xAGyLvOLu/HgPbzH7I7clpgTi3DG2Y2HxQhsIsY+0Pg=;
  b=M31Kz77Y8e3ZT26CdQHwdrU8XiUi156FSWGVOKryd3MQgndkOsC89AnT
   QaacHBIPYWrW612rRjZ0+U3V+6rWSByzILgTw6TmwxudukN0khviS/Ade
   3cZEzMpOzDwAujt46OIUnSFI6kj6LUwCng+EF/6up1+MoenRPXngihCWU
   HCnjbJWFQBONlOfd7zqjSP32l2azaX/qKyIz25uyjGYbDjOZIROYWmjV4
   TWxsk+zdSy2lVWkbqftG3N00edfgeR8k7ffsCvL2izzrOmEEi2tv4QPV9
   7LHaF7UrluzAGKvYXACxK2pkyN+5DNj1dV0Aw8zZYk4wR7iydIF6XEfFW
   A==;
IronPort-SDR: 1R9Cj3Ej2hKdo1tGbEL2iIvrSKwDfgiCW6aH7QS71kFXfWr9gpBKBC/pZBJk1pTG1347P8bOzY
 IlRV79gZCUzTPgwt4AWNm07tpjLXciws3NHfVg+Vvy39FdwumDcTgO/hJLz5vF753fGCzy9n+D
 e0lVWMjXJsNt6fT2PSpzXEiz6v8ynmON5Kb270qYbKTCi/flsH+jKwVgdcHvLHKTU4zzJUyEze
 tQZhzjL0bAOn2mWrOZhveDgDLNOxE0WpmQdnba/pYRZ6qxKA2BLInObEAeImdgQ0YiVH/6qU7D
 KcE=
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="93714392"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2020 02:14:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 30 Sep 2020 02:14:25 -0700
Received: from HNO-LT-M43677A.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 30 Sep 2020 02:14:23 -0700
From:   Thomas Kopp <thomas.kopp@microchip.com>
To:     <mkl@pengutronix.de>, <manivannan.sadhasivam@linaro.org>,
        <o.rempel@pengutronix.de>, <geert@linux-m68k.org>
CC:     <linux-can@vger.kernel.org>, <thomas.kopp@microchip.com>,
        <dev.kurt@vandijck-laurijssen.be>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <wg@grandegger.com>
Subject: [PATCH 1/2] can: mcp25xxfd: narrow down wildcards in device tree bindings
Date:   Wed, 30 Sep 2020 11:14:22 +0200
Message-ID: <20200930091423.755-1-thomas.kopp@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The wildcard should be narrowed down to prevent existing and
future devices that are not compatible from matching.
It is very unlikely that incompatible devices will be released
that do not match the wildcard.

Discussion Reference: https://lore.kernel.org/r/CAMuHMdVkwGjr6dJuMyhQNqFoJqbh6Ec5V2b5LenCshwpM2SDsQ@mail.gmail.com/

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Thomas Kopp <thomas.kopp@microchip.com>
---
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c | 18 +++++++++---------
 drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h      |  4 ++--
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
index 5557b2d1e774..672d5f24e325 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd-core.c
@@ -41,10 +41,10 @@ static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp2518fd = {
 };
 
 /* Autodetect model, start with CRC enabled. */
-static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp25xxfd = {
+static const struct mcp25xxfd_devtype_data mcp25xxfd_devtype_data_mcp251xfd = {
 	.quirks = MCP25XXFD_QUIRK_CRC_REG | MCP25XXFD_QUIRK_CRC_RX |
 		MCP25XXFD_QUIRK_CRC_TX | MCP25XXFD_QUIRK_ECC,
-	.model = MCP25XXFD_MODEL_MCP25XXFD,
+	.model = MCP25XXFD_MODEL_MCP251XFD,
 };
 
 static const struct can_bittiming_const mcp25xxfd_bittiming_const = {
@@ -78,8 +78,8 @@ static const char *__mcp25xxfd_get_model_str(enum mcp25xxfd_model model)
 		return "MCP2517FD"; break;
 	case MCP25XXFD_MODEL_MCP2518FD:
 		return "MCP2518FD"; break;
-	case MCP25XXFD_MODEL_MCP25XXFD:
-		return "MCP25xxFD"; break;
+	case MCP25XXFD_MODEL_MCP251XFD:
+		return "MCP251xFD"; break;
 	}
 
 	return "<unknown>";
@@ -2498,7 +2498,7 @@ static int mcp25xxfd_register_chip_detect(struct mcp25xxfd_priv *priv)
 	else
 		devtype_data = &mcp25xxfd_devtype_data_mcp2517fd;
 
-	if (!mcp25xxfd_is_25XX(priv) &&
+	if (!mcp25xxfd_is_251X(priv) &&
 	    priv->devtype_data.model != devtype_data->model) {
 		netdev_info(ndev,
 			    "Detected %s, but firmware specifies a %s. Fixing up.",
@@ -2707,8 +2707,8 @@ static const struct of_device_id mcp25xxfd_of_match[] = {
 		.compatible = "microchip,mcp2518fd",
 		.data = &mcp25xxfd_devtype_data_mcp2518fd,
 	}, {
-		.compatible = "microchip,mcp25xxfd",
-		.data = &mcp25xxfd_devtype_data_mcp25xxfd,
+		.compatible = "microchip,mcp251xfd",
+		.data = &mcp25xxfd_devtype_data_mcp251xfd,
 	}, {
 		/* sentinel */
 	},
@@ -2723,8 +2723,8 @@ static const struct spi_device_id mcp25xxfd_id_table[] = {
 		.name = "mcp2518fd",
 		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp2518fd,
 	}, {
-		.name = "mcp25xxfd",
-		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp25xxfd,
+		.name = "mcp251xfd",
+		.driver_data = (kernel_ulong_t)&mcp25xxfd_devtype_data_mcp251xfd,
 	}, {
 		/* sentinel */
 	},
diff --git a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
index 3bc799204cb0..b1b5d7fd33ea 100644
--- a/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
+++ b/drivers/net/can/spi/mcp25xxfd/mcp25xxfd.h
@@ -553,7 +553,7 @@ struct mcp25xxfd_regs_status {
 enum mcp25xxfd_model {
 	MCP25XXFD_MODEL_MCP2517FD = 0x2517,
 	MCP25XXFD_MODEL_MCP2518FD = 0x2518,
-	MCP25XXFD_MODEL_MCP25XXFD = 0xffff,	/* autodetect model */
+	MCP25XXFD_MODEL_MCP251XFD = 0xffff,	/* autodetect model */
 };
 
 struct mcp25xxfd_devtype_data {
@@ -607,7 +607,7 @@ mcp25xxfd_is_##_model(const struct mcp25xxfd_priv *priv) \
 
 MCP25XXFD_IS(2517);
 MCP25XXFD_IS(2518);
-MCP25XXFD_IS(25XX);
+MCP25XXFD_IS(251X);
 
 static inline u8 mcp25xxfd_first_byte_set(u32 mask)
 {
-- 
2.25.1

