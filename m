From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Thu, 29 Nov 2012 14:15:14 +0000 (UTC)
Message-ID: <loom.20121129T150945-987@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.806
  0708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com> <loom.20121126T181452-657@post.gmane.org> <50B3B162.9020905@grandegger.com> <50B751D7.6060106@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:51470 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753857Ab2K2OPh (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 29 Nov 2012 09:15:37 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Te4u2-000412-Dh
	for linux-can@vger.kernel.org; Thu, 29 Nov 2012 15:15:46 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 29 Nov 2012 15:15:46 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 29 Nov 2012 15:15:46 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> I have implemented a better solution now using different sets of
> registers for tx and rx. This avoids locking in the RX path as well.
> Furthermore, pch_can now uses spin_[un]lock_bh. Would be nice if you
> could give the pch_can and c_can_pci driver a try when time permits.

Great! I'm happy to test these drivers out.  In addition to testing
these drivers through my application, I'm looking at creating a soak test to
really push the interface (and the driver) hard.  That test will probably be
ready early next week.  I will get back to you with the results.

Thank you!
Mike




