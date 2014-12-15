From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 message length
Date: Mon, 15 Dec 2014 10:31:36 +0100
Message-ID: <20141215093136.GA646@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org>
 <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from [212.71.1.211] ([212.71.1.211]:52710 "EHLO
	relaygateway02.edpnet.net" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1751448AbaLOJcE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 15 Dec 2014 04:32:04 -0500
Content-Disposition: inline
In-Reply-To: <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

On Mon, Dec 15, 2014 at 08:58:14AM +0000, pfifre.ext@orange.com wrote:
> Hi Kurt,
>=20
> I resolved the issue. The problem appears with long message because, =
according to the j1939 specifications, the end of message has to be ful=
filled with 0xFF if the message is not modulo 8.
> Apparently, the j1939  drivers don't make the padding with 0xFF.

You're not the first to find an actual ECU complaining on this.
I assembled a patch earlier this year, see http://lists.kde.org/?l=3Dli=
nux-can&m=3D139825572207448&w=3D2

> Then I do that in my software and it works fine know.

I advise to apply that patch, and avoid to calculate packet sizes in us=
erspace.

Which is the remote ECU that does not accept the packets?

>=20
> Perhaps, It will be a good idea to add this in the drivers.

Yep, I'll do.

Kind regards,
Kurt
>=20
> Best regards,
>=20
> Pascal
>=20
> -----Message d'origine-----
> De=C2=A0: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]=20
> Envoy=C3=A9=C2=A0: vendredi 12 d=C3=A9cembre 2014 12:08
> =C3=80=C2=A0: zze-Open the box FIFRE P ext IMT/OLPS
> Cc=C2=A0: linux-can@vger.kernel.org
> Objet=C2=A0: Re: J1939 message length
>=20
> Hey Pascal,
>=20
> On Thu, Dec 11, 2014 at 10:44:39AM +0000, pascal wrote:
> > Hi,
> >=20
> > I've installed the patch for using j1939 socket CAN under linux=20
> > (beagleBone black).
> >=20
> > It works fine for receiving j1939 message and sending short message=
 (8=20
> > bytes max).
> >=20
> > But when I try to send long message (>8 bytes long), but the messag=
e=20
> > has not been sent.
>=20
> Ok.
> You provide little info how you detect that <=3D8 bytes work, and >8 =
bytes do not work.
>=20
> What do you see on the (raw) CAN bus?
>=20
> Are you aware of the Transport Protocol on J1939 that delivers messag=
es >8 bytes?
>=20
> Kurt
> >=20
> > I use the sendTo method to send frame.
> >=20
> > Do I have to do something special to send long message?
>=20
> no, not necessarily.
>=20
> > I'm working with a 3.8.13 kernel on beaglebone black.
>=20
> Kind regards,
> Kurt
>=20
> _____________________________________________________________________=
____________________________________________________
>=20
> Ce message et ses pieces jointes peuvent contenir des informations co=
nfidentielles ou privilegiees et ne doivent donc
> pas etre diffuses, exploites ou copies sans autorisation. Si vous ave=
z recu ce message par erreur, veuillez le signaler
> a l'expediteur et le detruire ainsi que les pieces jointes. Les messa=
ges electroniques etant susceptibles d'alteration,
> Orange decline toute responsabilite si ce message a ete altere, defor=
me ou falsifie. Merci.
>=20
> This message and its attachments may contain confidential or privileg=
ed information that may be protected by law;
> they should not be distributed, used or copied without authorisation.
> If you have received this email in error, please notify the sender an=
d delete this message and its attachments.
> As emails may be altered, Orange is not liable for messages that have=
 been modified, changed or falsified.
> Thank you.
>=20
