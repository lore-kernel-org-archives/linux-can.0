From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 01/21] can: c_can_pci: Set the type of the IP core
Date: Fri, 11 Apr 2014 08:13:10 -0000
Message-ID: <20140411080650.456724604@linutronix.de>
References: <20140411080547.845836199@linutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:52353 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbaDKIM7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 11 Apr 2014 04:12:59 -0400
Content-Disposition: inline; filename=can-c_pci_can-set-type.patch
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can <linux-can@vger.kernel.org>
Cc: Alexander Stein <alexander.stein@systec-electronic.com>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Mark <mark5@del-llc.com>

All type checks in c_can.c are != BOSCH_D_CAN so nobody noticed so far
that the pci code does not update the type information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can_pci.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/drivers/net/can/c_can/c_can_pci.c
===================================================================
--- linux-2.6.orig/drivers/net/can/c_can/c_can_pci.c
+++ linux-2.6/drivers/net/can/c_can/c_can_pci.c
@@ -132,6 +132,8 @@ static int c_can_pci_probe(struct pci_de
 		goto out_free_c_can;
 	}
 
+	priv->type = c_can_pci_data->type;
+
 	/* Configure access to registers */
 	switch (c_can_pci_data->reg_align) {
 	case C_CAN_REG_ALIGN_32:


