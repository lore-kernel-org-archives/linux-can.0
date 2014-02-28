From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v9 0/7] Add CAN FD infrastructure for CAN driver
Date: Fri, 28 Feb 2014 16:36:18 +0100
Message-ID: <1393601785-4631-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:38083 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343AbaB1Pgg (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 10:36:36 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is the patch series to extend the CAN driver infrastructure with CAN FD.

Changes v8 -> v9:

Fixed a whitepace issue in patch 4 and added a comment about the different
configuration options.

*** BLURB HERE ***

Oliver Hartkopp (7):
  can: preserve skbuff protocol in can_put_echo_skb
  can: only send bitrate data via netlink when available
  can: move sanity check for bitrate and tq into can_get_bittiming
  can: provide a separate bittiming_const parameter to bittiming
    functions
  can: introduce the data bitrate configuration for CAN FD
  can: allow to change the device mtu for CAN FD capable devices
  can: add bittiming check at interface open for CAN FD

 drivers/net/can/dev.c            | 160 ++++++++++++++++++++++++++++++---------
 include/linux/can/dev.h          |   7 +-
 include/uapi/linux/can/netlink.h |   3 +
 3 files changed, 133 insertions(+), 37 deletions(-)

-- 
1.9.0

