From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Thu, 6 Dec 2012 23:23:55 +0000 (UTC)
Message-ID: <loom.20121207T001439-459@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.806  0708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com> <loom.20121126T181452
   -657@post.gmane.org> <50B3B162.9020905@grandegger.com> <50B751D7.6060106@grandegger.com> <loom.20121129T150945-987@post.gmane.org> <loom.20121206T150229-86@post.gmane.org> <50C0B05F.7020606@grandegger.com> <loom.20121206T231009-942@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49982 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753977Ab2LFXYQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 6 Dec 2012 18:24:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1Tgknn-0003fh-NL
	for linux-can@vger.kernel.org; Fri, 07 Dec 2012 00:24:23 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 07 Dec 2012 00:24:23 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Fri, 07 Dec 2012 00:24:23 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Pellegrini <mikep86 <at> gmail.com> writes:

> I don't have an I2C application on-hand, let me see what I can whip up.

I tried loading the i2c-dev module and no i2c devices came up in /dev or
/sys/class/i2c-dev.  I am using the in-tree version of the driver.

In case it matters, my system automatically loaded the i2c_isch driver, but
not the i2c-dev driver.  I had to modprobe the latter manually.

I tried unloading both drivers, then loading just i2c-dev.  Still no i2c
devices.

Where should I go from here?

Thanks,
Mike

