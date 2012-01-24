From: Steffen Rose <ro@emtas.de>
Subject: Re: [Socketcan-users] increase buffer size
Date: Tue, 24 Jan 2012 17:50:47 +0100
Message-ID: <5532811.lHVu6H1glq@lisa>
References: <16594621.klnj3Hkir3@lisa> <2F0BDF8C-F6D0-4CCD-A08D-3D969B98BB02@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:60176 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab2AXQuv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 24 Jan 2012 11:50:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id CF32D561BEB
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 17:50:50 +0100 (CET)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n83QQ0CczU+9 for <linux-can@vger.kernel.org>;
	Tue, 24 Jan 2012 17:50:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 1EC01561BE6
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 17:50:50 +0100 (CET)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	(Authenticated sender: ro@emtas.de)
	by kolab.emtas.de (Postfix) with ESMTPSA id DF884561BB1
	for <linux-can@vger.kernel.org>; Tue, 24 Jan 2012 17:50:49 +0100 (CET)
In-Reply-To: <2F0BDF8C-F6D0-4CCD-A08D-3D969B98BB02@t-online.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Am Dienstag, 24. Januar 2012, 17:31:56 schrieb Heinz-Juergen Oertel:
> Von meinem iPhone gesendet
>=20
> Am 24.01.2012 um 16:36 schrieb Steffen Rose <ro@emtas.de>:
> > Du liest sicher mit...
>=20
> Ja, werde trotzdem nicht schlau wer die  Puffer, bes. RX verwaltet.

Wenn Du mich fragts:

RX Buffer: Hier wird die Socket Quere genutzt.
TX Buffer: Hierf=C3=BCr ist der CAN Treiber verantwortlich. Die Socket =
Quere k=C3=B6nnte=20
genutzt werden, wird aber typ. nicht genutzt.

bye
Steffen
=20
