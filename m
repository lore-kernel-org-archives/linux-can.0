From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC 0/6] pch_can/c_can: fix races and add PCH support to c_can
Date: Mon, 26 Nov 2012 09:23:00 +0100
Message-ID: <1353918186-4234-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33874 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754312Ab2KZIXf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 03:23:35 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: bhupesh.sharma@st.com, tomoya.rohm@gmail.com, Wolfgang Grandegger <wg@grandegger.com>

Hello,

as you might have already realized, Michael has reported problems with
the PCH_CAN driver. With his help we try to fix these issues and add
PCH PCI support to the C_CAN driver replacing the PCH_CAN driver sooner
than later. Here follows my current patch stack for the records. When
Michael's tests are successful, I'm going to post final patches.

For Michael I have prepared out-of-tree driver sources allowing to
easily build the drivers also for older 3.x kernel versions. More
tester are welcome.

As also pointed out by Casper, the problems are obvisouly due to races
with stop and wakeup of the netif tx queue, managing tx_next and
concurrent register accesses. For the moment I have fixed the races by
adding "spin[un]lock_irqsave/restore" but, thinking more about it,
"spinlock_bh" should be enough to protect against softirq context.

With the C_CAN driver I realized some other minor issues:

- The C/D_CAN type handling is common code and could go to
  alloc_c_can_dev() or register_c_can_dev().

Comments are welcome.

Wolfgang.

Wolfgang Grandegger (6):
  pch_can: add spinlock to protect tx objects
  c_can: add spinlock to protect tx and rx objects
  c_can: add optional reset callback
  c_can_pci: introduce board specific PCI bar
  c_can_pci: enable PCI bus master only for MSI
  c_can_pci: add support for PCH CAN on Intel EG20T PCH

 drivers/net/can/c_can/c_can.c     |   24 ++++++++++++++++-
 drivers/net/can/c_can/c_can.h     |    2 ++
 drivers/net/can/c_can/c_can_pci.c |   54 ++++++++++++++++++++++++++++++++++---
 drivers/net/can/pch_can.c         |   11 ++++++++
 4 files changed, 87 insertions(+), 4 deletions(-)

-- 
1.7.9.5

