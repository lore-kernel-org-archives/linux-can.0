From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: bridge
Date: Thu, 12 Jan 2012 16:37:17 +0100
Message-ID: <20120112153717.GJ380@e-circ.dyndns.org>
References: <20120109132638.GI386@e-circ.dyndns.org>
 <loom.20120109T162926-984@post.gmane.org>
 <20120110085105.GB330@e-circ.dyndns.org>
 <loom.20120110T112815-928@post.gmane.org>
 <20120110152341.GD2524@e-circ.dyndns.org>
 <loom.20120111T163604-92@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from gate.eia.be ([194.78.71.18]:32686 "EHLO mail.eia.be"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754000Ab2ALPmT (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 12 Jan 2012 10:42:19 -0500
Content-Disposition: inline
In-Reply-To: <loom.20120111T163604-92@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang <wutz@unterderbruecke.de>
Cc: linux-can@vger.kernel.org

Wolfgang,

I'm afraid I don't full understand the problem now.
Promiscuous mode means that PGNs not destined for you
are received also. It is not needed to catch broadcasted
traffic. Sorry for the noise about that.

Based on the 2 programs, I see no advantage in the use of recvmsg(),
since you're not using any of the extra functionality.

So far, use the first program as a reference.
Instead of modifying your source, I'll shortly describe the headlines
that I think I would use.

so:
	int ret, s1, s2;
 	socklen_t len; 
 	struct sockaddr_can src_addr;
 	char buf[128];

	struct sockaddr_can src_addr = {
		.can_family = AF_CAN,
		.can_addr.j1939 = {
			.addr = J1939_NO_ADDR,
			.pgn = J1939_NO_PGN,
			.name = J1939_NO_NAME,
		},
	};

	src_addr.can_ifindex = if_nametoindex("can0");
	dest_addr.can_ifindex = if_nametoindex("can1");

	s1 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (s1 < 0)
		perror("...");
	ret = bind(s1, (void *)&src_addr, sizeof(src_addr));
	if (ret < 0)
		perror("...");

	s2 = socket(PF_CAN, SOCK_DGRAM, CAN_J1939);
	if (s2 < 0)
		perror("...");
	/* no bind for s2 yet */

	while (1) {
		len = sizeof(src_addr);
 		ret = recvfrom(s, buf, sizeof(buf), 0, (void *)&src_addr, &len);
 		if (ret < 0)
 			perror ("recvfrom failed");
		/*
		 * OK, we got a PGN, of size 'ret' and originating
		 * from src_addr.can_ifindex, using SA src_addr.can_addr.j1939.addr
		 * and PGN src_addr.can_addr.j1939.pgn
		 *
		 * We need to use this info in s2 to be used as source for this PGN
		 * except for the can_ifindex member, since it's the other ifindex.
		 */

		/* clear the  ifindex */
		src_addr.can_ifindex = 0;
		if (bind(s2, (void *)&src_addr, sizeof(src_addr)) < 0)
			perror("...");

		/* s2 is now ready */
 		if (send(s2, buf, ret, 0)) < 0);
			perror("sendto failed");
	}

since my commits a few days ago, calling bind() with different source addresses is
now possible.

Kind regards,
Kurt
