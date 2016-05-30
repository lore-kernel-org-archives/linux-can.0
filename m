From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/5] Add support for CAN FD to broadcast manager (CAN_BCM)
Date: Mon, 30 May 2016 20:36:25 +0200
Message-ID: <1464633390-24299-1-git-send-email-socketcan@hartkopp.net>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:19786 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933116AbcE3Sgo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 30 May 2016 14:36:44 -0400
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

Oliver Hartkopp (5):
  can: bcm: fix indention style
  can: bcm: use CAN frame instead of can_frame in comments
  can: bcm: unify bcm_msg_head handling and prepare function parameters
  can: bcm: add support for CAN FD frames
  can: bcm: add documentation for CAN FD support

 Documentation/networking/can.txt |  22 +++
 include/uapi/linux/can/bcm.h     |   1 +
 net/can/bcm.c                    | 313 +++++++++++++++++++++++----------------
 3 files changed, 206 insertions(+), 130 deletions(-)

-- 
2.8.1

