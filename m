From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu, 12 Jul 2012 09:15:29 -0700
Message-ID: <1342109732-4995-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:43737 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab2GLQPe (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 12 Jul 2012 12:15:34 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 159DB222EA
	for <linux-can@vger.kernel.org>; Thu, 12 Jul 2012 09:15:34 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

Per reviewer feedback, I have moved the janz-ican3 driver-specific
modifications to the can_put_echo_skb() and can_get_echo_skb() into the
janz-ican3 driver itself.

The first patch brings support up to the level of the previously posted
patch series.

The second patch modifies the driver-specific versions of
can_put_echo_skb() and can_get_echo_skb() to use an SKB queue. This
removes the burden of index management, and allows increased TX buffer
queue length.

The third patch adds support for CAN_CTRLMODE_ONE_SHOT. My coworker has
requested this, and it seems like a good enhancement.

Ira W. Snyder (3):
  can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
  can: janz-ican3: increase tx buffer size
  can: janz-ican3: add support for one shot mode

 drivers/net/can/janz-ican3.c |  164 +++++++++++++++++++++++++++++++++++-------
 1 files changed, 137 insertions(+), 27 deletions(-)

-- 
1.7.8.6

