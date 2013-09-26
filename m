From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: D_CAN problems after devm_ioremap_resource conversion.
Date: Thu, 26 Sep 2013 08:56:16 +0530
Message-ID: <CAHbNUh2XUoTv1KcierjhKp9snG7oE3AdtM4XP2=XhWfaHzDNkA@mail.gmail.com>
References: <CAF03EBdqih4s1iUwZXqZtgNHx-btBdfrNoHy2z9xVuaS-ki41Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:63859 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752206Ab3IZD0Q (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 25 Sep 2013 23:26:16 -0400
Received: by mail-ob0-f169.google.com with SMTP id wp4so1249451obc.14
        for <linux-can@vger.kernel.org>; Wed, 25 Sep 2013 20:26:16 -0700 (PDT)
In-Reply-To: <CAF03EBdqih4s1iUwZXqZtgNHx-btBdfrNoHy2z9xVuaS-ki41Q@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: T Thayer <tthayer.linux@gmail.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, wg@grandegger.com, davem@davemloft.net

On 26 September 2013 02:06, T Thayer <tthayer.linux@gmail.com> wrote:
> Hello.
>
> I've run into a problem with the Altera CycloneV SoCFPGA D_CAN driver
> implementation after the devm_request_and_ioremap() to
> devm_ioremap_resources() change (git commit
> 32766fff24a761079636bb96c389411d24a334c6. As another data point, I do
> not have problems with 3.10 (which did not have the
> devm_ioremap_resources() change).
>
> I looked through the CAN mailing list archives but could not find any
> issues that matched my symptoms.
>
> Board #1 running 3.11 (git commit
> d25903f894849fa799141e774c4ad34199e3e6a1) that I configure as:
> canconfig can0 bitrate 500000
> canconfig can0 start
> candump can0
>
>
> Board #2 running 3.10 that I configure as:
> canconfig can0 bitrate 500000
> canconfig can0 start
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
>
> But nothing appears on the Board#1 dump.
>
> The strange thing is that if I type something (ie. the letter "A") in
> Board#1's terminal window and then change to Board#2's terminal window
> and do another
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
>
> then 2 messages show up on the candump (the original one and the one
> just sent). From then on, typing
> cansend can0 -i 0x123 0x11 0x22 0x33 0x44 0x55 0x66 0x77 0x88
>
> shows up on Board#1. It almost seems like typing any character in
> Board#1's terminal (which is waiting for data via candump) frees up
> the candump buffer printout.
>
> I don't know if this is an issue with candump or with the CAN driver.
> It doesn't seem like a candump issue because it works OK if I revert
> and rebuild the kernel before the above commit.  (and it breaks if I
> update my tree to after the above commit and rebuild).
>
> Thank you for any insight you may have,
>
> Thor

I don't have much understanding on how CAN works, hence I won't be of
much help here. Sorry.

Looking at the particular git patch, I can't find anything that would
change the behavior of the code.

-- 
Tushar Behera
