From: ajneu <ajneu1@gmail.com>
Subject: Re: Kernel Oops with: ip link set can0 type can
Date: Tue, 21 Jun 2016 12:31:28 +0000 (UTC)
Message-ID: <loom.20160621T142652-138@post.gmane.org>
References: <loom.20160621T095606-63@post.gmane.org> <loom.20160621T105023-651@post.gmane.org> <53a1d68d-6267-e3fc-af7d-ba4d49f8124a@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:60337 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260AbcFUMbv (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 21 Jun 2016 08:31:51 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1bFKqC-000545-8O
	for linux-can@vger.kernel.org; Tue, 21 Jun 2016 14:31:41 +0200
Received: from 195.50.142.51 ([195.50.142.51])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 14:31:40 +0200
Received: from ajneu1 by 195.50.142.51 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Tue, 21 Jun 2016 14:31:40 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Oliver Hartkopp <socketcan <at> hartkopp.net> writes:

> 
> 
> On 06/21/2016 10:55 AM, ajneu wrote:
> > ajneu <ajneu1 <at> gmail.com> writes:
> >
> >>
> >> Hi,
> >>
> >> issuing the command
> >>    sudo ip link set can0 type can
> >> I get Kernel Oops (NULL pointer dereference)
> >> Command line prints: "Killed".
> >>
> >> [...]
> >>
> >> dmesg shows
> >> [...]
> >
> >
> > Question:
> > How should one add and set a can device???
> 
> You do can not add a CAN device.
> 
> A 'real' CAN netdevice is detected and initialized automatically.

Well ok, I hear you.

But how is the netdevice detected and initialized automatically?
Is this from udev somewhere? Where? Can you point me to where that is?
What if I want to issue commands myself -- that possible?


Note also:
I can still do this:
   sudo ip link delete can0   ## also removes /sys/class/net/can0

Is this "legal"??
As mentioned in another post -- If I still have the can0 interface
connected, and remove it from the PC AFTER that 'ip link delete' command,
then the whole system hangs.


Thanks.
ajneu

> You only can add 'virtual' CAN devices:
> 
> ip link add dev vcan0 type vcan
> 
> But the OOPS should no occur due to your ip usage anyway 
> This has to be fixed ...
> 
> Regards,
> Oliver
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 




