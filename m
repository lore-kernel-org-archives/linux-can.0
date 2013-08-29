From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: Reading messages that use BAM, or have a DLC larger than 8
Date: Thu, 29 Aug 2013 17:02:58 +0200
Message-ID: <zarafa.521f62a2.71cb.78ab067b096d4b28@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:36272 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755076Ab3H2PDA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 29 Aug 2013 11:03:00 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?Brent_Sink?= <brent.sink@we-ics.com>, =?utf-8?Q?Kurt_Van_Dijck?= <kurt.van.dijck@eia.be>
Cc: =?utf-8?Q?John_Boyd_=28jaboydjr77=40gmail=2Ecom=29?= <jaboydjr77@gmail.com>, =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?Marc_Kleine-Budde?= <mkl@pengutronix.de>

Hello Kurt,

depending on your hints how to get J1939 protocol support to my kernel =
(v3.8 on BeagleBone Black) I was able to receive and see/log the J1939 =
messages today.

=46or DM1 it looks like:
root@arm:/home/debian# jspy can0:00000000e8a9344c,0feca
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01
 can0:00000000e8a9344c,0feca - !7 [10] 40ff6e00 0b015f04 0b01


Some questions for J1939 suppor ton Linux is open for me:
1. Which userspace programs are already available? Do you know some Ope=
nSource projects with or without GUI beside jspy?
2. I was figuring with "jspy can0:DM1,0feca" which doesn't work as it m=
ust be the CAN-ID like above. Are there plans to implement something li=
ke a lookup table which shows the J1939 PGN-Name directly depending on =
the PGN (i.e. DM1 instead of FECA) in "jspy" which are specified in the=
 J1939 standard?
3. What is the normal way to setup the bitrate and the j1939 interface =
in one step?=20
"ip link set can0 type can bitrate 500000" works to set up standard CAN=
 interface but "ip link set can0 type j1939 on bitrate 250000" doesn't =
work (Garbage instead of arguments "bitrate ...". Try "ip link help".)
I've set up the bitrate first with "ip link set can0 type can bitrate 2=
50000" and then "ip link set can0 j1939 on"


Regards
Mike

-----Urspr=C3=BCngliche Nachricht-----
Von:	Kurt Van Dijck <kurt.van.dijck@eia.be>
Gesendet:	Di 27.08.2013 23:11
Betreff:	Re: Reading messages that use BAM, or have a DLC larger than 8
An:	Brent Sink <Brent.Sink@we-ics.com>;=20
CC:	Marc Kleine-Budde <mkl@pengutronix.de>; linux-can@vger.kernel.org; =
John Boyd (jaboydjr77@gmail.com) <jaboydjr77@gmail.com>;=20
> Hi Brent,
>=20
> > I received that error when I was trying to manually send a message =
in PEAK=20
> Explorer with a DLC of 9.
> I see. You should respect a inter-frame delay of 50msec (up to 250mse=
c or so),
> which is practically impossible to perform manually.
>=20
> > When I connect my device to an actual CAN bus that is transmitting =
a DM1=20
> message with a DLC of 34, I do not see the message using candump.
> > However, I don't see the timeout error anymore, so that's a plus.
>=20
> The actual DM1 message respects the timings. That's good.
>=20
> > Is there something specific I need to do in order to receive messag=
es that=20
> use BAM?
> Try the jspy program in can-j1939-utils.
> candump does/should show the 6 raw can frames, jspy should show the 1=
 j1939=20
> packet.
>=20
> Kind regards,
> Kurt
>=20
> On Tue, Aug 27, 2013 at 02:17:08PM -0400, Brent Sink wrote:
> > Kurt,
> >=20
> > Ok, maybe I'm missing something.=20
> > I received that error when I was trying to manually send a message =
in PEAK=20
> Explorer with a DLC of 9.
> > When I connect my device to an actual CAN bus that is transmitting =
a DM1=20
> message with a DLC of 34, I do not see the message using candump.
> > However, I don't see the timeout error anymore, so that's a plus.
> > Is there something specific I need to do in order to receive messag=
es that=20
> use BAM?
> >=20
> > -brent
> >=20
> >=20
> > -----Original Message-----
> > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]=20
> > Sent: Tuesday, August 27, 2013 2:54 AM
> > To: Brent Sink
> > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> (jaboydjr77@gmail.com)
> > Subject: Re: Reading messages that use BAM, or have a DLC larger th=
an 8
> >=20
> > Hi Brent,
> >=20
> > j1939tp_rxtask: timeout on 2
> >=20
> > It looks like you got everything up and running then!
> >=20
> > The message indicates a protocol fault of the sender.
> > The remote is sending too slow.
> > You can debug such things with candump, and inspect timestamps.
> > But there is nothing you can do on the receiving side to fix protoc=
ol faults.
> >=20
> > Kind regards,
> > Kurt
> >=20
> > On Mon, Aug 26, 2013 at 04:00:50PM -0400, Brent Sink wrote:
> > > Kurt,
> > >=20
> > > Ok, so I have managed to get your version of ip and candump worki=
ng and=20
> have the kernel built with the j1939 options.  Calling "ip link set c=
an0 j1939=20
> on" works just fine, but I'm seeing an issue when trying to read the =
DM1=20
> message using candump.  I seem to be getting a timeout error: j1939tp=
_rxtask:=20
> timeout on 2.
> > >=20
> > > Any thoughts?
> > >=20
> > > -brent
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > Sent: Thursday, August 22, 2013 1:56 PM
> > > To: Brent Sink
> > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> > > (jaboydjr77@gmail.com)
> > > Subject: Re: Reading messages that use BAM, or have a DLC larger =
than=20
> > > 8
> > >=20
> > > Brent,
> > >=20
> > > > # ip link set can0 j1939 on                                   =20
> > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > >=20
> > > You will want the j1939 branch of can-utils, and absolutely _need=
_ the=20
> j1939 branch of iproute2.
> > > The message you got is generated by iproute2 ...
> > >=20
> > > Sorry for the inconvenience.
> > > I must apologize for my limited availability nowadays.
> > > I'm pretty occupied with other things.
> > >=20
> > > Kurt
> > >=20
> > > On Thu, Aug 22, 2013 at 12:24:15PM -0400, Brent Sink wrote:
> > > > Ok, so merged this into my 3.8 branch and built the kernel.  Ca=
lling "ip=20
> link set can0 j1939 on" results in the error seen below.  I'm guessin=
g I need=20
> to build the can-utils=20
> (git://gitorious.org/~kurt-vd/linux-can/can-j1939-utils.git)... right=
? =20
> Anything else that I may need to do?
> > > >=20
> > > > # ip link set can0 j1939 on                                   =20
> > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > > >=20
> > > > -brent
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > Sent: Thursday, August 22, 2013 10:39 AM
> > > > To: Brent Sink
> > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org
> > > > Subject: Re: Reading messages that use BAM, or have a DLC large=
r=20
> > > > than
> > > > 8
> > > >=20
> > > > Brent,
> > > >=20
> > > > in your linux git repository, do:
> > > > $ git remote add j1939
> > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git
> > > > $ git remote update j1939
> > > > $ git merge j1939/v3.6 (or any branch that suits best your kern=
el).
> > > >=20
> > > > This won't take as long as cloning the entire repository, if yo=
u are=20
> already working in a git repo.
> > > >=20
> > > > Kurt
> > > >=20
> > > >=20
> > > > On Thu, Aug 22, 2013 at 10:22:31AM -0400, Brent Sink wrote:
> > > > > Thanks Kurt.  Do I really need to clone the entire repository=
, or=20
> > > > > can you point me to the files I need to rebuild the can-utils=
?  Is=20
> > > > > there a patch that I could apply to my current kernel build?
> > > > > Thanks,
> > > > >=20
> > > > > -brent
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > Sent: Thursday, August 22, 2013 3:56 AM
> > > > > To: Marc Kleine-Budde
> > > > > Cc: Brent Sink; linux-can@vger.kernel.org
> > > > > Subject: Re: Reading messages that use BAM, or have a DLC lar=
ger=20
> > > > > than
> > > > > 8
> > > > >=20
> > > > > Hi,
> > > > >=20
> > > > > I have a git repository on
> > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git
> > > > >=20
> > > > > I added a complete j1939 stack, including 'BAM'.
> > > > >=20
> > > > > You will need the associated can-utils with j1939 support to =
activate=20
> the j1939 processing for a specific CAN device:
> > > > > $ ip link set can0 j1939 on
> > > > >=20
> > > > > If you only need to receive j1939 packets, then that's all yo=
u need to=20
> do.
> > > > >=20
> > > > > The associated can-utils provide some example programs. You w=
ill need=20
> to take a look as the API for j1939 sockets is different than for raw=
 CAN.
> > > > >=20
> > > > > Kind regards,
> > > > > Kurt
> > > > >=20
> > > > > On Wed, Aug 21, 2013 at 10:19:22PM +0200, Marc Kleine-Budde w=
rote:
> > > > > > On 08/21/2013 08:43 PM, Brent Sink wrote:
> > > > > > > How do I read J1939 messages that use the BAM format?  So=
me of=20
> > > > > > > the diagnostic messages that are on the DM01 message have=
 a=20
> > > > > > > DLC that is often larger than 8 bytes when the message=20
> > > > > > > contains more than one error.  Is there something special=
 that=20
> > > > > > > I need to do to enable reading these messages?  Thanks!
> > > > > >
> > > > > > With mainline linux you just receive raw CAN frames. I'm no=
t a
> > > > > > j1939 expert, as far as I can see, BAM is a transport proto=
col for=20
> CAN.
> > > > > >
> > > > > > There are two options:
> > > > > > 1) You have to implement the BAM protocol yourself either,
> > > > > >    a) inside the kernel or
> > > > > >    b) inside userspace.
> > > > > > 2) Talk to Kurt (Cc'ed) if his j1939 patches support BAM.
> > > > > >
> > > > > > Marc
> > > > > > --
> > > > > > Pengutronix e.K.                  | Marc Kleine-Budde      =
     |
> > > > > > Industrial Linux Solutions        | Phone: +49-231-2826-924=
     |
> > > > > > Vertretung West/Dortmund          | Fax:   +49-5121-206917-=
5555 |
> > > > > > Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.=
de   |
> > > > > >
> > > > >=20
> > > > >=20
> > > > >=20
> > > > > --
> > > > > Kurt Van Dijck
> > > > > GRAMMER EiA ELECTRONICS
> > > > > http://www.eia.be
> > > > > kurt.van.dijck@eia.be
> > > > > +32-38708534
> > > > >=20
> > > > > The information contained in this message may be privileged a=
nd=20
> confidential and protected from disclosure. If the reader of this mes=
sage is=20
> not the intended recipient, or an employee or agent responsible for d=
elivering=20
> this message to the intended recipient, you are hereby notified that =
any=20
> dissemination, distribution or copying of this communication is stric=
tly=20
> prohibited. If you have received this communication in error, please =
notify us=20
> immediately by replying to the message and deleting it from your comp=
uter.=20
> Internet communications are not assured to be secure or clear of inac=
curacies=20
> as information could be intercepted, corrupted, lost, destroyed, arri=
ve late or=20
> incomplete, or contain viruses. Therefore, we do not accept responsib=
ility for=20
> any errors or omissions that are present in this email, or any attach=
ment, that=20
> have arisen as a result of e-mail transmission.
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
> > > >   =EC=B9=BB & ~ &   +-  =DD=B6  w  =CB=9B   m b  \jx    =DC=A8}=
   =C6=A0z &j:+v   =20
> > > >     zZ+  +zf   h   ~    i   z  w   ?    & )=DF=A2f
> > >=20
> > > --
> > > Kurt Van Dijck
> > > GRAMMER EiA ELECTRONICS
> > > http://www.eia.be
> > > kurt.van.dijck@eia.be
> > > +32-38708534
> > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   z   h   =
 &   G   h (
> > >  =E9=9A=8E =DD=A2j"   m     z =DE=96   f   h   ~ m=20
> >=20
> > --
> > Kurt Van Dijck
> > GRAMMER EiA ELECTRONICS
> > http://www.eia.be
> > kurt.van.dijck@eia.be
> > +32-38708534
>=20
> --=20
> Kurt Van Dijck
> GRAMMER EiA ELECTRONICS
> http://www.eia.be
> kurt.van.dijck@eia.be
> +32-38708534
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
