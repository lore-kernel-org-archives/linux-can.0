From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 0/7] Add CAN FD infrastructure for CAN driver
Date: Fri, 21 Feb 2014 19:56:58 +0100
Message-ID: <1393009025-4903-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:53825 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaBUS5U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 21 Feb 2014 13:57:20 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is the patch series to extend the CAN driver infrastructure with CAN FD.

Changes v3->v4:

- fix a comment in patch 4 pointed out by Stephane
- added patches 6 & 7

Patch 6 fixes a semantic issue and is probably a stable candidate.

Patch 7 can be applied later - when patch 6 emerges in the -next trees.

Regarding the discussion for patch 5: Does anyone have a better idea for it?

Regards,
Oliver

*** BLURB HERE ***

Oliver Hartkopp (7):
  can: preserve skbuff protocol in can_put_echo_skb
  can: netlink send bittiming data only when a bitrate is available
  can: provide a separate bittiming_const parameter to bittiming
    functions
  can: introduce the data bitrate configuration for CAN FD
  can: allow to change the device mtu for CAN FD capable devices
  can: fix bitrate check semantics at interface open time
  can: add bittiming check at interface open for CAN FD

 drivers/net/can/dev.c            | 144 +++++++++++++++++++++++++++++++++------
 include/linux/can/dev.h          |   7 +-
 include/uapi/linux/can/netlink.h |   3 +
 3 files changed, 131 insertions(+), 23 deletions(-)

-- 
1.9.0

