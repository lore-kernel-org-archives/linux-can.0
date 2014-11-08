From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: candump error flags
Date: Sat, 08 Nov 2014 16:29:54 +0100
Message-ID: <545E36F2.5040005@hartkopp.net>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net>	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>	<545E301F.7090708@hartkopp.net> <CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:47646 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaKHP37 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 10:29:59 -0500
In-Reply-To: <CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 11/08/2014 04:14 PM, Paul Lever wrote:
>>>> ps. additionally "candump -r 16000 -l can0 &" would be better :-)
>>> I need the timestamps.
>>
>> The logfile format contains a unix timestamp (usec resolution) for every CAN
>> frame (and error message).
> Correct if I use the -t option. I was just commenting on the
> suggestion not to use the option. Not sure why it was suggested.
> 

Hm. No.

The -l option creates a logfile with the current date/time in the current
directory. The '-L' option puts the logfile format to the stdout.
Both of them contain a timestamp for all CAN frames and error messages.

No need for '-t?' in these cases.

>> I'll better wait for the kernel version until answering based on assumptions.
> The kernel is
>  Image Name:   Linux-3.12.9-00111-gcad6b9e
> with an updated c_can driver.

In this case the -d option should work.
But just for the records: The -d option detects drops from the network layer
to the application which opened the socket (here: candump).

So it basically detects problems when your user space application is not fast
enough to read and handle the CAN frames. It does NOT detect whether the CAN
driver dropped any frames.

Regards,
Oliver

