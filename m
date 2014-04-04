From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [patch 10/10] can: c_can : Disable rx split as workaround
Date: Fri, 04 Apr 2014 19:41:28 +0200
Message-ID: <533EEEC8.3090905@hartkopp.net>
References: <20140404134816.751883017@linutronix.de> <20140404134858.173427806@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:10016 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753120AbaDDRld (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 4 Apr 2014 13:41:33 -0400
In-Reply-To: <20140404134858.173427806@linutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, linux-can <linux-can@vger.kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>, Alexander Stein <alexander.stein@systec-electronic.com>


-------- Original Message --------
Subject: [patch 10/10] can: c_can : Disable rx split as workaround

(..)

+config CAN_C_CAN_NO_RX_SPLIT
+	bool "Disable RX Split buffer"
+	---help---
+	  RX Split buffer prevents packet reordering but can cause packet
+	  loss. Select the less of the two evils.
+

Can you try to use something more understandable for the Kconfig option?

AFAICS there are the options:

1. Frames are in order but may get lost.
2. Frames do not get lost but may be disordered.

No user/kernel builder knows about "rx split buffers" ...

What about

+config CAN_C_CAN_STRICT_FRAME_ORDERING
+	bool "Force a strict RX CAN frame order (may cause frame loss)"
+	---help---
+	  The RX split buffer prevents packet reordering but can cause packet
+	  loss. Only enable this option when you accept to lose CAN frames
+	  in favor of getting the received CAN frames in the correct order.
+

Regards,
Oliver

ps. Your patches are attached in my mail client, which makes it hard to
comment the code inline.
