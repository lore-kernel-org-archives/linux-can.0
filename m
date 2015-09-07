From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [PATCH v3 2/2] Allwinner A10/A20 CAN Controller support
Date: Mon, 7 Sep 2015 19:18:00 +0200
Message-ID: <CAJ=nTstMVfVByht2-dFCVrv+giaQAmQAsPQrvAppnaJMzf1ayQ@mail.gmail.com>
References: <1441376988-2384-1-git-send-email-info@gerhard-bertelsmann.de>
	<1441376988-2384-3-git-send-email-info@gerhard-bertelsmann.de>
	<CAJ=nTsuYHPv5OjzowBXy0ss02f7PHKxWV-csxV+u1CZP6dOnYQ@mail.gmail.com>
	<c0271c81cf9dd9ea16b32375c6dc6449@mail.rdts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:35006 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753812AbbIGRSD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Sep 2015 13:18:03 -0400
Received: by lagj9 with SMTP id j9so55789967lag.2
        for <linux-can@vger.kernel.org>; Mon, 07 Sep 2015 10:18:00 -0700 (PDT)
In-Reply-To: <c0271c81cf9dd9ea16b32375c6dc6449@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>, linux-can-owner@vger.kernel.org

2015-09-07 18:25 GMT+02:00 Gerhard Bertelsmann <info@gerhard-bertelsman=
n.de>:
> Hi Mirza,
>
>
> thx for your hint. Do you think that's really needed ? The scope of t=
he
> defines are limited to this file. There is no other hardware dependan=
t
> code involved.

Well if we look at the files that you are including, chances are that
they might define something and produce "redefinition" errors. Which
was the case for the SJA1000 driver as well.

I am mostly reacting to defines like END, ACK, WAKEUP.

>
> IMHO the SJA1000 is a different story. The SJA1000 could be connected=
 via
> different busses where other registers are involved.

The fact that the SJA1000 driver has a different structure had nothing
to do with the conflict. Since the conflict was in
arch/sh/include/asm/ptrace_32.h

>
> Nevertheles if the gurus here say I have to change this I'm going to =
add
> a prefix to the defines.

Agreed :). This might be a no- issue but I am putting it out there.


--=20
Med V=C3=A4nliga H=C3=A4lsningar / Best Regards

*******************************************************************
Mirza Krak
Host Mobility AB
mirza.krak@hostmobility.com
Anders Personsgatan 12, 416 64 G=C3=B6teborg
Sweden
http://www.hostmobility.com
Direct: +46 31 31 32 704
Phone: +46 31 31 32 700
=46ax: +46 31 80 67 51
Mobile: +46 730 28 06 22
*******************************************************************
