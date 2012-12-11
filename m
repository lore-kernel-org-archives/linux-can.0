From: Christian Bendele <Christian.Bendele@gmx.net>
Subject: Re: =?utf-8?b?cGNoX2Nhbg==?= probable bug
Date: Tue, 11 Dec 2012 16:08:24 +0000 (UTC)
Message-ID: <loom.20121211T165553-739@post.gmane.org>
References: <loom.20121211T155025-697@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41500 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753343Ab2LKQIo (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 11 Dec 2012 11:08:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TiSO5-00071L-AD
	for linux-can@vger.kernel.org; Tue, 11 Dec 2012 17:08:53 +0100
Received: from irdmzpr02-ext.ir.intel.com ([192.198.151.37])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 17:08:53 +0100
Received: from Christian.Bendele by irdmzpr02-ext.ir.intel.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 11 Dec 2012 17:08:53 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Well, I just found the most recent patch to the generic c_can driver on this
list. I had only checked with Kernel 3.7rcSomething before and it didn't seem to
support the intel eg20t. I failed to check if there was a more recent patch
available and if that supported the intel chip. I'm really sorry for that.

I will try if that patch works for me tomorrow, since unfortunatelly my working
day is almost at its end and I don't have the hardware at home. However, cursery
skimming the code of c_can.c, c_can_do_rx_poll() it seems to me as if it does
the same thing here:


			if (msg_ctrl_save & IF_MCONT_EOB)
				return num_rx_pkts;

Christian


