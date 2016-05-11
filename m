From: Mirza Krak <mirza.krak@hostmobility.com>
Subject: Re: rx-fifo: add implmentation and switch flexcan driver to use it
Date: Wed, 11 May 2016 21:07:20 +0200
Message-ID: <CAJ=nTssx5MgiOE0OSbpGWS05=PcE2ikrCdCuy7iM3J=n4phimQ@mail.gmail.com>
References: <1462791154-13375-1-git-send-email-mkl@pengutronix.de>
	<CAJ=nTsvE1ZMNC9zmagM=CA+7oE5FWCszeJFsXEO5rc7g=X_B-g@mail.gmail.com>
	<CAJ=nTsuQgeLpjA6RrL-CKAx+2P9HQhXsad1Y-zk0Cm4b9FNA1g@mail.gmail.com>
	<5732F76E.6080804@hartkopp.net>
	<CAJ=nTssNPDeGW+pEAHTpa+5ARQCQHfXumE=a=cr9prmjhgeJxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35227 "EHLO
	mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbcEKTHX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 May 2016 15:07:23 -0400
Received: by mail-lf0-f48.google.com with SMTP id j8so59339445lfd.2
        for <linux-can@vger.kernel.org>; Wed, 11 May 2016 12:07:22 -0700 (PDT)
In-Reply-To: <CAJ=nTssNPDeGW+pEAHTpa+5ARQCQHfXumE=a=cr9prmjhgeJxQ@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Sorry, my phone e-mail client sent HTML formatted mail, which got
rejected. so re sending.

> Den 11 maj 2016 11:12 fm skrev "Oliver Hartkopp" <socketcan@hartkopp.=
net>:
>> Hello Marc,
>>
>> is it possible that the indirection irq -> rx-fifo -> napi can shuff=
le the
>> CAN frames when the can1 irq is served by different CPUs?

Should be noted that I ran my tests on a single core SOC.
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
