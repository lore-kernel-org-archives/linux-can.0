From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] Message stalls in SocketCan Layer?
Date: Fri, 03 Feb 2012 17:57:03 +0100
Message-ID: <4F2C11DF.7010707@hartkopp.net>
References: <4F29091F.4010908@in.tum.de> <4F2AA5DF.9080304@grandegger.com> <4F2C0675.1050808@in.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:34426 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757136Ab2BCQ5U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 11:57:20 -0500
In-Reply-To: <4F2C0675.1050808@in.tum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?ISO-8859-1?Q?Michael_J=E4ntsch?= <michael.jaentsch@in.tum.de>
Cc: linux-can@vger.kernel.org

Hi Michael,

On 03.02.2012 17:08, Michael J=E4ntsch wrote:


> yes, it all started when I switched to kernel 3.0.0-15-generic. Howev=
er,
> weirdly enough there is one computer with this kernel where the probl=
em
> doesn't appear and two where it does. I think I will confirm this by
> going back to an older kernel and seeing if the problem disappears.


please consider that if it works on other machines with the same kernel=
 that
there could be some changes within the USB subsystem or some interrupt =
or
ACPI/powersaving issues too.

Going back to an older Kernel is a good check - don't know, if you also=
 can go
further (3.1, 3.2) with Ubuntu 11.10 too ?!?

Maybe there's some USB debugging available to check whether the URB has=
 been
sent properly to the USB wire and if the interrupt of the USB controlle=
r
reached the system after sending.

Generally i would not assume that there's a problem in the PF_CAN netla=
yer in
this special case.

Regards,
Oliver
