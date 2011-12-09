From: "Oliver Hartkopp" <socketcan@hartkopp.net>
Subject: Re: PEAK CAN USB driver v0.4.0
Date: Fri, 9 Dec 2011 15:21:18 +0100 (MET)
Message-ID: <201112091421.pB9ELIvL003552@post.webmailer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from em-p00-ob.rzone.de ([81.169.146.224]:18577 "EHLO
	em-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab1LIO1H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 9 Dec 2011 09:27:07 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Grosjean Stephane <s.grosjean@peak-system.com>
Cc: linux-can@vger.kernel.org

Please send the patch inline for review! (!!)

Like e.g. this one is sent: http://article.gmane.org/gmane.linux.can/30=
1

Preferably based on this git tree https://gitorious.org/linux-can/linux=
-can-next

Thanks,
Oliver

----- original Nachricht --------

Betreff: PEAK CAN USB driver v0.4.0
Gesendet: Fr, 09. Dez 2011
Von: Grosjean Stephane<s.grosjean@peak-system.com>

> Hi Oliver,
>=20
> Please find a new version of the candev driver for our PEAK USB adapt=
ers.
> I tried to follow your suggestions, especially those concerning the=20
> names of the files and the Kconfig file content. However, I kept the=20
> original Kbuild file since I didn't find (for the moment) another way=
 to=20
> add one or the other pcan_usb.o/pcan_usb_pro.o file, according to the=
ir=20
> corresponding CONFIG_xxx ...
>=20
> This version also handles the PCAN-USB Pro adapter as well as the=20
> timestamps coming from PCAN-USB and PCAN-USB Pro (new from v0.2.0).
> There's something which should be fixed too and I wanted to talk abou=
t=20
> that too:
>=20
> I don't know why for the moment, but sending data through the adapter=
s=20
> works without any problems, except when data are sent through one or =
the=20
> other can channel of the the PCAN-USB Pro: the data are correclty sen=
t=20
> on the bus but, for each sent frame, the Kernel adds the following te=
xt=20
> to the syslog:
>=20
>      [98724.131218] ehci_hcd 0000:00:1a.7: dma_pool_free buffer-32,=20
> f4e93000/34e93000 (bad dma)
>=20
> Seems to be a warning-like, since nothing else occurs anywhere (data =
are=20
> sent, the kernel is/seems always stable...).
> That's the main reason why I decided to give you that new version, an=
d=20
> also to ask you if you had got any idea about the reason of such a lo=
g?=20
> I mean, that "problem" doesnot occur when sending through PCAN-USB=20
> adapter channel... If you have a look to the sources, the management =
of=20
> the tx buffer(s) is done into pcan_usb_core.c, that is, tx buffers=20
> allocation/free doesn't depend on the type of USB adapter (well I=20
> suppose it is, but why and where?).
>=20
> So, while I'm delving into the code, I hope you'll be able to have=20
> enough time to test'n play with your PEAK USB CAN adapters and this n=
ew=20
> driver.
>=20
> Many thanks and regards,
>=20
> St=E9phane
>=20
>=20

--- original Nachricht Ende ----

