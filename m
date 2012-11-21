From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 15:41:03 +0000 (UTC)
Message-ID: <loom.20121121T163120-220@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or
  g> <loom.20121121T162041-774@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54333 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755213Ab2KUPlQ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Nov 2012 10:41:16 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbCQX-0003Mf-Nr
	for linux-can@vger.kernel.org; Wed, 21 Nov 2012 16:41:25 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 16:41:25 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 16:41:25 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Pellegrini <mikep86 <at> gmail.com> writes:

> I shouldn't have spoken so soon.  Running my application on the PCH-System
> caused the original problem within minutes.  Message transmission stopped
> and and my application started printing the error "No buffer space available".
> The only way to recover was to reset the interface.

Something of note: When I encounter the message transmission problem,
dmesg prints the message "c_can_isr: irqstatus=0xXX" continuously, with the
same value for irqstatus.  So far, I have seen irqstatus=0x17 and
irqstatus=0x19.

- Mike


