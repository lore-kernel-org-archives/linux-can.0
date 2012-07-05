From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 0/2] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Thu,  5 Jul 2012 13:58:26 -0700
Message-ID: <1341521908-11454-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:48733 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751515Ab2GEU6b (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 5 Jul 2012 16:58:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id EB5D9222B2
	for <linux-can@vger.kernel.org>; Thu,  5 Jul 2012 13:58:30 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

This series adds support for can_cmp_echo_skb(), and then uses it to fix
support for CAN_RAW_RECV_OWN_MSGS in the janz-ican3 driver.

After these patches are applied, the SocketCAN test tst-rcv-own-msgs works
correctly. However, if cangen is invoked in non-loopback mode, the driver
stops accepting packets after a few seconds.

The cangen command which causes the driver to stop accepting packets:
cangen -g 0 -e -i -L 8 -x can0

Due to the issues mentioned above, please DO NOT apply the 2nd patch in
this series!

Ira W. Snyder (2):
  can: add can_cmp_echo_skb() for echo skb comparison
  can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS

 drivers/net/can/dev.c        |   34 ++++++++++++++++++++++++++++++++++
 drivers/net/can/janz-ican3.c |   37 ++++++++++++++++++++++++++++++-------
 include/linux/can/dev.h      |    2 ++
 3 files changed, 66 insertions(+), 7 deletions(-)

-- 
1.7.3.4

