From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Reading messages that use BAM, or have a DLC larger than 8
Date: Fri, 30 Aug 2013 11:28:26 +0200
Message-ID: <zarafa.522065ba.471f.174f0b440938c779@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:53372 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753577Ab3H3J23 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 30 Aug 2013 05:28:29 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Kurt_Van_Dijck?= <kurt.van.dijck@eia.be>
Cc: =?utf-8?Q?Marc_Kleine-Budde?= <mkl@pengutronix.de>, =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?John_Boyd_=28jaboydjr77=40gmail=2Ecom=29?= <jaboydjr77@gmail.com>, =?utf-8?Q?Brent_Sink?= <brent.sink@we-ics.com>

Hello Kurt,

> > 2. I was figuring with "jspy can0:DM1,0feca" which doesn't work as =
it must be=20
> the CAN-ID like above. Are there plans to implement something like a =
lookup=20
> table which shows the J1939 PGN-Name directly depending on the PGN (i=
=2Ee. DM1=20
> instead of FECA) in "jspy" which are specified in the J1939 standard?
> I believe you meant: $ jspy can0:00000000e8a9344c,DM1
> The middle member is the nodename. You could wildcard that...
> The last is the PGN (~=3D CAN-id).
Good hint!
=20
> I like the idea. I've never even tought about this.
> It belongs in a userspace library.
Please let me know if you have it ready, so I can update to your latest=
 version. ;-)
=20
> > 3. What is the normal way to setup the bitrate and the j1939 interf=
ace in one=20
> step?=20
> > "ip link set can0 type can bitrate 500000" works to set up standard=
 CAN=20
> interface but "ip link set can0 type j1939 on bitrate 250000" doesn't=
 work=20
> (Garbage instead of arguments "bitrate ...". Try "ip link help".)
> > I've set up the bitrate first with "ip link set can0 type can bitra=
te 250000"=20
> and then "ip link set can0 j1939 on"
>=20
> I did my best not to duplicate functionality.
> $ ip link set can0 j1939 on type can bitrate 250000
> would work.
In general yes, but if I do:
$ ip link set can0 j1939 on type can bitrate 250000
$ ip link set can0 up
RTNETLINK answers: Invalid argument

I can't set up the can0 interface with J1939 support=20

And if I try to do it afterwards like:
$ ip link set can0 down
$ ip link set can0 type can bitrate 250000
$ ip link set can0 j1939 on
RTNETLINK answers: Address family not supported by protocol

After power reset;
$ ip link set can0 j1939 on type can bitrate 250000
$ ip link set can0 type can bitrate 250000
$ ip link set can0 up
$ jspy can0
jspy: bind(can0): Host is down


Setting up of the can0 doesn't work correctly IMHO, the only way which =
is working for me is after a power reset:
$ ip link set can0 j1939 on type can bitrate 250000
$ ip link set can0 type can bitrate 250000
$ ip link set can0 j1939 on up
$ jspy can0:00000000e8a9344c,0feca
 can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
 can0:00000000e8a9344c,0feca - !6 [8] 00ff0000 0000ffff
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01

Is there anything I do in the wrong way?

Regards
Mike

> > -----Urspr=C3=BCngliche Nachricht-----
> > Von:	Kurt Van Dijck <kurt.van.dijck@eia.be>
> > Gesendet:	Di 27.08.2013 23:11
> > Betreff:	Re: Reading messages that use BAM, or have a DLC larger th=
an 8
> > An:	Brent Sink <Brent.Sink@we-ics.com>;=20
> > CC:	Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.o=
rg; John=20
> Boyd (jaboydjr77@gmail.com) <jaboydjr77@gmail.com>;=20
> > > Hi Brent,
> > >=20
> > > > I received that error when I was trying to manually send a mess=
age in=20
> PEAK=20
> > > Explorer with a DLC of 9.
> > > I see. You should respect a inter-frame delay of 50msec (up to 25=
0msec or=20
> so),
> > > which is practically impossible to perform manually.
> > >=20
> > > > When I connect my device to an actual CAN bus that is transmitt=
ing a DM1=20
> > > message with a DLC of 34, I do not see the message using candump.
> > > > However, I don't see the timeout error anymore, so that's a plu=
s.
> > >=20
> > > The actual DM1 message respects the timings. That's good.
> > >=20
> > > > Is there something specific I need to do in order to receive me=
ssages=20
> that=20
> > > use BAM?
> > > Try the jspy program in can-j1939-utils.
> > > candump does/should show the 6 raw can frames, jspy should show t=
he 1 j1939=20
> > > packet.
> > >=20
> > > Kind regards,
> > > Kurt
> > >=20
> > > On Tue, Aug 27, 2013 at 02:17:08PM -0400, Brent Sink wrote:
> > > > Kurt,
> > > >=20
> > > > Ok, maybe I'm missing something.=20
> > > > I received that error when I was trying to manually send a mess=
age in=20
> PEAK=20
> > > Explorer with a DLC of 9.
> > > > When I connect my device to an actual CAN bus that is transmitt=
ing a DM1=20
> > > message with a DLC of 34, I do not see the message using candump.
> > > > However, I don't see the timeout error anymore, so that's a plu=
s.
> > > > Is there something specific I need to do in order to receive me=
ssages=20
> that=20
> > > use BAM?
> > > >=20
> > > > -brent
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]=20
> > > > Sent: Tuesday, August 27, 2013 2:54 AM
> > > > To: Brent Sink
> > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> > > (jaboydjr77@gmail.com)
> > > > Subject: Re: Reading messages that use BAM, or have a DLC large=
r than 8
> > > >=20
> > > > Hi Brent,
> > > >=20
> > > > j1939tp_rxtask: timeout on 2
> > > >=20
> > > > It looks like you got everything up and running then!
> > > >=20
> > > > The message indicates a protocol fault of the sender.
> > > > The remote is sending too slow.
> > > > You can debug such things with candump, and inspect timestamps.
> > > > But there is nothing you can do on the receiving side to fix pr=
otocol=20
> faults.
> > > >=20
> > > > Kind regards,
> > > > Kurt
> > > >=20
> > > > On Mon, Aug 26, 2013 at 04:00:50PM -0400, Brent Sink wrote:
> > > > > Kurt,
> > > > >=20
> > > > > Ok, so I have managed to get your version of ip and candump w=
orking and=20
> > > have the kernel built with the j1939 options.  Calling "ip link s=
et can0=20
> j1939=20
> > > on" works just fine, but I'm seeing an issue when trying to read =
the DM1=20
> > > message using candump.  I seem to be getting a timeout error:=20
> j1939tp_rxtask:=20
> > > timeout on 2.
> > > > >=20
> > > > > Any thoughts?
> > > > >=20
> > > > > -brent
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > Sent: Thursday, August 22, 2013 1:56 PM
> > > > > To: Brent Sink
> > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> > > > > (jaboydjr77@gmail.com)
> > > > > Subject: Re: Reading messages that use BAM, or have a DLC lar=
ger than=20
> > > > > 8
> > > > >=20
> > > > > Brent,
> > > > >=20
> > > > > > # ip link set can0 j1939 on                                =
   =20
> > > > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > > > >=20
> > > > > You will want the j1939 branch of can-utils, and absolutely _=
need_ the=20
> > > j1939 branch of iproute2.
> > > > > The message you got is generated by iproute2 ...
> > > > >=20
> > > > > Sorry for the inconvenience.
> > > > > I must apologize for my limited availability nowadays.
> > > > > I'm pretty occupied with other things.
> > > > >=20
> > > > > Kurt
> > > > >=20
> > > > > On Thu, Aug 22, 2013 at 12:24:15PM -0400, Brent Sink wrote:
> > > > > > Ok, so merged this into my 3.8 branch and built the kernel.=
  Calling=20
> "ip=20
> > > link set can0 j1939 on" results in the error seen below.  I'm gue=
ssing I=20
> need=20
> > > to build the can-utils=20
> > > (git://gitorious.org/~kurt-vd/linux-can/can-j1939-utils.git)... r=
ight? =20
> > > Anything else that I may need to do?
> > > > > >=20
> > > > > > # ip link set can0 j1939 on                                =
   =20
> > > > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > > > > >=20
> > > > > > -brent
> > > > > >=20
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > Sent: Thursday, August 22, 2013 10:39 AM
> > > > > > To: Brent Sink
> > > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org
> > > > > > Subject: Re: Reading messages that use BAM, or have a DLC l=
arger=20
> > > > > > than
> > > > > > 8
> > > > > >=20
> > > > > > Brent,
> > > > > >=20
> > > > > > in your linux git repository, do:
> > > > > > $ git remote add j1939
> > > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git
> > > > > > $ git remote update j1939
> > > > > > $ git merge j1939/v3.6 (or any branch that suits best your =
kernel).
> > > > > >=20
> > > > > > This won't take as long as cloning the entire repository, i=
f you are=20
> > > already working in a git repo.
> > > > > >=20
> > > > > > Kurt
> > > > > >=20
> > > > > >=20
> > > > > > On Thu, Aug 22, 2013 at 10:22:31AM -0400, Brent Sink wrote:
> > > > > > > Thanks Kurt.  Do I really need to clone the entire reposi=
tory, or=20
> > > > > > > can you point me to the files I need to rebuild the can-u=
tils?  Is=20
> > > > > > > there a patch that I could apply to my current kernel bui=
ld?
> > > > > > > Thanks,
> > > > > > >=20
> > > > > > > -brent
> > > > > > >=20
> > > > > > > -----Original Message-----
> > > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > > Sent: Thursday, August 22, 2013 3:56 AM
> > > > > > > To: Marc Kleine-Budde
> > > > > > > Cc: Brent Sink; linux-can@vger.kernel.org
> > > > > > > Subject: Re: Reading messages that use BAM, or have a DLC=
 larger=20
> > > > > > > than
> > > > > > > 8
> > > > > > >=20
> > > > > > > Hi,
> > > > > > >=20
> > > > > > > I have a git repository on
> > > > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.gi=
t
> > > > > > >=20
> > > > > > > I added a complete j1939 stack, including 'BAM'.
> > > > > > >=20
> > > > > > > You will need the associated can-utils with j1939 support=
 to=20
> activate=20
> > > the j1939 processing for a specific CAN device:
> > > > > > > $ ip link set can0 j1939 on
> > > > > > >=20
> > > > > > > If you only need to receive j1939 packets, then that's al=
l you need=20
> to=20
> > > do.
> > > > > > >=20
> > > > > > > The associated can-utils provide some example programs. Y=
ou will=20
> need=20
> > > to take a look as the API for j1939 sockets is different than for=
 raw CAN.
> > > > > > >=20
> > > > > > > Kind regards,
> > > > > > > Kurt
> > > > > > >=20
> > > > > > > On Wed, Aug 21, 2013 at 10:19:22PM +0200, Marc Kleine-Bud=
de wrote:
> > > > > > > > On 08/21/2013 08:43 PM, Brent Sink wrote:
> > > > > > > > > How do I read J1939 messages that use the BAM format?=
  Some of=20
> > > > > > > > > the diagnostic messages that are on the DM01 message =
have a=20
> > > > > > > > > DLC that is often larger than 8 bytes when the messag=
e=20
> > > > > > > > > contains more than one error.  Is there something spe=
cial that=20
> > > > > > > > > I need to do to enable reading these messages?  Thank=
s!
> > > > > > > >
> > > > > > > > With mainline linux you just receive raw CAN frames. I'=
m not a
> > > > > > > > j1939 expert, as far as I can see, BAM is a transport p=
rotocol=20
> for=20
> > > CAN.
> > > > > > > >
> > > > > > > > There are two options:
> > > > > > > > 1) You have to implement the BAM protocol yourself eith=
er,
> > > > > > > >    a) inside the kernel or
> > > > > > > >    b) inside userspace.
> > > > > > > > 2) Talk to Kurt (Cc'ed) if his j1939 patches support BA=
M.
> > > > > > > >
> > > > > > > > Marc
> > > > > > > > --
> > > > > > > > Pengutronix e.K.                  | Marc Kleine-Budde  =
         |
> > > > > > > > Industrial Linux Solutions        | Phone: +49-231-2826=
-924     |
> > > > > > > > Vertretung West/Dortmund          | Fax:   +49-5121-206=
917-5555 |
> > > > > > > > Amtsgericht Hildesheim, HRA 2686  | http://www.pengutro=
nix.de   |
> > > > > > > >
> > > > > > >=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > --
> > > > > > > Kurt Van Dijck
> > > > > > > GRAMMER EiA ELECTRONICS
> > > > > > > http://www.eia.be
> > > > > > > kurt.van.dijck@eia.be
> > > > > > > +32-38708534
> > > > > > >=20
> > > > > > > The information contained in this message may be privileg=
ed and=20
> > > confidential and protected from disclosure. If the reader of this=
 message=20
> is=20
> > > not the intended recipient, or an employee or agent responsible f=
or=20
> delivering=20
> > > this message to the intended recipient, you are hereby notified t=
hat any=20
> > > dissemination, distribution or copying of this communication is s=
trictly=20
> > > prohibited. If you have received this communication in error, ple=
ase notify=20
> us=20
> > > immediately by replying to the message and deleting it from your =
computer.=20
> > > Internet communications are not assured to be secure or clear of=20
> inaccuracies=20
> > > as information could be intercepted, corrupted, lost, destroyed, =
arrive=20
> late or=20
> > > incomplete, or contain viruses. Therefore, we do not accept respo=
nsibility=20
> for=20
> > > any errors or omissions that are present in this email, or any at=
tachment,=20
> that=20
> > > have arisen as a result of e-mail transmission.
> > > > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   =
z   h    &   G   h (
> > > > > > >  =E9=9A=8E =DD=A2j"   m     z =DE=96   f   h   ~ m=20
> > > > > >=20
> > > > > > --
> > > > > > Kurt Van Dijck
> > > > > > GRAMMER EiA ELECTRONICS
> > > > > > http://www.eia.be
> > > > > > kurt.van.dijck@eia.be
> > > > > > +32-38708534
> > > > > >   =EC=B9=BB & ~ &   +-  =DD=B6  w  =CB=9B   m b  \jx    =DC=
=A8}   =C6=A0z &j:+v   =20
> > > > > >     zZ+  +zf   h   ~    i   z  w   ?    & )=DF=A2f
> > > > >=20
> > > > > --
> > > > > Kurt Van Dijck
> > > > > GRAMMER EiA ELECTRONICS
> > > > > http://www.eia.be
> > > > > kurt.van.dijck@eia.be
> > > > > +32-38708534
> > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   z   =
h    &   G   h (
> > > > >  =E9=9A=8E =DD=A2j"   m     z =DE=96   f   h   ~ m=20
> > > >=20
> > > > --
> > > > Kurt Van Dijck
> > > > GRAMMER EiA ELECTRONICS
> > > > http://www.eia.be
> > > > kurt.van.dijck@eia.be
> > > > +32-38708534
> > >=20
> > > --=20
> > > Kurt Van Dijck
> > > GRAMMER EiA ELECTRONICS
> > > http://www.eia.be
> > > kurt.van.dijck@eia.be
> > > +32-38708534
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-c=
an" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
> > >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> Kurt Van Dijck
> GRAMMER EiA ELECTRONICS
> http://www.eia.be
> kurt.van.dijck@eia.be
> +32-38708534
>
