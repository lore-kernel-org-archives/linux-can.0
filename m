From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC PATCH v2 1/2] can: add tx/rx LED trigger support
Date: Tue, 24 Apr 2012 17:41:55 +0200
Message-ID: <4F96C9C3.1010505@hartkopp.net>
References: <1335214966-20478-1-git-send-email-fabio.baltieri@gmail.com> <4F964C45.8010804@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:34684 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab2DXPl5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Apr 2012 11:41:57 -0400
In-Reply-To: <4F964C45.8010804@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Fabio Baltieri <fabio.baltieri@gmail.com>, linux-can@vger.kernel.org

On 24.04.2012 08:46, Wolfgang Grandegger wrote:


>> - The blink timer is implemented as:
>>   * keep on for delay_time
>>   * turn off and retrigger the timer
>>   * turn back on after delay
>>   so that the hot-path only contains a switch-case, some checks and a mod_timer.
>>
>> This is tested on an x86 with a custom usb-can interface and on a flexcan-based
>> Freescale ARM board. I'll post some patch to implement support in other drivers
>> if anyone is interested into testing this one.
>>
>> Any comments?
> 
> I still think that the blinking support should go to the timer class to
> avoid duplicated code. Any good reason against? Apart from that the
> patches look good.


Hello Wolfgang,

what exactly do you mean with "timer class" ??

To me the current implementation looks like standard jiffie-based timer usage.

IMO hrtimers are not needed here - or what are you thinking of?

Regards,
Oliver
