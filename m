From: Michael Pellegrini <mikep86@gmail.com>
Subject: Re: =?utf-8?b?cGNoX2Nhbjo=?= Data transmission stops after dropped packet
Date: Thu, 15 Nov 2012 18:26:39 +0000 (UTC)
Message-ID: <loom.20121115T191324-6@post.gmane.org>
References: <loom.20121114T160521-534@post.gmane.org> <14870489.3crZoRWJoA@lisa>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37412 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992484Ab2KOS0z (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 15 Nov 2012 13:26:55 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1TZ49W-00008t-0N
	for linux-can@vger.kernel.org; Thu, 15 Nov 2012 19:27:02 +0100
Received: from 96.45.208.254 ([96.45.208.254])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 19:27:02 +0100
Received: from mikep86 by 96.45.208.254 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 15 Nov 2012 19:27:02 +0100
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Steffen Rose <ro <at> emtas.de> writes:

> 
> > I am encountering a serious issue where, at random intervals, the CAN
> > interface will lock up and stop transmitting data.  Data reception
> > continues normally. 
> 
> Hello,
> 
> the situation is like my described situation at the 8.10.
> "unsure - socketCAN blocking"
> 
> socketCAN with EMS-USB interface
> 3.2.0-32-generic 64bit
> running in a virtualBox
> ip link add dev can0 type can
> 
> sometimes:
> Transmission stop
> Reception is working
> 

Hi Steffen,

I saw your post and tried the solutions proposed by Marc, which are copied
below:

"
Your program probably produces CAN frames faster than they could be
delivered by your CAN hardware. Your choices are:
1) If the write/sendto system call returns with -ENOBUFS,
   add the filedesciptor to poll/select and wait for it to be writeable
   again. For some known, but not yet resolved reasons (a.k.a. bug),
   the poll/select will return immediately, but the write will fail
   again. To workaround this usleep for some milliseconds between
   the write/sendto and the poll/select system call.

2) Increase txqueue length to 10000 or so.
   (ifconfig can0 txqueuelen 10000)
   This avoids to trigger the above bug and your write/sendto will
   block until the queues are free again and your CAN frame will added
   to the send queue. With this workaround poll/select work as expected,
   i.e. when they return the socket is writeable without problems.

Hope that helps,
Marc
"

I added a select call before the write to check that the file descriptor was
available for writing.  As expected, I hit the bug where the select call
indicated the file descriptor was available for writing but the write failed.

Increasing the tx queue length to 10000 resolved the select bug, but not the
data transmission bug.  Now, when the data transmission bug occurs, the select
call indicates that the file descriptor is not available for writing.

- Mike 


