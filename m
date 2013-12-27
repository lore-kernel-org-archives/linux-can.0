From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: plx_pci.c patch
Date: Fri, 27 Dec 2013 16:21:08 +0100
Message-ID: <52BD9AE4.7010104@hartkopp.net>
References: <52B8878E.5090505@mcc.vniiem.ru> <52B88A9E.6000008@mcc.vniiem.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.217]:24976 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753642Ab3L0PVN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 27 Dec 2013 10:21:13 -0500
In-Reply-To: <52B88A9E.6000008@mcc.vniiem.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?UTF-8?B?0J7Qu9C10LMg0JzQvtGA0L7Qtw==?= <oleg.moroz@mcc.vniiem.ru>
Cc: linux-can@vger.kernel.org

Hello Oleg,

thanks for your contribution!

On 23.12.2013 20:10, =D0=9E=D0=BB=D0=B5=D0=B3 =D0=9C=D0=BE=D1=80=D0=BE=D0=
=B7 wrote:
>=20
> Hello. I've added the ELCUS CAN-200-PCI card support into sja1000_plx=
_pci
> driver. Could you please review my changes and commit it to the  Linu=
x kernel
> repository?
>=20

Please post patches always in-line, e.g. an example for plx_pci.c is th=
is
commit:

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/d=
rivers/net/can/sja1000/plx_pci.c?id=3De4bc6c06569a90512169d98a11b3eb2ec=
18da4ae

Which had this patch:
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/patch/dr=
ivers/net/can/sja1000/plx_pci.c?id=3De08534b57e79fa722e3136b79868a725a8=
eea0f0

And this post on the mailing list:
http://marc.info/?l=3Dlinux-netdev&m=3D132368716608087&w=3D2

Please sent your patch the same way with a proper Signed-off-by: statem=
ent
(preferably without cyrillic characters).

Please clean up your code changes before =3D> remove the line changes b=
elow!

Best regards,
Oliver=20


@@ -440,13 +462,14 @@ static void plx_pci_reset_marathon(struc
 	}
 }
=20
+
+

(why did you introduce these lines?)

 static void plx_pci_del_card(struct pci_dev *pdev)
 {
 	struct plx_pci_card *card =3D pci_get_drvdata(pdev);
 	struct net_device *dev;
 	struct sja1000_priv *priv;
 	int i =3D 0;
-

(there should remain an empty line)
=20
 	for (i =3D 0; i < PLX_PCI_MAX_CHAN; i++) {
 		dev =3D card->net_dev[i];
 		if (!dev)

=3D> please leave this code as-is. Tnx.

ps. For the entire correct process see:
https://www.kernel.org/doc/Documentation/SubmittingPatches
