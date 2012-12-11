From: Wolfgang Grandegger <wg@grandegger.com>
Subject: [RFC v3 0/7] pch_can/c_can: fix races and add PCH support to c_can
Date: Tue, 11 Dec 2012 22:18:47 +0100
Message-ID: <1355260735-18994-1-git-send-email-wg@grandegger.com>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:59215 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917Ab2LKVTN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Dec 2012 16:19:13 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Alexander.Stein@systec-electronic.com, Christian.Bendele@gmx.net, Michael Pellegrini <mikep86@gmail.com>, bhupesh.sharma@st.com, Wolfgang Grandegger <wg@grandegger.com>

Hello,

here is v3 of my patches for the C_CAN drivers.

Alexander reported strange results with write-readback of C_CAN register
showing up with concurrent I2C access. They might not be related to CAN
but to other problems on that board. At least Michael did not realize
them yet. Apart from that the c_can driver seems to work fine.
Anyway, we now know that the handling of reveive objects is not water-
proof. To fix out-of-order receipten we should implement an improved
algorithm as suggested by Marc here:

  http://marc.info/?l=linux-can&m=135487418225533&w=2

I will not have time to look into that befoer Xmas. Volunteers are
welcome.

What's also missing is the suspend/resume handling. Then the pch_can
driver is obsolete and can be removed.

Wolfgang.

Changes since v2:

- re-use spin_[un]lock_[irqsave|irqrestore] to protect the tx objects
  of the pch_can driver. spin_[un]lock_bh was not sufficient.
- adapted for the most recent version of the net-next tree

Changes since v1:

- use init callback after renaming it from initram
- use different sets of interface registers for rx and tx (like PCH_CAN)
- use spin_[un]lock_bh to protect the tx objects

Wolfgang Grandegger (7):
  pch_can: add spinlocks to protect tx objects
  c_can: rename callback "initram" to "init" to more general usage
  c_can: use different sets of interface registers for rx and tx
  c_can: add spinlock to protect tx objects
  c_can_pci: introduce board specific PCI bar
  c_can_pci: enable PCI bus master only for MSI
  c_can_pci: add support for PCH CAN on Intel EG20T PCH

 drivers/net/can/c_can/c_can.c          |  102 ++++++++++++++++++++------------
 drivers/net/can/c_can/c_can.h          |    3 +-
 drivers/net/can/c_can/c_can_pci.c      |   57 +++++++++++++++++-
 drivers/net/can/c_can/c_can_platform.c |    2 +-
 drivers/net/can/pch_can.c              |   11 ++++
 5 files changed, 131 insertions(+), 44 deletions(-)

-- 
1.7.9.5

