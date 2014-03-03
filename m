From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: C-Can or Other SocketCAN Issue
Date: Mon, 03 Mar 2014 20:37:16 +0100
Message-ID: <5314D9EC.7060107@hartkopp.net>
References: <d634b30117cf40dfb954c723bef01b65@BN1PR01MB071.prod.exchangelabs.com>,<5314AF7F.3010701@pengutronix.de>,<4179fe0897d74eccba72d6c9ba63694c@BN1PR01MB071.prod.exchangelabs.com> <914f07d33a6c473ba415edb4bd05f7b5@BN1PR01MB071.prod.exchangelabs.com> <5314D4F2.4010405@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:51287 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753780AbaCCThT (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 3 Mar 2014 14:37:19 -0500
In-Reply-To: <5314D4F2.4010405@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Harrington, Sean M." <harrington.234@buckeyemail.osu.edu>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 03.03.2014 20:16, Marc Kleine-Budde wrote:
> On 03/03/2014 06:31 PM, Harrington, Sean M. wrote:
>>>> The Beaglebone Black should be running Ubuntu 13.04. I'm willing to
>>>> rebuild the kernel and install the latest distribution if I can some
>>>> feedback on the proper method to get SocketCAN functional and if it
>>>> would most likely resolve the issue.
>>
>>> Which Kernel version are you using?
>>
>> Here is what uname -a returned:
>> Linux arm 3.8.13-bone35 #2 SMP Sat Jan 4 10:18:07 PST 2014 armv7l armv7l armv7l GNU/Linux
> 
> Your kernel is probably missing the following patch:
> 
>> 5d0f801 can: c_can: Fix RX message handling, handle lost message before EOB
> 
> You should update to at least the newest v3.10.x or v3.13.x. You might
> also cherry-pick the above patch into you kernel.

Indeed two patches made it into linux-3.10.y stable:

http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/log/drivers/net/can/c_can?h=linux-3.10.y

- "can: c_can: Fix RX message handling, handle lost message before EOB"
- "can: c_can: don't call pm_runtime_get_sync() from interrupt context"

So applying these patches ...

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=5d0f801a2ccec3b1fdabc3392c8d99ed0413d216
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=e35d46adc49b469fd92bdb64fea8af93640e6651

to the 3.8.13 tree could help :-)

Tnx,
Oliver

