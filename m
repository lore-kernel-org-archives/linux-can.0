From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Thu, 06 Dec 2012 15:49:03 +0100
Message-ID: <50C0B05F.7020606@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060 809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080 507@grandegger.com> <50AFAFF0.9030706@grandegger.com> <loom.20121123T184133-638@post.gmane.org> <50B2449B.806  0708@grandegger.com> <loom.20121126T154645-335@post.gmane.org> <50B38AFB.70209@grandegger.com> <loom.20121126T181452
 -657@post.gmane.org> <50B3B162.9020905@grandegger.com> <50B751D7.6060106@grandegger.com> <loom.20121129T150945-987@post.gmane.org> <loom.20121206T150229-86@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51155 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423575Ab2LFOtH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:49:07 -0500
In-Reply-To: <loom.20121206T150229-86@post.gmane.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

Hi Michael,

On 12/06/2012 03:20 PM, Michael Pellegrini wrote:
> Michael Pellegrini <mikep86 <at> gmail.com> writes:
> 
>>> I have implemented a better solution now using different sets of
>>> registers for tx and rx. This avoids locking in the RX path as well.
>>> Furthermore, pch_can now uses spin_[un]lock_bh. Would be nice if you
>>> could give the pch_can and c_can_pci driver a try when time permits.
>>
>> Great! I'm happy to test these drivers out.  In addition to testing
>> these drivers through my application, I'm looking at creating a soak test to
>> really push the interface (and the driver) hard.  That test will probably be
>> ready early next week.  I will get back to you with the results.
> 
> I have some results.  
> 
> The good news: The c_can driver appears to work very well.  It has been running
> successfully under the soak test for 18 hours and counting.

Sounds good.

> The bad news: The pch_can driver is exhibiting the transmission problem again.
> The soak test causes the driver to fail within minutes.

OK, obviously spin_[un]lock_bh() is not suitable to avoid the race. I
will switch back to spin_lock_irqsave/spin_unlock_irqrestore in the next
version of the patch.

> Details of the soak test:
> 
> There are two systems involved in the test: the PCH-System and an External Node.
> The External Node transmits data at a high rate, bringing bus utilization to
> ~35%.
> The PCH-System also transmits data, in bursts of 10 messages every 5 ms.
> Combined, the two systems utilize ~90% of bus bandwidth.
> The PCH-System is constantly checking that it is receiving data from the
> External Node at the expected rate and in the expected order.

On another thread Alexander is reporting problems with the same driver
when he runs a I2C application concurrently. Are you able to stress the
system in a similar way?

Thanks a lot for testing.

Wolfgang.
