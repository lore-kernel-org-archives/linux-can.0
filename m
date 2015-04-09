From: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Subject: [PATCH 1/2] doc/bindings: Add 'endianess' optional-property for FlexCAN controller
Date: Thu, 9 Apr 2015 20:21:26 +0530
Message-ID: <1428591087-12831-1-git-send-email-bhupesh.sharma__3182.84624158895$1428591733$gmane$org@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:60309 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755232AbbDIPBu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Apr 2015 11:01:50 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:6f8:1178:4:5054:ff:fe8d:eefb] helo=bjornoya.do.blackshift.org)
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <mkl@pengutronix.de>)
	id 1YgDxk-0007ZV-Pj
	for linux-can@vger.kernel.org; Thu, 09 Apr 2015 17:01:48 +0200
Received: from [172.17.34.170] (unknown [172.17.34.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	(Authenticated sender: frogger)
	by bjornoya.do.blackshift.org (Postfix) with ESMTPSA id 67224E58A
	for <linux-can@vger.kernel.org>; Thu,  9 Apr 2015 15:01:48 +0000 (UTC)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, mkl@pengutronix.de
Cc: bhupesh.linux@gmail.com, bhupesh.sharma@freescale.com, olof@lixom.net, Sakar.Arora@freescale.com

This patch adds 'endianess' as the optional-property for
describing the FlexCAN controller present on various FSL platforms.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
Signed-off-by: Sakar Arora <Sakar.Arora@freescale.com>
---
 .../devicetree/bindings/net/can/fsl-flexcan.txt    |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
index 56d6cc3..0d5e668 100644
--- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
+++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
@@ -18,6 +18,10 @@ Optional properties:
 
 - xceiver-supply: Regulator that powers the CAN transceiver
 
+- little-endian: If the FlexCAN IP on this SoC is little-endian, use
+                 this property. By default it is assumed that the IP
+                 is big-endian
+
 Example:
 
 	can@1c000 {
-- 
1.7.9.5



