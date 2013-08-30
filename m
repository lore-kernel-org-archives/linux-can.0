From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Fri, 30 Aug 2013 19:57:58 +0200
Message-ID: <20130830175758.GA571@vandijck-laurijssen.be>
References: <20130829195631.GB538@vandijck-laurijssen.be>
 <zarafa.522065ba.471f.174f0b440938c779@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay003.isp.belgacom.be ([195.238.6.53]:40472 "EHLO
	mailrelay003.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756540Ab3H3R6F convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Fri, 30 Aug 2013 13:58:05 -0400
Content-Disposition: inline
In-Reply-To: <zarafa.522065ba.471f.174f0b440938c779@v14647.1blu.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Michael Luxen <mluxen@gmx.net>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On Fri, Aug 30, 2013 at 11:28:26AM +0200, Michael Luxen wrote:
> Hello Kurt,
>=20
> > > 2. I was figuring with "jspy can0:DM1,0feca" which doesn't work a=
s it must be=20
> > the CAN-ID like above. Are there plans to implement something like =
a lookup=20
> > table which shows the J1939 PGN-Name directly depending on the PGN =
(i.e. DM1=20
> > instead of FECA) in "jspy" which are specified in the J1939 standar=
d?
> > I believe you meant: $ jspy can0:00000000e8a9344c,DM1
> > The middle member is the nodename. You could wildcard that...
> > The last is the PGN (~=3D CAN-id).
> Good hint!
> =20
> > I like the idea. I've never even tought about this.
> > It belongs in a userspace library.
> Please let me know if you have it ready, so I can update to your late=
st version. ;-)

Yep. It may take a bit.

> =20
> > > 3. What is the normal way to setup the bitrate and the j1939 inte=
rface in one=20
> > step?=20
> > > "ip link set can0 type can bitrate 500000" works to set up standa=
rd CAN=20
> > interface but "ip link set can0 type j1939 on bitrate 250000" doesn=
't work=20
> > (Garbage instead of arguments "bitrate ...". Try "ip link help".)
> > > I've set up the bitrate first with "ip link set can0 type can bit=
rate 250000"=20
> > and then "ip link set can0 j1939 on"
> >=20
> > I did my best not to duplicate functionality.
> > $ ip link set can0 j1939 on type can bitrate 250000
> > would work.
> In general yes, but if I do:
> $ ip link set can0 j1939 on type can bitrate 250000
> $ ip link set can0 up
> RTNETLINK answers: Invalid argument
>=20
> I can't set up the can0 interface with J1939 support=20
>=20
> And if I try to do it afterwards like:
> $ ip link set can0 down
> $ ip link set can0 type can bitrate 250000
> $ ip link set can0 j1939 on
> RTNETLINK answers: Address family not supported by protocol
>=20
> After power reset;
> $ ip link set can0 j1939 on type can bitrate 250000
> $ ip link set can0 type can bitrate 250000
> $ ip link set can0 up
> $ jspy can0
> jspy: bind(can0): Host is down
>=20
>=20
> Setting up of the can0 doesn't work correctly IMHO, the only way whic=
h is working for me is after a power reset:
> $ ip link set can0 j1939 on type can bitrate 250000
> $ ip link set can0 type can bitrate 250000
> $ ip link set can0 j1939 on up
> $ jspy can0:00000000e8a9344c,0feca
>  can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
>  can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
>  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
>  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
>  can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
>=20
> Is there anything I do in the wrong way?

Nop. I get the same here. It have worked for a long time, but not today=
=2E
You probably don't do something wrong, but have something changed somew=
here
that my j1939 stack depends on.

I have a 3.8.2.

I'll take a look one of these days.

Kurt
>=20
> Regards
> Mike
>=20
> > > -----Urspr=C3=BCngliche Nachricht-----
> > > Von:	Kurt Van Dijck <kurt.van.dijck@eia.be>
> > > Gesendet:	Di 27.08.2013 23:11
> > > Betreff:	Re: Reading messages that use BAM, or have a DLC larger =
than 8
> > > An:	Brent Sink <Brent.Sink@we-ics.com>;=20
> > > CC:	Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel=
=2Eorg; John=20
> > Boyd (jaboydjr77@gmail.com) <jaboydjr77@gmail.com>;=20
> > > > Hi Brent,
> > > >=20
> > > > > I received that error when I was trying to manually send a me=
ssage in=20
> > PEAK=20
> > > > Explorer with a DLC of 9.
> > > > I see. You should respect a inter-frame delay of 50msec (up to =
250msec or=20
> > so),
> > > > which is practically impossible to perform manually.
> > > >=20
> > > > > When I connect my device to an actual CAN bus that is transmi=
tting a DM1=20
> > > > message with a DLC of 34, I do not see the message using candum=
p.
> > > > > However, I don't see the timeout error anymore, so that's a p=
lus.
> > > >=20
> > > > The actual DM1 message respects the timings. That's good.
> > > >=20
> > > > > Is there something specific I need to do in order to receive =
messages=20
> > that=20
> > > > use BAM?
> > > > Try the jspy program in can-j1939-utils.
> > > > candump does/should show the 6 raw can frames, jspy should show=
 the 1 j1939=20
> > > > packet.
> > > >=20
> > > > Kind regards,
> > > > Kurt
> > > >=20
> > > > On Tue, Aug 27, 2013 at 02:17:08PM -0400, Brent Sink wrote:
> > > > > Kurt,
> > > > >=20
> > > > > Ok, maybe I'm missing something.=20
> > > > > I received that error when I was trying to manually send a me=
ssage in=20
> > PEAK=20
> > > > Explorer with a DLC of 9.
> > > > > When I connect my device to an actual CAN bus that is transmi=
tting a DM1=20
> > > > message with a DLC of 34, I do not see the message using candum=
p.
> > > > > However, I don't see the timeout error anymore, so that's a p=
lus.
> > > > > Is there something specific I need to do in order to receive =
messages=20
> > that=20
> > > > use BAM?
> > > > >=20
> > > > > -brent
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]=20
> > > > > Sent: Tuesday, August 27, 2013 2:54 AM
> > > > > To: Brent Sink
> > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> > > > (jaboydjr77@gmail.com)
> > > > > Subject: Re: Reading messages that use BAM, or have a DLC lar=
ger than 8
> > > > >=20
> > > > > Hi Brent,
> > > > >=20
> > > > > j1939tp_rxtask: timeout on 2
> > > > >=20
> > > > > It looks like you got everything up and running then!
> > > > >=20
> > > > > The message indicates a protocol fault of the sender.
> > > > > The remote is sending too slow.
> > > > > You can debug such things with candump, and inspect timestamp=
s.
> > > > > But there is nothing you can do on the receiving side to fix =
protocol=20
> > faults.
> > > > >=20
> > > > > Kind regards,
> > > > > Kurt
> > > > >=20
> > > > > On Mon, Aug 26, 2013 at 04:00:50PM -0400, Brent Sink wrote:
> > > > > > Kurt,
> > > > > >=20
> > > > > > Ok, so I have managed to get your version of ip and candump=
 working and=20
> > > > have the kernel built with the j1939 options.  Calling "ip link=
 set can0=20
> > j1939=20
> > > > on" works just fine, but I'm seeing an issue when trying to rea=
d the DM1=20
> > > > message using candump.  I seem to be getting a timeout error:=20
> > j1939tp_rxtask:=20
> > > > timeout on 2.
> > > > > >=20
> > > > > > Any thoughts?
> > > > > >=20
> > > > > > -brent
> > > > > >=20
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > Sent: Thursday, August 22, 2013 1:56 PM
> > > > > > To: Brent Sink
> > > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=
=20
> > > > > > (jaboydjr77@gmail.com)
> > > > > > Subject: Re: Reading messages that use BAM, or have a DLC l=
arger than=20
> > > > > > 8
> > > > > >=20
> > > > > > Brent,
> > > > > >=20
> > > > > > > # ip link set can0 j1939 on                              =
     =20
> > > > > > > Error: either "dev" is duplicate, or "j1939" is a garbage=
=2E
> > > > > >=20
> > > > > > You will want the j1939 branch of can-utils, and absolutely=
 _need_ the=20
> > > > j1939 branch of iproute2.
> > > > > > The message you got is generated by iproute2 ...
> > > > > >=20
> > > > > > Sorry for the inconvenience.
> > > > > > I must apologize for my limited availability nowadays.
> > > > > > I'm pretty occupied with other things.
> > > > > >=20
> > > > > > Kurt
> > > > > >=20
> > > > > > On Thu, Aug 22, 2013 at 12:24:15PM -0400, Brent Sink wrote:
> > > > > > > Ok, so merged this into my 3.8 branch and built the kerne=
l.  Calling=20
> > "ip=20
> > > > link set can0 j1939 on" results in the error seen below.  I'm g=
uessing I=20
> > need=20
> > > > to build the can-utils=20
> > > > (git://gitorious.org/~kurt-vd/linux-can/can-j1939-utils.git)...=
 right? =20
> > > > Anything else that I may need to do?
> > > > > > >=20
> > > > > > > # ip link set can0 j1939 on                              =
     =20
> > > > > > > Error: either "dev" is duplicate, or "j1939" is a garbage=
=2E
> > > > > > >=20
> > > > > > > -brent
> > > > > > >=20
> > > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > > Sent: Thursday, August 22, 2013 10:39 AM
> > > > > > > To: Brent Sink
> > > > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org
> > > > > > > Subject: Re: Reading messages that use BAM, or have a DLC=
 larger=20
> > > > > > > than
> > > > > > > 8
> > > > > > >=20
> > > > > > > Brent,
> > > > > > >=20
> > > > > > > in your linux git repository, do:
> > > > > > > $ git remote add j1939
> > > > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.gi=
t
> > > > > > > $ git remote update j1939
> > > > > > > $ git merge j1939/v3.6 (or any branch that suits best you=
r kernel).
> > > > > > >=20
> > > > > > > This won't take as long as cloning the entire repository,=
 if you are=20
> > > > already working in a git repo.
> > > > > > >=20
> > > > > > > Kurt
> > > > > > >=20
> > > > > > >=20
> > > > > > > On Thu, Aug 22, 2013 at 10:22:31AM -0400, Brent Sink wrot=
e:
> > > > > > > > Thanks Kurt.  Do I really need to clone the entire repo=
sitory, or=20
> > > > > > > > can you point me to the files I need to rebuild the can=
-utils?  Is=20
> > > > > > > > there a patch that I could apply to my current kernel b=
uild?
> > > > > > > > Thanks,
> > > > > > > >=20
> > > > > > > > -brent
> > > > > > > >=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > > > Sent: Thursday, August 22, 2013 3:56 AM
> > > > > > > > To: Marc Kleine-Budde
> > > > > > > > Cc: Brent Sink; linux-can@vger.kernel.org
> > > > > > > > Subject: Re: Reading messages that use BAM, or have a D=
LC larger=20
> > > > > > > > than
> > > > > > > > 8
> > > > > > > >=20
> > > > > > > > Hi,
> > > > > > > >=20
> > > > > > > > I have a git repository on
> > > > > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.=
git
> > > > > > > >=20
> > > > > > > > I added a complete j1939 stack, including 'BAM'.
> > > > > > > >=20
> > > > > > > > You will need the associated can-utils with j1939 suppo=
rt to=20
> > activate=20
> > > > the j1939 processing for a specific CAN device:
> > > > > > > > $ ip link set can0 j1939 on
> > > > > > > >=20
> > > > > > > > If you only need to receive j1939 packets, then that's =
all you need=20
> > to=20
> > > > do.
> > > > > > > >=20
> > > > > > > > The associated can-utils provide some example programs.=
 You will=20
> > need=20
> > > > to take a look as the API for j1939 sockets is different than f=
or raw CAN.
> > > > > > > >=20
> > > > > > > > Kind regards,
> > > > > > > > Kurt
> > > > > > > >=20
> > > > > > > > On Wed, Aug 21, 2013 at 10:19:22PM +0200, Marc Kleine-B=
udde wrote:
> > > > > > > > > On 08/21/2013 08:43 PM, Brent Sink wrote:
> > > > > > > > > > How do I read J1939 messages that use the BAM forma=
t?  Some of=20
> > > > > > > > > > the diagnostic messages that are on the DM01 messag=
e have a=20
> > > > > > > > > > DLC that is often larger than 8 bytes when the mess=
age=20
> > > > > > > > > > contains more than one error.  Is there something s=
pecial that=20
> > > > > > > > > > I need to do to enable reading these messages?  Tha=
nks!
> > > > > > > > >
> > > > > > > > > With mainline linux you just receive raw CAN frames. =
I'm not a
> > > > > > > > > j1939 expert, as far as I can see, BAM is a transport=
 protocol=20
> > for=20
> > > > CAN.
> > > > > > > > >
> > > > > > > > > There are two options:
> > > > > > > > > 1) You have to implement the BAM protocol yourself ei=
ther,
> > > > > > > > >    a) inside the kernel or
> > > > > > > > >    b) inside userspace.
> > > > > > > > > 2) Talk to Kurt (Cc'ed) if his j1939 patches support =
BAM.
> > > > > > > > >
> > > > > > > > > Marc
> > > > > > > > > --
> > > > > > > > > Pengutronix e.K.                  | Marc Kleine-Budde=
           |
> > > > > > > > > Industrial Linux Solutions        | Phone: +49-231-28=
26-924     |
> > > > > > > > > Vertretung West/Dortmund          | Fax:   +49-5121-2=
06917-5555 |
> > > > > > > > > Amtsgericht Hildesheim, HRA 2686  | http://www.pengut=
ronix.de   |
> > > > > > > > >
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > --
> > > > > > > > Kurt Van Dijck
> > > > > > > > GRAMMER EiA ELECTRONICS
> > > > > > > > http://www.eia.be
> > > > > > > > kurt.van.dijck@eia.be
> > > > > > > > +32-38708534
> > > > > > > >=20
> > > > > > > > The information contained in this message may be privil=
eged and=20
> > > > confidential and protected from disclosure. If the reader of th=
is message=20
> > is=20
> > > > not the intended recipient, or an employee or agent responsible=
 for=20
> > delivering=20
> > > > this message to the intended recipient, you are hereby notified=
 that any=20
> > > > dissemination, distribution or copying of this communication is=
 strictly=20
> > > > prohibited. If you have received this communication in error, p=
lease notify=20
> > us=20
> > > > immediately by replying to the message and deleting it from you=
r computer.=20
> > > > Internet communications are not assured to be secure or clear o=
f=20
> > inaccuracies=20
> > > > as information could be intercepted, corrupted, lost, destroyed=
, arrive=20
> > late or=20
> > > > incomplete, or contain viruses. Therefore, we do not accept res=
ponsibility=20
> > for=20
> > > > any errors or omissions that are present in this email, or any =
attachment,=20
> > that=20
> > > > have arisen as a result of e-mail transmission.
> > > > > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r =
  z   h    &   G   h (
> > > > > > > >  =E9=9A=8E =DD=A2j"   m     z =DE=96   f   h   ~ m=20
> > > > > > >=20
> > > > > > > --
> > > > > > > Kurt Van Dijck
> > > > > > > GRAMMER EiA ELECTRONICS
> > > > > > > http://www.eia.be
> > > > > > > kurt.van.dijck@eia.be
> > > > > > > +32-38708534
> > > > > > >   =EC=B9=BB & ~ &   +-  =DD=B6  w  =CB=9B   m b  \jx    =DC=
=A8}   =C6=A0z &j:+v   =20
> > > > > > >     zZ+  +zf   h   ~    i   z  w   ?    & )=DF=A2f
> > > > > >=20
> > > > > > --
> > > > > > Kurt Van Dijck
> > > > > > GRAMMER EiA ELECTRONICS
> > > > > > http://www.eia.be
> > > > > > kurt.van.dijck@eia.be
> > > > > > +32-38708534
> > > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   z =
  h    &   G   h (
> > > > > >  =E9=9A=8E =DD=A2j"   m     z =DE=96   f   h   ~ m=20
> > > > >=20
> > > > > --
> > > > > Kurt Van Dijck
> > > > > GRAMMER EiA ELECTRONICS
> > > > > http://www.eia.be
> > > > > kurt.van.dijck@eia.be
> > > > > +32-38708534
> > > >=20
> > > > --=20
> > > > Kurt Van Dijck
> > > > GRAMMER EiA ELECTRONICS
> > > > http://www.eia.be
> > > > kurt.van.dijck@eia.be
> > > > +32-38708534
> > > > --
> > > > To unsubscribe from this list: send the line "unsubscribe linux=
-can" in
> > > > the body of a message to majordomo@vger.kernel.org
> > > > More majordomo info at  http://vger.kernel.org/majordomo-info.h=
tml
> > > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> >=20
> > --=20
> > Kurt Van Dijck
> > GRAMMER EiA ELECTRONICS
> > http://www.eia.be
> > kurt.van.dijck@eia.be
> > +32-38708534
> >

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
