From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Problem with Eurotech COM1273 Dual Channel CAN PC104 Module.
Date: Tue, 15 Apr 2014 15:19:43 +0200
Message-ID: <534D31EF.6050107@hartkopp.net>
References: <CA+s8ZrqFBun4bo2rJJFHb0FrV7m7PLybUVM+jjahKsdW8bdnaQ@mail.gmail.com>	<164afc991761b9eeb0eec6902814d00e@grandegger.com>	<534D0F00.7000202@hartkopp.net> <CA+s8Zrqrd_U0g1GRCDzXncgWLA_kO3Hyhjwy6Oe1S0cYohm2og@mail.gmail.com> <534D1F63.6080101@hartkopp.net> <534D270D.5060705@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:60864 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750790AbaDONTq (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 15 Apr 2014 09:19:46 -0400
In-Reply-To: <534D270D.5060705@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Wolfgang Grandegger <wg@grandegger.com>
Cc: khurram gulzar <khurramgulzar@gmail.com>, linux-can@vger.kernel.org

Something like this?

It uses the dev->dev_id which was missed in the 3e66d0138c05d9792f patch before.

Just compile-tested by now ...

diff --git a/drivers/net/can/sja1000/sja1000_isa.c b/drivers/net/can/sja1000/sja1000_isa.c
index df136a2..46e1784 100644
--- a/drivers/net/can/sja1000/sja1000_isa.c
+++ b/drivers/net/can/sja1000/sja1000_isa.c
@@ -46,6 +46,7 @@ static int clk[MAXDEV];
 static unsigned char cdr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
 static unsigned char ocr[MAXDEV] = {[0 ... (MAXDEV - 1)] = 0xff};
 static int indirect[MAXDEV] = {[0 ... (MAXDEV - 1)] = -1};
+static spinlock_t indirect_lock[MAXDEV];  /* lock for indirect access mode */
 
 module_param_array(port, ulong, NULL, S_IRUGO);
 MODULE_PARM_DESC(port, "I/O port number");
@@ -101,19 +102,28 @@ static void sja1000_isa_port_write_reg(const struct sja1000_priv *priv,
 static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_priv *priv,
 					     int reg)
 {
-	unsigned long base = (unsigned long)priv->reg_base;
+	unsigned long base, flags;
+	u8 readval;
 
+	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
+	base = (unsigned long)priv->reg_base;
 	outb(reg, base);
-	return inb(base + 1);
+	readval = inb(base + 1);
+	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
+
+	return readval;
 }
 
 static void sja1000_isa_port_write_reg_indirect(const struct sja1000_priv *priv,
 						int reg, u8 val)
 {
-	unsigned long base = (unsigned long)priv->reg_base;
+	unsigned long base, flags;
 
+	spin_lock_irqsave(&indirect_lock[priv->dev->dev_id], flags);
+	base = (unsigned long)priv->reg_base;
 	outb(reg, base);
 	outb(val, base + 1);
+	spin_unlock_irqrestore(&indirect_lock[priv->dev->dev_id], flags);
 }
 
 static int sja1000_isa_probe(struct platform_device *pdev)
@@ -169,6 +179,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 		if (iosize == SJA1000_IOSIZE_INDIRECT) {
 			priv->read_reg = sja1000_isa_port_read_reg_indirect;
 			priv->write_reg = sja1000_isa_port_write_reg_indirect;
+			spin_lock_init(&indirect_lock[idx]);
 		} else {
 			priv->read_reg = sja1000_isa_port_read_reg;
 			priv->write_reg = sja1000_isa_port_write_reg;
@@ -198,6 +209,7 @@ static int sja1000_isa_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
+	dev->dev_id = idx;
 
 	err = register_sja1000dev(dev);
 	if (err) {



On 15.04.2014 14:33, Marc Kleine-Budde wrote:
> On 04/15/2014 02:00 PM, Oliver Hartkopp wrote:
>> As I wrote in the other thread:
>>
>>> The command i am executing is 
>>> modprobe sja1000_isa port=0x200,0x204 irq=10,11 indirect=1 
>>
>> The parameters for each interface are given separately
> 
> The indirect mode is racy, btw....
> 
>> static u8 sja1000_isa_port_read_reg_indirect(const struct sja1000_priv *priv,
>>                                              int reg)
>> {
>>         unsigned long base = (unsigned long)priv->reg_base;
>>
>>         outb(reg, base);
>>         return inb(base + 1);
>> }
>>
>> static void sja1000_isa_port_write_reg_indirect(const struct sja1000_priv *priv,
>>                                                 int reg, u8 val)
>> {
>>         unsigned long base = (unsigned long)priv->reg_base;
>>
>>         outb(reg, base);
>>         outb(val, base + 1);
>> }
> 
> We need locks.
> 
> Marc
> 
