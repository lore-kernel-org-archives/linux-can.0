From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] net: can: sja1000: peak_pcmcia.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sun, 14 Sep 2014 19:30:33 +0200
Message-ID: <1410715833-15809-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:50557 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752742AbaINR2o (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 14 Sep 2014 13:28:44 -0400
Received: by mail-la0-f54.google.com with SMTP id ge10so3345941lab.41
        for <linux-can@vger.kernel.org>; Sun, 14 Sep 2014 10:28:42 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>, linux-can@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/net/can/sja1000/peak_pcmcia.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index dd56133..fc9f8b01 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -487,7 +487,7 @@ static void pcan_free_channels(struct pcan_pccard *card)
 		if (!netdev)
 			continue;
 
-		strncpy(name, netdev->name, IFNAMSIZ);
+		strlcpy(name, netdev->name, IFNAMSIZ);
 
 		unregister_sja1000dev(netdev);
 
-- 
1.7.10.4

