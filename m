From: Andri Yngvason <andri.yngvason@marel.com>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Tue, 23 Feb 2016 16:53:09 +0000
Message-ID: <20160223165309.GA14154@maxwell.marel.net>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-db3on0064.outbound.protection.outlook.com ([157.55.234.64]:38752
	"EHLO emea01-db3-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753551AbcBWR3R (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 23 Feb 2016 12:29:17 -0500
Content-Disposition: inline
In-Reply-To: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

On Wed, Jan 20, 2016 at 12:15:32PM +0100, Stephane Grosjean wrote:
> This patch installs a workaround when the driver detects one of the
> following PEAK-System CAN interfaces, running a firmware < v1.3.0:
>=20
> PCAN-PCI Express 1/2/4 CAN; DeviceID 0x0003
> PCAN-PCI/104 Express 1/2/4 CAN; DeviceID 0x0007
> PCAN-miniPCIe 1/2 CAN; DeviceID 0x0008
> PCAN-PCI Express OEM 1/2/4 CAN; DeviceID 0x0009
> PCAN-ExpressCard 34 1 CAN; DeviceID 0x000A
>=20
> This fixes potential loss of one tx frame in Linux SMP when some othe=
r
> task does another Command Register write (e.g. Release Receive Buffer=
)
> in between the triggering Tx Request and the next Sample Point.
>=20
> This workaround is useless thus *NOT* installed when the firmware
> has been upgraded to v1.3.0 or higher, nor if the CAN interface is eq=
uipped
> with true SJA1000 controller(s).
>=20
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/peak_pci.c | 34 ++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
[...]

Hi St=E9phane,

Is this still being worked on?

I can test this if you like. I just need to have the firmware upgrade.

Regards,
Andri
