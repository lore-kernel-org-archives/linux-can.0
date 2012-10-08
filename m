From: Steffen Rose <ro@emtas.de>
Subject: Re: unsure - socketCAN blocking
Date: Mon, 08 Oct 2012 17:21:18 +0200
Message-ID: <2236713.jcWFbEc6dn@lisa>
References: <6309304.MqJsLKDGaO@lisa> <5072E9A5.2060908@grandegger.com> <5072EA72.9050308@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:59274 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752493Ab2JHPVW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 8 Oct 2012 11:21:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id D75965636F1
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 17:21:21 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E82UXxLq43hJ for <linux-can@vger.kernel.org>;
	Mon,  8 Oct 2012 17:21:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 66B625637E5
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 17:21:21 +0200 (CEST)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id 366CA5637E2
	for <linux-can@vger.kernel.org>; Mon,  8 Oct 2012 17:21:21 +0200 (CEST)
In-Reply-To: <5072EA72.9050308@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Am Montag, 8. Oktober 2012, 17:00:02 schrieb Marc Kleine-Budde:
> >> Now my error:
> >>      write: Interrupted system call

> > Hm, who has interrupted the write system call? gdb?
=20
> Is your application making use of signals? This is not an error, just
> restart the write.

I will ask my colleguage. But that is possible.

--=20
Mit freundlichen Gr=FC=DFen / Best regards

Steffen Rose

