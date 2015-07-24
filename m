From: Tom Evans <tom_usenet@optusnet.com.au>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Fri, 24 Jul 2015 13:53:13 +1000
Message-ID: <55B1B6A9.1000702@optusnet.com.au>
References: <559D35CA.2050402@uweschneider.de> <2576741.YrBIndJIHB@ws-stein> <CAOpc7mEc+kr=Es34772fcTnsQpJsaCaoVOx67AhfRjxucPhAhw@mail.gmail.com> <3634451.aFQ5B85Yzk@ws-stein> <CAOpc7mG52ni5ESuijv1qVLpMznZXSxxU8gmkhjGqtKZfXuxUNQ@mail.gmail.com> <55AF4D9D.8040904@uweschneider.de> <55AF5AF2.6050905@pengutronix.de>
Reply-To: tom_usenet@optusnet.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45073 "EHLO
	mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752894AbbGXDxR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 23 Jul 2015 23:53:17 -0400
In-Reply-To: <55AF5AF2.6050905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Torsten Lang <torsten.lang@uweschneider.de>
Cc: Holger Schurig <holgerschurig@gmail.com>, Alexander Stein <alexander.stein@systec-electronic.com>, linux-can@vger.kernel.org

On 22/07/15 18:57, Marc Kleine-Budde wrote:
> On 07/22/2015 10:00 AM, Torsten Lang wrote:
>> Am 09.07.2015 um 09:59 schrieb Holger Schurig:
>>>> Is it "normal" to have interrupts locked out for more than 300us
 >>>> (six 50us CAN messages at 1MHz)?
>>> Unfortunately yes.  My $CUSTOMER had overruns with 500 kB/s, 80% bus
>>> load, and CAN messages with 3 bytes of data. My guess this was mostly
>>> due to the sucky SDHCI (eMMC) driver code in Linux.

There's been some off-list email on this. It looks like the MMC driver isn't 
well written.

I think I've found the "Official Freescale" workaround for the CAN problems 
under Linux:

http://cache.freescale.com/files/32bit/doc/app_note/AN4815.pdf

The above App Note documents migration to the i.MX 6SoloX chip. It contains 
one each of Cortex-A9 and Cortex-M4 CPU cores.

The purpose of the M4 core is listed to be:

               Secondary processor for fast boot, low power
               processing, and robust CAN message handling.

So that's your only fix. Use a totally separate CPU for CAN.

Or don't design hardware that uses chips that the software doesn't support 
(well enough to work with your other hardware). So don't design with eMMC on 
this platform. Use something simpler and faster, like NAND or NOR Flash.

On a slightly better note, who's responsible for the MMC driver?

Which one are you using? This one (from Freescale 2.6.35):

/*
  *  linux/drivers/mmc/host/mxc_mmc.c - Freescale MXC/i.MX MMC driver
  *
  *  based on imxmmc.c
  *  Copyright (C) 2004 Sascha Hauer, Pengutronix <sascha@saschahauer.de>
  *
  *  derived from pxamci.c by Russell King

This one from the Mainline:

http://lxr.free-electrons.com/source/drivers/mmc/host/mxcmmc.c

   9  *  Copyright (C) 2008 Sascha Hauer, Pengutronix <s.hauer@pengutronix.de>
  10  *  Copyright (C) 2006 Pavel Pisa, PiKRON <ppisa@pikron.com>
  11  *
  12  *  derived from pxamci.c by Russell King

Is there a mailing list where these apparent MMC driver problems can be 
reported? Probably "gmane.linux.kernel.mmc".

It might be worth posting some FTRACE results to there.

> IIRC you can insert a SD/MMC/eMMC and mark it as non removable
 > in the DT to work around the problem - connecting the Card
 > Detection pin might also work.

Has anyone tested that to see if it helps or helps enough?

Tom

