From: "Gole, Anant" <anantgole@ti.com>
Subject: RE: [Socketcan-users] Support of MCP2515 and AM35x High-End CAN
	controller in (RT-)SocketCAN
Date: Wed, 2 May 2012 08:17:35 +0000
Message-ID: <3F602CD5BF1C69469B2F060E90850642C7E6DC@DQHE01.ent.ti.com>
References: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45401 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754950Ab2EBIRo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 2 May 2012 04:17:44 -0400
In-Reply-To: <CAKG=6c5jafRAGjeQscTKLQbSjPFp7UJYwhhcpOS2QoNvy7Cggw@mail.gmail.com>
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marcus Liebhardt <marcus.liebhardt@yujinrobot.com>, "socketcan-users@lists.berlios.de" <socketcan-users@lists.berlios.de>
Cc: Linux-CAN <linux-can@vger.kernel.org>

Marcus,

>Looking for a low-cost solution for a real-time Linux system with CAN bus support, 
>I am currently considering the Beaglebone [1] (similar to the >Beagleboard) with 
>the addition of a CAN bus cape [2]. The later provides two MCP2515 CAN controller 
>and also allows the use of the integrated CAN >controller [3] of the Beaglebone's 
>ARM microprocessor (Cortex A8) .

>Furthermore, is there support for the integrated CAN controller (AM35x HECC) in 
>SocketCAN and/or RT-SocketCAN?

Note that Beaglebone uses TI's AM335x SOC which has D_CAN peripheral vs the Beagleboard 
Which uses TI's AM37x SOC and it does not have CAN peripheral integrated. AM3517 SOC has 
HECC CAN peripheral which is different than D_CAN found on AM335x. Both HECC and D_CAN drivers 
have been submitted to the linux-can list and HECC is already mainline - D_CAN driver has
been submitted to this list and is undergoing review - it will be merged with the C_CAN driver
shortly.

TI's HECC driver: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=drivers/net/can/ti_hecc.c;h=4accd7ec69543facab276fe3d6d2fd8b902c3604;hb=HEAD

D_CAN driver submission: http://www.spinics.net/lists/linux-omap/msg67538.html

Regards,
Anant
