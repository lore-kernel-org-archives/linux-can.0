From: Paul Lever <svjeorgia@gmail.com>
Subject: Re: candump error flags
Date: Sat, 8 Nov 2014 11:34:05 -0400
Message-ID: <CAHuoerk0S9FxsoQiCm-gc5ohvAGqjVnVpSJ2ev1jD8e31-5_Dw@mail.gmail.com>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
	<545CD775.1030200@pengutronix.de>
	<545CDD93.1080600@hartkopp.net>
	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
	<545E301F.7090708@hartkopp.net>
	<CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
	<545E36F2.5040005@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:63574 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793AbaKHPeH (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 8 Nov 2014 10:34:07 -0500
Received: by mail-yk0-f178.google.com with SMTP id 79so2374836ykr.23
        for <linux-can@vger.kernel.org>; Sat, 08 Nov 2014 07:34:05 -0800 (PST)
In-Reply-To: <545E36F2.5040005@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

> In this case the -d option should work.
> But just for the records: The -d option detects drops from the network layer
> to the application which opened the socket (here: candump).
>
> So it basically detects problems when your user space application is not fast
> enough to read and handle the CAN frames. It does NOT detect whether the CAN
> driver dropped any frames.


Thanks for the info. Is there an easy way to detect driver level
packet drops or overruns?The CANBUS is at 250,000 bitrate.

Regards
Paul
