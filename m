From: Holger Schurig <holgerschurig@gmail.com>
Subject: Re: can: flexcan: implement workaround for FIFO overruns (based on
 code by David Jander)
Date: Thu, 9 Jul 2015 11:32:26 +0200
Message-ID: <CAOpc7mHREmGPhM7xK3DO_t=SdieBt9fpQ4MtyTgWiRQ6iErX+Q@mail.gmail.com>
References: <559D35CA.2050402@uweschneider.de>
	<CAOpc7mGxD7PF97jA3qfcty5P14=JHd4KS7Ks0HUPF8foTavMLQ@mail.gmail.com>
	<559E3E3E.7080603@uweschneider.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38167 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbbGIJc1 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 9 Jul 2015 05:32:27 -0400
Received: by wibdq8 with SMTP id dq8so236396105wib.1
        for <linux-can@vger.kernel.org>; Thu, 09 Jul 2015 02:32:26 -0700 (PDT)
In-Reply-To: <559E3E3E.7080603@uweschneider.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Torsten Lang <torsten.lang@uweschneider.de>
Cc: linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>

Thorsten,

after pondering a bit on this I'd just say give up.

The FlexCAN driver is in a state of limbo. For many months
occassionally people submit some path, but nothing really changes,
only minor things get accepted and applied to the kernel. I see two
reasons:

* some people have the picture of a "one big patch series that saves
the world" view. But this one is complex, and so it never
materialized. For example my KFIFO patch was not dismissed because of
technical reasons, but because this big patch will eventually come.
Marc said "I'll look into it at the end of the week", but that was
optimistic
* the FlexCAN driver is too complex, or, better phrased: the
environment where it runs is too complex. When you make a substantial
change, you'd need to test it an all CPUs that implement various
versions of the FlexCAN IP. But who has access to an i.MX6, to an
i.MX5, and to the other chips that run it?  This hinders changes that
do bigger architectural changes. I'm not sure how this can be fixed,
maybe in the way the wifi people do it with Atheros chipsets.

But my guess, at the current point of view, is that your patch (even
when reworked) has little chance to get accepted. It will just rest
here in the mailing list.

Do I sound frustrated?  Yes. Because the FlexCAN RxFIFO-packet-lost
problem is known for a very long time and nothing substantial happens.
