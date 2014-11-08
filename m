From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: candump error flags
Date: Sat, 08 Nov 2014 16:00:47 +0100
Message-ID: <545E301F.7090708@hartkopp.net>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net> <CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:59919 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbaKHPAx (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 10:00:53 -0500
In-Reply-To: <CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 11/08/2014 03:47 PM, Paul Lever wrote:
>>> Make sure you're running a recent new kernel (v3.15 or better) as a lot
>>> of fixes went into the driver.
>>>
>>
>> E.g. the dropcount functionality emerged in Linux 2.6.33
>> So a Debian Squeeze with 2.6.32 won't make it here ...
> I am running the c_can driver with the updates to late June.

Of which kernel version?
A 2.6.32.x with security and stable patches is still no 2.6.33+

>> ps. additionally "candump -r 16000 -l can0 &" would be better :-)
> I need the timestamps.

The logfile format contains a unix timestamp (usec resolution) for every CAN
frame (and error message).

> 
> With berr-reporting enabled I still don't see any messages generated
> by the -e and -d options to candump. Looking at my received data I can
> see that there are missing sequential packets.

I'll better wait for the kernel version until answering based on assumptions.

Regards,
Oliver

