From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH 0/4] CAN sk_buff and can-gw enhancements
Date: Thu, 17 Jan 2013 18:43:36 +0100
Message-ID: <50F83848.4090006@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:36879 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752708Ab3AQRnj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 17 Jan 2013 12:43:39 -0500
Received: from [192.168.178.31] (p5B0B0333.dip0.t-ipconnect.de [91.11.3.51])
	by smtp.strato.de (jorabe mo12) (RZmta 31.13 DYNA|AUTH)
	with ESMTPA id N057f1p0HHGu0v for <linux-can@vger.kernel.org>;
	Thu, 17 Jan 2013 18:43:37 +0100 (CET)
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

From 0cb44d2bda7d3aeb96ce45eb7ee24a139bf40f78 Mon Sep 17 00:00:00 2001
From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Thu, 17 Jan 2013 17:51:48 +0100
Subject: [PATCH 0/4] CAN sk_buff and can-gw enhancements

Hi all,

after the discussion with DaveM about the skb_iif usage here's my alternative
to support the new can-gw functionalities:

- make routing to the incoming CAN interface configurable
- add a variable limit for CAN frame routings
- indicate and count deleted frames due to misconfiguration

I added some private space to CAN sk_buffs. See commit messages.

It can be pulled from the cangw branch of ollis-can-next:

https://gitorious.org/~hartkopp/linux-can/ollis-can-next/commits/cangw

Regards,
Oliver

Oliver Hartkopp (4):
  can: add private data space for CAN sk_buffs
  can-gw: make routing to the incoming CAN interface configurable
  can-gw: add a variable limit for CAN frame routings
  can-gw: indicate and count deleted frames due to misconfiguration

 drivers/net/can/dev.c       |    8 ++++-
 drivers/net/can/slcan.c     |    8 ++++-
 include/linux/can/skb.h     |   35 ++++++++++++++++++++
 include/uapi/linux/can/gw.h |    2 ++
 net/can/bcm.c               |   12 +++++--
 net/can/gw.c                |   74 +++++++++++++++++++++++++++++++++----------
 net/can/raw.c               |    8 +++--
 7 files changed, 124 insertions(+), 23 deletions(-)
 create mode 100644 include/linux/can/skb.h

-- 
1.7.10.4

