From: Wolfgang <wutz@unterderbruecke.de>
Subject: =?utf-8?b?TVNHX0RPTlRST1VURQ==?=
Date: Mon, 16 Jan 2012 10:04:17 +0000 (UTC)
Message-ID: <loom.20120116T103812-141@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org> <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org> <loom.20120113T122554-557@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36875 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751877Ab2APKE3 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 Jan 2012 05:04:29 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RmjQS-0001eP-Ls
	for linux-can@vger.kernel.org; Mon, 16 Jan 2012 11:04:28 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2012 11:04:28 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2012 11:04:28 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

What did I do wrong I want that after the reception of the message it is checked 
whether the MSG_DONTROUTE flag is set and if it isn't set the message is bridged
on socket s2? 
At the moment it doesn't matter if the frame is new or created on the local host.

	while (1) {
		
		iov.iov_len = s.pkt_len;
		msg.msg_namelen = sizeof(src);
		msg.msg_controllen = sizeof(ctrlmsg);
		msg.msg_flags = 0;

			
		ret = recvmsg(sock, &msg, 0);


		if ((msg.msg_flags & MSG_DONTROUTE) == 0)
			{
				src.can_addr.j1939.addr = J1939_NO_ADDR;
				src.can_ifindex = if_nametoindex("can1");
				sendmsg(s2, &msg, 0);
			}


Thanks for your ideas!


