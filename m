From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [patch 07/10] can: c_can: Simplify buffer reenabling
Date: Fri, 04 Apr 2014 18:14:58 +0200
Message-ID: <533EDA82.4020209@hartkopp.net>
References: <20140404134816.751883017@linutronix.de> <20140404134857.523481518@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:30016 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbaDDQPG (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 12:15:06 -0400
In-Reply-To: <20140404134857.523481518@linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>

Hello Thomas, hello Alexander,

I just took a short look into the C_CAN manual.

-------- Original Message --------
Subject: [patch 07/10] can: c_can: Simplify buffer reenabling

(..)

Instead of writing to the message object we can simply clear the
NewDat bit with the get method.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/net/can/c_can/c_can.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

Index: linux-can/drivers/net/can/c_can/c_can.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-can.orig/drivers/net/can/c_can/c_can.c
+++ linux-can/drivers/net/can/c_can/c_can.c

(..)

 /* For the high buffers we clear the interrupt bit and newdat */
-#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_TXRQST)
+#define IF_COMM_RCV_HIGH	(IF_COMM_RCV_LOW | IF_COMM_CLR_NEWDAT)


I wonder if it generally works correctly, when the interrupt and newdat=
 bits
are handled separately, as the manual states:

4.8.1 Reading from a FIFO Buffer
When the CPU transfers the contents of Message Object to the IFx Messag=
e
Bugger registers by writing its number to the IFx Command Request Regis=
ter,
the corresponding Command Mask Register should be programmed the way th=
at bits
NewDat and IntPnd are reset to zero
(TxRqst/NewDat =3D =911=92 and ClrIntPnd =3D =911=92).

The driver seems to write these bits in different steps.

Regards,
Oliver


