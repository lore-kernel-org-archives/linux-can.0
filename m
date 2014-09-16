From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH can] peak_pci: add PCI ID definition pcie card variant
Date: Tue, 16 Sep 2014 15:50:04 +0200
Message-ID: <5418400C.6070107@hartkopp.net>
References: <5417EF55.9050805@hartkopp.net> <5418358E.1060506@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:9616 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbaIPN4J (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 09:56:09 -0400
In-Reply-To: <5418358E.1060506@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Stephane,

On 16.09.2014 15:05, Stephane Grosjean wrote:

> You've got my Acked-by, many thanks for having handled that !

That's the advantage when providing readable code :-)

The adapter works pretty good - even the PCI hotplug stuff and the LED.

Thanks & best regards,
Oliver

>=20
> Le 16/09/2014 10:05, Oliver Hartkopp a =E9crit :
>> Add PCI ID definition for the single channel PCAN ExpressCard 34 ada=
pter.
>> Due to the subsystem id evaluation the correct number of channels (h=
ere 1)
>> is created at initialization time. Tested including the LED function=
ality.
>>
>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> CC: Stephane Grosjean <s.grosjean@peak-system.com>
> Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
>>

