From: Steffen Rose <ro@emtas.de>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 17:19:26 +0200
Message-ID: <1674155.DFlslIQ3jM@lisa>
References: <6309304.MqJsLKDGaO@lisa> <1722972.yqiF7qX92T@lisa> <5072E9A5.2060908@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:50995 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752Ab2JHPTa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 11:19:30 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 3EB5D5637E2
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 17:19:30 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gieqHEoL9Lxc for <linux-can@vger.kernel.org>;
	Mon,  8 Oct 2012 17:19:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id C1C535637ED
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 17:19:29 +0200 (CEST)
In-Reply-To: <5072E9A5.2060908@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org
Cc: Wolfgang Grandegger <wg@grandegger.com>

Hello,

> > Now my error:
> > 	write: Interrupted system call
>=20
> Hm, who has interrupted the write system call? gdb?

That's my question, too.
=20
> > $ ./candump can0
>=20
> Please use "candump can0 any,0:0,#FFFFFFFF" to also see error message=
s.

Thank you.
>=20
> Maybe error frames?

I see some error frames and error passive in the logs. But no busoff.

Now - (sporadic different situations):
The CAN transmit from the virtual env to the CAN, but the receiving doe=
sn't=20
work. Also the candump show only the messages transmitted by the intern=
al=20
programs, not the additional traffic on the real CAN.

> > Can I see more states about the can, can_raw or the ems_usb modules=
?
>=20
> The stats below should tell you if you still receive messages.
>=20
> > $ ip -det -stat link show can0
> > 4: can0: <NOARP,UP,LOWER_UP,ECHO> mtu 16 qdisc pfifo_fast state UNK=
NOWN
> > qlen 10000

Currently I see only TX packets, no RX.

> You seemed to have electrical problem on the bus. Not sure if it's
> related, though.

Possible. But also in error passive is traffic possible and now the CAN=
=20
interface is in error active. In my case not only some messages are dro=
pped.=20
The traffic dropped in one or both directions in general.

Of course, it is possible, that the USB connection or the virtual box U=
SB=20
driver or so on is the problem! At the moment I want to analyze the pro=
blem=20
and search help for this.

--=20
Mit freundlichen Gr=FC=DFen / Best regards

Steffen Rose

