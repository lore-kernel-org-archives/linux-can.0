From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: sendmsg
Date: Tue, 7 Feb 2012 15:11:13 +0000 (UTC)
Message-ID: <loom.20120207T160415-497@post.gmane.org>
References: <20120110085105.GB330@e-circ.dyndns.org> <loom.20120110T112815-928@post.gmane.org> <20120110152341.GD2524@e-circ.dyndns.org> <loom.20120112T155904-850@post.gmane.org> <4F0F2195.7050109@hartkopp.net> <20120113111251.GD319@e-circ.dyndns.org> <loom.20120113T122554-557@post.gmane.org> <loom.20120116T103812-141@post.gmane.org> <20120116133140.GA26427@e-circ.dyndns.org> <loom.20120116T153805-349@post.gmane.org> <20120116153644.GA7763@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41592 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755502Ab2BGPLZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 7 Feb 2012 10:11:25 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RumhX-0005hm-8S
	for linux-can@vger.kernel.org; Tue, 07 Feb 2012 16:11:23 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 07 Feb 2012 16:11:23 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 07 Feb 2012 16:11:23 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi Kurt,

I am back working a little my gw.

As the defined in the j1939-21 the maximum dlc is 1785. 

static struct {
	int pkt_len;
} s = {
	.pkt_len = 1024,
};

buf = malloc(s.pkt_len);

recvmsg(sockfd, &msg, 0);

Did I get that right, that a dlc more than 1024 bytes is not possible with
recvmsg or sendmsg. For my application I won't need so many data but for
understanding the code!

Kind regards,
Wolfgang


I forget to mention, that I set s.pkt_len = 1785 and it seemed to work with
sendmsg and recvmsg. But UIO_MAXIOV is defined as 1024, so what do I get wrong?

