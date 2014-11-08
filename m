From: Paul Lever <svjeorgia@gmail.com>
Subject: Re: candump error flags
Date: Sat, 8 Nov 2014 11:14:16 -0400
Message-ID: <CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
	<545CD775.1030200@pengutronix.de>
	<545CDD93.1080600@hartkopp.net>
	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
	<545E301F.7090708@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f44.google.com ([209.85.213.44]:60860 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753806AbaKHPOR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 10:14:17 -0500
Received: by mail-yh0-f44.google.com with SMTP id b6so2480217yha.17
        for <linux-can@vger.kernel.org>; Sat, 08 Nov 2014 07:14:16 -0800 (PST)
In-Reply-To: <545E301F.7090708@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

>>> ps. additionally "candump -r 16000 -l can0 &" would be better :-)
>> I need the timestamps.
>
> The logfile format contains a unix timestamp (usec resolution) for every CAN
> frame (and error message).
Correct if I use the -t option. I was just commenting on the
suggestion not to use the option. Not sure why it was suggested.


> I'll better wait for the kernel version until answering based on assumptions.
The kernel is
 Image Name:   Linux-3.12.9-00111-gcad6b9e
with an updated c_can driver.

Regards
Paul
