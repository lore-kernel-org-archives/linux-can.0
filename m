From: "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>
Subject: Populating netdev::dev_id for udev discrimination
Date: Sat, 08 Mar 2014 11:00:20 -0500
Message-ID: <1394294420.3356.15.camel@NREC-014563>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.rec.ri.cmu.edu ([128.2.197.155]:37248 "EHLO
	mail.rec.ri.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487AbaCHQPT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Mar 2014 11:15:19 -0500
Received: from [192.168.0.19] (c-67-165-49-6.hsd1.pa.comcast.net [67.165.49.6])
	(authenticated bits=0)
	by mail.rec.ri.cmu.edu (8.13.1/8.13.1) with ESMTP id s28G0TKM001507
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <linux-can@vger.kernel.org>; Sat, 8 Mar 2014 11:00:29 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi All,

I'm new to the list, and have poked around on gmane enough to convince
myself that this hasn't been covered before, but if I've missed
something in this vein, apologies in advance.

My objective is to be able to totally discriminate CAN ports on
multi-port cards via udev so as to rename them to semantically
interesting/unique names for my system (e.g., "ecuCAN" and "auxCAN"
instead of "can0" and "can1").

udevadm info gives me the KERNELS=... incantation to match the pci bus
address, but there are no other differences in the udev listing for my
various CAN ports (at least for my peak_pci device)

Digging into the semantics of ATTRS{...}, "dev_id" stood out as having
the intention of discriminating between physical ports that "share the
same link layer" (from netdev.h) or "share the same MAC address" (from
various other mailing lists).

The following patch assigns the dev_id field to match the channel number
on all multi-channel cards I could identify in a fresh git pull under
drivers/net/can.  I can only test my two-port Peak PCI card, but it
works as expected: ATTRS{dev_id} now expresses the port number and my
udev rules now unambiguously pick out and rename my individual CAN
ports.

The drivers for other cards I have touched at least compile, but should
certainly be tested before deploying this patch.

-Chris

diff --git a/drivers/net/can/sja1000/ems_pci.c b/drivers/net/can/sja1000/ems_pci.c
index d790b87..fd13dbf 100644
--- a/drivers/net/can/sja1000/ems_pci.c
+++ b/drivers/net/can/sja1000/ems_pci.c
@@ -323,6 +323,7 @@ static int ems_pci_add_card(struct pci_dev *pdev,
 			priv->cdr = EMS_PCI_CDR;
 
 			SET_NETDEV_DEV(dev, &pdev->dev);
+			dev->dev_id = i;
 
 			if (card->version == 1)
 				/* reset int flag of pita */
diff --git a/drivers/net/can/sja1000/ems_pcmcia.c b/drivers/net/can/sja1000/ems_pcmcia.c
index 9e535f2..381de99 100644
--- a/drivers/net/can/sja1000/ems_pcmcia.c
+++ b/drivers/net/can/sja1000/ems_pcmcia.c
@@ -211,6 +211,7 @@ static int ems_pcmcia_add_card(struct pcmcia_device *pdev, unsigned long base)
 		priv = netdev_priv(dev);
 		priv->priv = card;
 		SET_NETDEV_DEV(dev, &pdev->dev);
+		dev->dev_id = i;
 
 		priv->irq_flags = IRQF_SHARED;
 		dev->irq = pdev->irq;
diff --git a/drivers/net/can/sja1000/kvaser_pci.c b/drivers/net/can/sja1000/kvaser_pci.c
index c96eb14..23b8e13 100644
--- a/drivers/net/can/sja1000/kvaser_pci.c
+++ b/drivers/net/can/sja1000/kvaser_pci.c
@@ -270,6 +270,7 @@ static int kvaser_pci_add_chan(struct pci_dev *pdev, int channel,
 		 priv->reg_base, board->conf_addr, dev->irq);
 
 	SET_NETDEV_DEV(dev, &pdev->dev);
+	dev->dev_id = channel;
 
 	/* Register SJA1000 device */
 	err = register_sja1000dev(dev);
diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 065ca49..c540e3d 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -642,6 +642,7 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		icr |= chan->icr_mask;
 
 		SET_NETDEV_DEV(dev, &pdev->dev);
+		dev->dev_id = i;
 
 		/* Create chain of SJA1000 devices */
 		chan->prev_dev = pci_get_drvdata(pdev);
diff --git a/drivers/net/can/sja1000/peak_pcmcia.c b/drivers/net/can/sja1000/peak_pcmcia.c
index f7ad754..dd56133 100644
--- a/drivers/net/can/sja1000/peak_pcmcia.c
+++ b/drivers/net/can/sja1000/peak_pcmcia.c
@@ -550,6 +550,7 @@ static int pcan_add_channels(struct pcan_pccard *card)
 		priv = netdev_priv(netdev);
 		priv->priv = card;
 		SET_NETDEV_DEV(netdev, &pdev->dev);
+		netdev->dev_id = i;
 
 		priv->irq_flags = IRQF_SHARED;
 		netdev->irq = pdev->irq;
diff --git a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
index fbb61a0..ec39b7c 100644
--- a/drivers/net/can/sja1000/plx_pci.c
+++ b/drivers/net/can/sja1000/plx_pci.c
@@ -587,6 +587,7 @@ static int plx_pci_add_card(struct pci_dev *pdev,
 			priv->cdr = ci->cdr;
 
 			SET_NETDEV_DEV(dev, &pdev->dev);
+			dev->dev_id = i;
 
 			/* Register SJA1000 device */
 			err = register_sja1000dev(dev);
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 9ea0dcd..c79dad1 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -832,6 +832,7 @@ static int softing_pdev_probe(struct platform_device *pdev)
 			ret = -ENOMEM;
 			goto netdev_failed;
 		}
+		netdev->dev_id = j;
 		priv = netdev_priv(card->net[j]);
 		priv->index = j;
 		ret = softing_netdev_register(netdev);
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb2.c
index 7fbe859..65ea1058 100644
--- a/drivers/net/can/usb/esd_usb2.c
+++ b/drivers/net/can/usb/esd_usb2.c
@@ -1024,6 +1024,7 @@ static int esd_usb2_probe_one_net(struct usb_interface *intf, int index)
 	netdev->netdev_ops = &esd_usb2_netdev_ops;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
+	netdev->dev_id = index;
 
 	err = register_candev(netdev);
 	if (err) {
diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/kvaser_usb.c
index e77d110..880c0257 100644
--- a/drivers/net/can/usb/kvaser_usb.c
+++ b/drivers/net/can/usb/kvaser_usb.c
@@ -1529,6 +1529,7 @@ static int kvaser_usb_init_one(struct usb_interface *intf,
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
+	netdev->dev_id = channel;
 
 	dev->nets[channel] = priv;
 
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 0b7a4c3..89f560b 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -769,6 +769,7 @@ static int peak_usb_create_dev(struct peak_usb_adapter *peak_usb_adapter,
 	usb_set_intfdata(intf, dev);
 
 	SET_NETDEV_DEV(netdev, &intf->dev);
+	netdev->dev_id = ctrl_idx;
 
 	err = register_candev(netdev);
 	if (err) {

