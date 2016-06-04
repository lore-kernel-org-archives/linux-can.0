From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v4 0/5] Add support for CAN FD to broadcast manager (CAN_BCM)
Date: Sat,  4 Jun 2016 21:26:46 +0200
Message-ID: <1465068411-24301-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:32544 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbcFDT1P (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 4 Jun 2016 15:27:15 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This series adds the capability for the CAN broadcast manager to handle
CAN FD frames analogue to the CAN frames. It allows sending as well as all
known data filtering functions (including multiplex filtering).

Changes in v2:
Introduce a helper variable cfsiz to prevent multiple CFSIZ(op) operations
in bcm_rx_handler() (patch 4/5).

Changes in v3:
Introduce a helper variable cfsiz into struct bcm_op to minimize CFSIZ(op)
operations (patch 4/5).
Fix documentation table of contents and code example (patch 5/5)

Changes in v4:
fixed more style issues remarked by checkpatch.pl (patch 1/5)
Use CFSIZ macro in bcm_sendmsg() for TX_SEND too (patch 4/5)

Oliver Hartkopp (5):
  can: bcm: fix indention and other minor style issues
  can: bcm: use CAN frame instead of can_frame in comments
  can: bcm: unify bcm_msg_head handling and prepare function parameters
  can: bcm: add support for CAN FD frames
  can: bcm: add documentation for CAN FD support

 Documentation/networking/can.txt |  25 +++-
 include/uapi/linux/can/bcm.h     |   1 +
 net/can/bcm.c                    | 305 ++++++++++++++++++++++-----------------
 3 files changed, 200 insertions(+), 131 deletions(-)

-- 
2.8.1

