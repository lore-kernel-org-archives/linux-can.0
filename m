From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 19 Nov 2012 20:19:15 +0000 (UTC)
Message-ID: <loom.20121119T211403-520@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44027 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754666Ab2KSUTc (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 19 Nov 2012 15:19:32 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TaXoi-0002GF-Hg
	for linux-can@vger.kernel.org; Mon, 19 Nov 2012 21:19:40 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 21:19:40 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 19 Nov 2012 21:19:40 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> 
> OK, priv->regs in c_can_pci_reset_pch() is wrong. It should be
> priv->base. Next try. I have attached c-can-pci-v2.tar.bz2.
> 
> Wolfgang.
> 
> 
> Attachment (c-can-pci-v2.tar.bz2): application/x-bzip, 11 KiB

My system really didn't like some part of the changes.  Once I loaded
c_can_pci.ko, I was locked out of all input, command line & graphical.
I had to hard-reset the system to recover.




