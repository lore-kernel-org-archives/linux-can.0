From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: c_can driver sometimes sends first two bytes filled with zeros
Date: Mon, 23 May 2016 20:19:39 +0200
Message-ID: <574349BB.3010703@grandegger.com>
References: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailproxy03.manitu.net ([217.11.48.151]:58248 "EHLO
	mailproxy03.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679AbcEWSTo (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 May 2016 14:19:44 -0400
In-Reply-To: <0120733A154AE74CA608A286CE7FFD2621D9A343@rg-contact.RG.local>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Richard Andrysek <richard.andrysek@gomtec.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hello,

Am 12.05.2016 um 11:23 schrieb Richard Andrysek:
> We can reproduce an issue with the canutils. We send messages in the loop with non-zero bytes and from time to time we get first two bytes of the message with zero values. The test script looks so:
>
> #!/bin/sh
>
> echo "Press [CTRL+C] to stop.."
> while true
> do
>                 cansend can1 --loop=15 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
> done
>
> With CAN analyzer we see normally the right message, but in cycles ~1min we see first two bytes are zero.
>
> If we add some delays between messages, like this:
>
> do
>                 cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
> 	cansend can1 --loop=1 -i 933 0xde 0xde 0xde 0xde 0xde 0xde
>                 usleep 5
>
> done
>
> It works fine.
>
> We use Altera Cyclone V, where the  c_can driver is used. It runs with Linux kernel 3.16, but I've checked 4.5 version of a driver and it is a same one.
>
> Have somebody idea how to find a reason for that?

The official "cansend" does not support "--loop". The official canutils
have cangen and canfdtest for more thorough testing. Anyway, does
"ip -s -d link show" report any errors? And could you run
"candump any,0:0,#FFFFFFFF" while sending. Does it also list the 
messages with the wrong data?

Wolfgang.
