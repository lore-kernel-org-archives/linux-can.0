From: Kurt Van Dijck <kurt.van.dijck@eia.be>
Subject: Re: Reading messages that use BAM, or have a DLC larger than 8
Date: Thu, 29 Aug 2013 21:36:07 +0200
Message-ID: <20130829193607.GA538@vandijck-laurijssen.be>
References: <20130822143858.GB997@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1BF6@WEICSUS1.weics.local>
 <20130822175628.GA8941@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1CFA@WEICSUS1.weics.local>
 <20130827065408.GA3875@vandijck-laurijssen.be>
 <9522AFA707AD744DA5CF5DF53E30277430EEDB1D6A@WEICSUS1.weics.local>
 <20130827210018.GB2105@vandijck-laurijssen.be>
 <1377640991.4869.13.camel@ergasia.protologos.net>
 <20130828092959.GA16095@vandijck-laurijssen.be>
 <1377694586.1254.25.camel@ergasia.protologos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mailrelay012.isp.belgacom.be ([195.238.6.179]:55073 "EHLO
	mailrelay012.isp.belgacom.be" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756157Ab3H2TgP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 29 Aug 2013 15:36:15 -0400
Content-Disposition: inline
In-Reply-To: <1377694586.1254.25.camel@ergasia.protologos.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: John Boyd <jaboydjr77@gmail.com>
Cc: Brent Sink <Brent.Sink@we-ics.com>, linux-can@vger.kernel.org

Hi,

If you prefer read() over recvfrom(), that will work also.
I tend to prefer recv()/recvfrom().

Please note that j1939 is a message oriented system.
Messages, or PGN's, are sent as messages.
I feel very comfortable with a message oriented API.
It treats metadata like addressing information very well.

If one prefers to implement the n+1th J1939 BAM assembly in userspace,
then that's possible. I've done so also. But most, if not all, such
implementations include some problems.
I'll point to the interframe delay that Brent encountered as a typical
problem.
But not all applications out there really need full j1939 correctness..=
=2E

If I summarize your story correctly, then your choosing between
CAN_RAW sockets, with fixed-length CAN frames, on one hand and
CAN_J1939 sockets with variable length J1939 messages on the other
hand.
What exactly do you try to compare then?
Can you clarify your findings and solutions.

I've not studied a STREAMS api for J1939 yet, have you?

Kind regards,
Kurt

On Wed, Aug 28, 2013 at 08:56:26AM -0400, John Boyd wrote:
> Yes...
>=20
> The app this concerns currently uses read().  recvmsg() is a differen=
t
> animal relative to read().  Your candump also uses recvmsg().
>=20
> So where Brent is concerned, "try jspy" means read() won't work for B=
AM
> messages if your protocol layer is being used - it's either recvmsg()=
 or
> recvfrom().  Otherwise, one can (I hope; I think Brent has tried this
> now) do message assembly from raw fixed-length CAN packets, thus to=20
> bypassing/ignoring your protocol layer.  The reason to do that, BTW, =
is
> to avoid rewriting an app to accomodate a subset of messages that are
> logically variable-length, but from another perspective are assembled
> from fixed-length packets.
>=20
> If so, then it's not just "turn on j1939, that's all"; it's "if you t=
urn
> on j1939, your app has to be message-oriented, not stream-oriented."
>=20
> I.e., receiving variable-length message-level input is a change here,
> however it gets done, and there are alternatives.  Using a protocol
> layer may or may not be the most effective, or the least disruptive.
>=20
> I should tell you, Kurt, that I was involved with Linux well before t=
he
> model you're using - BSD's sockets model - was adopted.  I was an
> advocate for the SYSV STREAMS model.  Particularly, I needed FD passi=
ng,
> and I implemented it using the STREAMS approach (and later did FD
> passing and all of the STREAMS interprocess communication layer for w=
hat
> was known then as Linux STREAMS, or LiS).  Alan Cox was working at th=
e
> time on a new BSD-based networking layer, to replace Fred van Kempen'=
s
> ad hoc networking layer.  Alan was working full time on it, and doing
> the whole layer; I was a grad student, and didn't intend to do a whol=
e
> layer.  So Alan's approach won the day, so to speak, though I had FD
> passing working for a year before Alan managed to get sendmsg/recvmsg
> support working for that capability.
>=20
> LiS never made it into the mainline kernel; Larry McVoy (author of
> bitkeeper, git's predecessor where kernel version control is concerne=
d)
> launched a "holy war" against STREAMS and the LiS community, but he a=
lso
> had Linus' ear.  The rest is history, and why Linux networking is
> BSD-like instead of STREAMS-like.  But, IMO, STREAMS is the far super=
ior
> model technically, in various respects, and, ... I lost that battle l=
ong
> ago.
>=20
> What looks "clean" from the perspective of an implementor of these ki=
nds
> of things, may not look very clean from the perspective of an app
> developer.  And frankly, I've never been impressed by the sockets mod=
el,
> and I don't think it's well appreciated how difficult it can be for a=
pp
> developers to grasp and employ.
>=20
> So my point about "try jspy" was larger than just recvmsg() vs.
> recvfrom(); it was about using your protocol layer, or not...
>=20
> On Wed, 2013-08-28 at 11:29 +0200, Kurt Van Dijck wrote:
> > Hi John,
> >=20
> > Technically, "try jspy" means that recvmsg() will work also.
> >=20
> > Please consider man 2 recvmsg & man 2 recvfrom.
> > I mentioned earlier that using recvfrom() could yield simpler code =
than
> > using recvmsg. I forgot to mention explicitely that both do almost =
the same job.
> > You'll find the differences when reading the man pages.
> >=20
> > I advised now to try jspy, since candump will never access j1939 so=
ckets.
> > So, as an example of accessing the j1939 socket, jspy suits very we=
ll.
> >=20
> > Reading back my previous post, I realized I didn't really answer th=
is:
> > > > > Is there something specific I need to do in order to receive =
messages that use BAM?
> >=20
> > The answer is: turn on j1939, that's all. (ip link set can0 j1939 o=
n).
> > From that point, BAM messages will be received.
> > jspy (or any other j1939 socket program, not candump) can then be u=
sed to
> > get those messages into userspace.
> >=20
> > Kind regards,
> > Kurt
> >=20
> > On Tue, Aug 27, 2013 at 06:03:11PM -0400, John Boyd wrote:
> > > "Try jspy" is telling you that you have to use recvmsg(), I think=
=2E..
> > >=20
> > > On Tue, 2013-08-27 at 23:00 +0200, Kurt Van Dijck wrote:
> > > > Hi Brent,
> > > >=20
> > > > > I received that error when I was trying to manually send a me=
ssage in PEAK Explorer with a DLC of 9.
> > > > I see. You should respect a inter-frame delay of 50msec (up to =
250msec or so),
> > > > which is practically impossible to perform manually.
> > > >=20
> > > > > When I connect my device to an actual CAN bus that is transmi=
tting a DM1 message with a DLC of 34, I do not see the message using ca=
ndump.
> > > > > However, I don't see the timeout error anymore, so that's a p=
lus.
> > > >=20
> > > > The actual DM1 message respects the timings. That's good.
> > > >=20
> > > > > Is there something specific I need to do in order to receive =
messages that use BAM?
> > > > Try the jspy program in can-j1939-utils.
> > > > candump does/should show the 6 raw can frames, jspy should show=
 the 1 j1939 packet.
> > > >=20
> > > > Kind regards,
> > > > Kurt
> > > >=20
> > > > On Tue, Aug 27, 2013 at 02:17:08PM -0400, Brent Sink wrote:
> > > > > Kurt,
> > > > >=20
> > > > > Ok, maybe I'm missing something.=20
> > > > > I received that error when I was trying to manually send a me=
ssage in PEAK Explorer with a DLC of 9.
> > > > > When I connect my device to an actual CAN bus that is transmi=
tting a DM1 message with a DLC of 34, I do not see the message using ca=
ndump.
> > > > > However, I don't see the timeout error anymore, so that's a p=
lus.
> > > > > Is there something specific I need to do in order to receive =
messages that use BAM?
> > > > >=20
> > > > > -brent
> > > > >=20
> > > > >=20
> > > > > -----Original Message-----
> > > > > From: Kurt Van Dijck [mailto:kurt.van.dijck@eia.be]=20
> > > > > Sent: Tuesday, August 27, 2013 2:54 AM
> > > > > To: Brent Sink
> > > > > Cc: Marc Kleine-Budde; linux-can@vger.kernel.org; John Boyd (=
jaboydjr77@gmail.com)
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
protocol faults.
> > > > >=20
> > > > > Kind regards,
> > > > > Kurt
> > > > >=20
> > > > > On Mon, Aug 26, 2013 at 04:00:50PM -0400, Brent Sink wrote:
> > > > > > Kurt,
> > > > > >=20
> > > > > > Ok, so I have managed to get your version of ip and candump=
 working and have the kernel built with the j1939 options.  Calling "ip=
 link set can0 j1939 on" works just fine, but I'm seeing an issue when =
trying to read the DM1 message using candump.  I seem to be getting a t=
imeout error: j1939tp_rxtask: timeout on 2.
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
 _need_ the j1939 branch of iproute2.
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
l.  Calling "ip link set can0 j1939 on" results in the error seen below=
=2E  I'm guessing I need to build the can-utils (git://gitorious.org/~k=
urt-vd/linux-can/can-j1939-utils.git)... right?  Anything else that I m=
ay need to do?
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
 if you are already working in a git repo.
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
rt to activate the j1939 processing for a specific CAN device:
> > > > > > > > $ ip link set can0 j1939 on
> > > > > > > >=20
> > > > > > > > If you only need to receive j1939 packets, then that's =
all you need to do.
> > > > > > > >=20
> > > > > > > > The associated can-utils provide some example programs.=
 You will need to take a look as the API for j1939 sockets is different=
 than for raw CAN.
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
 protocol for CAN.
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
eged and confidential and protected from disclosure. If the reader of t=
his message is not the intended recipient, or an employee or agent resp=
onsible for delivering this message to the intended recipient, you are =
hereby notified that any dissemination, distribution or copying of this=
 communication is strictly prohibited. If you have received this commun=
ication in error, please notify us immediately by replying to the messa=
ge and deleting it from your computer. Internet communications are not =
assured to be secure or clear of inaccuracies as information could be i=
ntercepted, corrupted, lost, destroyed, arrive late or incomplete, or c=
ontain viruses. Therefore, we do not accept responsibility for any erro=
rs or omissions that are present in this email, or any attachment, that=
 have arisen as a result of e-mail transmission.
> > > > > > > > N     r  y   b X  =C7=A7v ^ )=DE=BA{.n +    { q   ^n r =
  z =1A  h    &  =1E G   h =03(
> > > > > > > >  =E9=9A=8E =DD=A2j"  =1A =1Bm     z =DE=96   f   h   ~ =
m=20
> > > > > > >=20
> > > > > > > --
> > > > > > > Kurt Van Dijck
> > > > > > > GRAMMER EiA ELECTRONICS
> > > > > > > http://www.eia.be
> > > > > > > kurt.van.dijck@eia.be
> > > > > > > +32-38708534
> > > > > > > =13  =EC=B9=BB=1C & ~ & =18  +-  =DD=B6=17  w  =CB=9B   m=
 b  \jx  =17  =DC=A8}   =C6=A0z &j:+v   =20
> > > > > > >     zZ+  +zf   h   ~    i   z =1E w   ?    & )=DF=A2=1Bf
> > > > > >=20
> > > > > > --
> > > > > > Kurt Van Dijck
> > > > > > GRAMMER EiA ELECTRONICS
> > > > > > http://www.eia.be
> > > > > > kurt.van.dijck@eia.be
> > > > > > +32-38708534
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
> > > >=20
> > >=20
> > >=20
> >=20
>=20
>=20

--=20
Kurt Van Dijck
GRAMMER EiA ELECTRONICS
http://www.eia.be
kurt.van.dijck@eia.be
+32-38708534
