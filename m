From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 + iMX6 + yocto
Date: Tue, 8 Sep 2015 09:58:00 +0200
Message-ID: <20150908075800.GA864@airbook.eia.lan>
References: <loom.20141211T112702-791@post.gmane.org>
 <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
 <20150519084626.GC1088@vandijck-laurijssen.be>
 <18596_1441369456_55E98D70_18596_3092_1_F1366246CF364C42B98553900CE0C5CB089DBAF9@OPEXCLILM23.corporate.adroot.infra.ftgroup>
 <36853685-8336-4C81-88CE-AE3CB1A36AFA@vandijck-laurijssen.be>
 <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway01.edpnet.net ([212.71.1.210]:46916 "EHLO
	relaygateway01.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753765AbbIHH6J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Sep 2015 03:58:09 -0400
Content-Disposition: inline
In-Reply-To: <12979_1441607513_55ED2F59_12979_6_1_F1366246CF364C42B98553900CE0C5CB089DBBE6@OPEXCLILM23.corporate.adroot.infra.ftgroup>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: pfifre.ext@orange.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Pascal,

I got back to my PC now.
I see how the j1939-v3.10 branch dissapeared. I had pushed it
to gitorious.org, which is obsolete now, thinking that I had pushed it
to github. I set that right just now.

> Which platform do you use?
We have a custom iMX6 platform (in-house developed), with the core
similar to sabre-lite from Boundary Devices (They have renamed that
board now). Our board has 2 SJA1000 chips added.

I also updated iproute2-j1939, to a version that is equal to what yocto
is using now. This was less effort than choosing a different version
of iproute2 in yocto (to me).

Kind regards,
Kurt

--- Original message ---
> Date:	Mon, 7 Sep 2015 06:31:47 +0000
> From: pfifre.ext@orange.com
> To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> Subject: RE: J1939 + iMX6 + yocto
>=20
> Hi Kurt,
>=20
> Glad to know that you already work on the same feature.
>=20
> Which platform do you use?
> I'm working now on the Digi ConnectCore 6.
>=20
> I'm wating on Tuesday to get your 3.10 branch and test it on my side.
>=20
> Thanks a lot for your help!
>=20
> Pascal
>=20
>=20
> -----Message d'origine-----
> De=C2=A0: Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]=20
> Envoy=C3=A9=C2=A0: lundi 7 septembre 2015 02:40
> =C3=80=C2=A0: FIFRE Pascal Ext IMT/OLPS
> Cc=C2=A0: linux-can@vger.kernel.org
> Objet=C2=A0: RE: J1939 + iMX6 + yocto
>=20
> Hi,
>=20
>=20
> On 4 September 2015 14:24:15 CEST, pfifre.ext@orange.com wrote:
> >Hi Kurt,
> >
> >I continue my works on J1939 on another platform (based on IMX6 and=20
> >Yocto).
>=20
> I'm currently using the same iMX6 with yocto.=20
>=20
> >
> >I try now to patch the Yocto Kernel to embed your J1939 stack.
> >But, this yocto kernel is based on 3.10-r0 and the nearest version o=
f=20
> >your git is for 3.8 or for 3.12-rc1 kernels.
> >
> >I tried to patch with the git J1939-v3.8 and lot of conflicts appear=
s=20
> >during merge.
> >I think I will have the same issues with 3.12-rc1.
> >
> You need first to rebase the j1939 branch onto 3.10, or else you merg=
e everything including 3.12.
>=20
> >I suppose that modifications of the kernel are limited to can stack =
and=20
> >can drivers. I'm right?
>=20
> Can stack only, no drivers.
>=20
> >Can I patch my kernel manualy with the specific J1939 sources and ad=
apt=20
> >their structures to my kernel version?
>=20
> You should merge using git and resolve merge conflicts on the way.
> I cannot tell from my current position which branch to start best wit=
h.
> Or you could wait until Tuesday, then I can push a my 3.10 branch. I'=
ve gone through the merge conflicts already...
>=20
> >
> >What do you think about that?
> >
> >Best regards,
> >
> >Pascal
> >
>=20
> Sent from a small mobile device
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
