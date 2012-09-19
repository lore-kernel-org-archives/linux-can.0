From: Steffen Rose <ro@emtas.de>
Subject: Re: What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 12:18:45 +0200
Message-ID: <8427746.XzAaKfMUEU@lisa>
References: <2478881.znSzbTXnK5@uschi> <50586DE4.9020707@grandegger.com> <50587058.7090703@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49237 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575Ab2ISKSs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 06:18:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 081C756249E
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 12:18:53 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3+-O1zFlnYRx for <linux-can@vger.kernel.org>;
	Wed, 19 Sep 2012 12:18:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 8EEAD562544
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 12:18:52 +0200 (CEST)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id 57A9D56249E
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 12:18:52 +0200 (CEST)
In-Reply-To: <50587058.7090703@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hallo,

more a question to this discussion then a meaning:

> >> a) clear the TX-queue in Linux
[...]
> Yes, if it's a hardware limitation so be it. But if we design an
> interface it should support "clear everything" (a+b+c), but also just
> only c.
>=20

Example:
 I use more than one program, e.g.3 to communicate over one interface,=20
e.g.can0.

Question:
The TX Queue is interface related, not program related, right?

This would mean, if my program (one of the 3) clear the TX queue as par=
t of an=20
internal communication reset it would also destroy the messages of the =
other=20
programs.

Is this idea right?

--=20
Mit freundlichen Gr=FC=DFen / Regards

Steffen Rose

--------------------------------------------------------------

emtas - your embedded solution partner

Meet our specialists on the SPS IPC drives fair=20
from 27 to 29.November in Nuremberg

--------------------------------------------------------------
emtas GmbH
=46ischweg 17
06217 Merseburg
Tel.:  +49(0)3461-79416-0
=46ax.:  +49(0)3461-79416-10
www.emtas.de - service@emtas.de
Gesch=E4ftsf=FChrer: Andreas Boebel, Torsten Gedenk, Steffen Rose
Registergericht: Amtsgericht Stendal
Registernummer:  HRB 17616=20
UstID: DE281092198
--------------------------------------------------------------
