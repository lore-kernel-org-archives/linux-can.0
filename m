From: Paul Lever <svjeorgia@gmail.com>
Subject: Re: candump error flags
Date: Sun, 9 Nov 2014 10:50:36 -0400
Message-ID: <CAHuoerm+hYJx_rPK6-AZfgX2E+j-QXvbHaDZzv+TO8cEvX6j=A@mail.gmail.com>
References: <CAHuoermNC-Cc79pK_qxkS4t+SjU=JkKtbxN9oZoBZRDUEnvYmA@mail.gmail.com>
	<545CD775.1030200@pengutronix.de>
	<545CDD93.1080600@hartkopp.net>
	<CAHuoernFKhHJZKTYDc+qpbhwkrx6cWAr7vreH=Sa=FoinVG6dw@mail.gmail.com>
	<545E301F.7090708@hartkopp.net>
	<CAHuoerkEB==OqEPasu7xWZXxFw8_AQFRNRMAx5qbbC09cff2pA@mail.gmail.com>
	<545E36F2.5040005@hartkopp.net>
	<CAHuoerk0S9FxsoQiCm-gc5ohvAGqjVnVpSJ2ev1jD8e31-5_Dw@mail.gmail.com>
	<545E4866.1070003@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:48773 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbaKIOuh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 9 Nov 2014 09:50:37 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so6916146wgh.6
        for <linux-can@vger.kernel.org>; Sun, 09 Nov 2014 06:50:36 -0800 (PST)
In-Reply-To: <545E4866.1070003@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org

> I'm not familiar with c_can - but can you see these statistics increasing the
> values in your setup?
>
> ip -stats link show can0
>
> should display them.
Yes, they are shown in the stats:
ip -stats link show can0
3: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state
UNKNOWN mode DEFAULT group default qlen 10
    link/can
    RX: bytes  packets  errors  dropped overrun mcast
    619176     77397    71192   37270   0       0
    TX: bytes  packets  errors  dropped carrier collsns
    0          0        0       0       0       0

I'm just not seeing any from the candump listing.

Thanks again for the info
Paul
