From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: Dual SJA1000 can controllers on SMP system.
Date: Mon, 17 Jun 2013 15:46:19 +0200
Message-ID: <51BF132B.3020705@hostmobility.com>
References: <c2744427f1624d26950ca030d4dff1c6@s75.digisrv.net> <51BDB1ED.1040603@grandegger.com> <51BEA863.1040704@hostmobility.com> <51BEB849.3020409@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040004040604010001060507"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f51.google.com ([209.85.215.51]:48105 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755834Ab3FQNqY (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 17 Jun 2013 09:46:24 -0400
Received: by mail-la0-f51.google.com with SMTP id fq12so2446529lab.38
        for <linux-can@vger.kernel.org>; Mon, 17 Jun 2013 06:46:22 -0700 (PDT)
In-Reply-To: <51BEB849.3020409@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, Rickard Gustafsson <rickard.gustafsson@hostmobility.com>

This is a multi-part message in MIME format.
--------------040004040604010001060507
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit

My modifications to sja1000_platform.c are attached as a patch.

Wolfgang: Using spinlock_irqsave() and spinlock_irqrestore() was also my 
initial idea on the io functions but I tried this without it solving the 
problem. I could try this again to be sure.

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


On 06/17/2013 09:18 AM, Marc Kleine-Budde wrote:
> On 06/17/2013 08:10 AM, Mirza Krak wrote:
>> Aah off course. The low-level device driver is sja1000_platform.c. The
>> functions I am using are sp_read_reg8 and sp_write_reg8 which I have
>> slightly modified. Since I don't use multiplexed bus functionality I
>> write the address first.
>>
>>    static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
>> {
>>      iowrite8(reg, priv->reg_base);
>        ^^^^^^^^
>>      return ioread8(priv->reg_base + 0x20);
>> }
>>
>> static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 val)
>> {
>>      iowrite8(reg, priv->reg_base);
>        ^^^^^^^^
>>      iowrite8(val, (priv->reg_base + 0x20));
>> }
>
> Can you post a proper patch, so that we can see what you have changed?
>
> You probably have a nice race condition here. The two iowrites have to
> be atomic.
>
> Marc
>

--------------040004040604010001060507
Content-Type: text/x-patch;
 name="sja1000_platform.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="sja1000_platform.patch"

Index: sja1000_platform.c
===================================================================
--- sja1000_platform.c	(revision 160)
+++ sja1000_platform.c	(working copy)
@@ -38,12 +38,14 @@
 
 static u8 sp_read_reg8(const struct sja1000_priv *priv, int reg)
 {
-	return ioread8(priv->reg_base + reg);
+	iowrite8(reg, priv->reg_base);
+	return ioread8(priv->reg_base + 0x20);
 }
 
 static void sp_write_reg8(const struct sja1000_priv *priv, int reg, u8 val)
 {
-	iowrite8(val, priv->reg_base + reg);
+	iowrite8(reg, priv->reg_base);
+	iowrite8(val, (priv->reg_base + 0x20));
 }
 
 static u8 sp_read_reg16(const struct sja1000_priv *priv, int reg)

--------------040004040604010001060507--
