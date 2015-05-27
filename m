From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: ip -details link fails
Date: Wed, 27 May 2015 19:24:53 +0200
Message-ID: <5565FDE5.1040908@hartkopp.net>
References: <BAY176-W131B8CC6A9756B64828C77D3CB0@phx.gbl>,<5565F98E.5010101@hartkopp.net> <BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:45224 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbbE0RbN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 May 2015 13:31:13 -0400
In-Reply-To: <BAY176-W119C53753111D23AE6FA39D3CB0@phx.gbl>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Ssagarr Patil <hugarsagar@outlook.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 05/27/2015 07:11 PM, Ssagarr Patil wrote:

Your backports from 3.14 are looking to work properly ..

E.g. the output from
# cat /proc/net/dev
and
# dmesg | grep -C 5 can0

look sane.

BUT:

> # ip -details link show wlan0
> RTNETLINK answers: Invalid argument
> Cannot send link get request: Invalid argument

The fact that your 'ip' tool doesn't work with wlan0 too your problem is
probably not CAN related.

Can you update the 'ip' tool to a recent version from iproute2:

http://git.kernel.org/cgit/linux/kernel/git/shemminger/iproute2.git/

What does your

	ip -V

tells your about the ip version?

Regards,
Oliver


> # cat /proc/net/dev
> Inter-|   Receive                                                |  Transmit
>  face |bytes    packets errs drop fifo frame compressed multicast|bytes    packets errs drop fifo colls carrier compressed
>     lo:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>  teql0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>   eth0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>   can0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>   can1:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>  wlan0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
>   sit0:       0       0    0    0    0     0          0         0        0       0    0    0    0     0       0          0
> #  uname -a
> Linux evm 2.6.37 #1 Wed May 6 10:43:07 BST 2015 armv7l ARMv7 Processor rev 2 (v7l) ti8148evm GNU/Linux
> # dmesg | grep -C 5 can0
> [    8.320000] CAN device driver interface
> [    8.380000] <30>systemd[1]: Started Trigger Flushing of Journal to Persistent Storage.
> [    8.410000] <30>systemd[1]: Found device /dev/ttyO0.
> [    8.420000] <30>systemd[1]: Started Recreate Volatile Files and Directories.
> [    8.420000] <30>systemd[1]: Starting System Initialization.
> [    8.440000] PM: Adding info for No Bus:can0
> [    8.440000] c_can_platform d_can.0: c_can_platform device registered (regs=fa1cc000, irq=52)
> [    8.440000] PM: Adding info for No Bus:can1
> [    8.440000] c_can_platform d_can.1: c_can_platform device registered (regs=fa1d0000, irq=55)
> [    8.440000] <30>systemd[1]: Reached target System Initialization.
> [    8.440000] <30>systemd[1]: Starting OpenSSH Socket.
> --
> [   38.570000] can: raw protocol (rev 20120528)
> [   38.570000] hci0: type 1 len 36
> [   38.580000] hci0: type 1 len 245
> [   38.590000] hci0: type 1 len 7
> [   38.600000] hci0: type 1 len 5
> [   38.620000] c_can_platform d_can.0: can0: setting BTR=0504 BRPE=0000
> [   38.630000] c_can_platform d_can.1: can1: setting BTR=0504 BRPE=0000
> [ 1953.040000] sit: Unknown symbol xfrm4_tunnel_register (err 0)
> [ 1953.050000] sit: Unknown symbol xfrm4_tunnel_deregister (err 0)
> [ 1980.800000] ipcomp: Unknown symbol ipcomp_input (err 0)
> 
> Note: The Linux version is 2.6.37 but the network stack & CAN drivers are from 3.14 kernel backports.
> 
> Thanks,
> -Sagar
> 
>  		 	   		  
> 
