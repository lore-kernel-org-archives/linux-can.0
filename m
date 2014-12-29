From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] bfin_can: move the header file to arch independent location
Date: Mon, 29 Dec 2014 18:36:35 +0100
Message-ID: <54A19123.5040708@hartkopp.net>
References: <1419563241-20766-1-git-send-email-Aaron.wu@analog.com> <549E936A.2080904@hartkopp.net> <5234314.TQCbV9cZp1@heinz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:18250 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbaL2Rgm (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 29 Dec 2014 12:36:42 -0500
In-Reply-To: <5234314.TQCbV9cZp1@heinz>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?windows-1252?Q?Heinz-J=FCrgen_Oertel?= <hj.oertel@t-online.de>, mkl@pengutronix.de
Cc: Aaron Wu <Aaron.wu@analog.com>, linux-can@vger.kernel.org, linux-kernel@vger.kernel.org

On 12/29/2014 05:45 PM, Heinz-J=FCrgen Oertel wrote:
> Am Samstag, 27. Dezember 2014, 12:09:30 schrieb Oliver Hartkopp:
>> As bfin_can.c is the only user of defines from this include file jus=
t add the
>> needed(!) defines directly to bfin_can.c
>=20
> I often include also the yet unneeded definitions, e.g., for unused r=
egister or unused bit definitions.
> That makes it easier for someone else to add missing functionality, w=
hen later on needed.
>=20

Yes. This can be useful when you can imagine to add functionality into =
a
specific direction. But in this case there were tons of mailbox definit=
ions
(always defined 32 times each) which we will not use in this way in the=
 netdev
driver.

Just take a look into bfin_can.h and what is really used in bfin_can.c =
from
those defines and you will see.

Regards,
Oliver
