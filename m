From: swapnil <patilswa@gmail.com>
Subject: Re: J1939 Interpacket Delay - issue of EOM
Date: Mon, 21 Apr 2014 15:04:12 +0000 (UTC)
Message-ID: <loom.20140421T164905-320@post.gmane.org>
References: <loom.20140409T155830-71@post.gmane.org> <20140409194939.GD15221@vandijck-laurijssen.be> <loom.20140410T155519-838@post.gmane.org> <20140411083139.GB449@vandijck-laurijssen.be> <loom.20140417T051332-76@post.gmane.org> <20140417201835.GA12665@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:49668 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbaDUPEZ (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Apr 2014 11:04:25 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WcFlg-0006rM-CL
	for linux-can@vger.kernel.org; Mon, 21 Apr 2014 17:04:24 +0200
Received: from 192.158.48.18 ([192.158.48.18])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2014 17:04:24 +0200
Received: from patilswa by 192.158.48.18 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2014 17:04:24 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:

>=20
> On Thu, Apr 17, 2014 at 03:18:44AM +0000, swapnil wrote:
> > Kurt Van Dijck <dev.kurt <at> vandijck-laurijssen.be> writes:
> >=20
> > >=20
> > > Hey,
> > >=20
> > > > > Hey,
> > > > >=20
> [...]
> > > > Is it possible that i can modify the code for j1939 for adding =
some=20
> > delay=20
> > > > for my use only -- if yes
> > >=20
> > > yes, you can. It's GPL
> > >=20
> > > > can u tell in which function can i add that delay.
> > > > This is the most important part in my project..
> > >=20
> > > You can patch the code like shown below.
> > > If that helps you releasing a product, don't hesitate.
> > >=20
> > > I'll keep your usecase in mind for the future.
> > >=20
> > > > actually i am able to=20
> > > > monitor the parameters using j1939 stack but if i want to calib=
rate=20
ECU
> > > > it fails.
> > >=20
> > > in net/can/j1939/transport.c, around line 1046, add this.
> > >=20
> > > 	case tp_cmd_bam:
> > > 		...
> > > 		while (session->pkt.tx < pkt_end) {
> > > 			...
> > > 			if (j1939cb_is_broadcast(session->cb)) {
> > > 				if (session->pkt.tx < session->pkt.total)
> > > 					j1939tp_schedule_txtimer(session,=20
> > 50);
> > > 				break;
> > > +			} else {
> > > +				j1939tp_schedule_txtimer(session, 1);
> > > +				break;
> > > 			}
> > > 		}
> > >=20
> > > this will add 1+ msec delay between packets.
> > > You may need to use bigger delays, like 5msec, as this is the del=
ay
> > > that is used to schedule the packet into the queue, and you want =
to
> > > delay the point that the CAN frames leave the queue onto the CAN =
bus.
> > >=20
> >=20
> > Thanks Kurt i merged this change and it is showing delay of 1 ms in=
 each=20
> > packet from my test program .I will try this on ECU.
> > log from candump
> > 1387768377.823498) can0 18EC00F9#10B2001A1A00EF00
> > (1387768377.824306) can0 1CECF900#111A01FFFF00EF00
> > (1387768377.825045) can0 18EB00F9#0100112233445566
> > (1387768377.826136) can0 18EB00F9#0200112233445566
> > (1387768377.827230) can0 18EB00F9#0300112233445566
> > (1387768377.828566) can0 18EB00F9#0400112233445566
> > (1387768377.829635) can0 18EB00F9#0544556600112233
> > (1387768377.830779) can0 18EB00F9#0644556644556600
> > (1387768377.831878) can0 18EB00F9#0711223344556644
> > (1387768377.832988) can0 18EB00F9#0855660011223344
> > (1387768377.834063) can0 18EB00F9#0955664455660011
> > (1387768377.835134) can0 18EB00F9#0A22334455664455
> > (1387768377.836277) can0 18EB00F9#0B66001122334455
> > (1387768377.837373) can0 18EB00F9#0C66445566001122
> > (1387768377.838451) can0 18EB00F9#0D33445566445566
> > (1387768377.839655) can0 18EB00F9#0E00112233445566
> > (1387768377.840645) can0 18EB00F9#0F44556600112233
> > (1387768377.841721) can0 18EB00F9#1044556644556600
> > (1387768377.842796) can0 18EB00F9#1111223344556644
> > (1387768377.843926) can0 18EB00F9#1255660011223344
> > (1387768377.845020) can0 18EB00F9#1355664455660011
> > (1387768377.846148) can0 18EB00F9#1422334455664455
> > (1387768377.847236) can0 18EB00F9#1566001122334455
> > (1387768377.848366) can0 18EB00F9#1666445566001122
> > (1387768377.849429) can0 18EB00F9#1733445566445566
> > (1387768377.850531) can0 18EB00F9#1800112233445566
> > (1387768377.851619) can0 18EB00F9#1944556600112233
> > (1387768377.852570) can0 18EB00F9#1A445566
> > (1387768377.853316) can0 1CECF900#13B2001AFF00EF00
> > Thanks once again=20
>=20
> I'm glad it works as expected!
>=20
> I'll investigate to add a decent API to control such thing from users=
pace
> via sockets, some day.
>=20
> Kind regards,
> Kurt
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Hi Kurt ,

 I am able to find out why ECU is not sending the end of message (EOM)
its because i am not padding(or filling) the renaming bytes=20
please check the log

without padding=20
(1387768742.573470) can0 18EC00F9#100A00020200EF00
(1387768742.574075) can0 18ECF900#110201FFFF00EF00
(1387768742.574802) can0 18EB00F9#0100112233445566
(1387768742.575741) can0 18EB00F9#02778899
(1387768743.830696) can0 18EC00F9#FF03FFFFFF00EF00

with padding reply
(1387768780.530352) can0 18EC00F9#100E00020200EF00
(1387768780.530957) can0 18ECF900#110201FFFF00EF00
(1387768780.531675) can0 18EB00F9#0100112233445566
(1387768780.532752) can0 18EB00F9#0277889911223344
(1387768780.533427) can0 18ECF900#130E0002FF00EF00

following lines from sae j1939
5.10.4 Transport Protocol=E2=80=94Data Transfer Message (TP.DT)

Packetized Data (7 bytes). Note the last packet of a multipacket
Parameter Group may require less than 8 data bytes. The extra bytes
should be filled with FF.

is it good to add in j1939 module ? or in my application=20

Thank You Swapnil


