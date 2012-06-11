From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC v5] CAN FD support
Date: Mon, 11 Jun 2012 20:03:51 +0200
Message-ID: <4FD63307.7020605@grandegger.com>
References: <4FC3D9EE.4010807@hartkopp.net> <4FD60007.8070801@grandegger.com> <4FD62CBA.8050300@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:45358 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632Ab2FKSDy (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 11 Jun 2012 14:03:54 -0400
In-Reply-To: <4FD62CBA.8050300@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 06/11/2012 07:36 PM, Oliver Hartkopp wrote:
> On 11.06.2012 16:26, Wolfgang Grandegger wrote:
> 
>> On 05/28/2012 10:02 PM, Oliver Hartkopp wrote:
>>> Hi all,
>>>
>>> since RFC v4 - see http://marc.info/?l=linux-can&m=133708871921901&w=2 from
>>> 2012-05-15 - i cleaned up some details and added the support of simultaneous
>>> CAN and CANFD frame handling inside the networking code after some discussion
>>> with Kurt. Sometimes code needs to be implemented to see that there is a more
>>> elegant solution out there when removing that code again ;-)
>>>
>>> If you also feel fine with this patch i would finally create a patchset of
>>> four patches, like 
>>>
>>> - adding new structures and constants
>>> - adding CAN FD support in af_can.c
>>> - adding CAN FD support in raw.c
>>> - adding CAN FD support in vcan.c
>>>
>>> for the upcoming net-next bound for Linux 3.6 .
>>
>> Do you have already CAN FD hardware for testing? If not, do we really
>> want to have this patchset mainline.
> 
> 
> Yes. There's a good reason for this patchset.
> 
> As you might remember from the old days ...
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=history;f=drivers/net/can/Kconfig
> 
> 2009-05-18 	Wolfgang Grandegger	can: CAN Network device driver and Netlink interface 	blob | commitdiff | diff to current
> 
> 2008-01-28 	Oliver Hartkopp	[CAN]: Add virtual CAN netdevice driver 	blob | commitdiff | diff to current
> 
> it was nearly 16 month the PF_CAN infrastructure was part of the mainline
> kernel until the first 'real' CAN drivers have been added to the tree.
> Meanwhile the driver development inside and outside the tree had a stable
> environment for APIs and testing.

Ah, I forgot, the vcan driver allows to test the CAN FD interface as
well, basically ==> the code is tested to some extend which calms me
down ;).

> Same situation here. The CAN FD patches just provide a CAN FD capable
> infrastructure with new data structures and extended userspace API which
> allows to develop both drivers and CAN FD applications.
> 
> So when the patches go the usual way, they are released in Linux 3.6
> somewhere in November/December this year - together with the first announced
> real CAN FD hardware silicon. Btw. i assume that the first FPGA based CAN
> controllers will be available for tests earlier.
> 
> So hitting this net-next window to provide CAN FD support in the netlayer
> infrastructure is not too fast but right in time :-)
> 
>> More later...
> 
> 
> Reviews are welcome.
> Please check the different postings and discussions up to v5 before.

Well, I'm just back from holiday...

Wolfgang.
