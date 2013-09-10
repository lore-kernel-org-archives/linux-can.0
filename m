From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH 6/9] can: mcp251x: use dev_get_platdata()
Date: Tue, 10 Sep 2013 17:42:19 +0900
Message-ID: <004d01ceae01$a8e95f70$fabc1e50$%han@samsung.com>
References: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:46447 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754593Ab3IJImV (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 10 Sep 2013 04:42:21 -0400
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout3.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MSW00MGOIUJ6QW0@mailout3.samsung.com> for
 linux-can@vger.kernel.org; Tue, 10 Sep 2013 17:42:19 +0900 (KST)
In-reply-to: <004701ceae01$4303dcd0$c90b9670$%han@samsung.com>
Content-language: ko
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>
Cc: 'Wolfgang Grandegger' <wg@grandegger.com>, linux-can@vger.kernel.org, 'Jingoo Han' <jg1.han@samsung.com>

Use the wrapper function for retrieving the platform data instead of
accessing dev->platform_data directly. This is a cosmetic change
to make the code simpler and enhance the readability.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/net/can/mcp251x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/mcp251x.c b/drivers/net/can/mcp251x.c
index fe7dd69..08ac401 100644
--- a/drivers/net/can/mcp251x.c
+++ b/drivers/net/can/mcp251x.c
@@ -999,7 +999,7 @@ static int mcp251x_can_probe(struct spi_device *spi)
 {
 	struct net_device *net;
 	struct mcp251x_priv *priv;
-	struct mcp251x_platform_data *pdata = spi->dev.platform_data;
+	struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
 	int ret = -ENODEV;
 
 	if (!pdata)
-- 
1.7.10.4


