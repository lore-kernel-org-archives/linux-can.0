From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] Where to permanent set the bitrate
Date: Wed, 18 Apr 2012 19:22:13 +0200
Message-ID: <4F8EF845.5070600@hartkopp.net>
References: <20366.62479.788236.563357@elektron.ikp.physik.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:38642 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071Ab2DRRWQ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 18 Apr 2012 13:22:16 -0400
In-Reply-To: <20366.62479.788236.563357@elektron.ikp.physik.tu-darmstadt.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Uwe Bonnes <bon@elektron.ikp.physik.tu-darmstadt.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 18.04.2012 19:04, Uwe Bonnes wrote:

> Hello,
> 
> running  a recent 3.4.0-rc2 Kernel, I needed to access my PEAK USB
> Adapters. As there is now an In-Kernel peak_usb.ko Module versus the
> out-of-kernel pcan.ko module, i needed to set the bitrate. After long
> searching, I found that
>>  ip link set canX up type can bitrate 1000000
> did the trick for me.
> 
> 1. The kernel documentation does not tell about these support commands. It
>    would be helpfull if it would.


http://lxr.linux.no/#linux+v3.3.2/Documentation/networking/can.txt#L646

> 2. Where ist the place to put those commands in the /etc tree? 


You may use this can_if script copied to /etc/init.d and add the appropriate
links e.g. in /etc/rc2.d ..

See: http://svn.berlios.de/wsvn/socketcan/trunk/etc/can_if

> 
> Otherwise Thanks for the work to get peak_usb in the kernel!


Yes - Stephane did a good job!

Regards,
Oliver
