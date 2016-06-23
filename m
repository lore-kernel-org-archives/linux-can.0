From: ajneu <ajneu1@gmail.com>
Subject: Re: Clear transmit buffer (of pending queued tx-messages)
Date: Thu, 23 Jun 2016 08:45:27 +0000 (UTC)
Message-ID: <loom.20160623T104337-28@post.gmane.org>
References: <loom.20160622T135857-352@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:54901 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751788AbcFWIpq (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 23 Jun 2016 04:45:46 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bG0Gc-0005CS-MC
	for linux-can@vger.kernel.org; Thu, 23 Jun 2016 10:45:42 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2016 10:45:42 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 23 Jun 2016 10:45:42 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

> 
> The question is whether blocking write (and probably write outdated 
> content) is what you want for CAN.

Oliver Hartkopp posted that on a different thread...
Subject: Re: want blocking writes, but eventually get: errno 105 (No buffer
space available)
Date: 2016-06-22 15:52:04 GMT (15 hours and 32 minutes ago)

OK ->

I've tried non-blocking.
Unfortunately non-blocking will not tell you if messages are delivered or not.

Example:
If I send out 2 messages (non-blocking) with no participant on the bus,
those messages will remain queued.
If 5 minutes later a participant joins the bus, he'll get those 2 very old
messages: outdated content.

What are my options to solve this?
(Can I find out if a message has actually been sent out onto the bus?)
(I'm currently thinking about checking the CAN-Bus status: If NOT
error-active (and high tx count), I know that tx-messages will not get
delivered.
But if I had a few messages in the queue, I still cannot tell which ones got
delivered. Hmmmm...
  ***)
)

Thanks,
ajneu


PS:
  ***)
Perhaps in some cases it does not matter to know which messages actually
still got delivered and which not.
In that case, when the program detects NO-longer-ERROR_ACTIVE, it can enter
into an error-state "waiting for online":
first it does can_do_stop followed by can_do_start, to clear the queue. Then
it just sends periodic messages, until it get's back_to_error_active.
Once it get's back_to_error_active, it it back "online".
Thoughts?

