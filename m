From: Wolfgang <wutz@unterderbruecke.de>
Subject: Re: using can-j1939
Date: Wed, 21 Dec 2011 15:11:30 +0000 (UTC)
Message-ID: <loom.20111221T153828-216@post.gmane.org>
References: <20111216093308.GB669@e-circ.dyndns.org> <loom.20111216T150333-707@post.gmane.org> <20111217192038.GA309@e-circ.dyndns.org> <loom.20111220T112550-205@post.gmane.org> <20111220110059.GA311@e-circ.dyndns.org> <loom.20111220T150849-247@post.gmane.org> <20111220150545.GC311@e-circ.dyndns.org> <loom.20111220T160841-487@post.gmane.org> <20111220163247.GE311@e-circ.dyndns.org> <loom.20111221T111539-419@post.gmane.org> <20111221134302.GA12050@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:39677 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751584Ab1LUPLr (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Dec 2011 10:11:47 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RdNpY-00068o-1o
	for linux-can@vger.kernel.org; Wed, 21 Dec 2011 16:11:44 +0100
Received: from fire.d-i-f.com ([80.152.230.22])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2011 16:11:43 +0100
Received: from wutz by fire.d-i-f.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Dec 2011 16:11:43 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> I bet len (= sizeof(frame.data) in your example) is 8.
> If you want to send 3 bytes, then supply 3 bytes to the kernel!
OK, so I set the unused bytes 0 and don't care.


> > So sendto() is used to send to a specific address, at the moment I am always
> > doing broadcast?
> yes.
Maybe you can give me a hint what I did wrong
...
addr.can_addr.j1939.name = 0x81;
....
if (sendto(s, frame.data, strlen(frame.data), 0, (void *)&addr, \
sizeof(frame.data))<0)
    {
    	perror ("sendto failed");
    }


One general question, am I right, you have to create for every different
struct sockaddr_can (different pgn etc.) one socket per 
interface?

Gratefully,
Wolfgang



