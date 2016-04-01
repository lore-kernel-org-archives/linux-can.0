From: Alexander Gerasiov <gq@cs.msu.su>
Subject: [PATCH] can: sja1000: Fix error location forwarding
Date: Fri, 1 Apr 2016 19:16:45 +0300
Message-ID: <20160401191645.36722a06@brick.gerasiov.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.gerasiov.net ([158.250.17.72]:45813 "EHLO
	mail.gerasiov.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752355AbcDAQXI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 1 Apr 2016 12:23:08 -0400
Received: from mail.gerasiov.net (mail.gerasiov.net [127.0.0.1])
	by mail.gerasiov.net (Postfix) with ESMTP id 35193A011C
	for <linux-can@vger.kernel.org>; Fri,  1 Apr 2016 19:16:46 +0300 (MSK)
Received: from brick.gerasiov.net (130-255-10-191.customers.ligalink.ru [130.255.10.191])
	by mail.gerasiov.net (Postfix) with ESMTPSA id 175C4A0116
	for <linux-can@vger.kernel.org>; Fri,  1 Apr 2016 19:16:46 +0300 (MSK)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

According to SJA1000 documentation the location of error is available
regardless of an error type. Therefore it should always be forwarded to
SocketCAN.

Signed-off-by: Nikita Edward Baruzdin <nebaruzdin@lvk.cs.msu.su>
Signed-off-by: Alexander GQ Gerasiov <gq@cs.msu.su>
---
 drivers/net/can/sja1000/sja1000.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 8dda3b7..9f10779 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -438,6 +438,7 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
 
                cf->can_id |= CAN_ERR_PROT | CAN_ERR_BUSERROR;
 
+               /* set error type */
                switch (ecc & ECC_MASK) {
                case ECC_BIT:
                        cf->data[2] |= CAN_ERR_PROT_BIT;
@@ -449,9 +450,12 @@ static int sja1000_err(struct net_device *dev, uint8_t isrc, uint8_t status)
                        cf->data[2] |= CAN_ERR_PROT_STUFF;
                        break;
                default:
-                       cf->data[3] = ecc & ECC_SEG;
                        break;
                }
+
+               /* set error location */
+               cf->data[3] = ecc & ECC_SEG;
+
                /* Error occurred during transmission? */
                if ((ecc & ECC_DIR) == 0)
                        cf->data[2] |= CAN_ERR_PROT_TX;
-- 
2.1.4



-- 
Best regards,
 Alexander Gerasiov

 Contacts:
 e-mail: gq@cs.msu.su  Homepage: http://gerasiov.net  Skype: gerasiov
 PGP fingerprint: 04B5 9D90 DF7C C2AB CD49  BAEA CA87 E9E8 2AAC 33F1
