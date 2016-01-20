From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Wed, 20 Jan 2016 15:29:18 +0100
Message-ID: <569F99BE.70001@peak-system.com>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
 <569F9588.2090809@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:57658 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932721AbcATO33 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jan 2016 09:29:29 -0500
In-Reply-To: <569F9588.2090809@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>


Le 20/01/2016 15:11, Marc Kleine-Budde a =C3=A9crit :
> On 01/20/2016 12:15 PM, Stephane Grosjean wrote:
>> This patch installs a workaround when the driver detects one of the
>> following PEAK-System CAN interfaces, running a firmware < v1.3.0:
> Is the problem fixed on FW >=3D 1.3.0? Is it possible to update the
> firmware? If so, what about printing a warning message about known
> problem with the firmware?

Yes, problem is fixed with 1.3.0.
And yes, firmware can be updated.
What kind of warning message are you talking about? Do you mean that=20
peak_pci could dev_warn() a text msg to inform about the fact that the=20
current FW is able to be upgraded?

If yes, since peak_pci prints a single info line per CAN channel, what=20
would you prefer?

- the same warning about the old FW version, for each candev, something=
=20
like:

[ 2200.129168] peak_pci 0000:05:01.0: can0 at=20
reg_base=3D0xffffc90000678000 cfg_base=3D0xffffc90000676000 irq=3D22 FW=
=3D1.2.0=20
should be updated
[ 2200.129307] peak_pci 0000:05:01.0: can1 at=20
reg_base=3D0xffffc90000678400 cfg_base=3D0xffffc90000676000 irq=3D22 FW=
=3D1.2.0=20
should be updated

- or a single warning msg for the hardware device, something like:

[ 2200.129168] peak_pci 0000:05:01.0: Warning: FW v1.2.0 needs a=20
workaround; update is available
[ 2200.129168] peak_pci 0000:05:01.0: can0 at=20
reg_base=3D0xffffc90000678000 cfg_base=3D0xffffc90000676000 irq=3D22
[ 2200.129307] peak_pci 0000:05:01.0: can1 at=20
reg_base=3D0xffffc90000678400 cfg_base=3D0xffffc90000676000 irq=3D22

?

St=C3=A9phane

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183=20
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
