From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] Newbie Question about the SJA1000_Platform
 Driver
Date: Wed, 29 Feb 2012 22:30:29 +0100
Message-ID: <4F4E98F5.8050908@grandegger.com>
References: <33414181.post@talk.nabble.com> <4F4E88F5.8000602@grandegger.com> <001501ccf722$4ff38590$efda90b0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:53943 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323Ab2B2Vae (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Feb 2012 16:30:34 -0500
In-Reply-To: <001501ccf722$4ff38590$efda90b0$@com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Fredric J. Einstein" <feinstei@frontier.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Hi Frederic,

first, I switch the discussion to our new mailing list...

On 02/29/2012 09:40 PM, Fredric J. Einstein wrote:
> Hi Wolfgang, 
> 
> Thanks for answering my question.  I loaded the latest version of Debian
> (yesterday) from their website (using the "live" version and then installing
> from that image).  I searched the installation and didn't find sja1000_isa
> at all, only sja1000 and sja1000_platform.  I have a 32 bit Atom board and
> the Debian installation went normally.  Did I perhaps install the wrong
> thing?  Thanks again for your patience!

I have in my Ubuntu distribution:

~$ ls -l /lib/modules/2.6.38-8-generic/kernel/drivers/net/can/sja1000/
total 72
-rw-r--r-- 1 root root  7468 2011-04-11 11:16 ems_pci.ko
-rw-r--r-- 1 root root  7796 2011-04-11 11:16 kvaser_pci.ko
-rw-r--r-- 1 root root 10876 2011-04-11 11:16 plx_pci.ko
-rw-r--r-- 1 root root 10436 2011-04-11 11:16 sja1000_isa.ko
-rw-r--r-- 1 root root 12392 2011-04-11 11:16 sja1000.ko
-rw-r--r-- 1 root root  6516 2011-04-11 11:16 sja1000_platform.ko
-rw-r--r-- 1 root root  5936 2011-04-11 11:16 tscan1.ko

If you just find sja1000 and sja1000_platform, your distro/kernel is
most probably broken.

Wolfgang.

> 
> Fred E.
> 
> -----Original Message-----
> From: Wolfgang Grandegger [mailto:wg@grandegger.com] 
> Sent: Wednesday, February 29, 2012 3:22 PM
> To: FredEi
> Cc: socketcan-users@lists.berlios.de
> Subject: Re: [Socketcan-users] Newbie Question about the SJA1000_Platform
> Driver
> 
> On 02/29/2012 05:50 PM, FredEi wrote:
>>
>> Please excuse my ignorance, but I'm very new to compiling Linux kernels,
>> setting parameters for Platform type drivers etc.   Our Intel Atom based
>> board has an SJA1000 controller on it that worked in older versions of 
>> Linux (such as Ubuntu 10.04) with the SJA1000_ISA driver that was 
>> included with Ubuntu.  Unfortunately, with Debian Squeeze (the latest 
>> version), it seems that this driver has been replaced with 
>> SJA1000_PLATFORM.  However, unlike
> 
> Why do you think that? The sja1000_isa is still available in the mainline
> kernel. And the sja1000_platform driver is not replacing it? It serves a
> different bus. Is it possible that you switched to 64bit Linux at the same
> time? Older kernel versions do not support sja1000_isa on
> x86_64 but the issue has been fixed in the meantime.
> 
> Wolfgang.
> 
> 

