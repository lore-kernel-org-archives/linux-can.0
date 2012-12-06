From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 06 Dec 2012 18:05:31 +0100
Message-ID: <2331999.ZYFOYXdjyx@ws-stein>
References: <loom.20121114T160521-534@post.gmane.org> <50ACABE2.2020306@grandegger.com> <50C0B05F.7020606@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:47180 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753734Ab2LFRFn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 12:05:43 -0500
In-Reply-To: <50C0B05F.7020606@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

Hi Michael,

On Thursday 06 December 2012 15:49:03, Wolfgang Grandegger wrote:
> > Details of the soak test:
> > 
> > There are two systems involved in the test: the PCH-System and an External Node.
> > The External Node transmits data at a high rate, bringing bus utilization to
> > ~35%.
> > The PCH-System also transmits data, in bursts of 10 messages every 5 ms.
> > Combined, the two systems utilize ~90% of bus bandwidth.
> > The PCH-System is constantly checking that it is receiving data from the
> > External Node at the expected rate and in the expected order.

So you do a lot of transmit and reception of CAN frames?

> On another thread Alexander is reporting problems with the same driver
> when he runs a I2C application concurrently. Are you able to stress the
> system in a similar way?

Could you please test with the following patch? Do you see error messages from this patch?
Thanks!

Alexander

diff --git a/drivers/net/can/c_can/c_can.c b/drivers/net/can/c_can/c_can.c
index d63aaa3..da9bbc0 100644
--- a/drivers/net/can/c_can/c_can.c
+++ b/drivers/net/can/c_can/c_can.c
@@ -1186,6 +1186,7 @@ struct net_device *alloc_c_can_dev(void)
                                        CAN_CTRLMODE_BERR_REPORTING;
 
        spin_lock_init(&priv->lock);
+       spin_lock_init(&priv->testlock);
 
        return dev;
 }
diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
index 3487d5e..2b58b75 100644
--- a/drivers/net/can/c_can/c_can.h
+++ b/drivers/net/can/c_can/c_can.h
@@ -173,6 +173,7 @@ struct c_can_priv {
        unsigned int instance;
        void (*init) (const struct c_can_priv *priv, bool enable);
        spinlock_t lock;        /* to protect tx and rx message objects */
+       spinlock_t testlock;    /* to protect tx and rx message objects */
 };
 
 struct net_device *alloc_c_can_dev(void);
diff --git a/drivers/net/can/c_can/c_can_pci.c b/drivers/net/can/c_can/c_can_pci.c
index 2516ea9..0ac4d43 100644
--- a/drivers/net/can/c_can/c_can_pci.c
+++ b/drivers/net/can/c_can/c_can_pci.c
@@ -74,13 +74,37 @@ static void c_can_pci_write_reg_aligned_to_32bit(struct c_can_priv *priv,
 static u16 c_can_pci_read_reg_32bit(struct c_can_priv *priv,
                                    enum reg index)
 {
-       return (u16)ioread32(priv->base + 2 * priv->regs[index]);
+       unsigned long flags;
+       u16 reg;
+
+       spin_lock_irqsave(&priv->testlock, flags);
+       reg = (u16)ioread32(priv->base + 2 * priv->regs[index]);
+       spin_unlock_irqrestore(&priv->testlock, flags);
+
+       return reg;
 }
 
 static void c_can_pci_write_reg_32bit(struct c_can_priv *priv,
                                      enum reg index, u16 val)
 {
-       iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+       u16 reg;
+       unsigned long flags;
+       int retries;
+
+       retries = 0;
+
+       spin_lock_irqsave(&priv->testlock, flags);
+
+       do
+       {
+               iowrite32((u32)val, priv->base + 2 * priv->regs[index]);
+               reg = (u16)ioread32(priv->base + 2 * priv->regs[index]);
+               if (reg != val)
+               {
+                       netdev_err(priv->dev, "write 0x%x to offset 0x%x failed. got: 0x%x\n", val, 2 * priv->regs[index], reg);
+               }
+       } while ((reg != val) && (retries++ < 20));
+       spin_unlock_irqrestore(&priv->testlock, flags);
 }
 
 static void c_can_pci_reset_pch(const struct c_can_priv *priv, bool enable)

