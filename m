Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520734BCABD;
	Tue,  4 Aug 2026 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785873381; cv=none; b=QJO3pTmpUhM/kaOJtdbK7OA/kipa44R3rQG769gDdCpXgVfrhH0bEAVK5Nm+qR3QkNQBKGEvbQJMJr5wstpqC92OjcvMIiEjAA8GLWNVnth7AlBN6xWHuqPbl6ErKsjdYVBBUvUWey4qXhjmc9vO57YbnE0X+MgUxWzx6v+5wqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785873381; c=relaxed/simple;
	bh=XTUzUJ37Odv4BS+aB9joZBwyMHufZWHuEz1yKCIDIFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aFzolS8ufaygYu4pU2SN+EIB+78z0n76pfYrGEh1P6QWTg1ZtDOKSGx4ln8rGqCVwLj6du1WUqJYxNL1hpVsoayqLCEjjFGfw3J8yhrL7KKG8JTrh3/kY/fc/ELEMLwaiSB2+3uC+YAcyAXj97AjYJRHe5Xz7atzDmmQ854edQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRnyiUxa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRnyiUxa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8D81F000E9;
	Tue,  4 Aug 2026 19:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785873379;
	bh=2VDdT3KXm5jnar1tvFOEh8puTxc0rnf/78TD7aGvKKA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MRnyiUxazNN63cWqUsjqzSaOaxjq0R+5B6HtASSZ/OKUoBRtjwwx82vBpopKWHY6R
	 mXxslsPkcY85+3ZPpAxWrOjjgVPHRvSp7+SInEhYnFjimdGP6j/y4PbSydgQS4UKzY
	 Eh3Z/vM+8mbQvYJE2790F41MGw0Y0RuaIaAVPYsneEOoEbdKnR+/eyhy+dhg+LCwvh
	 PgvLGP6+EI3CV5E85waatlZUyuaL5QPF4fN23B1y2yLRysjM8c4r07cR0bwdIkD7YV
	 XPvSLXray8TlP3+L/+V9Gi1g/CIrT9bMIcZkR8c+6Ia5uPAO10N5R1mQp0h1zRYOeq
	 na1GI1HOIZR0g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 04 Aug 2026 21:55:27 +0200
Subject: [PATCH 4/4] can: treewide: remove redundant IFF_ECHO assignments
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-automate_iff_echo_flag-v1-4-26f06ff0f8bc@kernel.org>
References: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
In-Reply-To: <20260804-automate_iff_echo_flag-v1-0-26f06ff0f8bc@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=20309; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=XTUzUJ37Odv4BS+aB9joZBwyMHufZWHuEz1yKCIDIFY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDFlFzjfvrzWcqv+e/cJiFQ+Vf8sqA082bZMN28+eUn7lc
 MvpGbf4OiayMIhxMViKKbIsK+fkVugo9A479NcSZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 BDJ0jBi4OAVgqquOM/xPDLPIv7HwmcqDoNqKdyrvLK4zTtylclCPV/UT9/5UrdV3GP577758TED
 XLzJdQkd/QszqorTPby/sT5oy+8vThuDje/bzAQA=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

alloc_candev() and alloc_candev_mqs() now set IFF_ECHO automatically
when echo skb slots are requested. Remove the explicit assignments from
drivers which are covered by that generic setup.

Keep the remaining explicit IFF_ECHO assignments for drivers with custom
or virtual echo handling.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/at91_can.c                         | 1 -
 drivers/net/can/bxcan.c                            | 1 -
 drivers/net/can/c_can/c_can_main.c                 | 1 -
 drivers/net/can/cc770/cc770.c                      | 2 --
 drivers/net/can/ctucanfd/ctucanfd_base.c           | 1 -
 drivers/net/can/dummy_can.c                        | 1 -
 drivers/net/can/esd/esd_402_pci-core.c             | 1 -
 drivers/net/can/flexcan/flexcan-core.c             | 1 -
 drivers/net/can/ifi_canfd/ifi_canfd.c              | 1 -
 drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c | 1 -
 drivers/net/can/m_can/m_can.c                      | 1 -
 drivers/net/can/mscan/mscan.c                      | 2 --
 drivers/net/can/peak_canfd/peak_canfd.c            | 1 -
 drivers/net/can/rcar/rcar_can.c                    | 1 -
 drivers/net/can/rcar/rcar_canfd.c                  | 1 -
 drivers/net/can/rockchip/rockchip_canfd-core.c     | 1 -
 drivers/net/can/sja1000/sja1000.c                  | 1 -
 drivers/net/can/softing/softing_main.c             | 1 -
 drivers/net/can/spi/hi311x.c                       | 1 -
 drivers/net/can/spi/mcp251x.c                      | 1 -
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c     | 1 -
 drivers/net/can/sun4i_can.c                        | 1 -
 drivers/net/can/ti_hecc.c                          | 1 -
 drivers/net/can/usb/ems_usb.c                      | 2 --
 drivers/net/can/usb/esd_usb.c                      | 2 --
 drivers/net/can/usb/etas_es58x/es58x_core.c        | 1 -
 drivers/net/can/usb/f81604.c                       | 1 -
 drivers/net/can/usb/gs_usb.c                       | 1 -
 drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c   | 2 --
 drivers/net/can/usb/mcba_usb.c                     | 2 --
 drivers/net/can/usb/nct6694_canfd.c                | 1 -
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       | 2 --
 drivers/net/can/usb/usb_8dev.c                     | 2 --
 drivers/net/can/virtio_can.c                       | 1 -
 drivers/net/can/xilinx_can.c                       | 2 --
 35 files changed, 44 deletions(-)

diff --git a/drivers/net/can/at91_can.c b/drivers/net/can/at91_can.c
index 58da323f14d7..aaa21697abb4 100644
--- a/drivers/net/can/at91_can.c
+++ b/drivers/net/can/at91_can.c
@@ -1105,7 +1105,6 @@ static int at91_can_probe(struct platform_device *pdev)
 	dev->netdev_ops	= &at91_netdev_ops;
 	dev->ethtool_ops = &at91_ethtool_ops;
 	dev->irq = irq;
-	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
 	priv->can.clock.freq = clk_get_rate(clk);
diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
index baf494d20bef..98e712488313 100644
--- a/drivers/net/can/bxcan.c
+++ b/drivers/net/can/bxcan.c
@@ -987,7 +987,6 @@ static int bxcan_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &bxcan_netdev_ops;
 	ndev->ethtool_ops = &bxcan_ethtool_ops;
 	ndev->irq = rx_irq;
-	ndev->flags |= IFF_ECHO;
 
 	priv->dev = dev;
 	priv->ndev = ndev;
diff --git a/drivers/net/can/c_can/c_can_main.c b/drivers/net/can/c_can/c_can_main.c
index b3b321d9ce68..3a3ca718bb8d 100644
--- a/drivers/net/can/c_can/c_can_main.c
+++ b/drivers/net/can/c_can/c_can_main.c
@@ -1373,7 +1373,6 @@ int register_c_can_dev(struct net_device *dev)
 	 */
 	pinctrl_pm_select_sleep_state(dev->dev.parent);
 
-	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &c_can_netdev_ops;
 	dev->ethtool_ops = &c_can_ethtool_ops;
 
diff --git a/drivers/net/can/cc770/cc770.c b/drivers/net/can/cc770/cc770.c
index 8d5abd643c06..16ac88426384 100644
--- a/drivers/net/can/cc770/cc770.c
+++ b/drivers/net/can/cc770/cc770.c
@@ -852,8 +852,6 @@ int register_cc770dev(struct net_device *dev)
 	dev->netdev_ops = &cc770_netdev_ops;
 	dev->ethtool_ops = &cc770_ethtool_ops;
 
-	dev->flags |= IFF_ECHO;	/* we support local echo */
-
 	/* Should we use additional functions? */
 	if (!i82527_compat && priv->control_normal_mode & CTRL_EAF) {
 		priv->can.do_get_berr_counter = cc770_get_berr_counter;
diff --git a/drivers/net/can/ctucanfd/ctucanfd_base.c b/drivers/net/can/ctucanfd/ctucanfd_base.c
index 07d4aa43c700..f54927863cf6 100644
--- a/drivers/net/can/ctucanfd/ctucanfd_base.c
+++ b/drivers/net/can/ctucanfd/ctucanfd_base.c
@@ -1381,7 +1381,6 @@ int ctucan_probe_common(struct device *dev, void __iomem *addr, int irq, unsigne
 
 	/* Get IRQ for the device */
 	ndev->irq = irq;
-	ndev->flags |= IFF_ECHO;	/* We support local echo */
 
 	if (set_drvdata_fnc)
 		set_drvdata_fnc(dev, ndev);
diff --git a/drivers/net/can/dummy_can.c b/drivers/net/can/dummy_can.c
index cd23de488edc..41953655e3d3 100644
--- a/drivers/net/can/dummy_can.c
+++ b/drivers/net/can/dummy_can.c
@@ -241,7 +241,6 @@ static int __init dummy_can_init(void)
 
 	dev->netdev_ops = &dummy_can_netdev_ops;
 	dev->ethtool_ops = &dummy_can_ethtool_ops;
-	dev->flags |= IFF_ECHO; /* enable echo handling */
 	priv = netdev_priv(dev);
 	priv->can.bittiming_const = &dummy_can_bittiming_const;
 	priv->can.bitrate_max = 20 * MEGA /* BPS */;
diff --git a/drivers/net/can/esd/esd_402_pci-core.c b/drivers/net/can/esd/esd_402_pci-core.c
index c826f00c551b..244bc387062d 100644
--- a/drivers/net/can/esd/esd_402_pci-core.c
+++ b/drivers/net/can/esd/esd_402_pci-core.c
@@ -362,7 +362,6 @@ static int pci402_init_cores(struct pci_dev *pdev)
 		}
 		core->netdev = netdev;
 
-		netdev->flags |= IFF_ECHO;
 		netdev->dev_port = i;
 		netdev->netdev_ops = &pci402_acc_netdev_ops;
 		netdev->ethtool_ops = &pci402_acc_ethtool_ops;
diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index f5d22c61503f..8e06f462ee02 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2182,7 +2182,6 @@ static int flexcan_probe(struct platform_device *pdev)
 	dev->netdev_ops = &flexcan_netdev_ops;
 	dev->ethtool_ops = &flexcan_ethtool_ops;
 	dev->irq = irq;
-	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
 	priv->devtype_data = *devtype_data;
diff --git a/drivers/net/can/ifi_canfd/ifi_canfd.c b/drivers/net/can/ifi_canfd/ifi_canfd.c
index 0f83335e4d07..732b59017734 100644
--- a/drivers/net/can/ifi_canfd/ifi_canfd.c
+++ b/drivers/net/can/ifi_canfd/ifi_canfd.c
@@ -985,7 +985,6 @@ static int ifi_canfd_plat_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	ndev->irq = irq;
-	ndev->flags |= IFF_ECHO;	/* we support local echo */
 	ndev->netdev_ops = &ifi_canfd_netdev_ops;
 	ndev->ethtool_ops = &ifi_canfd_ethtool_ops;
 
diff --git a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
index d8c9bfb20230..dbe6bd0f40f1 100644
--- a/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
+++ b/drivers/net/can/kvaser_pciefd/kvaser_pciefd_core.c
@@ -1005,7 +1005,6 @@ static int kvaser_pciefd_setup_can_ctrls(struct kvaser_pciefd *pcie)
 		if (status & KVASER_PCIEFD_KCAN_STAT_CAP)
 			can->can.ctrlmode_supported |= CAN_CTRLMODE_ONE_SHOT;
 
-		netdev->flags |= IFF_ECHO;
 		SET_NETDEV_DEV(netdev, &pcie->pci->dev);
 
 		iowrite32(GENMASK(31, 0), can->reg_base + KVASER_PCIEFD_KCAN_IRQ_REG);
diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index eb856547ae7d..3cccb796aa40 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -2330,7 +2330,6 @@ static int register_m_can_dev(struct m_can_classdev *cdev)
 {
 	struct net_device *dev = cdev->net;
 
-	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &m_can_netdev_ops;
 	if (dev->irq && cdev->is_peripheral)
 		dev->ethtool_ops = &m_can_ethtool_ops_coalescing;
diff --git a/drivers/net/can/mscan/mscan.c b/drivers/net/can/mscan/mscan.c
index 39c7aa2a0b2f..9285a441d326 100644
--- a/drivers/net/can/mscan/mscan.c
+++ b/drivers/net/can/mscan/mscan.c
@@ -675,8 +675,6 @@ struct net_device *alloc_mscandev(void)
 	dev->netdev_ops = &mscan_netdev_ops;
 	dev->ethtool_ops = &mscan_ethtool_ops;
 
-	dev->flags |= IFF_ECHO;	/* we support local echo */
-
 	netif_napi_add_weight(dev, &priv->napi, mscan_rx_poll, 8);
 
 	priv->can.bittiming_const = &mscan_bittiming_const;
diff --git a/drivers/net/can/peak_canfd/peak_canfd.c b/drivers/net/can/peak_canfd/peak_canfd.c
index 4fd1aefb780f..ce2ab0bcecf7 100644
--- a/drivers/net/can/peak_canfd/peak_canfd.c
+++ b/drivers/net/can/peak_canfd/peak_canfd.c
@@ -827,7 +827,6 @@ struct net_device *alloc_peak_canfd_dev(int sizeof_priv, int index,
 	priv->cmd_len = 0;
 	spin_lock_init(&priv->echo_lock);
 
-	ndev->flags |= IFF_ECHO;
 	ndev->netdev_ops = &peak_canfd_netdev_ops;
 	ndev->ethtool_ops = &peak_canfd_ethtool_ops;
 	ndev->dev_id = index;
diff --git a/drivers/net/can/rcar/rcar_can.c b/drivers/net/can/rcar/rcar_can.c
index 2727c5ce029c..1ed0b19111f3 100644
--- a/drivers/net/can/rcar/rcar_can.c
+++ b/drivers/net/can/rcar/rcar_can.c
@@ -792,7 +792,6 @@ static int rcar_can_probe(struct platform_device *pdev)
 	ndev->netdev_ops = &rcar_can_netdev_ops;
 	ndev->ethtool_ops = &rcar_can_ethtool_ops;
 	ndev->irq = irq;
-	ndev->flags |= IFF_ECHO;
 	priv->ndev = ndev;
 	priv->regs = addr;
 	priv->clock_select = clock_select;
diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index fcc37b73ed43..6772117f18d0 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -1878,7 +1878,6 @@ static int rcar_canfd_channel_probe(struct rcar_canfd_global *gpriv, u32 ch,
 
 	ndev->netdev_ops = &rcar_canfd_netdev_ops;
 	ndev->ethtool_ops = &rcar_canfd_ethtool_ops;
-	ndev->flags |= IFF_ECHO;
 	priv->ndev = ndev;
 	priv->base = gpriv->base;
 	priv->transceiver = transceiver;
diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 29de0c01e4ed..a2a4ed624b6d 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -893,7 +893,6 @@ static int rkcanfd_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 
 	ndev->netdev_ops = &rkcanfd_netdev_ops;
-	ndev->flags |= IFF_ECHO;
 
 	platform_set_drvdata(pdev, priv);
 	priv->can.clock.freq = clk_get_rate(priv->clks[0].clk);
diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 3cdb583ee3e5..423e9395e776 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -688,7 +688,6 @@ int register_sja1000dev(struct net_device *dev)
 	if (!sja1000_probe_chip(dev))
 		return -ENODEV;
 
-	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &sja1000_netdev_ops;
 	dev->ethtool_ops = &sja1000_ethtool_ops;
 
diff --git a/drivers/net/can/softing/softing_main.c b/drivers/net/can/softing/softing_main.c
index 519ab3097f86..5ab67c8dc8ff 100644
--- a/drivers/net/can/softing/softing_main.c
+++ b/drivers/net/can/softing/softing_main.c
@@ -651,7 +651,6 @@ static struct net_device *softing_netdev_create(struct softing *card,
 	priv->output = softing_default_output(netdev);
 	SET_NETDEV_DEV(netdev, &card->pdev->dev);
 
-	netdev->flags |= IFF_ECHO;
 	netdev->netdev_ops = &softing_netdev_ops;
 	netdev->ethtool_ops = &softing_ethtool_ops;
 	priv->can.do_set_mode = softing_candev_set_mode;
diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index ae90e6716de5..267b3404e699 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -861,7 +861,6 @@ static int hi3110_can_probe(struct spi_device *spi)
 
 	net->netdev_ops = &hi3110_netdev_ops;
 	net->ethtool_ops = &hi3110_ethtool_ops;
-	net->flags |= IFF_ECHO;
 
 	priv = netdev_priv(net);
 	priv->can.bittiming_const = &hi3110_bittiming_const;
diff --git a/drivers/net/can/spi/mcp251x.c b/drivers/net/can/spi/mcp251x.c
index 0d0190ae094a..732a2cc1dd50 100644
--- a/drivers/net/can/spi/mcp251x.c
+++ b/drivers/net/can/spi/mcp251x.c
@@ -1361,7 +1361,6 @@ static int mcp251x_can_probe(struct spi_device *spi)
 
 	net->netdev_ops = &mcp251x_netdev_ops;
 	net->ethtool_ops = &mcp251x_ethtool_ops;
-	net->flags |= IFF_ECHO;
 
 	priv = netdev_priv(net);
 	priv->can.bittiming_const = &mcp251x_bittiming_const;
diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index f441f2265299..07b67ac2f8c5 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -2281,7 +2281,6 @@ static int mcp251xfd_probe(struct spi_device *spi)
 
 	ndev->netdev_ops = &mcp251xfd_netdev_ops;
 	ndev->irq = spi->irq;
-	ndev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(ndev);
 	spi_set_drvdata(spi, priv);
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index af52285d5a4e..f15344126791 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -874,7 +874,6 @@ static int sun4ican_probe(struct platform_device *pdev)
 	dev->netdev_ops = &sun4ican_netdev_ops;
 	dev->ethtool_ops = &sun4ican_ethtool_ops;
 	dev->irq = irq;
-	dev->flags |= IFF_ECHO;
 
 	priv = netdev_priv(dev);
 	priv->can.clock.freq = clk_get_rate(clk);
diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
index 1d3dbf28b105..3831d23a4ab9 100644
--- a/drivers/net/can/ti_hecc.c
+++ b/drivers/net/can/ti_hecc.c
@@ -908,7 +908,6 @@ static int ti_hecc_probe(struct platform_device *pdev)
 	priv->can.ctrlmode_supported = CAN_CTRLMODE_3_SAMPLES;
 
 	spin_lock_init(&priv->mbx_lock);
-	ndev->flags |= IFF_ECHO;
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->netdev_ops = &ti_hecc_netdev_ops;
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 24cf8f651f8f..8c9a1892e9e0 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -1058,8 +1058,6 @@ static int ems_usb_probe(struct usb_interface *intf,
 	netdev->netdev_ops = &ems_usb_netdev_ops;
 	netdev->ethtool_ops = &ems_usb_ethtool_ops;
 
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
 	init_usb_anchor(&dev->rx_submitted);
 
 	init_usb_anchor(&dev->tx_submitted);
diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index f41d4a0d140f..43a645a5c4a2 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1263,8 +1263,6 @@ static int esd_usb_probe_one_net(struct usb_interface *intf, int index)
 	priv->can.do_set_mode = esd_usb_set_mode;
 	priv->can.do_get_berr_counter = esd_usb_get_berr_counter;
 
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
 	netdev->netdev_ops = &esd_usb_netdev_ops;
 	netdev->ethtool_ops = &esd_usb_ethtool_ops;
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index e1724ae79c5a..3ab5de7910c0 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -2107,7 +2107,6 @@ static int es58x_init_netdev(struct es58x_device *es58x_dev, int channel_idx)
 
 	netdev->netdev_ops = &es58x_netdev_ops;
 	netdev->ethtool_ops = &es58x_ethtool_ops;
-	netdev->flags |= IFF_ECHO;	/* We support local echo */
 	netdev->dev_port = channel_idx;
 
 	ret = register_candev(netdev);
diff --git a/drivers/net/can/usb/f81604.c b/drivers/net/can/usb/f81604.c
index f12318268e46..7b6af2aa55f1 100644
--- a/drivers/net/can/usb/f81604.c
+++ b/drivers/net/can/usb/f81604.c
@@ -1201,7 +1201,6 @@ static int f81604_probe(struct usb_interface *intf,
 
 		netdev->ethtool_ops = &f81604_ethtool_ops;
 		netdev->netdev_ops = &f81604_netdev_ops;
-		netdev->flags |= IFF_ECHO;
 		netdev->dev_port = i;
 
 		SET_NETDEV_DEV(netdev, &intf->dev);
diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index 82508a865095..e4f04b5c95cd 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1351,7 +1351,6 @@ static struct gs_can *gs_make_candev(unsigned int channel,
 	netdev->netdev_ops = &gs_usb_netdev_ops;
 	netdev->ethtool_ops = &gs_usb_ethtool_ops;
 
-	netdev->flags |= IFF_ECHO; /* we support full roundtrip echo */
 	netdev->dev_id = channel;
 	netdev->dev_port = channel;
 
diff --git a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
index d0a2a2a33c1c..1cbf1c0b9fea 100644
--- a/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
+++ b/drivers/net/can/usb/kvaser_usb/kvaser_usb_core.c
@@ -886,8 +886,6 @@ static int kvaser_usb_init_one(struct kvaser_usb *dev, int channel)
 		priv->can.fd.do_set_data_bittiming = kvaser_usb_set_data_bittiming;
 	}
 
-	netdev->flags |= IFF_ECHO;
-
 	netdev->netdev_ops = &kvaser_usb_netdev_ops;
 	netdev->ethtool_ops = &kvaser_usb_ethtool_ops;
 	SET_NETDEV_DEV(netdev, &dev->intf->dev);
diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 04170326dc7e..8043c1e24345 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -853,8 +853,6 @@ static int mcba_usb_probe(struct usb_interface *intf,
 	netdev->netdev_ops = &mcba_netdev_ops;
 	netdev->ethtool_ops = &mcba_ethtool_ops;
 
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
 	SET_NETDEV_DEV(netdev, &intf->dev);
 
 	err = register_candev(netdev);
diff --git a/drivers/net/can/usb/nct6694_canfd.c b/drivers/net/can/usb/nct6694_canfd.c
index e5f7f8849a73..b6ac97dd78ca 100644
--- a/drivers/net/can/usb/nct6694_canfd.c
+++ b/drivers/net/can/usb/nct6694_canfd.c
@@ -743,7 +743,6 @@ static int nct6694_canfd_probe(struct platform_device *pdev)
 	}
 
 	ndev->irq = irq;
-	ndev->flags |= IFF_ECHO;
 	ndev->dev_port = port;
 	ndev->netdev_ops = &nct6694_canfd_netdev_ops;
 	ndev->ethtool_ops = &nct6694_canfd_ethtool_ops;
diff --git a/drivers/net/can/usb/peak_usb/pcan_usb_core.c b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
index 55aad01cd8ca..a49af5a06194 100644
--- a/drivers/net/can/usb/peak_usb/pcan_usb_core.c
+++ b/drivers/net/can/usb/peak_usb/pcan_usb_core.c
@@ -957,8 +957,6 @@ static int peak_usb_create_dev(const struct peak_usb_adapter *peak_usb_adapter,
 
 	netdev->netdev_ops = &peak_usb_netdev_ops;
 
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
 	/* add ethtool support */
 	netdev->ethtool_ops = peak_usb_adapter->ethtool_ops;
 
diff --git a/drivers/net/can/usb/usb_8dev.c b/drivers/net/can/usb/usb_8dev.c
index 3125cf59d002..6815d7fe987d 100644
--- a/drivers/net/can/usb/usb_8dev.c
+++ b/drivers/net/can/usb/usb_8dev.c
@@ -939,8 +939,6 @@ static int usb_8dev_probe(struct usb_interface *intf,
 	netdev->netdev_ops = &usb_8dev_netdev_ops;
 	netdev->ethtool_ops = &usb_8dev_ethtool_ops;
 
-	netdev->flags |= IFF_ECHO; /* we support local echo */
-
 	init_usb_anchor(&priv->rx_submitted);
 
 	init_usb_anchor(&priv->tx_submitted);
diff --git a/drivers/net/can/virtio_can.c b/drivers/net/can/virtio_can.c
index f67d0bf09681..863dfcf3f13d 100644
--- a/drivers/net/can/virtio_can.c
+++ b/drivers/net/can/virtio_can.c
@@ -425,7 +425,6 @@ static const struct net_device_ops virtio_can_netdev_ops = {
 
 static int register_virtio_can_dev(struct net_device *dev)
 {
-	dev->flags |= IFF_ECHO;	/* we support local echo */
 	dev->netdev_ops = &virtio_can_netdev_ops;
 
 	return register_candev(dev);
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 43d7f22820b8..e63e3d0a0cf6 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -1996,8 +1996,6 @@ static int xcan_probe(struct platform_device *pdev)
 
 	ndev->irq = ret;
 
-	ndev->flags |= IFF_ECHO;	/* We support local echo */
-
 	platform_set_drvdata(pdev, ndev);
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->netdev_ops = &xcan_netdev_ops;

-- 
2.54.0

