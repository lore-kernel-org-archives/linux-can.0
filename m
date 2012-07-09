From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Subject: [PATCH 0/3] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS
Date: Mon,  9 Jul 2012 12:56:27 -0700
Message-ID: <1341863790-5645-1-git-send-email-iws@ovro.caltech.edu>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ovro.ovro.caltech.edu ([192.100.16.2]:53236 "EHLO
	ovro.ovro.caltech.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752722Ab2GIT4c (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Jul 2012 15:56:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by ovro.ovro.caltech.edu (Postfix) with ESMTP id 86EE4222F4
	for <linux-can@vger.kernel.org>; Mon,  9 Jul 2012 12:56:31 -0700 (PDT)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>

From: "Ira W. Snyder" <iws@ovro.caltech.edu>

This is another different approach to fixing the Janz ICAN3 support for
CAN_RAW_RECV_OWN_MSGS.

The can_put_echo_skb() function is changed to always keep all packets
until can_get_echo_skb() is called. Previously, it would drop packets if
they were not needed to be looped back. This makes it possible for the
new function can_cmp_echo_skb() to work with hardware-assisted loopback
support on the Janz ICAN3, which does not have TX-complete interrupts of
any kind.

Since we are now storing packets even in the non-loopback case, there is
some extra memory overhead, to store the extra packets between the calls
to can_put_echo_skb() and can_get_echo_skb().

After this patch series is applied, the SocketCAN tst-rcv-own-msgs test
passes.

Performance is rougly 15% less than using the previously posted patch:
[PATCH ALTERNATE VERSION 1/1] can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS

This performance drop is due to the extra overhead of receiving the echo
packets from the card itself. This involves one extra interrupt for each
packet sent, and the associated overhead of running ican3_napi() for
each packet sent.

Ira W. Snyder (3):
  can: make the echo stack keep packet information longer
  can: add can_cmp_echo_skb() for echo skb comparison
  can: janz-ican3: fix support for CAN_RAW_RECV_OWN_MSGS

 drivers/net/can/dev.c        |   75 ++++++++++++++++++++++++++++++-----------
 drivers/net/can/janz-ican3.c |   56 +++++++++++++++++--------------
 include/linux/can/dev.h      |    2 +
 3 files changed, 87 insertions(+), 46 deletions(-)

-- 
1.7.8.6

