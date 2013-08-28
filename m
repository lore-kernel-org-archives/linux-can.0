From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Wed, 28 Aug 2013 11:29:59 +0200
Message-ID: <20130828092959.GA16095@vandijck-laurijssen.be>
References: <20130822075613.GA1831@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1BD2@WEICSUS1.weics.local>
 <20130822143858.GB997@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1BF6@WEICSUS1.weics.local>
 <20130822175628.GA8941@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1CFA@WEICSUS1.weics.local>
 <20130827065408.GA3875@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1D6A@WEICSUS1.weics.local>
 <20130827210018.GB2105@vandijck-laurijssen.be>
 <1377640991.4869.13.camel@ergasia.protologos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay011.isp.belgacom.be ([195.238.6.178]:23143 "EHLO
	mailrelay011.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753278Ab3H1Jad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 28 Aug 2013 05:30:33 -0400
Received: from vandijck-laurijssen.be (unknown [192.168.0.70])
	by cylon.vandijck-laurijssen.be (Postfix) with ESMTPSA id 162BB4C246
	for <linux-can@vger.kernel.org>; Wed, 28 Aug 2013 11:30:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1377640991.4869.13.camel@ergasia.protologos.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Boyd <jaboydjr77@gmail.com>
Cc: Brent Sink <Brent.Sink@we-ics.com>

Hi John,

Technically, "try jspy" means that recvmsg() will work also.

Please consider man 2 recvmsg & man 2 recvfrom.
I mentioned earlier that using recvfrom() could yield simpler code than
using recvmsg. I forgot to mention explicitely that both do almost the =
same job.
You'll find the differences when reading the man pages.

I advised now to try jspy, since candump will never access j1939 socket=
s.
So, as an example of accessing the j1939 socket, jspy suits very well.

Reading back my previous post, I realized I didn't really answer this:
> > > Is there something specific I need to do in order to receive mess=
ages that use BAM?

The answer is: turn on j1939, that's all. (ip link set can0 j1939 on).
=46rom that point, BAM messages will be received.
jspy (or any other j1939 socket program, not candump) can then be used =
to
get those messages into userspace.

Kind regards,
Kurt

On Tue, Aug 27, 2013 at 06:03:11PM -0400, John Boyd wrote:
> "Try jspy" is telling you that you have to use recvmsg(), I think...
>=20
> On Tue, 2013-08-27 at 23:00 +0200, Kurt Van Dijck wrote:
> > Hi Brent,
> >=20
> > > I received that error when I was trying to manually send a messag=
e in PEAK Explorer with a DLC of 9.
> > I see. You should respect a inter-frame delay of 50msec (up to 250m=
sec or so),
> > which is practically impossible to perform manually.
> >=20
> > > When I connect my device to an actual CAN bus that is transmittin=
g a DM1 message with a DLC of 34, I do not see the message using candum=
p.
> > > However, I don't see the timeout error anymore, so that's a plus.
> >=20
> > The actual DM1 message respects the timings. That's good.
> >=20
> > > Is there something specific I need to do in order to receive mess=
ages that use BAM?
> > Try the jspy program in can-j1939-utils.
> > candump does/should show the 6 raw can frames, jspy should show the=
 1 j1939 packet.
> >=20
> > Kind regards,
> > Kurt
> >=20
> > On Tue, Aug 27, 2013 at 02:17:08PM -0400, Brent Sink wrote:
> > > Kurt,
> > >=20
> > > Ok, maybe I'm missing something.=20
> > > I received that error when I was trying to manually send a messag=
e in PEAK Explorer with a DLC of 9.
> > > When I connect my device to an actual CAN bus that is transmittin=
g a DM1 message with a DLC of 34, I do not see the message using candum=
p.
> > > However, I don't see the timeout error anymore, so that's a plus.
> > > Is there something specific I need to do in order to receive mess=
ages that use BAM?
> > >=20
> > > -brent
> > >=20
> > >=20
> > > -----Original Message-----
> > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]=20
> > > Sent: Tuesday, August 27, 2013 2:54 AM
> > > To: Brent Sink
> > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd (jabo=
ydjr77@gmail.com)
> > > Subject: Re: Reading messages that use BAM, or have a DLC larger =
than 8
> > >=20
> > > Hi Brent,
> > >=20
> > > j1939tp_rxtask: timeout on 2
> > >=20
> > > It looks like you got everything up and running then!
> > >=20
> > > The message indicates a protocol fault of the sender.
> > > The remote is sending too slow.
> > > You can debug such things with candump, and inspect timestamps.
> > > But there is nothing you can do on the receiving side to fix prot=
ocol faults.
> > >=20
> > > Kind regards,
> > > Kurt
> > >=20
> > > On Mon, Aug 26, 2013 at 04:00:50PM -0400, Brent Sink wrote:
> > > > Kurt,
> > > >=20
> > > > Ok, so I have managed to get your version of ip and candump wor=
king and have the kernel built with the j1939 options.  Calling "ip lin=
k set can0 j1939 on" works just fine, but I'm seeing an issue when tryi=
ng to read the DM1 message using candump.  I seem to be getting a timeo=
ut error: j1939tp_rxtask: timeout on 2.
> > > >=20
> > > > Any thoughts?
> > > >=20
> > > > -brent
> > > >=20
> > > >=20
> > > > -----Original Message-----
> > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > Sent: Thursday, August 22, 2013 1:56 PM
> > > > To: Brent Sink
> > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd=20
> > > > (jaboydjr77@gmail.com)
> > > > Subject: Re: Reading messages that use BAM, or have a DLC large=
r than=20
> > > > 8
> > > >=20
> > > > Brent,
> > > >=20
> > > > > # ip link set can0 j1939 on                                  =
 =20
> > > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > > >=20
> > > > You will want the j1939 branch of can-utils, and absolutely _ne=
ed_ the j1939 branch of iproute2.
> > > > The message you got is generated by iproute2 ...
> > > >=20
> > > > Sorry for the inconvenience.
> > > > I must apologize for my limited availability nowadays.
> > > > I'm pretty occupied with other things.
> > > >=20
> > > > Kurt
> > > >=20
> > > > On Thu, Aug 22, 2013 at 12:24:15PM -0400, Brent Sink wrote:
> > > > > Ok, so merged this into my 3.8 branch and built the kernel.  =
Calling "ip link set can0 j1939 on" results in the error seen below.  I=
'm guessing I need to build the can-utils (git://gitorious.org/~kurt-vd=
/linux-can/can-j1939-utils.git)... right?  Anything else that I may nee=
d to do?
> > > > >=20
> > > > > # ip link set can0 j1939 on                                  =
 =20
> > > > > Error: either "dev" is duplicate, or "j1939" is a garbage.
> > > > >=20
> > > > > -brent
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > Sent: Thursday, August 22, 2013 10:39 AM
> > > > > To: Brent Sink
> > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org
> > > > > Subject: Re: Reading messages that use BAM, or have a DLC lar=
ger=20
> > > > > than
> > > > > 8
> > > > >=20
> > > > > Brent,
> > > > >=20
> > > > > in your linux git repository, do:
> > > > > $ git remote add j1939
> > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git
> > > > > $ git remote update j1939
> > > > > $ git merge j1939/v3.6 (or any branch that suits best your ke=
rnel).
> > > > >=20
> > > > > This won't take as long as cloning the entire repository, if =
you are already working in a git repo.
> > > > >=20
> > > > > Kurt
> > > > >=20
> > > > >=20
> > > > > On Thu, Aug 22, 2013 at 10:22:31AM -0400, Brent Sink wrote:
> > > > > > Thanks Kurt.  Do I really need to clone the entire reposito=
ry, or=20
> > > > > > can you point me to the files I need to rebuild the can-uti=
ls?  Is=20
> > > > > > there a patch that I could apply to my current kernel build=
?
> > > > > > Thanks,
> > > > > >=20
> > > > > > -brent
> > > > > >=20
> > > > > > -----Original Message-----
> > > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]
> > > > > > Sent: Thursday, August 22, 2013 3:56 AM
> > > > > > To: Marc Kleine-Budde
> > > > > > Cc: Brent Sink; linux-can@vger.kernel.org
> > > > > > Subject: Re: Reading messages that use BAM, or have a DLC l=
arger=20
> > > > > > than
> > > > > > 8
> > > > > >=20
> > > > > > Hi,
> > > > > >=20
> > > > > > I have a git repository on
> > > > > > git://gitorious.org/~kurt-vd/linux-can/linux-can-j1939.git
> > > > > >=20
> > > > > > I added a complete j1939 stack, including 'BAM'.
> > > > > >=20
> > > > > > You will need the associated can-utils with j1939 support t=
o activate the j1939 processing for a specific CAN device:
> > > > > > $ ip link set can0 j1939 on
> > > > > >=20
> > > > > > If you only need to receive j1939 packets, then that's all =
you need to do.
> > > > > >=20
> > > > > > The associated can-utils provide some example programs. You=
 will need to take a look as the API for j1939 sockets is different tha=
n for raw CAN.
> > > > > >=20
> > > > > > Kind regards,
> > > > > > Kurt
> > > > > >=20
> > > > > > On Wed, Aug 21, 2013 at 10:19:22PM +0200, Marc Kleine-Budde=
 wrote:
> > > > > > > On 08/21/2013 08:43 PM, Brent Sink wrote:
> > > > > > > > How do I read J1939 messages that use the BAM format?  =
Some of=20
> > > > > > > > the diagnostic messages that are on the DM01 message ha=
ve a=20
> > > > > > > > DLC that is often larger than 8 bytes when the message=20
> > > > > > > > contains more than one error.  Is there something speci=
al that=20
> > > > > > > > I need to do to enable reading these messages?  Thanks!
> > > > > > >
> > > > > > > With mainline linux you just receive raw CAN frames. I'm =
not a
> > > > > > > j1939 expert, as far as I can see, BAM is a transport pro=
tocol for CAN.
> > > > > > >
> > > > > > > There are two options:
> > > > > > > 1) You have to implement the BAM protocol yourself either=
,
> > > > > > >    a) inside the kernel or
> > > > > > >    b) inside userspace.
> > > > > > > 2) Talk to Kurt (Cc'ed) if his j1939 patches support BAM.
> > > > > > >
> > > > > > > Marc
> > > > > > > --
> > > > > > > Pengutronix e.K.                  | Marc Kleine-Budde    =
       |
> > > > > > > Industrial Linux Solutions        | Phone: +49-231-2826-9=
24     |
> > > > > > > Vertretung West/Dortmund          | Fax:   +49-5121-20691=
7-5555 |
> > > > > > > Amtsgericht Hildesheim, HRA 2686  | http://www.pengutroni=
x.de   |
> > > > > > >
> > > > > >=20
> > > > > >=20
> > > > > >=20
> > > > > > --
> > > > > > Kurt Van Dijck
> > > > > > GRAMMER EiA ELECTRONICS
> > > > > > http://www.eia.be
> > > > > > kurt.van.dijck@eia.be
> > > > > > +32-38708534
> > > > > >=20
> > > > > > The information contained in this message may be privileged=
 and confidential and protected from disclosure. If the reader of this =
message is not the intended recipient, or an employee or agent responsi=
ble for delivering this message to the intended recipient, you are here=
by notified that any dissemination, distribution or copying of this com=
munication is strictly prohibited. If you have received this communicat=
ion in error, please notify us immediately by replying to the message a=
nd deleting it from your computer. Internet communications are not assu=
red to be secure or clear of inaccuracies as information could be inter=
cepted, corrupted, lost, destroyed, arrive late or incomplete, or conta=
in viruses. Therefore, we do not accept responsibility for any errors o=
r omissions that are present in this email, or any attachment, that hav=
e arisen as a result of e-mail transmission.
> > > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   z =
=1A  h    &  =1E G   h =03(
> > > > > >  =E9=9A=8E =DD=A2j"  =1A =1Bm     z =DE=96   f   h   ~ m=20
> > > > >=20
> > > > > --
> > > > > Kurt Van Dijck
> > > > > GRAMMER EiA ELECTRONICS
> > > > > http://www.eia.be
> > > > > kurt.van.dijck@eia.be
> > > > > +32-38708534
> > > > > =13  =EC=B9=BB=1C & ~ & =18  +-  =DD=B6=17  w  =CB=9B   m b  =
\jx  =17  =DC=A8}   =C6=A0z &j:+v   =20
> > > > >     zZ+  +zf   h   ~    i   z =1E w   ?    & )=DF=A2=1Bf
> > > >=20
> > > > --
> > > > Kurt Van Dijck
> > > > GRAMMER EiA ELECTRONICS
> > > > http://www.eia.be
> > > > kurt.van.dijck@eia.be
> > > > +32-38708534
> > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r   z =1A =
 h    &  =1E G   h =03(
> > > >  =E9=9A=8E =DD=A2j"  =1A =1Bm     z =DE=96   f   h   ~ m=20
> > >=20
> > > --
> > > Kurt Van Dijck
> > > GRAMMER EiA ELECTRONICS
> > > http://www.eia.be
> > > kurt.van.dijck@eia.be
> > > +32-38708534
> >=20
>=20
>=20

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
