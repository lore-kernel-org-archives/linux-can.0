From: =?iso-8859-1?Q?Heinz-J=FCrgen_Oertel?= <oe@port.de>
Subject: AW: Peak PCAN USB question
Date: Wed, 25 Apr 2012 08:43:40 +0000
Message-ID: <77D4E1B1D8549C4388FD52C58AC24547053FE3DA@SBSPORT2.portnet.local>
References: <77D4E1B1D8549C4388FD52C58AC24547053FE38D@SBSPORT2.portnet.local>,<4F97B3E5.3060603@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mx.professional-internet.de ([94.125.152.3]:56569 "EHLO
	mx.professional-internet.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752419Ab2DYInt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 25 Apr 2012 04:43:49 -0400
In-Reply-To: <4F97B3E5.3060603@grandegger.com>
Content-Language: de-DE
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>


________________________________________
Von: Wolfgang Grandegger [wg@grandegger.com]
Gesendet: Mittwoch, 25. April 2012 10:20
Bis: Heinz-J=FCrgen Oertel
Cc: linux-can@vger.kernel.org
Betreff: Re: Peak PCAN USB question

On 04/25/2012 09:37 AM, Heinz-J=FCrgen Oertel wrote:
> I'm working on a project where the application has to use can4linux a=
nd SocketCAN.
> Mainly because can4linux has no USB support yet.
> For some requests to the SocketCAN layer I use libsocketcan.
> Can someone confirm that can_get_berr_counter(), can_get_state()
> and may be some more functions are not working with the Peak PCAN USB=
 Interface?

Looking to the driver: can_get_berr_counter() is not supported but
can_get_state() should work. And bus error reporting is also not suppor=
ted.

Wolfgang.

This call:
 ret =3D can_get_state(canh_dev_to_name(dev), &sct_state);
    if(ret =3D=3D -1) {
	perror("libsocketcan can_get_state");
prints out:
 libsocketcan can_get_state: Resource temporarily unavailable

It works perfectly with EMS CPC-PCI boards.


Is it pcan_netdev.c where I have to look, peak version 7.4 ?

Regards
    Heinz

PS: I still don't know how to quote emails correctly using Outlook :-)



