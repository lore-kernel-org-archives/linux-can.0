From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: recv list
Date: Tue, 10 Jan 2012 10:45:30 +0000 (UTC)
Message-ID: <loom.20120110T112815-928@post.gmane.org>
References: <20120109132638.GI386@e-circ.dyndns.org> <loom.20120109T162926-984@post.gmane.org> <20120110085105.GB330@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:35444 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab2AJKpr (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 10 Jan 2012 05:45:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RkZD7-0005Gd-Km
	for linux-can@vger.kernel.org; Tue, 10 Jan 2012 11:45:45 +0100
Received: from fire.makon-engineering.de ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2012 11:45:45 +0100
Received: from wutz by fire.makon-engineering.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 10 Jan 2012 11:45:45 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I take back this conclusion. I looked again, and came on this:
> clear the src_addr.can_ifindex, since that's for sure wrong when bridging.

It is working, thanks.
As far as I can judge this, your patch is also working I can bind different 
sockets on one interface, and then send with different src addr.


> In a later iteration, You could (if necessary, since I have no clue what kind
> of traffic you will bridge):
> * make the receiving socket (s) 'promiscuous', i.e. receiving all traffic.
> * fetch the original destination by using recvmsg() as illustrated in jspy

OK, I think I am that far, making one socket promiscuous and than depending 
on the source address send it with the corresponding socket.
Is there any 'easy' iteration, of that. Or do I have to rebuild the jspy.c, 
libj1939.c, libj1939.h according to my wishes?


Thanks so far.

Kind regards,

Wolfgang


