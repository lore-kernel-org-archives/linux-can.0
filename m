From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Thu, 29 Nov 2012 15:39:40 +0100
Message-ID: <1354199987-10350-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:44184 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752836Ab2K2Ojz (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Nov 2012 09:39:55 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Hello,

here is v2 of my patches for the C_CAN drivers.

For Michael I have prepared out-of-tree driver sources allowing to
easily build the drivers also for older 3.x kernel versions. More
tester are welcome.

Changes since v1:

- use init callback after renaming it from initram
- use different sets of interface registers for rx and tx (like PCH_CAN)
- use spin_[un]lock_bh to protect the tx objects

Wolfgang Grandegger (7):
  pch_can: add spinlocks to protect tx objects
  c_can: rename callback "initram" to "init" to more general usage
  c_can: use different sets of interface registers for rx and tx
  c_can_pci: introduce board specific PCI bar
  c_can_pci: enable PCI bus master only for MSI
  c_can_pci: add support for PCH CAN on Intel EG20T PCH
  c_can: add spinlock to protect tx and  objects

 drivers/net/can/c_can/c_can.c          |   66 +++++++++++++++++++++-----------
 drivers/net/can/c_can/c_can.h          |    3 +-
 drivers/net/can/c_can/c_can_pci.c      |   56 +++++++++++++++++++++++++--
 drivers/net/can/c_can/c_can_platform.c |    2 +-
 drivers/net/can/pch_can.c              |    9 +++++
 5 files changed, 108 insertions(+), 28 deletions(-)

-- 
1.7.9.5

