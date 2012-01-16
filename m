From: Wolfgang <wutz@unterderbruecke.de>
Subject: sendmsg
Date: Mon, 16 Jan 2012 15:28:24 +0000 (UTC)
Message-ID: <loom.20120116T153805-349@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org> <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org> <loom.20120113T122554-557@post.gmane.org> <loom.20120116T103812-141@post.gmane.org> <20120116133140.GA26427@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:57325 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754637Ab2APP2o (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 16 Jan 2012 10:28:44 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RmoUD-0003Hp-5Q
	for linux-can@vger.kernel.org; Mon, 16 Jan 2012 16:28:41 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2012 16:28:40 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 16 Jan 2012 16:28:40 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I'm just pushed an update that fixes this. 
Great! Thanks.


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

                  } 



Is it possible or what do I have to change that sendmsg will send the _same_ 
frame which is received? Now the dlc is always 0x400 as declared in s.pkt_len.

Kind regards!




