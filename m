From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: [RFC] K-Line protocol via SocketCAN
Date: Fri, 20 May 2016 08:04:49 +0200
Message-ID: <CAJ=nTsu_bJgj1A5JNJNAd9HAao5493CnofbQpJ_qftYOiCgaYw@mail.gmail.com>
References: <573E491E.1000906@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f49.google.com ([209.85.215.49]:35832 "EHLO
	mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997AbcETGEv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 20 May 2016 02:04:51 -0400
Received: by mail-lf0-f49.google.com with SMTP id e126so20126393lfg.2
        for <linux-can@vger.kernel.org>; Thu, 19 May 2016 23:04:50 -0700 (PDT)
In-Reply-To: <573E491E.1000906@denx.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, davem@davemloft.net, Wolfgang Grandegger <wg@grandegger.com>

2016-05-20 1:15 GMT+02:00 Marek Vasut <marex@denx.de>:
> I will also need to add support for the LIN protocol and SENT protoco=
l
> further down the line. I will also likely revisit the Arinc at some
> point afterward. So I would like to know how to deal with this protoc=
ol
> mess.

=46YI, there has been a similar LIN project for quite a while [1]. You
might have seen it earlier?

[1]. http://rtime.felk.cvut.cz/gitweb/linux-lin.git

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
