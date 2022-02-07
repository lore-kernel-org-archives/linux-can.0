Return-Path: <linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE72C4167B
	for <linux-can@archiver.kernel.org>; Mon,  7 Feb 2022 13:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377018AbiBGNrq (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Mon, 7 Feb 2022 08:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380472AbiBGNLY (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 7 Feb 2022 08:11:24 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCBC0401DF
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 05:10:54 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nH3nA-0003io-LM
        for linux-can@vger.kernel.org; Mon, 07 Feb 2022 14:10:52 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
        by bjornoya.blackshift.org (Postfix) with SMTP id 32A182D79C
        for <linux-can@vger.kernel.org>; Mon,  7 Feb 2022 13:10:49 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bjornoya.blackshift.org (Postfix) with ESMTPS id EAA1C2D785;
        Mon,  7 Feb 2022 13:10:48 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
        by hardanger.blackshift.org (OpenSMTPD) with ESMTP id dbcc100c;
        Mon, 7 Feb 2022 13:10:48 +0000 (UTC)
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     linux-can@vger.kernel.org
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Thomas Kopp <thomas.kopp@microchip.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 02/15] can: mcp251xfd: mcp251xfd_regmap_crc_read(): ignore CRC error only if solely OSC register is read
Date:   Mon,  7 Feb 2022 14:10:34 +0100
Message-Id: <20220207131047.282110-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220207131047.282110-1-mkl@pengutronix.de>
References: <20220207131047.282110-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

MCP251XFD_REG_OSC is the first register the driver reads from. The
chip may be in deep sleep and the SPI transfer (i.e. the assertion of
the CS) will wake the chip up. This takes about 3ms. The CRC of this
transfer is wrong, or there isn't any chip at all, in this case the
CRC will be wrong, too. The driver ignores the CRC error and returns
the read data to the caller.

To avoid any confusion, this patch changes the
mcp251xfd_regmap_crc_read() function to only ignore the CRC error if
solely the OSC register is read. So when reading more than the OSC
registers at once, CRC errors are not ignored.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
index 7b120c716228..8112f8df22a6 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-regmap.c
@@ -368,7 +368,7 @@ mcp251xfd_regmap_crc_read(void *context,
 		 * to the caller. It will take care of both cases.
 		 *
 		 */
-		if (reg == MCP251XFD_REG_OSC) {
+		if (reg == MCP251XFD_REG_OSC && val_len == sizeof(__le32)) {
 			err = 0;
 			goto out;
 		}
-- 
2.34.1


