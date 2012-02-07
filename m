From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: About can/usb v4 patches serie
Date: Tue, 07 Feb 2012 14:13:46 +0100
Message-ID: <4F31238A.9060305@volkswagen.de>
References: <1328281974-11761-1-git-send-email-s.grosjean@peak-system.com> <4F2FF9EE.1060301@volkswagen.de> <4F30F691.5070307@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr2.volkswagen.de ([194.114.62.76]:46615 "EHLO
	mr2.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910Ab2BGNO4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2012 08:14:56 -0500
In-Reply-To: <4F30F691.5070307@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On 07.02.2012 11:01, Stephane Grosjean wrote:
> Hi Oliver,
>
> Thanks for all of your tests.
> Can you please install the serie of patches I just post which contains last
> version of the can/usb divers (according to your logs, you don't use it).

Hi Stephane,

i thought i used the latest version you sent with the tar-ball.

But having a clean version from the mailing list is always a better starting 
point for tests ;-)

> This
> version should handle restart mechanism in a (more) correct way, for both
> pcan-usb/pcan-us pro adapters now.

ok.

> Meanwhile, I have a look to the deadlock issue in the pcmcia driver timer
> function first...

Yes. Just to be sure this eject problem can generally be solved i replaced the 
PEAK PCMCIA card with the EMS PCMCIA card in my setup, where i only get two 
removal notifications when pulling the card under full rx load.

Just one remark upon the USB driver:

I did a

cangen -g0 -i can5

to flood the USB-Pro adapter with outgoing traffic.

When doing an "ifconfig can5 down" i get:


peak_usb 2-2:1.0: can5: Tx URB aborted (-2)

ten times (what is probably the netdev queue length)

So on shutdown and/or unplugging there's something to do too.

Best regards,
Oliver
