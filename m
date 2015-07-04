From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong assumption
 in raw_rcv
Date: Sat, 04 Jul 2015 18:54:38 +0200
Message-ID: <55980FCE.4030304@hartkopp.net>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com> <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store> <55916EBC.2010807@hartkopp.net>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:47560 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752611AbbGEIy5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 5 Jul 2015 04:54:57 -0400
In-Reply-To: <55916EBC.2010807@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, tom_usenet@optusnet.com.au, Manfred Schlaegl <manfred.schlaegl@gmx.at>

Hi Stephane,

On 29.06.2015 18:13, Oliver Hartkopp wrote:
> Hi Stephane,
>
> On 25.06.2015 11:36, Oliver Hartkopp wrote:
>>> Stephane Grosjean <s.grosjean@peak-system.com>
>>> (..)
>>> tells that he's facing some loss of frames with the PEAK-System PCAN-USB
>>> adapter, in case of "relatively"  high bus load... He's running two
>>> Kernels (3.19 and the last 4.1 patched with this recent "fix"). At the
>>> moment, he says he always notes some frame leakage, especially when he
>>> (for example) "resizes windows on his desktop"...

Is $COSTUMERs problem fixed now?

While testing the patches

can: fix loss of CAN frames in raw_rcv
http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/commit/?h=testing&id=36c01245eb8046c16eee6431e7dbfbb302635fa8

and

can: replace timestamp as unique skb attribute
http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/commit/?h=testing&id=a6ffebda241e513f6e839662d769b60b084d0957

I discovered an increase of out-of-order CAN frame receptions.
My setup is a core i7 with a PCAN USB and a PCAN USB pro connected to my full 
busload CAN source (1MBit/s, ~8008 frames/s).

With 3.16 the out-of-order CAN frame reception is 'relatively' seldom.
It's more with the PCAN USB and very few with PCAN USB pro.

With the latest 4.2-merge the effect is reproducible after some time (~10min).

Examples:

  drop detected: expected 204 received 212
  drop detected: expected 237 received 204
  drop detected: expected 212 received 237
  drop detected: expected 68 received 69
  drop detected: expected 70 received 68
  drop detected: expected 69 received 70

Obviously the frames do not get lost BUT are reordered.

newcounter = frame.data[0];
if (((counter + 1) & 0xFF) != newcounter) {
  printf(" drop detected: expected %u received %u\n", counter + 1, newcounter);
}
counter = newcounter;

I'm a bit confused as this effect seems to increase with Linux kernel version 
numbers. I removed all the changes for 4.1 in the 4.2-merge kernel to have a 
4.0 CAN subsystem (which was stable for a long time) - but even this patch 
removal did not fix the out of order reception.

Good thing: The latest changes in 4.1 (which patches) do not drop CAN frames 
by accident.

Bad thing: Why is the out-of-order reception increasing in Linux?

I /assume/ some changes with RPS (receive packet steering) in the network 
layer ...


Regards,
Oliver
