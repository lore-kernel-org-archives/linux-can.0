From: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
Subject: Re: J1939 message length
Date: Tue, 19 May 2015 23:01:31 +0200
Message-ID: <20150519210131.GC29137@vandijck-laurijssen.be>
References: <loom.20141211T112702-791@post.gmane.org>
 <20141212110743.GC10796@vandijck-laurijssen.be>
 <6726_1418633895_548EA2A7_6726_15776_1_F1366246CF364C42B98553900CE0C5CB07FE75B7@PEXCVZYM13.corporate.adroot.infra.ftgroup>
 <20141215093136.GA646@vandijck-laurijssen.be>
 <306_1430126538_553DFFCA_306_19026_1_F1366246CF364C42B98553900CE0C5CB0801EF73@PEXCVZYM11.corporate.adroot.infra.ftgroup>
 <20150519084626.GC1088@vandijck-laurijssen.be>
 <26458_1432042025_555B3A29_26458_297_2_F1366246CF364C42B98553900CE0C5CB08028AE4@PEXCVZYM11.corporate.adroot.infra.ftgroup>
 <CAA7hF3y7+j_TZ4nTak8t5Y4ejmE2fOFWxRBKJbrHLiFts_+8eg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from relaygateway02.edpnet.net ([212.71.1.211]:21407 "EHLO
	relaygateway02.edpnet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbbESWwg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 19 May 2015 18:52:36 -0400
Content-Disposition: inline
In-Reply-To: <CAA7hF3y7+j_TZ4nTak8t5Y4ejmE2fOFWxRBKJbrHLiFts_+8eg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: laurent vaudoit <laurent.vaudoit@gmail.com>
Cc: pfifre.ext@orange.com, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hey,

--- Original message ---
> Date: Tue, 19 May 2015 15:40:38 +0200
> From: laurent vaudoit <laurent.vaudoit@gmail.com>
> To: pfifre.ext@orange.com
> Cc: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
> 	"linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> Subject: Re: J1939 message length
>=20
> Hi Pascal,
>=20
> i think you're mentionning the bug i have seen a few time ago.
> the pgn request is allways sent with 8 bytes instead of only 3 bytes.

I think that now too.

> i think the padding should be done in the transport layer instead of =
in the
> main.c file.
> you can have a look at the beginning of this mail thread.

You could change the patch mentioned earlier as:

diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index 7edf843..1479de4 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -156,7 +156,9 @@ static int j1939_send_can(struct sk_buff *skb)
 		canid |=3D ((sk_addr->pgn & 0x3ffff) << 8);
=20
 	msg->can_id =3D canid;
+	if ((dlc < 8) && sk_addr->pgn !=3D 0x0ea00)) {
+		memset(msg->data+dlc, 0xff, 8 - dlc);
+		dlc =3D 8;
+	}
 	msg->can_dlc =3D dlc;
 =20
 	/* set net_device */
 	ret =3D -ENODEV;
=09

--
This should fix the request PGN bug.

Due to the interest, I just worked out a different patch
that _only_ pads transport protocol data frames.
This only solves problems when the receiver is intolerant
for transport protocol frames, and not for regular frames.

Note that it makes not real sense to apply both patches.

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 2b50902..187aaad 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -369,8 +369,9 @@ static int j1939tp_tx_dat(struct session *related,
 	/* fix pgn */
 	skb_cb->pgn =3D related->extd ? etp_pgn_dat : tp_pgn_dat;
=20
-	skdat =3D skb_put(skb, len);
+	skdat =3D skb_put(skb, 8);
 	memcpy(skdat, dat, len);
+	memset(skdat+len, 0xff, 8-len);
 	ret =3D j1939_send_normalized_pkt(skb);
 	if (ret < 0)
 		kfree_skb(skb);


Kind regards,
Kurt

>=20
> Regards
>=20
> Laurent
>=20
> On Tue, May 19, 2015 at 3:27 PM, <pfifre.ext@orange.com> wrote:
>=20
> > Thanks for your answer Kurt.
> >
> > Yes, I refer to "Request for address claimed" PGN, wich is normally=
 3
> > bytes.
> > When I send it with a length of 3, like jacd do, the request is sen=
t with
> > 8 bytes (the others are padded with 0xFF).
> > When I try with jacd, it sends the same frame.
> >
> > I think it's a bug, I'm right?
> > I think, that the driver doesn't analyse the PGN and pad the frame
> > systemically.
> >
> > I can't use the send function to send the frame, because I need to =
specify
> > the PGN in the address.
> >
> > Then one of devices on the bus doesn't answer to the request.
> >
> > Regards,
> >
> > Pascal
> >
> > -----Message d'origine-----
> > De : Kurt Van Dijck [mailto:dev.kurt@vandijck-laurijssen.be]
> > Envoy=C3=A9 : mardi 19 mai 2015 10:46
> > =C3=80 : zze-Open the box FIFRE P ext IMT/OLPS
> > Cc : linux-can@vger.kernel.org
> > Objet : Re: J1939 message length
> >
> > Hi Pascal,
> >
> > I apologise for the late answer.
> > Your email has slipped in without drawing my attention.
> >
> > Please find my answer below.
> >
> > --- Original message ---
> > > Date: Mon, 27 Apr 2015 09:22:17 +0000
> > > From: pfifre.ext@orange.com
> > > To: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
> > > CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
> > > Subject: RE: J1939 message length
> > >
> > > Hi Kurt,
> > >
> > > I have an issue on address claim.
> > >
> > > When I call the bind the claim address is send with a DLC of 8 an=
d 8
> > bytes sent on the CAN.
> > > But, according to the ISO11783, I need to send and address CLAIM =
by a 3
> > bytes frame.
> >
> > The "Address Claim" PGN (0x0ee00) is 8 bytes, even in iso11783.
> > I think you refer to the "Request for address claimed" PGN, which i=
s 3
> > bytes, with PGN 0x0ea00, and payload 00ee00.
> >
> > >
> > > How can, I do that with existing kernel J1939 stack or where I ca=
n
> > modify this?
> > You can just send a 3 byte message with send(SOCK, <DATA>, 3, 0)
> >
> > If you want to do the address claiming,
> > then you may take a look at jacd, a j1939 adddress claim daemon.
> > It does all the userspace handling necessary for address claiming.
> > You can find it at https://github.com/kurt-vd/can-utils.git, in j19=
39-v6
> > branch.
> >
> > Kind regards,
> > Kurt
> >
> >
> > ___________________________________________________________________=
______________________________________________________
> >
> > Ce message et ses pieces jointes peuvent contenir des informations
> > confidentielles ou privilegiees et ne doivent donc
> > pas etre diffuses, exploites ou copies sans autorisation. Si vous a=
vez
> > recu ce message par erreur, veuillez le signaler
> > a l'expediteur et le detruire ainsi que les pieces jointes. Les mes=
sages
> > electroniques etant susceptibles d'alteration,
> > Orange decline toute responsabilite si ce message a ete altere, def=
orme ou
> > falsifie. Merci.
> >
> > This message and its attachments may contain confidential or privil=
eged
> > information that may be protected by law;
> > they should not be distributed, used or copied without authorisatio=
n.
> > If you have received this email in error, please notify the sender =
and
> > delete this message and its attachments.
> > As emails may be altered, Orange is not liable for messages that ha=
ve been
> > modified, changed or falsified.
> > Thank you.
> >
> >
