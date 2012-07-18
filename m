From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 0/6] can: janz-ican3: multiple fixes
Date: Wed, 18 Jul 2012 15:33:12 -0700
Message-ID: <1342650798-2991-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:50088 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2GRWdU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Jul 2012 18:33:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 7538E22296
	for <linux-can@vger.kernel.org>; Wed, 18 Jul 2012 15:33:20 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

This patch series started out as a way to fix support for
CAN_RAW_RECV_OWN_MSGS, and has grown quite a bit since then.

The new addition is a workaround for a quirk in the firmware. If you have
enabled infinite bus error messages to be generated, but your host CPU
cannot keep up, the firmware will stop responding to control messages until
it is hard-reset. This can be worked around by setting a small bus error
quota, and re-enabling bus errors every time you receive a message.

With this change, leaving the controller in "one-shot off" mode, it will
successfully send the packet as soon as the bus is reconnected. This is the
expected behavior, and it works well. The "one-shot on" mode works as well,
without retransmissions.

I moved the TX-error vs. ECHO skb handling from patch #6 (add support for
one shot mode) into patch #4 (fix support for CAN_RAW_RECV_OWN_MSGS). This
puts all of the ECHO skb changes into a single patch.

Many thanks to those who have provided feedback for this patch series. It
is appreciated.

Changes since last version:
- several unrelated changes broken into separate small patches
- ECHO vs. TX-error handling moved into patch #4, where it belongs
- avoid firmware lockup caused by patch #4's use of bus error messages
- support for single shot mode is now very simple
- various nitpicks suggested by reviewers

Ira W. Snyder (6):
  can: janz-ican3: remove dead code
  can: janz-ican3: drop invalid skbs
  can: janz-ican3: fix error and byte counters
  can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
  can: janz-ican3: avoid firmware lockup caused by infinite bus error quota
  can: janz-ican3: add support for one shot mode

 drivers/net/can/janz-ican3.c |  228 ++++++++++++++++++++++++++++++++----------
 1 files changed, 177 insertions(+), 51 deletions(-)

-- 
1.7.8.6

