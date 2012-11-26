From: Christoph Appel <cappel@ilv.uni-kiel.de>
Subject: Re: J1939 support: plans for integration?
Date: Mon, 26 Nov 2012 11:56:09 +0100
Message-ID: <50B34AC9.1010306@ilv.uni-kiel.de>
References: <50AE12C5.2070501@ilv.uni-kiel.de> <20121123055240.GA17495@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from l4ms.rz.uni-kiel.de ([134.245.11.212]:48609 "EHLO
	l4ms.rz.uni-kiel.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754361Ab2KZK4K (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 26 Nov 2012 05:56:10 -0500
Received: from localhost ([127.0.0.1])
	by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
	(envelope-from <cappel@ilv.uni-kiel.de>)
	id 1TcwMC-0005u7-Lk
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 11:56:08 +0100
Received: from frontend3.mail.uni-kiel.de ([134.245.12.50])
	by l4ms.rz.uni-kiel.de with esmtp (Exim 4.80.1)
	(envelope-from <cappel@ilv.uni-kiel.de>)
	id 1TcwMC-0005u2-Iw
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 11:56:08 +0100
Received: from [134.245.144.187]
	by frontend3.mail.uni-kiel.de with esmtpsa (TLSv1:DHE-RSA-CAMELLIA256-SHA:256)
	(Exim 4.80.1)
	(envelope-from <cappel@ilv.uni-kiel.de>)
	id 1TcwMB-0001dO-6l
	for linux-can@vger.kernel.org; Mon, 26 Nov 2012 11:56:07 +0100
In-Reply-To: <20121123055240.GA17495@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello Kurt,

Am 23.11.2012 06:52, schrieb Kurt Van Dijck:
> Hi,
>
>> are there any plans for a "streamlined" integration of J1939 support
>> into linux-can i.e. the kernel main line?
> This has always been the target, and still is.
> The number of known users is very small, and do not convince linux-ca=
n maintainers
> yet that the approach of the stack is a good approach.

I see.

> You're welcome to join this effort.

> How do you use the current J1939 stack?
I am in the early process of evaluating possibilities
deploying J1939 in farm machinery (primary
data logging purposes with a couple of bus requests).
So for now, I only use the Linux stack on virtual busses.

> Do you use Transport Protocol, Address Claiming, ....
The latter is planned, as we try to integrate our bus logging
facilities seamlessly.

> Do you use it only on developer PC, or on production items.
There will be in-house products for research purposes, both
PC-based and embedded.

> Mr. Hartkopp & I are very interested in feedback of other users.
As we are in early stages, I can't promise anything but will keep you=20
informed, if we should finally use the Linux stack.

Kind regards,

   Christoph
--=20
Mit freundlichem Gru=C3=9F,

   Christoph Appel

Christian-Albrechts-Universit=C3=A4t zu Kiel
Institut f=C3=BCr Landwirtschaftliche Verfahrenstechnik

Hausadresse: Max-Eyth-Strasse 6, 24118 Kiel
Postadresse: Olshausenstrasse 40, 24098 Kiel

Telefon: +49 (0) 431 880-3790
Telefax: +49 (0) 431 880-4283
http://www.ilv.uni-kiel.de/
