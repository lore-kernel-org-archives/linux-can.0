From: Efim Monjak <emonjak@lipowsky.de>
Subject: at91 driver lost CAN messages
Date: Fri, 10 Mar 2017 14:48:57 +0100
Message-ID: <3f039cfd-cac1-3adb-77d2-87c5e67066f2@lipowsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from server1.railshosting.de ([5.45.177.35]:34604 "EHLO
        server1.railshosting.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755104AbdCJPlI (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 10 Mar 2017 10:41:08 -0500
Received: from localhost (localhost [127.0.0.1])
        by server1.railshosting.de (Postfix) with ESMTP id EFF1B13EC179
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 14:46:55 +0100 (CET)
Received: from server1.railshosting.de ([127.0.0.1])
        by localhost (server1.railshosting.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id gIsrzaLOVD1o for <linux-can@vger.kernel.org>;
        Fri, 10 Mar 2017 14:46:55 +0100 (CET)
Received: from zappa (p57bfa984.dip0.t-ipconnect.de [87.191.169.132])
        by server1.railshosting.de (Postfix) with ESMTPA id A3F3D13EC168
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 14:46:55 +0100 (CET)
Received: from zappa (localhost [127.0.0.1])
        by zappa (Postfix) with ESMTP id 75F644F5B
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 14:46:55 +0100 (CET)
Received: from [192.168.129.196] (unknown [192.168.129.196])
        by zappa (Postfix) with ESMTP id 6E60F4F5A
        for <linux-can@vger.kernel.org>; Fri, 10 Mar 2017 14:46:55 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi all,

performance test at91_can.c driver by sending 4kByte data @1Mbit/s
without delay between CAN Frames show data lost by CAN driver. Sampling 
a Linux time stamps
show sometimes about 200usec delay between enter receive CAN interrupt 
and enter the
polling function by napi.
If napi polling is deactivated by follow change no more receive overflow 
error occurs.

Index: at91_can.c
===================================================================
--- at91_can.c    (revision 32447)
+++ at91_can.c    (revision 32448)
@@ -792,6 +792,35 @@
      return 1;
  }

+static int at91_poll_nonapi(struct net_device * dev, int quota)
+{
+    const struct at91_priv *priv = netdev_priv(dev);
+    u32 reg_sr = at91_read(priv, AT91_SR);
+    int work_done = 0;
+
+    if (reg_sr & get_irq_mb_rx(priv))
+        work_done += at91_poll_rx(dev, quota - work_done);
+
+    /*
+     * The error bits are clear on read,
+     * so use saved value from irq handler.
+     */
+    reg_sr |= priv->reg_sr;
+    if (reg_sr & AT91_IRQ_ERR_FRAME)
+        work_done += at91_poll_err(dev, quota - work_done, reg_sr);
+
+    if (work_done < quota) {
+        /* enable IRQs for frame errors and all mailboxes >= rx_next */
+        u32 reg_ier = AT91_IRQ_ERR_FRAME;
+        reg_ier |= get_irq_mb_rx(priv) & ~AT91_MB_MASK(priv->rx_next);
+
+        at91_write(priv, AT91_IER, reg_ier);
+    }
+
+    return work_done;
+}
+
+
  static int at91_poll(struct napi_struct *napi, int quota)
  {
      struct net_device *dev = napi->dev;
@@ -1086,7 +1115,15 @@
          priv->reg_sr = reg_sr;
          at91_write(priv, AT91_IDR,
                 get_irq_mb_rx(priv) | AT91_IRQ_ERR_FRAME);
-        napi_schedule(&priv->napi);
+
+        /*
+        * Call CAN controller polling function without napi.
+        * Sometimes need napi too many time to call
+        * the polling function. In this case Rx overflow
+        * occur at high bus load.
+        */
+        at91_poll_nonapi(dev, 64);
+        /* napi_schedule(&priv->napi); */
      }

      /* Transmission complete interrupt */


Is there a possibility to make using of napi configurable in this driver?

Depend on design sometimes after receive interrupt occurs
there is only time for three CAN frames before overflow error.
Not really a lot of time to use polling, but for other people possibly 
preferable.

Regards,
Efim


