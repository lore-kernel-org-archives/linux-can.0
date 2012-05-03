From: Yegor Yefremov <yegor_sub1@visionsystems.de>
Subject: Re: [Socketcan-users] Support of MCP2515 and AM35x High-End CAN controller
 in (RT-)SocketCAN
Date: Thu, 03 May 2012 08:42:22 +0200
Message-ID: <4FA228CE.2080907@visionsystems.de>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com> <3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com> <CAKG=6c50e3Q-fKvfhcSzqMAC66jTg2t7+U3f7uE10_r5sC5pLg@mail.gmail.com>
Reply-To: yegor_sub1@visionsystems.de
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from hhlx01.visionsystems.de ([62.145.30.242]:37105 "EHLO
	mail.visionsystems.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752435Ab2ECGmf (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 02:42:35 -0400
In-Reply-To: <CAKG=6c50e3Q-fKvfhcSzqMAC66jTg2t7+U3f7uE10_r5sC5pLg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Am 03.05.2012 07:21, schrieb Marcus Liebhardt:
> Hi there!
> 
> First of all, thank you for your valuable feedback! I'll combine my
> questions and answers in one email.
> 
>> Setup time is not a strong argument for choosing -rt vs. Xenomai.
>> [...]
>> What are your requirements concerning latency and data rate?
> 
> Our real-time requirements are 10 ms cycles, latencies around 1000 us
> and we plan to use the 1 Mbit/s data rate. Based on what I read so
> far, this should be feasible with SocketCAN and a _well-tuned_
> RT-Linux.
> And yes, set-up time is not the most important part for this decision,
> but since I am a beginner it is not totally unimportant either.
> 
>> Don't use mcp2515, you won't have any fun with it. [...]
> 
> Why exactly is the MCP2515 not suitable for real-time applications? Is
> the SPI interface a bottleneck? (Isn't SPI fast?)
> 
>> Note that Beaglebone uses TI's AM335x SOC which has D_CAN peripheral vs the Beagleboard
>> Which uses TI's AM37x SOC and it does not have CAN peripheral integrated. AM3517 SOC has
>> HECC CAN peripheral which is different than D_CAN found on AM335x. Both HECC and D_CAN drivers
>> have been submitted to the linux-can list and HECC is already mainline - D_CAN driver has
>> been submitted to this list and is undergoing review - it will be merged with the C_CAN driver
>> shortly.
> 
> Thanks a lot for this clarification! It made me realise that I got
> quite confused by those many SoC variations. Hence, I checked the
> documents again and I hope I got it right this time:
> Neither the Beagleboard (OMAP3530), nor the Beagleboard-xM (DM3730)
> offer a CAN bus controller. But the Beaglebone (AM3359) offers the
> DCAN controller and the Craneboard (AM3517) the HECC.
> Are both controllers suitable for a real-time application with the
> mentioned requirements? Is there a performance difference among both
> controllers?
> And do you think that the whole system consisting of SocketCAN + Linux
> + PREEMPT_RT patch + proper tuning will fulfil the requirements?
> 
> About Linux driver support for the DCAN controller: After skimming
> through the Linux driver guide on the TI wiki [1] I got the impression
> that the DCAN controller is _already_ supported by the kernel. Is the
> TI wiki ahead of time?

TI wiki speaks about their own kernel repository with DCAN drivers. But the drivers are still not mainlined, i.e. you'll need to patch this repo [1] with RT-patch and I don't know if it works without problems. BTW you'll probably get problems patching kernels with both am33xx and am3517, because they are still not fully supported by mainline kernel and you'll have to do with TI's repos. Please let us know if you had success.

1. http://arago-project.org/git/projects/linux-am33x.git

Yegor
