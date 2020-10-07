Return-Path: <SRS0=tH2h=DO=vger.kernel.org=linux-can-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1F5C4727E
	for <linux-can@archiver.kernel.org>; Wed,  7 Oct 2020 21:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA9820872
	for <linux-can@archiver.kernel.org>; Wed,  7 Oct 2020 21:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbgJGVcN (ORCPT <rfc822;linux-can@archiver.kernel.org>);
        Wed, 7 Oct 2020 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728659AbgJGVcN (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 7 Oct 2020 17:32:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF16BC0613D8
        for <linux-can@vger.kernel.org>; Wed,  7 Oct 2020 14:32:10 -0700 (PDT)
Received: from heimdall.vpn.pengutronix.de ([2001:67c:670:205:1d::14] helo=blackshift.org)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1kQH2d-0005qi-Jx; Wed, 07 Oct 2020 23:32:07 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-can@vger.kernel.org,
        kernel@pengutronix.de, Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 04/17] MAINTAINERS: adjust to mcp251xfd file renaming
Date:   Wed,  7 Oct 2020 23:31:46 +0200
Message-Id: <20201007213159.1959308-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201007213159.1959308-1-mkl@pengutronix.de>
References: <20201007213159.1959308-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:205:1d::14
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

From: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Commit 27cf93863cbc ("MAINTAINERS: Add entry for Microchip MCP25XXFD
SPI-CAN network driver"), added the MCP25XXFD SPI-CAN NETWORK DRIVER
section with the following two file entries:

F:      Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
F:      drivers/net/can/spi/mcp25xxfd/

Commit 1f0e21a0c065 ("can: mcp251xfd: rename driver files and subdir to
mcp251xfd") renamed the files from mcp25xxfd to mcp251xfd, but missed to
adjust the MAINTAINERS section.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches    F: \
      Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
  warning: no file matches    F:    drivers/net/can/spi/mcp25xxfd/

Adjust the MCP251XFD SPI-CAN NETWORK DRIVER section to this driver file
renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Link: https://lore.kernel.org/r/20201003075500.12477-1-lukas.bulwahn@gmail.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 734d4dc61084..d651a0934be7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10675,14 +10675,14 @@ L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	drivers/hid/hid-mcp2221.c
 
-MCP25XXFD SPI-CAN NETWORK DRIVER
+MCP251XFD SPI-CAN NETWORK DRIVER
 M:	Marc Kleine-Budde <mkl@pengutronix.de>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 R:	Thomas Kopp <thomas.kopp@microchip.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/bindings/net/can/microchip,mcp25xxfd.yaml
-F:	drivers/net/can/spi/mcp25xxfd/
+F:	Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+F:	drivers/net/can/spi/mcp251xfd/
 
 MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@axentia.se>
-- 
2.28.0

