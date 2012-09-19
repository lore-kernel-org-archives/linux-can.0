From: Steffen Rose <ro@emtas.de>
Subject: Re: [Socketcan-users] What are you doing if the TX buffer overflows?
Date: Wed, 19 Sep 2012 13:32:01 +0200
Message-ID: <1614939.SsLEl76HCM@lisa>
References: <2478881.znSzbTXnK5@uschi> <34567791.oZ5dyCnTQA@lisa> <20120919102640.GB1612@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.8]:50429 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753210Ab2ISLcE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 19 Sep 2012 07:32:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 931CC561C42
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 13:32:08 +0200 (CEST)
Received: from kolab.emtas.de ([127.0.0.1])
	by localhost (kolab.emtas.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pu3rczp4YD2d for <linux-can@vger.kernel.org>;
	Wed, 19 Sep 2012 13:32:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by kolab.emtas.de (Postfix) with ESMTP id 267A9561EF0
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 13:32:08 +0200 (CEST)
Received: from lisa.localnet (lisa.emtas.de [192.168.3.54])
	by kolab.emtas.de (Postfix) with ESMTPS id E18EF561C42
	for <linux-can@vger.kernel.org>; Wed, 19 Sep 2012 13:32:07 +0200 (CEST)
In-Reply-To: <20120919102640.GB1612@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hello,

> > This would mean, if my program (one of the 3) clear the TX queue as=
 part
> > of an internal communication reset it would also destroy the messag=
es of
> > the other programs.
> >=20
> > Is this idea right?
>=20
> Yes, you're right.
> That's an aspect of 'multi-user' environment,
> with a flexible 'user' interpretation.

In this case I have a new case:

An other program (master) send a communication reset request to my prog=
ram.
I would clear all of my outstanding messages, because it contains old d=
ata and=20
I don't want to sent it. The most problems are, I think, if the message=
s are a=20
long time in the buffer, e.g. because the 'root' user, (not my program)=
 has=20
created a large buffer.

I want to clear this messages with user rights. I think, this last requ=
irement=20
(user rights) should be ok, because I want to clear only my messages.

I'm unsure, if the buffered messages have an assignment to the program,=
 that=20
sent this message.

Additional: Of course I response the reset request an I hope, that this=
=20
response is send after all old buffered messages. It's depend of the qu=
eue=20
configuration, I think.

--=20
Mit freundlichen Gr=C3=BC=C3=9Fen / Regards
Steffen Rose
www.emtas.de
