From: Wolfgang Grandegger <wg@grandegger.com>
Subject: c_can for pch (was Re: CAN NETWORK DRIVERS)
Date: Tue, 01 Apr 2014 22:08:41 +0200
Message-ID: <533B1CC9.5050703@grandegger.com>
References: <5334AA2D.70604@del-llc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:51124 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbaDAUIn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 1 Apr 2014 16:08:43 -0400
In-Reply-To: <5334AA2D.70604@del-llc.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mark Del Giorno <mark@del-llc.com>, mkl@pengutronix.de, Linux-CAN <linux-can@vger.kernel.org>

Hello,

sorry for the late answer. As this is a community project, please ask
your question on the linux-can mailing list [1]. Other's seem to have
similar problems with that driver, e.g. [2,3].

On 03/27/2014 11:46 PM, Mark Del Giorno wrote:
> Gentlemen,
> 
> I have an ADLINK board with an Atom processor and EG20T chip with CANbus
> on it.  I had been attempting to use the pch_can.c  driver that's in the
> main linux kernel with no success -- it failed routinely with "no buffer
> space available".
> 
> I believe I have a fix to those problems -- I rewrote portions of
> pch_can.c, and have that working, with 25% CANbus load running at 1 MBit.
> 
> In the process of tracking down bugs, I was directed by ADLINK to
> Alexander Stein, who pointed me to the two of you. He indicated the
> pch_can.c driver is being phased out and being replaced by c_can.

Yes, that's correct. I just repeat what I wrote recently here:

  http://marc.info/?l=linux-can&m=139638056029090&w=4

"The EG20T does have a C_CAN core and therefore we would like to switch
to the more advanced C_CAN driver (and get rid of the pch_can driver
sooner than later). It also has less known issues. Last year I posted a
PCH PCI interface driver for the EG20T but it did not make it into
mainline yet. The problem is that I don't have any C_CAN hardware at
hand to validate the patches myself. I'm going to dig the patches out,
end of the week, also for the pch_can."

> I read through the mailing list, and see many of the comments are
> similar to the problems I found with pch_can.c -- and am looking to see
> if I can test that new driver to see if it works.  My hope would be that
> future versions of the driver will work directly out of the mainline
> kernel, and I can abandon my customized version.  I have hardware
> in-place and can readily test a new driver in a fairly high-load
> environment, so if there are bugs, I'll likely find them.
> 
> I don't know to get the current version of a driver that works - so I
> can test it.  Is the repository where they are stored public?  I can see
> the linux-can-next repository, but most of the latest mailing list fixes
> don't appear to be pushed there.   [Note: I've written several CAN
> drivers from scratch for vxWorks...but this is my first linux
> application, so forgive me if I don't understand the process]

Unfortunately the patches did not make it to mainline.

> Any help / direction you can provide would be helpful.
> My high-level notes as to what I found / fixed are below.

The situation with the PCH_CAN driver is rather disappointing and it
would be nice if somebody would take care. Any help is appreciated.

The first step would be to switch to the C_CAN driver with an
appropriate PCI interface driver for the PCH.

> Thank you.
> 
> Mark Del Giorno
> mark@del-llc.com
> 
> ** Primary issue found in pch_can.c: The ifregs are being used without
> some type of semaphore / lock between tasks.These are the 2 registers
> that allow you to transfer information to/from the message RAM.The
> original writers of this code chose to use ifregs[1] for transmitting
> and ifregs[0] for receiving.I believe that's the major mistake.They
> should have divided up the use of those registers by *task*, not by
> tx/rx function, because:
> 
> As-written, the _xmit() routine could start writing to the ifregs[1]
> registers, then get interrupted by the _poll() routine running in a
> different task.It also uses the ifregs[1] registers if it's servicing a
> TX interrupt, and therein lies the problem:Those registers get corrupted
> and data never gets transmitted, things back up, and "no buffer space
> available".
> 
> One solution is to spin_lock() all accesses before accessing any
> ifregs[].I believe that would be clean, but didn't want to lock out the
> processor so much.So I modified the driver to have all _xmit() functions
> use ifregs[0], and all _poll() functions use ifregs[1].So the processes
> can interrupt each other and not corrupt those registers.That solved
> most of the problems.
> 
> Other issues seem to be noted in your mailing lists already --
> interrupts aren't well-handled and can cause lock-up.  The FIFO system
> for receiving has some issues missing packets, Handling overwritten data
> (MsgLst) doesn't work and can also cause lockup.  Consecutive status
> interrupts are sometimes not handled properly, etc..

Could you please check if the C_CAN driver (with the recent patches from
Thomas [3]) does have similar issues? I assume that at least some of
these problems are gone.

Wolfgang.

[1] linux-can@vger.kernel.org
[2] http://marc.info/?l=linux-can&m=139625998601111&w=4
[3] http://marc.info/?l=linux-can&m=139630531718305&w=4



> 
> 

