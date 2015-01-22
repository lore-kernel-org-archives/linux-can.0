From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH 6/7 v8] can/peak_usb: add peak_usb_netif_rx() new function
Date: Thu, 22 Jan 2015 16:42:58 +0100
Message-ID: <54C11A82.5050800@peak-system.com>
References: <1421940266-6088-1-git-send-email-s.grosjean@peak-system.com>
 <1421940266-6088-7-git-send-email-s.grosjean@peak-system.com>
 <54C117BC.2080905@pengutronix.de> <54C11978.200@peak-system.com>
 <54C119D4.5050104@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:50384 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750888AbbAVPnI (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Jan 2015 10:43:08 -0500
In-Reply-To: <54C119D4.5050104@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>


Le 22/01/2015 16:40, Marc Kleine-Budde a =C3=A9crit :
> On 01/22/2015 04:38 PM, Stephane Grosjean wrote:
>> Le 22/01/2015 16:31, Marc Kleine-Budde a =C3=A9crit :
>>> On 01/22/2015 04:24 PM, Stephane Grosjean wrote:
>>>> Add a common function that pushes the skb in the network queue wit=
h adding
>>>> timestamps information, converted from time values read from the
>>>> PEAK USB adapters.
>>> Why is this function in core.c, it's only used by pcan_usb_fd.c.
>> Because it should be able to use it from older source files (pcan_us=
b
>> and pcan_usb_pro, AFAIR)
> Are you planing to make use of the function in an upcoming patch?
>
> Marc
>

Yes, I am. Not sure I will have enough time to do this soon. How much=20
times do we have before next Kernel release, please?

St=C3=A9phane
--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt
Handelsregister Darmstadt HRB 9183=20
Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
--
