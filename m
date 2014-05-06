From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Fwd: [PATCH v2 0/3] can: add support for hash based access to EFF
 frame filters
Date: Tue, 06 May 2014 19:55:49 +0200
Message-ID: <53692225.3020304@hartkopp.net>
References: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:12199 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbaEFRzw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 6 May 2014 13:55:52 -0400
In-Reply-To: <1396463127-25541-1-git-send-email-socketcan@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey Marc,

what about this patch set for can-next you had so much fun to review?

:-)

I was running this patch for a month now and it still applies properly.

Regards,
Oliver

-------- Original Message --------
Subject: [PATCH v2 0/3] can: add support for hash based access to EFF frame
filters
Date: Wed,  2 Apr 2014 20:25:24 +0200
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
CC: Oliver Hartkopp <socketcan@hartkopp.net>

In contrast to the direct access to the single SFF frame filters (which are
indexed by the SFF CAN ID itself) the single EFF frame filters are arranged
in a single linked hlist. To reduce the hlist traversal in the case of many
filter subscriptions a hash based access is introduced for single EFF filters.

This patch set enhances and documents the hash based EFF filter sets in
af_can.c .

Changes in v2:
Some coding style fixes, like
- indroduce spaces arround shift operations
- use ARRAY_SIZE(d->rx_sff) instead of CAN_SFF_RCV_ARRAY_SZ
- use ARRAY_SIZE(d->rx_eff) instead of CAN_EFF_RCV_ARRAY_SZ
- change to forward hash function as suggested by Marc

Oliver Hartkopp (3):
  can: proc: make array printing function indenpendent from sff frames
  can: add hash based access to single EFF frame filters
  can: add documentation for CAN filter usage optimisation

 Documentation/networking/can.txt | 35 ++++++++++++++++++
 net/can/af_can.c                 | 31 +++++++++++++---
 net/can/af_can.h                 |  9 +++--
 net/can/proc.c                   | 76 ++++++++++++++++++++++++++++++++--------
 4 files changed, 129 insertions(+), 22 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-can" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


