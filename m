From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: Problem with so Loved interrupts
Date: Thu, 10 Nov 2011 10:52:01 +0100
Message-ID: <4EBB9EC1.1040508@grandegger.com>
References: <CAKvQZ_1Sf8xSJ2dGC7fO+mBFPQj_rwaeuiYcpJozUD0V5P1dYA@mail.gmail.com>	<CAKvQZ_0XOeaEqzXvC0L7YjBpQymeEhQvDJFwG2re7VTcTXLA3Q@mail.gmail.com> <CAKvQZ_0RhjE3+OBLposEBoU8UL66_3JfV237bWnL5pR0HrRMVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:55239 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933773Ab1KJJwF (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Nov 2011 04:52:05 -0500
In-Reply-To: <CAKvQZ_0RhjE3+OBLposEBoU8UL66_3JfV237bWnL5pR0HrRMVQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Willy Lambert <lambert.willy@gmail.com>
Cc: linux-can@vger.kernel.org

On 11/10/2011 09:56 AM, Willy Lambert wrote:
> 2011/11/9 Willy Lambert <lambert.willy@gmail.com>:
>> ---------- Forwarded message ----------
>> From: Willy Lambert <lambert.willy@gmail.com>
>> Date: 2011/11/9
>> Subject: Problem with so Loved interrupts
>> To: linux-can <linux-can@vger.kernel.org>
>>
>>
>> Hi all,
>> I am having interruption problems again.
>> The symptom is a /proc/interrupt or /proc/xenomia/irq not rising.
>> I am sure of my Hardware because I used an archive of a working linux
>> system and it works. So the wired are Ok, device is responding, BIOS
>> is well configured.
>> I check this : http://comments.gmane.org/gmane.network.socketcan.user/813,
>> and I am sure it is not the case since it worked with the old system
>> and it has been electrically protected.
>> I also recheck this
>> http://old.nabble.com/Re%3A-Trying-to-use-socketCan-on-an-Ixxat-PC-I-04-104-p30752686.html
>> but once again, everything is ok with old software.

Please describe "old system" and "old software".

>> So what did I changed ? I was updating many of my dependencies on my
>> target and even tried 64b, so the road have been very long. What I
>> accuse much is my new kernel. Before it was a 2.6.35.7, now it is a
>> 2.6.38.8 with xenomai patches. I may have forgot to select a kernel
>> option for interrupts...

Well, you get other interrupts and therefore it seem to be specific to
the CAN hardware and the bus/slot it is connected to. You say that it
works with your 2.6.35.7 kernel but does not with 2.6.38.8 on the
*identical* hardware, right? Then I would check the kernel configs for
PNP related differences.

Wolfgang.

