From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Thu, 12 Jan 2012 15:23:43 +0000 (UTC)
Message-ID: <loom.20120112T155904-850@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59656 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752438Ab2ALPX4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Jan 2012 10:23:56 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RlMVP-0005kB-M8
	for linux-can@vger.kernel.org; Thu, 12 Jan 2012 16:23:55 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 12 Jan 2012 16:23:55 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 12 Jan 2012 16:23:55 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi,

is it possible when I create a promiscuous socket with 
...

static struct {
	struct sockaddr_can src;
	int pkt_len;
} ss = {
	.pkt_len = 1024,
	.src.can_addr.j1939 = {
		.name = J1939_NO_NAME,
		.addr = J1939_NO_ADDR,
		.pgn = J1939_NO_PGN,
	},
};
....
addr.can_ifindex = ss.src.can_ifindex;
...

and then receive a msg with recvfrom and  send that msg with sendto to tell 
the promiscuous socket to ignore the send msg. That the promiscuous socket only
receives 'extern' messages. I am totally floored, or am I on the wrong track?

Best regards,
Wolfgang

