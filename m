From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Wed, 21 Nov 2012 17:43:35 +0000 (UTC)
Message-ID: <loom.20121121T184014-391@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <50A4972A.9070707@hartkopp.net> <50A4EA87.9020206@grandegger.com> <loom.20121115T171319-854@post.gmane.org> <50A55C65.2020003@grandegger.com> <loom.20121115T222748-977@post.gmane.org> <50A95FC1.3050907@grandegger.com> <loom.20121119T155735-163@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or
   g> <loom.20121121T162041-774@post.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49086 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754273Ab2KURn4 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 21 Nov 2012 12:43:56 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TbELB-0005ZC-Dy
	for linux-can@vger.kernel.org; Wed, 21 Nov 2012 18:44:01 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 18:44:01 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 21 Nov 2012 18:44:01 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Wolfgang Grandegger <wg <at> grandegger.com> writes:

> Could you show the sequence? I need to lookup the meaning of the bits.

I tried to capture the transition from functional to non-functional transmission
in dmesg, but the data gets logged too quickly.  Here's the best I can do:

Functional transmission:

[74734.413300] c_can_isr: irqstatus=0x15
[74734.441193] c_can_isr: irqstatus=0x8000
[74734.441265] c_can_isr: irqstatus=0x16
[74734.451140] c_can_isr: irqstatus=0x8000
[74734.451196] c_can_isr: irqstatus=0x17
[74734.461468] c_can_isr: irqstatus=0x8000
[74734.461523] c_can_isr: irqstatus=0x18
[74734.470794] c_can_isr: irqstatus=0x8000
[74734.470846] c_can_isr: irqstatus=0x19
[74734.488507] c_can_isr: irqstatus=0x8000
[74734.488567] c_can_isr: irqstatus=0x1a
[74734.500074] c_can_isr: irqstatus=0x8000
[74734.500127] c_can_isr: irqstatus=0x1b
[74734.515078] c_can_isr: irqstatus=0x8000
[74734.515133] c_can_isr: irqstatus=0x1c
[74734.543469] c_can_isr: irqstatus=0x8000
[74734.543509] c_can_isr: irqstatus=0x1d
[74734.553434] c_can_isr: irqstatus=0x8000
[74734.553484] c_can_isr: irqstatus=0x1e

Non-functional transmission:

[74553.334110] c_can_isr: irqstatus=0x16
[74553.334135] c_can_isr: irqstatus=0x16
[74553.334161] c_can_isr: irqstatus=0x16
[74553.334185] c_can_isr: irqstatus=0x16
[74553.334209] c_can_isr: irqstatus=0x16
[74553.334262] c_can_isr: irqstatus=0x16
[74553.334290] c_can_isr: irqstatus=0x16
[74553.334316] c_can_isr: irqstatus=0x16
[74553.334342] c_can_isr: irqstatus=0x16
[74553.334368] c_can_isr: irqstatus=0x16
[74553.334396] c_can_isr: irqstatus=0x16
[74553.334422] c_can_isr: irqstatus=0x16
[74553.334448] c_can_isr: irqstatus=0x16
[74553.334474] c_can_isr: irqstatus=0x16
[74553.334499] c_can_isr: irqstatus=0x16
[74553.334525] c_can_isr: irqstatus=0x16

- Mike


