From: Keith Jones <keith.rjones@yahoo.com>
Subject: flexcan_poll_error_state(struct net_device *dev, u32 reg_esr)
Date: Mon, 4 Jun 2012 16:24:21 -0700 (PDT)
Message-ID: <1338852261.93934.YahooMailNeo@web140802.mail.bf1.yahoo.com>
References: <1338849280.43608.YahooMailNeo@web140802.mail.bf1.yahoo.com> <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com>
Reply-To: Keith Jones <keith.rjones@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from nm34-vm1.bullet.mail.bf1.yahoo.com ([72.30.239.73]:20310 "HELO
	nm34-vm1.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751519Ab2FDXYW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 4 Jun 2012 19:24:22 -0400
In-Reply-To: <1338849547.86575.YahooMailNeo@web140805.mail.bf1.yahoo.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



Hello,

My kernel does not have "flexcan_poll_error_state" function in its flex=
can.c file.=A0 Is the following patch still valid?

[RFC PATCH 07/14] can: flexcan: consolidate error state handling.=20


What would a good linux version to obtain a functioning flexcan driver =
for imx536?=A0 My demo board is shipped with 2.6.35. I am able migrate =
to any version with appropriate patches.

thanks
keith

