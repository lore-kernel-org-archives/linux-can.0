From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v5 0/6] Add CAN FD infrastructure for CAN driver
Date: Wed, 26 Feb 2014 23:10:56 +0100
Message-ID: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:26084 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbaBZWL1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 17:11:27 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is the patch series to extend the CAN driver infrastructure with CAN FD.

Changes v4 -> v5:

Introduced a new helper function candev_has_bitrate() in patch 2 which leads
to simple changes in the following patches using this helper now.

Regards,
Oliver 

*** BLURB HERE ***

Oliver Hartkopp (6):
  can: preserve skbuff protocol in can_put_echo_skb
  can: only send bitrate data via netlink when available
  can: provide a separate bittiming_const parameter to bittiming
    functions
  can: introduce the data bitrate configuration for CAN FD
  can: allow to change the device mtu for CAN FD capable devices
  can: add bittiming check at interface open for CAN FD

 drivers/net/can/dev.c            | 146 +++++++++++++++++++++++++++++++++------
 include/linux/can/dev.h          |   7 +-
 include/uapi/linux/can/netlink.h |   3 +
 3 files changed, 134 insertions(+), 22 deletions(-)

-- 
1.9.0

