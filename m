From: Wolfgang Wagner <wutz@unterderbruecke.de>
Subject: Re: using j1939
Date: Fri, 9 Dec 2011 17:23:52 +0000 (UTC)
Message-ID: <loom.20111209T175414-826@post.gmane.org>
References: <20111206104432.91170@gmx.net> <20111206121403.GB322@e-circ.dyndns.org> <loom.20111206T131950-88@post.gmane.org> <4EDE1785.9000306@volkswagen.de> <20111209134721.GA309@e-circ.dyndns.org> <loom.20111209T145701-227@post.gmane.org> <20111209143224.GB309@e-circ.dyndns.org> <20111209144911.144460@gmx.net> <20111209150133.GA1470@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:36183 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752940Ab1LIRYG (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 9 Dec 2011 12:24:06 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1RZ4B2-0003zO-UM
	for linux-can@vger.kernel.org; Fri, 09 Dec 2011 18:24:05 +0100
Received: from p549CC262.dip.t-dialin.net ([84.156.194.98])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 18:24:04 +0100
Received: from wutz by p549CC262.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 09 Dec 2011 18:24:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

> Ok, I suppose you do not compile your kernel yourself.

Yes, ptxdist compiles everything automatic, but as Oliver suggest
for my system I can can drop the kernel and compile it again with 

$ ptxdist drop kernel compile
$ ptxdist go

So is there a possibility to modify my kernel with files of your
linux-can-j1939 repository and compile it again?


> Let's stick to the original plan then and get can-j1939-modules working
(after getting iproute2-j1939 up).

So if I use the tarball iproute2-2.6.39.tar.gz, you can find everywhere,
it should work? Or is there the possibility, that I possibly can faulty
one?








