From: Andri Yngvason <andri.yngvason@marel.com>
Subject: peak_pci: TX Frame Loss
Date: Wed, 18 Nov 2015 14:51:21 +0000
Message-ID: <20151118145121.32487.38169@maxwell.marel.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-am1on0063.outbound.protection.outlook.com ([157.56.112.63]:28016
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755920AbbKRPI3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Nov 2015 10:08:29 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, s.grosjean@peak-system.com

Hi all,

We've been experiencing frame loss on transmission in the peak_pci netdev
driver.

The frames are not reported as "dumped" by the netlink interface.

We are running CANopen and this manifests sporadically as nodes dropping off the
network due to failure to answer node guarding RTR and as SDO request timeouts.

Example with can0 and can1 on the same bus where the CANopen master is on can0
and can1 is set up to listen only:
(1446688151.783844)  can0  701  [1] remote request <- node guarding request on can0
(1446688151.784296)  can0  70A  [1] remote request <- another node guarding request
(1446688151.784304)  can1  70A  [1] remote request <- only the latter is seen by can1
(1446688151.784751)  can0  720  [1] remote request
(1446688151.784763)  can1  720  [1] remote request                             
(1446688151.785793)  can1  283  [8] 00 00 00 00 00 00 00 00                    
(1446688151.785792)  can0  283  [8] 00 00 00 00 00 00 00 00                    
(1446688151.786164)  can0  70A  [1] 85 <-- node guarding response
(1446688151.786163)  can1  70A  [1] 85                                         
(1446688151.786641)  can1  720  [1] 85 
(1446688151.786641)  can0  720  [1] 85 <-- node guarding response
(1446688151.787057)  can0  721  [1] remote request                             
(1446688151.787063)  can1  721  [1] remote request                             
(1446688151.787728)  can0  721  [1] 05                                         
(1446688151.787733)  can1  721  [1] 05          

Node 1 never responded because it never received the request.

The node guarding requests are sent in bursts where lower ids appear before
higher ids. A curious observation is that it's always the lowest id that drops
out first. I.e. the first frame in a burst of frames is the one that's lost.

Another interesting thing that we've found out is that if we turn off SMP on the
system, the problem disappears. But obviously we don't want to disable SMP in a
production system. ;)
It helps to set the cpy affinity of all threads and processes that touch the CAN
bus to a single core but sadly it doesn't eliminate the problem.

Our systems are running on kernel version 3.14.3 with the rt patch. I tried
running 4.1.12-rt13 but that did not eliminate the problem. We also tried
running with the pcan netdev driver from peak which does in fact run without
frame loss. Thus, this is probably an issue with either peak_pci or sja1000.

I tried poking around in sja1000.c. I noticed that sja1000_start_xmit() is not
guarded against trying to transmit when the tx buffer is occupied, so I added a
check and a print-out:
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 32bd7f4..adc49db 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -292,6 +292,11 @@ static netdev_tx_t sja1000_start_xmit(struct sk_buff *skb,
 
        netif_stop_queue(dev);
 
+       if (!(priv->read_reg(priv, SJA1000_SR) & SR_TBS)) {
+               netdev_err(dev, "BUG!, TX FIFO full when queue awake!\n");
+               return NETDEV_TX_BUSY;
+       }
+
        fi = dlc = cf->can_dlc;
        id = cf->can_id;

There was no error message in dmesg after frame loss, so that's not the problem.

The CPU is an Intel i7-4700EQ and the CAN interface is a Peak PCIe dual channel.

Does anyone have an idea what might be wrong? :)

Best regards,
Andri
