From: Thomas Graf <tgraf@suug.ch>
Subject: [PATCH 0/4] can: gw: Netlink related fixes
Date: Thu,  5 Jul 2012 14:19:54 +0200
Message-ID: <cover.1341489914.git.tgraf@suug.ch>
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753607Ab2GEMUB (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 5 Jul 2012 08:20:01 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q65CK0h7003014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:20:00 -0400
Received: from localhost (vpn1-4-18.ams2.redhat.com [10.36.4.18])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q65CJx0q019538
	for <linux-can@vger.kernel.org>; Thu, 5 Jul 2012 08:19:59 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi

These patches fix some Netlink quirks in the CAN gateway code.
Unfortunately I do not own any CAN hardware so this is compile
tested only. I'm fairly confident though as the changes are
mostly straight forward. I would appreciate if someone could
run them through a test suite or something though.


Thomas Graf (4):
  can: Don't bump nlmsg_len manually
  can: Use nla_policy to validate netlink attributes
  can: Properly fill the netlink header when responding to RTM_GETROUTE
  can: Remove pointless casts

 net/can/gw.c |   90 +++++++++++++++++++++------------------------------------
 1 files changed, 33 insertions(+), 57 deletions(-)

-- 
1.7.7.6

