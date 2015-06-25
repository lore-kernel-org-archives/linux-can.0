From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [BULK]Re: [PATCH] can: fix loss of frames due to wrong
 assumption in raw_rcv
Date: Thu, 25 Jun 2015 11:36:17 +0200 (CEST)
Message-ID: <840510251.4781629.1435224977567.JavaMail.open-xchange@patina.store>
References: <5585A104.1090201@gmx.at> <5585EC4D.40103@hartkopp.net> <5587D9DA.6000102@gmx.at> <5587E26A.1070000@hartkopp.net> <5588E6FB.5040903@optusnet.com.au> <55891263.3050704@hartkopp.net> <558A1244.3010908@optusnet.com.au> <558B0B6F.6010304@hartkopp.net> <558BBC92.6040906@peak-system.com>
Reply-To: Oliver Hartkopp <socketcan@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.161]:18287 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbbFYJg2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 25 Jun 2015 05:36:28 -0400
In-Reply-To: <558BBC92.6040906@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, tom_usenet@optusnet.com.au



> Stephane Grosjean <s.grosjean@peak-system.com> hat am 25. Juni 2015 u=
m 10:32
> geschrieben:
>=20
>=20
> Hi everyone,

Hi Stephane,

sorry for the probably bad formated mail - it is via webmail ...

>=20
> I follow this thread carefully and, with your permission, I'd like to=
=20
> speak in.
>=20
> As we always help our customers in using the mainline drivers product=
s=20
> line too, I just wanted to inform you that I currently have one who=20
> tells that he's facing some loss of frames with the PEAK-System PCAN-=
USB=20
> adapter, in case of "relatively"  high bus load... He's running two=20
> Kernels (3.19 and the last 4.1 patched with this recent "fix"). At th=
e=20
> moment, he says he always notes some frame leakage, especially when h=
e=20
> (for example) "resizes windows on his desktop"...

The patch

http://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git/commit?i=
d=3D36c01245eb8046c16eee6431e7dbfbb302635fa8

especially adds

   __net_timestamp(skb);

after dev_alloc_skb().

So you need to add this in pcan_netdev_rx() in pcan_netdev.c analogue t=
o the
patch above, e.g. directly after the successful dev_alloc_skb().

Can you check, if this fixes the issue with the (patched) 4.1 kernel?

Many thanks,
Oliver

>=20
> The curious things are:
>=20
> 0 - frames are lost when running his socket-can application over the=20
> mainline peak-usb driver
> 1 - frames are lost when running his socket-can application over our=20
> "pcan" driver (built in so-called "netdev" mode, that is, rx frames a=
re=20
> forwarded to socket-can using netif_rx())
> 2 - *but* no frame are lost when running the "ioctl()" test applicati=
ons=20
> above our "pcan" driver (built in so-called "chardev" mode, that is, =
rx=20
> frames are stored into internal fifos before being given to applicati=
ons)
> 3 - in both cases #0 and #1, "can0" network stats don't show any=20
> rx_dropped nor rx_fifo_errors errors at all (even if sometimes, he sa=
ys=20
> he notes some "real" rx_over_errors  raised up by the peak-usb driver=
).
>=20
> I don't succeed to reproduce this issue with my "old" 3.16 Kernel at =
the=20
> moment. Before going on with installing the 3.19 Kernel, could the ab=
ove=20
> "leakage" be explained by the last changes made in linux-can?
>=20
> Many thanks for your help,
>=20
> Regards,
>=20
> St=C3=A9phane
>=20
> Le 24/06/2015 21:56, Oliver Hartkopp a =C3=A9crit :
> > On 24.06.2015 04:13, Tom Evans wrote:
> >> On 23/06/15 18:01, Oliver Hartkopp wrote:
> >>> An alternative to force the timestamp to be set would be to add a=
nother
> >>> 'counter' to struct can_skb_priv which is just increased by the=20
> >>> driver with
> >>> every received CAN frame.
> >>>
> >>> But I wonder if its worth the effort in opposite to just enable=20
> >>> timestamping
> >>> in every skb. What do you think?
> >>
> >>  From a programming standpoint, using a "timestamp" as a "unique=20
> >> identifier"
> >> is opaque and a poor design. If the SKB requires a "unique=20
> >> identifier" then it
> >> should be provided with something that has that description and pu=
rpose.
> >
> > Hey Tom,
> >
> >> The timestamp may be optional for a reason. Maybe some platforms=20
> >> simply don't
> >> provide a high resolution timestamp, and/or the timestamp comes wi=
th=20
> >> a high
> >> overhead. Can you guarantee that all current, future and past plat=
forms
> >> support a low overhead and high resolution timestamp?
> >
> > I have used the CAN stuff on two PowerPC, one ARM and several x86=20
> > platforms - always with enabled timestamping - without any problems=
 in=20
> > performance.
> >
> >> A new "feature" probably shouldn't change something that was optio=
nal=20
> >> to being
> >> compulsory. Would all existing CAN drivers need to be rewritten to=
=20
> >> add this
> >> timestamping, or is the timestamp added in higher (and more generi=
c)=20
> >> layers,
> >> and in the one place?
> >
> > The point is that out-of-tree drivers (like the PEAK-System driver)=
=20
> > would need to set the timestamp too to take advantage of the joint=20
> > filter feature.
> > The mainline drivers are adapted for now with the stable patch
> >
> > http://git.kernel.org/cgit/linux/kernel/git/davem/net.git/commit/?i=
d=3D36c01245eb8046c16eee6431e7dbfbb302635fa8
> >=20
> >
> >
> > But I felt not very comfortable with this fix. The point is that I=20
> > have to take care that the processing of an incoming skb in=20
> > can_receive() in af_can.c is done in 'one step' with an unique skb.=
 So=20
> > marking the skb for the joint filter feature in raw_rcv() can proba=
bly=20
> > be done in can_receive().
> >
> > I'm looking for a SMP save solution for this - to finally revert th=
e=20
> > fix above. So thanks for the 'wake-up call' by naming the timestamp=
ing=20
> > solution  a 'poor design'  ;-)
> >
> > Best regards,
> > Oliver
> >
> > --=20
> > To unsubscribe from this list: send the line "unsubscribe linux-can=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt
> Handelsregister Darmstadt HRB 9183=20
> Geschaeftsfuehrung: Alexander Gach, Uwe Wilhelm
> --
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
