From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Mon, 26 Nov 2012 14:54:41 +0000 (UTC)
Message-ID: <loom.20121126T154645-335@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060
  809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.8060708@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51274 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753440Ab2KZOy4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 26 Nov 2012 09:54:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Td05Q-0004dn-8d
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 15:55:04 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 15:55:04 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 26 Nov 2012 15:55:04 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> There is a return in the critical section which must also be handled.
> Hope you didn't hit it...
> 
> I have attached v7 fixing this issue. Furthermore I have added spinlock
> protection to the PCH driver. It needs fixing, even if I want to get
> ride of it as soon as possible. Could you please give this driver a try
> as well? The README tells how to build the modules. I will also send my
> current patch stack for the record (and feedback).

Oops, I missed that return.  Looks like the system didn't hit it though,
the CAN interface was still functional after running continuously over the 
weekend.

I tried the PCH driver and hit the transmission failure within a minute.
I'm happy to test out more changes to this driver if you think it is worth
pursuing.

I started a test with the new c_can driver.  I'll check on it throughout
the day and let it run overnight as well.

Thanks,
Mike




