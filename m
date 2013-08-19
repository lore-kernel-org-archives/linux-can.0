From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH v2 3/3] can: mcp251x: Allow tuning SPI mode and limit maximal SPI speed
Date: Mon, 19 Aug 2013 15:39:21 +0400
Message-ID: <1376912361-22133-3-git-send-email-shc_work@mail.ru>
References: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from smtp33.i.mail.ru ([94.100.177.93]:58231 "EHLO smtp33.i.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751267Ab3HSLjf (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Aug 2013 07:39:35 -0400
In-Reply-To: <1376912361-22133-1-git-send-email-shc_work@mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Eric Miao <eric.y.miao@gmail.com>, Russell King <linux@arm.linux.org.uk>, Haojian Zhuang <haojian.zhuang@gmail.com>, Alexander Shiyan <shc_work@mail.ru>

Patch allow to use different mode settings for SPI (MODE3 for example)
and limit maximal speed according to IC datasheet.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/net/can/mcp251x.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index a48d3df..c08edc7 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -1082,7 +1082,11 @@ static int mcp251x_can_probe(struct spi_device *spi)
 	SET_NETDEV_DEV(net, &spi->dev);
 
 	/* Configure the SPI bus */
-	spi->mode = SPI_MODE_0;
+	spi->mode = spi->mode ? : SPI_MODE_0;
+	if (mcp251x_is_2510(spi))
+		spi->max_speed_hz = spi->max_speed_hz ? : 5 * 1000 * 1000;
+	else
+		spi->max_speed_hz = spi->max_speed_hz ? : 10 * 1000 * 1000;
 	spi->bits_per_word = 8;
 	spi_setup(spi);
 
-- 
1.8.1.5

