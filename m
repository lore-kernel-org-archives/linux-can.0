From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v6 0/7] Add CAN FD infrastructure for CAN driver
Date: Thu, 27 Feb 2014 19:15:05 +0100
Message-ID: <1393524912-12970-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:59323 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753753AbaB0SPX (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 27 Feb 2014 13:15:23 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is the patch series to extend the CAN driver infrastructure with CAN FD.

Changes v5 -> v6:

The new helper function candev_has_bitrate() can be removed as the 'bitrate'
element is sufficient to detect a correct bitrate.
In patch 3 a sanity check has been moved to reduce the new CAN FD code.

The more I look into the patches the shorter they get :-)

Regards,
Oliver

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

 drivers/net/can/dev.c            | 148 ++++++++++++++++++++++++++++++++-------
 include/linux/can/dev.h          |   7 +-
 include/uapi/linux/can/netlink.h |   3 +
 3 files changed, 132 insertions(+), 26 deletions(-)

-- 
1.9.0

