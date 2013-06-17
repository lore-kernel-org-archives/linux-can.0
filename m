From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 20:49:28 +0200
Message-ID: <51BF5A38.3080001@hostmobility.com>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com> <51BEA863.1040704@hostmobility.com> <51BEB849.3020409@pengutronix.de> <51BF132B.3020705@hostmobility.com> <51BF193B.1030307@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040001010800050205010902"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:51098 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3FQStc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 14:49:32 -0400
Received: by mail-lb0-f180.google.com with SMTP id o10so2859897lbi.39
        for <linux-can@vger.kernel.org>; Mon, 17 Jun 2013 11:49:31 -0700 (PDT)
In-Reply-To: <51BF193B.1030307@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Rickard Gustafsson <rickard.gustafsson@hostmobility.com>, Tord Andersson <tord.andersson@endian.se>

This is a multi-part message in MIME format.
--------------040001010800050205010902
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

Thank you Marc for your patch. We  applied it but it did not solve our 
problem.

Wolfgang suggested defining a lock common for all devices:

  static DEFINE_SPINLOCK(snor_bus_lock);

Which I applied and now it seems to work perfectly. Thank you for your help.

Should I blame the hardware driver? :)

Attaching the patch for reference .

Med Vänliga Hälsningar / Best Regards
Mirza

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 Göteborg
Sweden
www.hostmobility.com <http://www.hostmobility.com>
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
Fax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************


On 06/17/2013 04:12 PM, Marc Kleine-Budde wrote:
> On 06/17/2013 03:46 PM, Mirza Krak wrote:
>> My modifications to sja1000_platform.c are attached as a patch.
>>
>> Wolfgang: Using spinlock_irqsave() and spinlock_irqrestore() was also my
>> initial idea on the io functions but I tried this without it solving the
>> problem. I could try this again to be sure.
>
> Without problem locking it not work anyway. Try the attached patch (it's
> compile time tested only).
>
> Marc
>

--------------040001010800050205010902
Content-Type: text/x-diff;
 name="sja1000_platform.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sja1000_platform.c.patch"

Index: drivers/net/can/sja1000/sja1000_platform.c
===================================================================
--- drivers/net/can/sja1000/sja1000_platform.c	(revision 519)
+++ drivers/net/can/sja1000/sja1000_platform.c	(working copy)
@@ -27,6 +27,7 @@
 #include <linux/can/dev.h>
 #include <linux/can/platform/sja1000.h>
 #include <linux/io.h>
+#include <linux/spinlock_types.h>
 
 #include "sja1000.h"
 
@@ -36,16 +37,29 @@
 MODULE_DESCRIPTION("Socket-CAN driver for SJA1000 on the platform bus");
 MODULE_LICENSE("GPL v2");
 
+static DEFINE_SPINLOCK(snor_bus_lock);
+
 static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
 {
+	u8 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&snor_bus_lock, flags);
 	iowrite8(reg, priv->reg_base);
-	return ioread8(priv->reg_base + 0x20);
+	value = ioread8(priv->reg_base + 0x20);
+	spin_unlock_irqrestore(&snor_bus_lock, flags);
+
+	return value;
 }
 
 static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 val)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&snor_bus_lock, flags);
 	iowrite8(reg, priv->reg_base);
 	iowrite8(val, (priv->reg_base + 0x20));
+	spin_unlock_irqrestore(&snor_bus_lock, flags);
 }
 
 static u8 sp_read_reg16(const struct sja1000_priv *priv, int reg)

--------------040001010800050205010902--
