From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: candump error flags
Date: Sat, 08 Nov 2014 17:44:22 +0100
Message-ID: <545E4866.1070003@hartkopp.net>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>	<545CD775.1030200@pengutronix.de>	<545CDD93.1080600@hartkopp.net>	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>	<545E301F.7090708@hartkopp.net>	<CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>	<545E36F2.5040005@hartkopp.net> <CAHuoerk0S9FxsoQiCm-gc5ohvAGqjVnVpSJ2ev1jD8e31-5_Dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:17946 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbaKHQo0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 11:44:26 -0500
In-Reply-To: <CAHuoerk0S9FxsoQiCm-gc5ohvAGqjVnVpSJ2ev1jD8e31-5_Dw@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Paul Lever <svjeorgia@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

On 11/08/2014 04:34 PM, Paul Lever wrote:

>> In this case the -d option should work.
>> But just for the records: The -d option detects drops from the network layer
>> to the application which opened the socket (here: candump).
>>
>> So it basically detects problems when your user space application is not fast
>> enough to read and handle the CAN frames. It does NOT detect whether the CAN
>> driver dropped any frames.
> 
> 
> Thanks for the info. Is there an easy way to detect driver level
> packet drops or overruns?The CANBUS is at 250,000 bitrate.

When the CAN driver supports it, there's a bit in the error message

	CAN_ERR_CRTL_RX_OVERFLOW

for that.

See:
http://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/tree/include/uapi/linux/can/error.h?h=linux-3.17.y#n63

Looking for it in the tree:
http://lxr.free-electrons.com/ident?i=CAN_ERR_CRTL_RX_OVERFLOW


It is used in c_can_handle_lost_msg_obj()

http://lxr.free-electrons.com/source/drivers/net/can/c_can/c_can.c#L348

So it should also increase rx_errors and rx_over_errors.

I'm not familiar with c_can - but can you see these statistics increasing the
values in your setup?

ip -stats link show can0

should display them.

Regards,
Oliver
