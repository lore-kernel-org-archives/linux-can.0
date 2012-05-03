From: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>
Subject: Re: [Socketcan-users] Support of MCP2515 and AM35x High-End CAN
 controller in (RT-)SocketCAN
Date: Thu, 3 May 2012 14:21:42 +0900
Message-ID: <CAKG=6c50e3Q-fKvfhcSzqMAC66jTg2t7+U3f7uE10_r5sC5pLg@mail.gmail.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
	<3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:59455 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751835Ab2ECFVo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 01:21:44 -0400
Received: by bkcji2 with SMTP id ji2so1024736bkc.19
        for <linux-can@vger.kernel.org>; Wed, 02 May 2012 22:21:43 -0700 (PDT)
In-Reply-To: <3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Linux-CAN <linux-can@vger.kernel.org>

Hi there!

=46irst of all, thank you for your valuable feedback! I'll combine my
questions and answers in one email.

> Setup time is not a strong argument for choosing -rt vs. Xenomai.
> [...]
> What are your requirements concerning latency and data rate?

Our real-time requirements are 10 ms cycles, latencies around 1000 us
and we plan to use the 1 Mbit/s data rate. Based on what I read so
far, this should be feasible with SocketCAN and a _well-tuned_
RT-Linux.
And yes, set-up time is not the most important part for this decision,
but since I am a beginner it is not totally unimportant either.

> Don't use mcp2515, you won't have any fun with it. [...]

Why exactly is the MCP2515 not suitable for real-time applications? Is
the SPI interface a bottleneck? (Isn't SPI fast?)

> Note that Beaglebone uses TI's AM335x SOC which has D_CAN peripheral =
vs the Beagleboard
> Which uses TI's AM37x SOC and it does not have CAN peripheral integra=
ted. AM3517 SOC has
> HECC CAN peripheral which is different than D_CAN found on AM335x. Bo=
th HECC and D_CAN drivers
> have been submitted to the linux-can list and HECC is already mainlin=
e - D_CAN driver has
> been submitted to this list and is undergoing review - it will be mer=
ged with the C_CAN driver
> shortly.

Thanks a lot for this clarification! It made me realise that I got
quite confused by those many SoC variations. Hence, I checked the
documents again and I hope I got it right this time:
Neither the Beagleboard (OMAP3530), nor the Beagleboard-xM (DM3730)
offer a CAN bus controller. But the Beaglebone (AM3359) offers the
DCAN controller and the Craneboard (AM3517) the HECC.
Are both controllers suitable for a real-time application with the
mentioned requirements? Is there a performance difference among both
controllers?
And do you think that the whole system consisting of SocketCAN + Linux
+ PREEMPT_RT patch + proper tuning will fulfil the requirements?

About Linux driver support for the DCAN controller: After skimming
through the Linux driver guide on the TI wiki [1] I got the impression
that the DCAN controller is _already_ supported by the kernel. Is the
TI wiki ahead of time?


Regards,
Marcus

--
Dipl.-Ing. (M.Sc.) Marcus Liebhardt
Control Engineer
Yujin Robot
=C1=D6=BC=D2: =B4=EB=C7=D1=B9=CE=B1=B9 =BC=AD=BF=EF=BD=C3 =B1=DD=C3=B5=B1=
=B8 =B0=A1=BB=EA=B5=BF 345-30 =B3=B2=BC=BA=C7=C1=B6=F3=C0=DA #601, 153-=
023.
Address: Door #601, Namsung-Plaza, 345-30 Gasan-dong, Guemcheon-gu,
Seoul, 153-023, Republic of Korea
Website: http://www.yujinrobot.com
Email: marcus.liebhardt@yujinrobot.com
Phone: +82-2-2104-0435
