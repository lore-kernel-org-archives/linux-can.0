From: Daniel =?utf-8?b?Qm9zdHLDtm0=?= <daniel.bostrom@maximatecc.com>
Subject: Re: SocketCAN over Ethernet
Date: Mon, 7 Apr 2014 14:14:01 +0000 (UTC)
Message-ID: <loom.20140407T161036-150@post.gmane.org>
References: <loom.20140403T134741-892@post.gmane.org> <533DB9A6.6030605@hartkopp.net> <loom.20140404T084336-169@post.gmane.org> <loom.20140404T134940-234@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:37307 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755182AbaDGOON (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 7 Apr 2014 10:14:13 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1WXAJQ-0004li-Ga
	for linux-can@vger.kernel.org; Mon, 07 Apr 2014 16:14:12 +0200
Received: from 193.15.169.28 ([193.15.169.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 07 Apr 2014 16:14:12 +0200
Received: from daniel.bostrom by 193.15.169.28 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Mon, 07 Apr 2014 16:14:12 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Daniel Bostr=C3=B6m <daniel.bostrom <at> maximatecc.com> writes:

>=20
> I created a vcan interface, built and started the socketcand daemon o=
n=20
the=20
> Ubuntu vm and finally installed Kayak on Windows. I had to edit=20
> socketcand.conf a bit but now CAN messages sent using cansend from=20
Ubuntu=20
> show up in Kayak. I think this is a great start, thanks again for the=
=20
help.
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" =
in
> the body of a message to majordomo <at> vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20

Unfortunately when I tried the same setup today and use sendcan in Ubun=
tu=20
Kayak does not show the message when I check the raw view. BusStatistic=
s=20
is however updated each time I send a message. I also noticed I am unab=
le=20
to send a message from Kayak and see it in Ubuntu using candump. Does=20
anyone have an idea why it is not working anymore?


