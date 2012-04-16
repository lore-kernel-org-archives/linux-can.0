From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull request: linux-can-next 2012-04-16
Date: Mon, 16 Apr 2012 21:32:24 +0200
Message-ID: <1334604746-24556-1-git-send-email-mkl@pengutronix.de>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40914 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751633Ab2DPTcg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 16 Apr 2012 15:32:36 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de

Hello David,

first round of linux-can updates for net-next, including a sparse warning
fix and the conversion of the pci drivers to use module_pci_driver.

The following changes since commit f4f9f6e75d67ddfcfea79a2108217bc654aef3af:

  tcp: restore formatting of macros for tcp_skb_cb sacked field (2012-04-16 14:38:16 -0400)

are available in the git repository at:
  git://gitorious.org/linux-can/linux-can-next.git master

Axel Lin (1):
      net/can: use module_pci_driver

Daniel Baluta (1):
      can: fix sparse warning for cgw_list

 drivers/net/can/pch_can.c            |   12 +-----------
 drivers/net/can/sja1000/ems_pci.c    |   14 +-------------
 drivers/net/can/sja1000/kvaser_pci.c |   13 +------------
 drivers/net/can/sja1000/peak_pci.c   |   12 +-----------
 drivers/net/can/sja1000/plx_pci.c    |   13 +------------
 net/can/gw.c                         |    2 +-


