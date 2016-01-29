From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Expose filtered CAN interface to processes
Date: Fri, 29 Jan 2016 21:05:02 +0100
Message-ID: <56ABC5EE.8070100@hartkopp.net>
References: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:31692 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbcA2ULU (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 29 Jan 2016 15:11:20 -0500
In-Reply-To: <EB7F4954055D8D47BE2774BFC0597392301E1285@MTK-SMS-XCH02.digi.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Osborne, Paul" <Paul.Osborne@digi.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Andri Yngvason <andri.yngvason@marel.com>

Hello Paul,

On 01/29/2016 08:06 PM, Osborne, Paul wrote:

> I am currently trying to figure out the best way to present a couple
> CAN devices to a process in such a way that will allow for filtering
> rules for sends on the exposed interface to be filtered according to
> some set of rules.
> 
> cangw works great for the basic parts of this use case.  That is, I
> have traffic coming from vcan<x> to can<x> after filtering and it
> works as expected.  The problem I have now is that for the user
> process can see both CAN buses.  I would only like them to see the
> vcan devices.
> 
> Is there a solution for this available in the kernel today or would
> this only work with network namespaces (which are not supported for
> can right now)?

Right.

> More accurately, it appears that network namespaces work on CAN
> interfaces but there does not appear to be the required support
> present for bridging vcan devices as can be done with veth devices
> (i.e. ip link add veth0 type veth peer name veth1).

I already took a look into the veth stuff and what to do to make (virtual) CAN
interfaces support namespaces - but veth ist pretty different to what we need
for CAN.

> I am new to network namespaces; Am I missing something?  Is this a
> real use case for network namespace support?  It sounded like there
> was uncertainty on this point with the RFC that was posted back in
> September by Andri: http://comments.gmane.org/gmane.linux.can/8589.

Yes. I think this would be the right way to go.

My current idea regarding namespace aware virtual CAN interfaces is to create
virtual CAN interfaces inside a network namespace. These 'vcan with namespace'
interfaces could then be connected via cangw in the initial (real world)
namespace to other can/vcan interfaces (with/without namespace) with cangw rules.

The good thing about this approach is that you can use the filter and
modification capabilities from cangw at the same time.

Regards,
Oliver

