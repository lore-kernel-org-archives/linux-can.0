From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: pch_can: Data transmission stops after dropped packet
Date: Fri, 23 Nov 2012 18:18:40 +0100
Message-ID: <50AFAFF0.9030706@grandegger.com>
References: <loom.20121114T160521-534@post.gmane.org> <50AA4FB3.7070009@grandegger.com> <loom.20121119T171647-35@post.gmane.org> <50AA5EE6.6060105@grandegger.com> <loom.20121119T183819-427@post.gmane.org> <50AA86DB.7000506@grandegger.com> <loom.20121119T211403-520@post.gmane.org> <50AAA8C8.2080504@grandegger.com> <loom.20121120T151831-134@post.gmane.org> <50ABABDE.8060503@grandegger.com> <loom.20121120T192159-770@post.gmane.org> <50ABF09C.8040303@grandegger.com> <50ACABE2.2020306@grandegger.com> <loom.20121121T160744-278@post.gmane.or  g> <loom.20121121T162041-774@p  ost.gmane.org> <50ACF9C0.8050206@grandegger.com> <loom.20121121T170446-911@post.gmane.org> <50AD042B.3020305 @grandegger.com> <loom.20121121T184014-391@post.gmane.org> <50AD319E.2000209@grandegger.com> <loom.20121121T215717-10
 6@post.gmane.org> <loom.20121123T150627-133@post.gmane.org> <50AF8C01.6060809@grandegger.com> <loom.20121123T155746-12@post.gmane.org> <50AFABB1.7080507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:36026 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2KWRSo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 23 Nov 2012 12:18:44 -0500
In-Reply-To: <50AFABB1.7080507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Pellegrini <mikep86@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/23/2012 06:00 PM, Wolfgang Grandegger wrote:
> On 11/23/2012 04:04 PM, Michael Pellegrini wrote:
>> Wolfgang Grandegger <wg <at> grandegger.com> writes:
>>
>>> Did you see any other related kernel messages? For real testing you
>>> should remove the debug message above. I will try to add a more
>>> sophisticated trigger.
>>
>> I didn't see any other messages.  That message prints in such a tight
>> loop that it's hard to catch any other messages.
> 
> That's clear. Therefore please remove that printk for testing. For a
> quick test could you please add spin_locks to c_can_do_rx_poll() similar
> to c_can_do_tx(). My suspicion is that there is a race in accessing the
> message ram. There is this infamous c_can_msg_obj_is_busy() in
> c_can_object_get() and c_can_object_put().

And please use:

CONFIG_CAN_DEBUG_DEVICES=y CONFIG_CAN_C_CAN_PCI=m make -C
/usr/src/linux-headers-`uname -r` SUBDIRS=`pwd` modules

otherwise we will not have debug messages.

Wolfgang.
